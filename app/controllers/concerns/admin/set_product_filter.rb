# frozen_string_literal: true

module Admin::SetProductFilter
  extend ActiveSupport::Concern

  included do
    before_action :set_filtered_product
  end

  private
    def set_filtered_product
      @filtered_product = Product.find_by(id: params[:admin][:product_id]) if params[:admin].present? && params[:admin][:product_id].present?
    end
end
