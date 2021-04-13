# frozen_string_literal: true

class Pm::Model::Transaction < Pm::Model
  attr_accessor :id, :refused_reason, :boleto_url, :boleto_barcode
  attr_writer :status

  # Switch to internal naming
  def status
    if @status == "paid"
      :completed
    elsif @tatus == "refused"
      :refused
    else
      :pending_payment
    end
  end
end
