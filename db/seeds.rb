# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
Company.destroy_all
BankAccount.destroy_all
Product.destroy_all


puts 'Criando companhias'
10.times do
  email = Faker::Internet.email
  Company.create(
    name: Faker::Company.name,
    cnpj: Faker::Company.brazilian_company_number(formatted: true),
    email_support: email,
    email_notification: email
  )

end
puts 'Companhias criadas'

puts 'Adicionando contas bancarias'

15.times do
  BankAccount.create(
    company_id: rand(0..10),
    bank_code: rand(100..800),
    bank_name: Faker::Bank.name,
    agency_number: rand(1000..5000),
    account_number: rand(0010..8590)
  )
end

puts 'Contas bancarias adicionadas'

puts 'Criando produtos'

13.times do
  Product.create(
    company_id: rand(1..10)
    name:
    price:
    description:
    external_id:
  )
end