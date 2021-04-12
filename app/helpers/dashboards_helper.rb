module DashboardsHelper
  def performance(current_value, reference_value)
    ((current_value.to_f / reference_value.to_f) - 1) * 100
  end

  def performance_color(performance_value)
    performance_value.positive? ? "success" : "danger"
  end
end