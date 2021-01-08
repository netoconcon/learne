class ApplicationController < ActionController::Base
  before_action :authenticate_user!
  before_action :set_paper_trail_whodunnit

  include SetCurrentRequestDetails
  include SetPlatform
  include SetVariant
end
