with nps_rating as (
    select
        count(*) as response_count,
        sum(case when category = 'promoter' then 1 else 0 end) as n_promoters,
        sum(case when category = 'detractor' then 1 else 0 end) as n_detractors
    from {{ ref('nps_response') }}
)

select
    response_count,
    n_promoters,
    n_detractors,
    round((n_promoters::float - n_detractors::float) * 100.0 / nullif(response_count, 0)) as nps_score
from nps_rating
