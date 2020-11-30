# frozen_string_literal: true

class Pm::Adapter::Customer
  def initialize(customer)
    @customer = customer
  end

  def payload
    {
        name: @customer.first_name + ' ' + @customer.last_name,
        email: @customer.email,
        type: 'individual',
        external_id: @customer.id.to_s,
        country: 'br',
        # birthday: birthday.to_s unless @customer.birthday.nil?,
        documents: [
            {"type": "cpf", "number": @customer.cpf.gsub(".","").gsub("-","")}
        ],
        phone_numbers: ["+55#{@customer.phone.gsub("(","").gsub(")","").gsub("-","").gsub(" ","")}"]
    }
  end
end
