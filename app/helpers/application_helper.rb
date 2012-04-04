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
    if focused_date < Date.today
      dates << focused_date + 1.day
    else
      dates.unshift(focused_date - 2.day)
    end
    dates.inject({}) do |hash, date|
      hash.merge! [date.strftime("%Y-%m-%d"), friendly_date_str(date)] => (date <=> focused_date)
    end
  end

  def backable_header(title)
    extra = if block_given?
              yield
            else
              ""
            end

    render "shared/backable_header", :title => title, :extra => extra
  end
end
