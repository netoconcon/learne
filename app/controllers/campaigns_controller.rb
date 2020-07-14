class CampaignsController < ApplicationController
  def index
    @campaigns = Campaign.all
  end
  def new
    @campaign = Campaign.new
  end

  def create
    @campaign = Campaign.new(campaign_params)
    if @campaign.save!
      redirect_to settings_path
    else
      render :new
    end
  end

  private

  def campaign_params
    params.require(:campaign).permit(:selling_page_id, :fbid, :utm_source, :utm_campaign, :utm_medium, :utm_medium, :utm_content, :pubid, :title)   
  end
end
