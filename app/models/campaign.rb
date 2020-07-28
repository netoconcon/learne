class Campaign < ApplicationRecord

  validates :title, presence: true

  belongs_to :selling_page
end
