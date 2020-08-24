class Order < ApplicationRecord
  include Validation

  belongs_to :kit
  belongs_to :address
end
