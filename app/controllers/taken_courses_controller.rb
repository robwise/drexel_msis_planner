class TakenCoursesController < ApplicationController
  before_filter :authenticate_user!
  before_action :set_taken_course, only: [:show, :edit, :update, :destroy]
  after_action :verify_authorized

  def new
    @taken_course = TakenCourseDecorator.new(
      TakenCourse.new(user_id: params[:user_id], course_id: params[:course_id])
    )
    authorize @taken_course
  end

  def create
    @taken_course = TakenCourseDecorator.new(TakenCourse.new(secure_params))
    authorize @taken_course
    if @taken_course.save
      render js: "window.location = #{ courses_path.to_json }", status: 201
      flash[:notice] = "Course added to taken courses."
    else
      render partial: "errors", status: :unprocessable_entity
    end
  end

  def edit
    authorize @taken_course
  end

  def update
    authorize @taken_course
    if @taken_course.save
      render js: "window.location = #{ user_path(current_user).to_json }",
             status: 200
      flash[:notice] = "Course history updated"
    else
      render partial: "errors", status: :unprocessable_entity
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
    @taken_course = TakenCourseDecorator.new(TakenCourse.find(params[:id]))
  end
end
