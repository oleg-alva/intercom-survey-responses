SELECT 
    survey_content_id, -- int
    survey_content_title, -- string
    email as respondent_email, -- string
    organization_id, -- int
    organization_name, -- string
    answers.question_id, -- int
    answers.answered_at, -- timestamp
    answers.response, -- int
    CASE WHEN response >= 4 THEN 'positive'
         WHEN response = 3 THEN 'neutral'
         WHEN response <= 2 THEN 'negative'
    END as category -- string
FROM {{ ref('staging__responses') }}
WHERE survey_content_id IN ('id1', 'id2', 'id3')
