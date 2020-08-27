module AddressesHelper
  def humanized_address(address)
    "#{address.street}, #{address.number} - #{address.city}/#{address.state}"
  end
end