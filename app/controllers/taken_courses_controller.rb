class TakenCoursesController < ApplicationController
  before_filter :authenticate_user!
  before_action :set_taken_course, only: [:show, :edit, :update, :destroy]
  after_action :verify_authorized

  # GET /users/:user_id/taken_courses/new
  def new
    @taken_course = TakenCourse.new
    @taken_course.user_id = params[:user_id]
    @taken_course.course_id = params[:course_id]
    authorize @taken_course
  end

  # POST /users/:user_id/taken_courses
  def create
    @taken_course = TakenCourse.new(secure_params)
    authorize @taken_course
    if TakenCourse.find_by(course_id: @taken_course.course_id,
                           user_id: @taken_course.user_id)
      redirect_to courses_path(@taken_course.course),
                           alert: 'Already took this course!'
    else
      @taken_course.save
      redirect_to course_path(id: @taken_course.course_id),
                              notice: 'Added course to your course history.'
    end
  end

  def edit
    authorize @taken_course
  end

  def update
    authorize @taken_course
    if @taken_course.update_attributes(secure_params)
      redirect_to user_path(current_user), :notice => "Course history updated."
    else
      redirect_to user_path(current_user),
                                    :alert => "Unable to update taken course."
    end
  end

  def destroy
    authorize @taken_course
    user_id =@taken_course.user_id
    @taken_course.destroy
    redirect_to user_path(user_id), notice: 'Course removed.'
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
