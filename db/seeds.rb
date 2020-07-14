# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
company.destroy


puts 'Criando companhias'
10.times do
  company = Company.create(
    name: Faker::Company.name,
    cnpj: Faker::Company.brazilian_company_number(formatted: true),
    email = Faker::Internet.email,
    email_support = email,
    email_notification = email
  )
  company.save!
end
puts 'Companhias criadas'

puts 'Adicionando contas bancarias'

15.times do
  bank_account = BankAccount.create(
    company_id: rand(0..10),
    bank_code: rand(100..800),
    bank_name: Faker::Bank.name,
    agency_number: rand(1000..5000),
    account_number: rand(0010..8590)
  )
  bank_account.save
end

puts 'Contas bancarias adicionadas'