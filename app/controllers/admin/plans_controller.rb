class Admin::PlansController < ApplicationController
  # before_action :check_admin

  def index
    @plans = Plan.all
  end

  def show
    @plan = Plan.find(params[:id])

  end

  def new
    @plan = Plan.new
  end

  def create
    @plan = Plan.new(plan_params)
    if @plan.save
      redirect_to admin_plans_path
    else
      render :new
    end
  end

  def edit
    @plan = Plan.find(params[:id])
  end

  def update
    @plan = Plan.find(params[:id])
    if @plan.update(plan_params)
      redirect_to admin_plans_path
    else
      render :edit
    end
  end

  def activate_plan
    @plan = Plan.find(params[:plan_id])
    @plan.set_pagarme_plan
    @plan.active = true
    @plan.visible = false
    @plan.deactivated = false
    @plan.save
    redirect_to admin_plans_path
  end

  def publish_plan
    @plan = Plan.find(params[:plan_id])
    @plan.active = true
    @plan.visible = true
    @plan.deactivated = false
    @plan.save
    redirect_to admin_plans_path
  end

  def deactivate_plan
    @plan = Plan.find(params[:plan_id])
    @plan.active = false
    @plan.visible = false
    @plan.deactivated = true
    @plan.save
    redirect_to admin_plans_path
  end

  private

  def plan_params
    params.require(:plan).permit(:name, :price, :days, :trials_days, :payment_methods, :charges, :installments, :invoice_reminder)
  end

  def check_admin
    unless current_user.admin
      redirect_to root_path
    end
  end
end
