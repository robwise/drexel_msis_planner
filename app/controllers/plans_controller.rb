class PlansController < ApplicationController
  before_filter :authenticate_user!
  before_action :set_plan, only: [:show, :edit, :update, :destroy]
  after_action  :verify_authorized

  # GET /users/:user_id/plans
  # GET /users/:user_id/plans.json
  def index
    @user = User.find(params[:user_id])
    authorize @user.plans
  end

  # GET /plans/1
  # GET /plans/1.json
  def show
  end

  # GET users/:user_id/plans/new
  def new
    @plan = Plan.new
    @plan.user_id = params[:user_id]
    authorize @plan
  end

  # GET /plans/1/edit
  def edit
  end

  # POST /users/:user_id/plans
  # POST /users/:user_id/plans.json
  def create
    @plan = Plan.new(plan_params)
    authorize @plan

    respond_to do |format|
      if @plan.save
        format.html { redirect_to @plan, notice: 'Plan was successfully created.' }
        format.json { render :show, status: :created, location: @plan }
      else
        format.html { render :new }
        format.json { render json: @plan.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /plans/1
  def update
    if @plan.update(plan_params)
      redirect_to @plan, notice: 'Plan was successfully updated.'
    else
      flash![:alert] = "Error updating plan."
    end
  end

  # DELETE /plans/1
  # DELETE /plans/1.json
  def destroy
    @plan.destroy
    respond_to do |format|
      format.html { redirect_to user_plans_url(@plan.user), notice: 'Plan was successfully deleted.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_plan
      @plan = Plan.find(params[:id])
      authorize @plan
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def plan_params
      params.require(:plan).permit(:user_id, :name)
    end
end
