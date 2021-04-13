class AddOrderItemsToOrders < ActiveRecord::Migration[6.1]
  def up
    Order.all.each do |order|
      product = order.kit.main_products.map(&:product).last
      if product.present?
        quantity = order.kit.main_products.last.quantity
        order.order_items.create! product: product, quantity: quantity, price: order.products_amount
      else
        order.destroy!
      end
    end
  end
end
