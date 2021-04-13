class Admin::OrdersController < AdminController
  def index
    # render period and product filters
    @render_admin_filter = true

    # get orders for filtered period
    @orders = Order.includes([:kit, :customer]).where("orders.created_at > ? AND orders.created_at < ?", @filtered_period_start, @filtered_period_end)

    # filter sales by product if necessary
    @orders = @orders.includes(kit: :products).where(products: { id: @filtered_product.id }) if @filtered_product.present?
  end

  def show
    @order = Order.find(params[:id])
  end

  def edit
    @order = Order.find(params[:id])
  end

  def update
    @order = Order.find(params[:id])
    if @order.update(order_params)
      redirect_to admin_order_path(@order)
    else
      render :edit
    end
  end

  private

  def order_params
    params.require(:order).permit(:paid, :installments, :kit_id, :payment_method, :price, :address_id, :customer_id, :pagarme_transaction_id, :boleto_url, :boleto_bar_code, :upsell_product, :refused_reason, :status, :cpf, :insts, :amount, :expiration_date)
  end
end

