module DatesHelper
  def humanize_date(date, show_year = false)
    show_year ? date.strftime("%d/%m/%y") : date.strftime("%d/%m")
  end
end