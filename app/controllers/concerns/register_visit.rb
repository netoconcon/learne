module RegisterVisit
  extend ActiveSupport::Concern

  included do
    before_action :create_visit
  end

  private
    def create_visit
      @visit = Visit.create fbid: params[:fbid],
                   utm_source: params[:utm_source],
                   utm_campaign: params[:utm_campaign],
                   utm_medium: params[:utm_medium],
                   utm_term: params[:utm_term],
                   utm_content: params[:utm_content],
                   pubid: params[:pubid]
    end
end