with nps_rating as (
    select
        d.month_start_date,
        count(*) as response_count,
        sum(case when category = 'promoter' then 1 else 0 end) as n_promoters,
        sum(case when category = 'detractor' then 1 else 0 end) as n_detractors
    from {{ ref('nps_response') }} r
    inner join {{ ref('dim_dates') }} d
        on date(r.answered_at_date) = d.date_day
    group by 
        d.month_start_date
)

select
    month_start_date,
    response_count,
    round(safe_divide((n_promoters - n_detractors) * 100.0, response_count)) as nps_score
from nps_rating
order by 
    month_start_date

