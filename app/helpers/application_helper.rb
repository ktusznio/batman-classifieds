module ApplicationHelper
  def tab_active?(tab)
    tab == params[:filter]
  end

  def date(date)
    return "unknown" if date.nil?
    date.strftime("%Y-%m-%d")
  end

  def datetime(date)
    return "unknown" if date.nil?
    date.strftime("%Y-%m-%d %I:%M%p")
  end

  def pretty_date(date)
    if date.beginning_of_day == Time.zone.now.beginning_of_day
      # today
      content_tag(:span, date.strftime("Today, %H:%M"), :class=> "today")
    elsif date.beginning_of_day == Time.zone.now.yesterday.beginning_of_day
      # yesterday
      content_tag(:span, date.strftime("Yesterday, %H:%M"), :class => "yesterday")
    else
      # other dates
      date.to_s(:short)
    end
  end

  def pretty_datetime(from_time, to_time = Time.now.utc)
    from_time = from_time.to_time if from_time.respond_to?(:to_time)
    to_time = to_time.to_time if to_time.respond_to?(:to_time)

    distance_in_minutes = (((to_time - from_time).abs)/60).round
    distance_in_seconds = ((to_time - from_time).abs).round

    case distance_in_minutes
      when 0..1
        case distance_in_seconds
          when 0..5   then 'less than 5 seconds ago'
          when 6..10  then 'less than 10 seconds ago'
          when 11..20 then 'less than 20 seconds ago'
          when 21..40 then 'half a minute ago'
          when 41..59 then 'less than a minute ago'
          else             '1 minute ago'
        end

      when 2..45      then "#{distance_in_minutes} minutes ago"
      when 46..90     then 'about 1 hour ago'
      when 90..1440   then "about #{(distance_in_minutes.to_f / 60.0).round} hours ago"
      when 1441..2880 then '1 day ago'
      else                 "#{(distance_in_minutes / 1440).round} days ago"
    end
  end


end
