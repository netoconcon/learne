class Admin::SellingPagesController < ApplicationController
  layout 'admin'

  def index
    @selling_pages = SellingPage.all.order('created_at ASC')
  end

  def show
    @selling_page = SellingPage.find(params[:id])
    @instances = KitProduct.where(id: @selling_page.kit.id)
  end

  def new
    @selling_page = SellingPage.new
  end

  def create
    @selling_page = SellingPage.new(selling_page_params)
    @company = params[:company_id]
    if @selling_page.save
      redirect_to admin_selling_pages_path
    else
      render :new
    end
  end

  def edit
    @selling_page = SellingPage.find(params[:id])
  end

  def update
    @selling_page = SellingPage.find(params[:id])
    @selling_page.update(selling_page_params)
    if @selling_page.save!
      redirect_to admin_selling_pages_path
    else
      render :edit
    end
  end

  def destroy
    @selling_page = SellingPage.find(params[:id])
    @selling_page.destroy
    redirect_to admin_selling_pages_path
  end

  def kit_show
    kit_id = SellingPage.find_by(url: params[:selling_page_url]).kit.id
    @order = OrderForm.new(kit_id: kit_id)
    render "orders/new"
  end

  private

  def selling_page_params
    params.require(:selling_page).permit(:kit_id, :name, :description, :url, :confirmation_page)
  end
end
