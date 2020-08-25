class SellingPagesController < ApplicationController
  def index
    @selling_pages = SellingPage.all.order('created_at ASC')
  end

  def show
    @selling_page = SellingPage.friendly.find(params[:id])
    @instances = KitProduct.where(product_id: @selling_page.product.id)

  end

  def new
    @selling_page = SellingPage.new
  end

  def create
    @selling_page = SellingPage.new(selling_page_params)
    @company = params[:company_id]
    if @selling_page.save
      redirect_to selling_pages_path
    else
      render :new
    end
  end

  def edit
    @selling_page = SellingPage.friendly.find(params[:id])
  end

  def update
    @selling_page = SellingPage.friendly.find(params[:id])
    @selling_page.update(selling_page_params)
    if @selling_page.save!
      redirect_to selling_pages_path
    else
      render :edit
    end
  end

  def destroy
    @selling_page = SellingPage.friendly.find(params[:id])
    @selling_page.destroy
    redirect_to selling_pages_path
  end


  private

  def selling_page_params
    params.require(:selling_page).permit(:product_id, :name, :description, :url)
  end
end
