class SellingPage < ApplicationRecord
  extend FriendlyId
  friendly_id :url, use: :slugged

  validates :name, :description, :url, presence: true

  belongs_to :kit
  has_many :campaigns, dependent: :destroy
end
