# frozen_string_literal: true

module SetCurrentRequestDetails
  extend ActiveSupport::Concern

  included do
    before_action do
      Current.ip_address = request.ip
      Current.request_id = request.uuid
      Current.user_agent = params[:device].nil? ? request.user_agent : "#{params[:device]} #{params[:mode]}"
      Current.accept_language = request.headers["HTTP_ACCEPT_LANGUAGE"]
    end
  end
end
