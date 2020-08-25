class SellingPage < ApplicationRecord
  extend FriendlyId
  friendly_id :name, use: :slugged

  validates :name, :description, :url, presence: true

  belongs_to :product
  has_many :campaigns, dependent: :destroy
end
