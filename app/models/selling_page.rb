class SellingPage < ApplicationRecord
  belongs_to :product
  has_many :campaigns
end
