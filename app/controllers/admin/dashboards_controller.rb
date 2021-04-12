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

    # charts
    set_graphs_data

    # products
    @items = Product.all
  end

  private
  def set_graphs_data
    set_daily_graph_date
  end

  def set_daily_graph_date
    @daily_graph_data = {}
    @filtered_sales.group_by { |order| order.created_at.to_date }.map { |date, orders| @daily_graph_data[date] = orders.count }
  end
end
