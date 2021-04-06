class FixOrder < ActiveRecord::Migration[6.1]
  def change
    # fix amount and remove price

    Order.all.each do |order|
      order.update! price: BigDecimal(order.amount) / 100
    end

    remove_column :orders, :amount
    add_column :orders, :amount, :decimal, precision: 8, scale: 2

    Order.all.each do |order|
      order.update! amount: order.price
    end

    remove_column :orders, :price

    # make payment_method a enum
    add_column :orders, :payment_type, :integer

    Order.all.each do |order|
      order.update! payment_type: order.payment_method ? 0 : 1
    end

    remove_column :orders, :payment_method
    add_column :orders, :payment_method, :integer

    Order.all.each do |order|
      order.update! payment_method: order.payment_type
    end

    remove_column :orders, :payment_type
  end
end
