module CampaignsHelper
  def campaign_url_for(campaign)
    campaign_variables =[]
    campaign_variables << "fbid=#{campaign.fbid}" if campaign.utm_source.present?
    campaign_variables << "pubid=#{campaign.pubid}" if campaign.utm_source.present?
    campaign_variables << "utm_source=#{campaign.utm_source}" if campaign.utm_source.present?
    campaign_variables << "utm_campaign=#{campaign.utm_campaign}" if campaign.utm_campaign.present?
    campaign_variables << "utm_medium=#{campaign.utm_medium}" if campaign.utm_medium.present?
    campaign_variables << "utm_term=#{campaign.utm_term}" if campaign.utm_term.present?
    campaign_variables << "utm_content=#{campaign.utm_content}" if campaign.utm_content.present?
    "#{request.base_url}/#{campaign.selling_page.url}?#{campaign_variables.join("&")}"
  end
end