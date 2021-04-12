class Admin::DashboardsController < AdminController
  def index
    # render period and product filters
    @render_admin_filter = true

    # get sales for filtered and reference periods
    @filtered_sales = Order.where("orders.created_at > ? AND orders.created_at < ?", @filtered_period_start, @filtered_period_end)
    @reference_sales = Order.where("orders.created_at > ? AND orders.created_at < ?", @reference_period_start, @reference_period_end)

    # filter sales by product if necessary
    @filtered_sales = @filtered_sales.includes(kit: :products).where(products: { id: @filtered_product.id }) if @filtered_product.present?
    @reference_sales = @reference_sales.includes(kit: :products).where(products: { id: @filtered_product.id }) if @filtered_product.present?
  end
end
