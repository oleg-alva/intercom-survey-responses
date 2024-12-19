with csat_score as (
    select 
        d.month_start_date,
        count(case when r.response >= 4 then 1 end) as count_csat_ratings,
        count(*) as count_sent
    from {{ ref('csat_response') }} r
    inner join {{ ref('dim_dates') }} d
        on date(r.answered_at_date) = d.date_day
    group by 
        d.month_start_date
)

select
    month_start_date, -- date
    count_sent,
    round(safe_divide(count_csat_ratings, count_sent), 3) as csat_score -- float
from csat_score
order by 
    month_start_date