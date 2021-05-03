module CustomerHelper
  def pending_tag(problems)
    if problems.zero?
      "OK"
    else
      "Alerta"
    end
  end
end