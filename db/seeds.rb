# # This file should contain all the record creation needed to seed the database with its default values.
# # The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
# #
# # Examples:
# #
# #   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
# #   Character.create(name: 'Luke', movie: movies.first)
# Company.destroy_all
# BankAccount.destroy_all
# Product.destroy_all
# Kit.destroy_all

# puts 'Criando seeds'

# 10.times do
#   email = Faker::Internet.email
#   Company.create(
#     name: Faker::Company.name,
#     cnpj: Faker::Company.brazilian_company_number(formatted: true),
#     email_support: email,
#     email_notification: email
#   )

# end

# 15.times do
#   BankAccount.create(
#     company_id: rand(0..10),
#     bank_code: rand(100..800),
#     bank_name: Faker::Bank.name,
#     agency_number: rand(1000..5000),
#     account_number: rand(0010..8590)
#   )
# end


# 13.times do
#   Product.create(
#     company_id: rand(1..10),
#     name: Faker::Appliance.equipment,
#     price_cents: rand(3000..20000),
#     description: Faker::Company.bs
#   )
# end

# 9.times do
#   Kit.create(
#     name:"kit #{rand(1..5)}",
#     payment_type: rand(0..1),
#     shipment_cost: rand(0..20),
#     weight: rand(0..2500),
#     length: rand(0..2500),
#     width: rand(0..2500),
#     height: rand(0..2500)
#   )
# end






    3.times do
      puts "creating customer"
      customer = Customer.create!(first_name: "João", last_name: "Gilberto", email: "b@a.com")

      puts "Creating address"
        address = Address.create!(
          street: "Paim",
          number: 10,
          neighborhood: "BV",
          complement: "casa",
          city: "SP",
          state: "SP",
          zipcode: "10209010",
          customer: customer
          )


      10.times do
        puts "creating order"
        order = Order.create!(
          paid: false,
          installments: 10,
          kit: Kit.last,
          payment_method: [true, false].sample,
          price: 15000,
          customer: customer,
          address: address,
          status: 0,
          cpf: "9999999999",
          insts: 10 ,
          amount: 15000,
        )
      end
    end





