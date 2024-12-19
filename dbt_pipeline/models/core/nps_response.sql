SELECT 
    survey_content_id, -- int
    survey_content_title, -- string
    respondent_email, -- string
    organization_id, -- int
    organization_name, -- string
    question_id, -- int
    answered_at, -- timestamp
    date(answered_at) as answered_at_date, -- date
    CAST(response AS INT) as response, -- int
    CASE WHEN CAST(response AS INT) >= 9 THEN 'promoter'
         WHEN CAST(response AS INT) >= 7 AND CAST(response AS INT) <= 8 THEN 'passive'
         WHEN CAST(response AS INT) <= 6 THEN 'detractor'
    END as category -- string
FROM {{ ref('staging__responses') }}
WHERE true
AND survey_content_id IN (135107)
AND question_id IN (431254)