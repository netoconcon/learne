class SellingPage < ApplicationRecord
  validates :name, presence: true
  validates :description, presence: true
  validates :url, presence: true

  belongs_to :product
  has_many :campaigns, dependent: :destroy
end
