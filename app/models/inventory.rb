class Inventory < ApplicationRecord
  belongs_to :product

  before_update :product_changed

  private

  def product_changed
    if self.changed?
      @updating = self.changes
    end
  end

end
