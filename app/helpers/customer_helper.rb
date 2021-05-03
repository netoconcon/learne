module CustomerHelper
  def pending_tag(problems)
    if problems.zero?
      "OK"
    else
      "Alerta"
    end
  end

  def problems_tag(problems)
    if problems.zero?
      "completed"
    else
      "refused"
    end
  end
end