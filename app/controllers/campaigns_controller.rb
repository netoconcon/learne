class CampaignsController < ApplicationController
  skip_before_action :authenticate_user!
  layout 'public'

  def show
    campaign = Campaign.find(params[:id])
    campaign.register_visit!
    redirect_to campaign.selling_page.url
  end
end
