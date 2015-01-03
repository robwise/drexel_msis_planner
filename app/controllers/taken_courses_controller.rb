class TakenCoursesController < ApplicationController
  before_filter :authenticate_user!
  before_action :set_taken_course, only: [:show, :edit, :update, :destroy]
  after_action :verify_authorized

  def new
    @taken_course = TakenCourse.new(user_id: params[:user_id],
                                    course_id: params[:course_id])
    authorize @taken_course
  end

  # POST /users/:user_id/taken_courses
  def create
    @taken_course = TakenCourse.new(secure_params)
    authorize @taken_course
    if @taken_course.save
      respond_to do |format|
        format.js
      end
    else
      respond_to do |format|
        format.js { render "_modal_errors" }
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
