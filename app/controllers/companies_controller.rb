class CompaniesController < ApplicationController
  def index
    @companies = Company.all
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
    if @company.save!
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
    if @company.save!
      redirect_to companies_path
    else
      render :new
    end
  end

  def destroy
    @company = Company.find(params[:id])
    @company.destroy
    redirect_to companies_path
  end

  private

  def company_params
    params.require(:company).permit(:CNPJ, :international, :email_support, :email_notification, :phone_support, :shipment_origin_zipcode, :name)   
  end
end
