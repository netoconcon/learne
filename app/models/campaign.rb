class Campaign < ApplicationRecord

  validates :title, presence: true

  belongs_to :selling_page

  def visits
    Visit.where(
        fbid: fbid,
        utm_campaign: utm_campaign,
        utm_content: utm_content,
        utm_term: utm_term,
        utm_medium: utm_medium,
        utm_source: utm_source,
        pubid: pubid
    )
  end

  def orders
    Order.includes(:visits).where(visits: { id: visits.pluck(:id) })
  end
end
