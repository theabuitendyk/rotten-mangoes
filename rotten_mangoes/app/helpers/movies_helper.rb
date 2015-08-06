module MoviesHelper
  def formatted_date(date)
    date.strftime("%b %e")
  end

  def long_formatted_date(date)
    date.strftime("%b %e, %Y")
  end
end
