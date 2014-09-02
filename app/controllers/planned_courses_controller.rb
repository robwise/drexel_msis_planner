class PlannedCoursesController < ApplicationController
  before_filter :authenticate_user!
  before_action :set_planned_course, only: [:show, :edit, :update, :destroy]
  # after_action :verify_authorized

  # GET plans/:plan_id/planned_courses/new
  def new
    @planned_course = PlannedCourse.new
  end

  # GET /planned_courses/1/edit
  def edit
  end

  # POST /plans/:plan_id/planned_courses
  # POST /plans/:plan_id/planned_courses.json
  def create
    @planned_course = PlannedCourse.new(planned_course_params)

    respond_to do |format|
      if @planned_course.save
        format.html { redirect_to @planned_course, notice: 'Planned course was successfully created.' }
        format.json { render :show, status: :created, location: @planned_course }
      else
        format.html { render :new }
        format.json { render json: @planned_course.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /planned_courses/1
  # PATCH/PUT /planned_courses/1.json
  def update
    respond_to do |format|
      if @planned_course.update(planned_course_params)
        format.html { redirect_to @planned_course, notice: 'Planned course was successfully updated.' }
        format.json { render :show, status: :ok, location: @planned_course }
      else
        format.html { render :edit }
        format.json { render json: @planned_course.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /planned_courses/1
  # DELETE /planned_courses/1.json
  def destroy
    @planned_course.destroy
    respond_to do |format|
      format.html { redirect_to planned_courses_url, notice: 'Planned course was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_planned_course
      @planned_course = PlannedCourse.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def planned_course_params
      params.require(:planned_course).permit(:plan_id, :course_id, :quarter)
    end
end
