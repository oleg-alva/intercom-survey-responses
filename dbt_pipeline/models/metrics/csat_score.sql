with csat_score as (
    select 
        d.year_number,
        d.month_of_year,
        d.month_name,
        count(case when r.rating >= 4 then 1 end) as count_csat_ratings,
        count(*) as count_sent
    from {{ ref('csat_response') }} r
    inner join {{ ref('dim_dates') }} d
        on date(r.created_at) = d.date_day
    group by 
        d.year_number,
        d.month_of_year,
        d.month_name
)

select
    year_number, -- int 
    month_of_year, -- int
    month_name, -- string
    round(safe_divide(count_csat_ratings, count_sent), 2) as csat_score -- float
from csat_score
order by 
    year_number,
    month_of_year
