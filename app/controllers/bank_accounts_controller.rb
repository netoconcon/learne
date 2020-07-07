class BankAccountsController < ApplicationController
  def index
    @bank_accounts = Bank_account.all
  end

  def show
    @bank_accounts = BankAccount.find(params[:id])
  end

  def new
    @bank_account = BankAccount.new
    @company = Company.find(params[:company_id])
  end

  def create
    @bank_account = BankAccount.new(bank_account_params)
    @bank_account.company_id = params[:company_id]
    if @bank_account.save!
      redirect_to companies_path
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
    if @bank_account.save!
      redirect_to companies_path
    else
      render :new
    end
  end

  def destroy
    @bank_account = BankAccount.find(params[:id])
    @bank_account.destroy
    redirect_to companies_path
  end

  private

  def bank_account_params
    params.require(:bank_account).permit(:bank_code, :international, :bank_name, :agency_number, :account_number)   
  end
end
