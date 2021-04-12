class AdminController < ApplicationController
  include Admin::SetProductFilter, Admin::SetPeriodFilter
  layout "admin"
end
