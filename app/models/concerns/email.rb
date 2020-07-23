module Email
  extend ActiveSupport::Concern

  # included do
  #   validates :email, format: { with: /\A([^@]+@[^\.]+\..+)\z/ }
  #   validates :email_support, format: { with: /\A([^@]+@[^\.]+\..+)\z/ }
  #   validates :email_notification, format: { with: /\A([^@]+@[^\.]+\..+)\z/ }
  # end

  def self.email_validation
    validates :email_support, format: { with: /\A([^@]+@[^\.]+\..+)\z/ }
    validates :email_notification, format: { with: /\A([^@]+@[^\.]+\..+)\z/ }
  end
end