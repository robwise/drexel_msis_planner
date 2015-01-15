class TakenCoursesController < ApplicationController
  before_filter :authenticate_user!
  before_action :set_taken_course, only: [:show, :edit, :update, :destroy]
  after_action :verify_authorized

  def new
    @taken_course = TakenCourse.new(user_id: params[:user_id],
                                    course_id: params[:course_id])
    authorize @taken_course
    respond_to do |format|
      format.js {}
    end
  end

  def create
    @taken_course = TakenCourse.new(secure_params)
    authorize @taken_course
    respond_to do |format|
      if @taken_course.save
        format.js do
          flash[:notice] = "Course added to taken courses"
          flash.keep(:notice) # Keep flash notice around for the redirect.
          render js: "window.location = #{ courses_path.to_json }", status: 201
        end
      else
        format.js {}
      end
    end
  end

  def edit
    authorize @taken_course
    respond_to do |format|
      format.html
      format.js
    end
  end

  def update
    authorize @taken_course
    if @taken_course.update(secure_params)
      redirect_to user_path(current_user),
                  notice: "Course history updated."
    else
      redirect_to user_path(current_user),
                  alert: "Unable to update taken course."
    end
  end

  def destroy
    authorize @taken_course
    user_id = @taken_course.user_id
    @taken_course.destroy
    redirect_to user_path(user_id), notice: "Course removed."
  end

  private

    def secure_params
      params.require(:taken_course).permit(:id, :user_id, :course_id, :grade,
                                           :quarter)
    end

    def set_taken_course
      @taken_course = TakenCourse.find(params[:id])
    end

end
