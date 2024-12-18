SELECT
  date_day, -- date
  day_of_week, -- string
  day_of_month, -- int
  day_of_year, -- int
  week_of_year, -- int
  month_of_year, -- int
  month_name, -- string
  quarter_of_year, -- int
  year_number -- int
FROM
  {{ ref('staging__dates') }}