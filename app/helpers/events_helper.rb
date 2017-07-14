module EventsHelper
  AS1 = Date.new(1966, 5, 1)

  def sca_date(datetime, format: '')
    datetime = datetime.to_time # Just in case
    strformat = "%e %B #{sca_year(datetime)}"
    strformat += ' (%Y&nbsp;CE)' unless format.to_s =~ %r[no_ce]
    strformat += ' %l:%M %P' unless format.to_s =~ %r[date_only]

    raw datetime.strftime strformat
  end

  def sca_year(date)
    date = date.to_date # Just in case
    ret = date.year - AS1.year
    ret += 1 if date >= Date.new(date.year, 5, 1)
    ret
  end

  def event_date(event, format: '')
    if event.start_at.to_date === event.end_at.to_date && format =~ %r[date_only]
      sca_date(event.start_at, format: format)
    else
      sca_date(event.start_at, format: format) +
          raw('&ndash;') +
          sca_date(event.end_at, format: format)
    end
  end
end
