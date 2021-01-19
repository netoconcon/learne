class Campaign < ApplicationRecord

  delegate :product, to: :selling_page, prefix: true
  attr_accessor :product_id

  validates :title, presence: true

  belongs_to :selling_page
  has_many :visits

  def orders
    Order.includes(:visits).where(visits: { id: visits.pluck(:id) })
  end

  def register_visit!
    self.visits.create!
  end
end
