class EnrolledInsController < ApplicationController
  before_filter :authenticate_user!
  after_action :verify_authorized

  def new
    @enrolled_in = EnrolledIn.new
    @enrolled_in.user_id = current_user.id
    authorize @enrolled_in
    @enrolled_in.course_id = params[:course_id]
  end

  def create
    @enrolled_in = EnrolledIn.new(secure_params)
    authorize @enrolled_in
    if EnrolledIn.find_by(course_id: @enrolled_in.course_id,
                          user_id: @enrolled_in.user_id)
      redirect_to courses_path,
                           alert: 'Already considered having taken this course!'
    else
      @enrolled_in.save
      redirect_to course_path(@enrolled_in.course_id)
    end
  end

  def edit
    @enrolled_in = EnrolledIn.find(params[:id])
    authorize @enrolled_in
  end

  def update
    @enrolled_in = EnrolledIn.find(params[:id])
    authorize @enrolled_in
    if @enrolled_in.update_attributes(secure_params)
      redirect_to user_path(current_user), :notice => "Course history updated."
    else
      redirect_to user_path(current_user),
                                    :alert => "Unable to update taken course."
    end
  end

  def destroy
    enrolled_in = EnrolledIn.find(params[:id])
    authorize enrolled_in
    enrolled_in.destroy
    redirect_to user_path(current_user), notice: 'Course removed.'
  end

  private

    def secure_params
      params.require(:enrolled_in).permit(:id, :user_id, :course_id, :grade,
                                          :quarter)
    end
end
