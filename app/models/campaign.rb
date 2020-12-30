class Campaign < ApplicationRecord

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
