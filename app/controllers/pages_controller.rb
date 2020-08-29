class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: [ :home ]
  layout "admin"

  def home
  end
end
