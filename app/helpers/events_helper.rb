module EventsHelper
  AS1 = Date.new(1966, 5, 1)

  def sca_date(datetime, options={})
    datetime = datetime.to_time # Just in case
    format = "%e %B #{sca_year(datetime)}"
    format += ' (%Y CE)' unless options[:format] =~ %r[no_ce]
    format += ' %l:%M %P' unless options[:format] =~ %r[date_only]

    datetime.strftime format
  end

  def sca_year(date)
    date = date.to_date # Just in case
    ret = date.year - AS1.year
    ret += 1 if date >= Date.new(date.year, 5, 1)
    ret
  end

  def event_date(event, options={})
    if event.start_at.to_date === event.end_at.to_date && options[:format] == :date_only
      sca_date(event.start_at, options)
    else
      sca_date(event.start_at, options) +
          ' &ndash; ' +
          sca_date(event.end_at, options)
    end
  end
end

