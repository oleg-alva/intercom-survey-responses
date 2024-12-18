SELECT 
    survey_content_id, -- int
    survey_content_title, -- string
    email as respondent_email, -- string
    organization_id, -- int
    organization_name, -- string
    answers.question_id, -- int
    answers.answered_at, -- timestamp
    answers.response, -- int
    CASE WHEN answer_1_value >= 9 THEN 'promoter'
         WHEN answer_1_value >= 7 AND answer_1_value <= 8 THEN 'passive'
         WHEN answer_1_value <= 6 THEN 'detractor'
    END as category -- string
FROM {{ ref('staging__responses') }}
WHERE survey_content_id IN ('id1', 'id2', 'id3')
