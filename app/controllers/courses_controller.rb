class CoursesController < ApplicationController
  before_filter :authenticate_user!, except: [:index, :show]
  after_action :verify_authorized, except: [:index, :show]

  def index
    @taken_course_ids = current_user.try(:course_ids)
    @planned_course_ids = @active_plan.try(:course_ids)
    @courses = Course.all
  end

  def show
    @course = Course.find(params[:id])
  end

  def new
    @course = Course.new
    authorize @course
  end

  def create
    @course = Course.new(secure_params)
    authorize @course
    if @course.save
      redirect_to @course, notice: "Course sucessfully created."
    else
      redirect_to new_course_path(@course)
      # TODO: switch to using Ajax update of errors
      flash[:alert] =
        "Error creating course. #{@course.errors.full_messages.presence}"
    end
  end

  def edit
    @course = Course.find(params[:id])
    authorize @course
  end

  def update
    @course = Course.find(params[:id])
    authorize @course
    if @course.update_attributes(secure_params)
      redirect_to @course, notice: "Course updated."
    else
      redirect_to courses_path, alert: "Error updating course."
    end
  end

  def destroy
    @course = Course.find(params[:id])

    authorize @course
    if @course.destroy
      redirect_to courses_path, notice: "Course successfully deleted."
    else
      flash![:error] = "Error deleting course."
    end
  end

  private

  def secure_params
    params.require(:course).permit(:id,
                                   :department,
                                   :level,
                                   :title,
                                   :description,
                                   :degree_requirement)
  end
end
