# frozen_string_literal: true

class Pm::Model
  def initialize(attributes)
    attributes.each do |key, value|
      method = "#{key}="
      public_send(method, value) if respond_to?(method)
    end
  end
end
