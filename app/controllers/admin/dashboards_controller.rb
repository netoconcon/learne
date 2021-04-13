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

    set_graphs_data
  end

  private
  def set_graphs_data
    set_daily_graph_data
    set_credit_card_sales
    set_credit_card_revenue
    set_boleto_sales
  end

  def set_daily_graph_data
    boleto_data = { name: "Vendas boleto", data: {} }
    credit_card_data = { name: "Vendas cartão de crédito", data: {} }
    @filtered_sales.boleto.group_by { |order| order.created_at.to_date }.map { |date, orders| boleto_data[:data][date] = orders.count }
    @filtered_sales.credit_card.group_by { |order| order.created_at.to_date }.map { |date, orders| credit_card_data[:data][date] = orders.count }
    @daily_graph_data = [boleto_data, credit_card_data]
  end

  def set_credit_card_sales
    @credit_card_sales = { "Referência" => @reference_sales.credit_card.count, "Foco" => @filtered_sales.credit_card.count }
  end

  def set_credit_card_revenue
    @credit_card_revenue = { "Referência" => @reference_sales.credit_card.sum(&:total_amount), "Foco" => @filtered_sales.credit_card.sum(&:total_amount) }
  end

  def set_boleto_sales
    @boleto_sales = { "Referência" => @reference_sales.boleto.count, "Foco" => @filtered_sales.boleto.count }
  end

  def set_boleto_revenue
    @boleto_revenue = { "Referência" => @reference_sales.boleto.sum(&:total_amount), "Foco" => @filtered_sales.boleto.sum(&:total_amount) }
  end
end
