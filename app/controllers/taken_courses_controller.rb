class TakenCoursesController < ApplicationController
  before_filter :authenticate_user!
  after_action :verify_authorized

  def new
    @taken_course = TakenCourse.new
    @taken_course.user_id = params[:user_id]
    authorize @taken_course
    @taken_course.course_id = params[:course_id]
  end

  def create
    @taken_course = TakenCourse.new(secure_params)
    authorize @taken_course
    if TakenCourse.find_by(course_id: @taken_course.course_id,
                           user_id: @taken_course.user_id)
      redirect_to courses_path(@taken_course.course),
                           alert: 'Already considered having taken this course!'
    else
      @taken_course.save
      redirect_to course_path(id: @taken_course.course_id), notice: 'Added course to list of taken courses.'
    end
  end

  def edit
    @taken_course = TakenCourse.find(params[:id])
    authorize @taken_course
  end

  def update
    @taken_course = TakenCourse.find(params[:id])
    authorize @taken_course
    if @taken_course.update_attributes(secure_params)
      redirect_to user_path(current_user), :notice => "Course history updated."
    else
      redirect_to user_path(current_user),
                                    :alert => "Unable to update taken course."
    end
  end

  def destroy
    taken_course = TakenCourse.find(params[:id])
    authorize taken_course
    taken_course.destroy
    redirect_to user_path(current_user), notice: 'Course removed.'
  end

  private

    def secure_params
      params.require(:taken_course).permit(:id, :user_id, :course_id, :grade,
                                          :quarter)
    end
end
