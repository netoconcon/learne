# frozen_string_literal: true

module SetVariant
  extend ActiveSupport::Concern

  included do
    before_action -> { request.variant = platform.to_sym }
  end
end
