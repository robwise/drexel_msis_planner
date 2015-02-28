class PlannedCoursesController < ApplicationController
  before_filter :authenticate_user!
  before_action :set_planned_course, only: [:show, :edit, :update, :destroy]
  after_action  :verify_authorized

  # GET /plans/:plan_id/planned_courses/new
  def new
    @planned_course = PlannedCourse.new(plan_id: params[:plan_id],
                                        course_id: params[:course_id])
    authorize @planned_course
  end

  # POST /plans/:plan_id/planned_courses
  def create
    @planned_course = PlannedCourse.new(planned_course_params)
    authorize @planned_course
    if @planned_course.save
      render js: "window.location = #{ courses_path.to_json }", status: 201
      flash[:notice] = "#{@planned_course.course.full_id} added to #{@planned_course.plan.name}."
    else
      render partial: "errors", status: :unprocessable_entity
    end
  end

  # PATCH/PUT /planned_courses/1
  def update
    if @planned_course.update(planned_course_params)
      redirect_to @plan, notice: "Plan successfully updated."
    else
      redirect_to @plan, alert: "Error updating plan."
    end
  end

  # DELETE /planned_courses/1
  def destroy
    if @planned_course.destroy
      redirect_to planned_courses_url, notice: "Removed course from plan."
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_planned_course
    @planned_course = PlannedCourse.find(params[:id])
    authorize @planned_course
  end

  # Never trust parameters from the scary internet, only allow the white list
  # through.
  def planned_course_params
    params.require(:planned_course).permit(:plan_id, :course_id, :quarter)
  end
end
