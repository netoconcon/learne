module Email
  extend ActiveSupport::Concern

  included do
    validates_format_of :email_support, :with => Devise::email_regexp
    validates_format_of :email_notification, :with => Devise::email_regexp
  end
end