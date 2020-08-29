module User::Validation
  extend ActiveSupport::Concern

  included do
    validates :email, presence: true, format: Formatter.email
  end
end
