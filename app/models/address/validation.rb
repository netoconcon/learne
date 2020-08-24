module Address::Validation
  extend ActiveSupport::Concern

  included do
    validates :street, presence: true
    validates :number, presence: true, numericality: { only_integer: true, greater_than: 0 }
    validates :neighborhood, presence: true
    validates :city, presence: true
    validates :state, presence: true, inclusion: { in: %w(AC AL AP AM BA CE DF ES GO MA MT MS MG PA PB PR PE PI RJ RN RS RO RR SC SP SE TO) }
    validates :zipcode, presence: true, length: { maximum: 8 }, format: Formatter.zipcode
  end
end
