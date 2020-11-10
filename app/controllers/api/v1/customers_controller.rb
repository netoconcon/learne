class Api::V1::CustomersController < Api::V1::BaseController
  def counter
    @customers = Customer.all
  end
end
