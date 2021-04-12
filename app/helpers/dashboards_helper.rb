module DashboardsHelper
  def performance(current_value, reference_value)
    ((current_value.to_f / reference_value.to_f) - 1) * 100
  end
end