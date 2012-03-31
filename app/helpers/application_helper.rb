module ApplicationHelper
  def friendly_date_str(date)
    case date
    when Date.today then t("dates.today")
    when Date.yesterday then t("dates.yesterday")
    else date.strftime("%d/%m")
    end
  end

  def focused_date
    @focused_date ||= (
      date = Date.parse(params[:date]) if params[:date].present?
      date ||= Date.today
    )
  end

  def dates_to_display
    dates = [focused_date - 1.day, focused_date]
    dates << focused_date + 1.day if focused_date < Date.today
    dates.inject({}) do |hash, date|
      hash.merge! [date.strftime("%Y-%m-%d"), friendly_date_str(date)] => (date <=> focused_date)
    end
  end
end
