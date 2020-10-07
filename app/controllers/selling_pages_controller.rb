class SellingPagesController < ApplicationController
  skip_before_action :authenticate_user!
  include RegisterVisit
  layout 'public'

  def show
    selling_page = SellingPage.find_by(url: params[:selling_page_url])

    @order = OrderForm.new(kit_id: selling_page.kit.id, visit_id: @visit.id)
    render "orders/new"
  end
end
