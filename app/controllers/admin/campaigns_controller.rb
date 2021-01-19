class Admin::CampaignsController < ApplicationController
  layout "admin"

  def index
    @campaigns = Campaign.all.order('created_at ASC')
  end

  def show
    @campaign = Campaign.find(params[:id])
  end

  def new
    @campaign = Campaign.new
    @products = Product.all.map { |product| [product.name, product.id] }
  end

  def create
    @campaign = Campaign.new(campaign_params)
    if @campaign.save
      redirect_to admin_campaigns_path
    else
      if @campaign.product_id.present?
        @selling_pages = Product.find(campaign_params[:product_id]).selling_pages
        @campaign.errors.delete(:title)
        @campaign.errors.delete(:selling_page)
      end
      render :new
    end
  end

  def edit
    @campaign = Campaign.find(params[:id])
  end

  def update
    @campaign = Campaign.find(params[:id])
    @campaign.update(campaign_params)
    if @campaign.save
      redirect_to admin_campaigns_path
    else
      @product
      render :new
    end
  end

  def destroy
    @campaign = Campaign.find(params[:id])
    @campaign.destroy
    redirect_to admin_campaigns_path
  end

  private

  def campaign_params
    params.require(:campaign).permit(:selling_page_id, :fbid, :utm_source, :utm_campaign, :utm_term,:utm_medium, :utm_medium, :utm_content, :pubid, :title, :product_id)
  end
end
