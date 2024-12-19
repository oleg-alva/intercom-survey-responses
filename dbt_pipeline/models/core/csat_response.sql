SELECT 
    survey_content_id, -- int
    survey_content_title, -- string
    respondent_email, -- string
    organization_id, -- int
    organization_name, -- string
    question_id, -- int
    answered_at, -- timestamp
    date(answered_at) as answered_at_date,
    CAST(response AS INT) as response, -- int
    CASE WHEN CAST(response AS INT) >= 4 THEN 'positive'
         WHEN CAST(response AS INT) = 3 THEN 'neutral'
         WHEN CAST(response AS INT) <= 2 THEN 'negative'
    END as category -- string
FROM {{ ref('staging__responses') }}
WHERE true
AND survey_content_id IN (135826)
AND question_id IN (433942)