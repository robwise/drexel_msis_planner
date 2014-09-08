class PlansController < ApplicationController
  before_filter :authenticate_user!
  before_action :set_plan, only: [:show, :edit, :update, :destroy]
  after_action  :verify_authorized

  # GET /users/:user_id/plans
  def index
    @user = User.find(params[:user_id])
    authorize @user.plans
  end

  # GET /plans/1
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
  def create
    @plan = Plan.new(plan_params)
    authorize @plan
    if @plan.save
      redirect_to @plan, notice: 'Plan was successfully created.'
    else
      redirect_to new_user_plan_path(@plan.user)
      flash[:alert] = "Error creating plan. #{@plan.errors.full_messages.presence}"
    end
  end

  # PATCH/PUT /plans/1
  def update
    user = @plan.user
    respond_to do |format|
      if @plan.update(plan_params)
        format.html { render action: "index", params: { user: user }, notice: 'Plan was successfully updated.' }
        format.js   { flash.now[:notice] = 'Plan was successfully updated.' }
      else
        format.html { render action: "index", params: { user: user } ; flash[:alert] = 'Error updating plan.' }
      end
    end
  end

  # DELETE /plans/1
  def destroy
    @plan.destroy
    redirect_to user_plans_url(@plan.user), notice: 'Plan was successfully deleted.'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_plan
      @plan = Plan.find(params[:id])
      authorize @plan
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def plan_params
      params.require(:plan).permit(:user_id, :name, :active)
    end
end
