class SellingPage < ApplicationRecord

  validates :name, :description, :url, presence: true

  belongs_to :product
  has_many :campaigns, dependent: :destroy

  def total_visits
    visits = 0
    self.campaigns.each do |camp|
      visits += camp.visits.count
    end
    visits
  end
end
