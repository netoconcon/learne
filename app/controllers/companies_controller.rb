class CompaniesController < ApplicationController
  layout "admin"

  def index
    @companies = Company.all.order('created_at ASC')
    @bank_accounts = BankAccount.all
  end

  def show
    @company = Company.find(params[:id])
  end

  def new
    @company = Company.new
  end

  def create
    @company = Company.new(company_params)
    # @company.cnpj.gsub!(/\D/, '')
    if @company.save
      redirect_to companies_path
    else
      render :new
    end
  end

  def edit
    @company = Company.find(params[:id])
  end

  def update
    @company = Company.find(params[:id])
    @company.update(company_params)
    if @company.save
      redirect_to companies_path
    else
      render :edit
    end
  end

  def destroy
    @company = Company.find(params[:id])
    @company.destroy
    redirect_to companies_path
  end

  private

  def company_params
    params.require(:company).permit(:cnpj, :international, :email_support, :email_notification, :phone_support, :shipment_origin_zipcode, :name)
  end
end
