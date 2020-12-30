class SellingPage < ApplicationRecord

  validates :name, :description, :url, presence: true

  belongs_to :product
  has_many :campaigns, dependent: :destroy

	has_one_attached :banner
end
