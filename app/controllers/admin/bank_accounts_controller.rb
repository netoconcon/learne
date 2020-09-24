class Admin::BankAccountsController < ApplicationController
  layout "admin"

  def index
    @company = Company.find(params[:company_id])
    @bank_accounts = BankAccount.all
  end

  def show
    @bank_accounts = BankAccount.find(params[:id])
  end

  def new
    @company = Company.find(params[:company_id])
    @bank_account = BankAccount.new
  end

  def create
    @bank_account = BankAccount.new(bank_account_params)
    @bank_account.company_id = params[:company_id]
    if @bank_account.save
      redirect_to admin_companies_path
    else
      render :new
    end
  end

  def edit
    @bank_account = BankAccount.find(params[:id])
  end

  def update
    @bank_account = BankAccount.find(params[:id])
    @bank_account.update(bank_account_params)
    if @bank_account.save
      redirect_to admin_companies_path
    else
      render :edit
    end
  end

  def destroy
    @bank_account = BankAccount.find(params[:id])
    @bank_account.destroy
    redirect_to admin_companies_path
  end

  private

  def bank_account_params
    params.require(:bank_account).permit(:company_id, :bank_code, :international, :bank_name, :agency_number, :account_number)
  end
end
