# frozen_string_literal: true

module Admin::SetPeriodFilter
  extend ActiveSupport::Concern

  included do
    before_action :set_filtered_period
  end

  private
    def set_filtered_period
      if params[:admin].present? && params[:admin][:filtered_period_start].present?
        filtered_period_start_split = params[:admin][:filtered_period_start].split("/")
        @filtered_period_start = Date.new(filtered_period_start_split[2].to_i, filtered_period_start_split[1].to_i, filtered_period_start_split[0].to_i)
      else
        @filtered_period_start = Date.today - 30
      end

      if params[:admin].present? && params[:admin][:filtered_period_end].present?
        filtered_period_end_split = params[:admin][:filtered_period_end].split("/")
        @filtered_period_end = Date.new(filtered_period_end_split[2].to_i, filtered_period_end_split[1].to_i, filtered_period_end_split[0].to_i)
      else
        @filtered_period_end = Date.today
      end

        @reference_period_start = @filtered_period_start - 31
      @reference_period_end = @filtered_period_end - 31
    end
end
