class FixCpfColumnName < ActiveRecord::Migration[6.0]
  def change
    add_column :orders, :cpf, :string
    Order.all.each { |order| order.update_columns cpf: order.CPF || "123.456.789-10" }
    change_column_null :orders, :cpf, false
    remove_column :orders, :CPF
  end
end
