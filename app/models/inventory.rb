class Inventory < ApplicationRecord
  has_paper_trail

  belongs_to :product

end
