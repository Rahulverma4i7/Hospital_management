module ApplicationHelper
  def line_chart(data, options = {})
    # This will be used by the chartkick gem
    content_tag(:div, "", data: { chart: "line", series: data.to_json })
  end
  def age_from_dob(dob)
    return "N/A" unless dob
    now = Time.now.utc.to_date
    now.year - dob.year - ((now.month > dob.month || (now.month == dob.month && now.day >= dob.day)) ? 0 : 1)
  end
end
