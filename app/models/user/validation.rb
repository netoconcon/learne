module User::Validation
  extend ActiveSupport::Concern

  included do
    validates :phone, format: Formatter.phone
    validates :email, presence: true, format: Formatter.email
    validates :cpf, format: Formatter.cpf
  end
end
