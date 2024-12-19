SELECT  
CASE 
  WHEN campaign = "5fca258f245e3900047dd10e" THEN 135826
  WHEN campaign = "5fca254c5a9f7300040101ea" THEN 135107
  ELSE 0
END AS survey_content_id,
'' AS survey_content_title,
user_email AS respondent_email,
0 AS organization_id,
'' AS organization_name,
CASE 
  WHEN campaign = "5fca258f245e3900047dd10e" THEN 433942
  WHEN campaign = "5fca254c5a9f7300040101ea" THEN 431254
  ELSE 0
END AS question_id,
created AS answered_at,
answer_1_value AS response
FROM {{ source('satismeter_legacy_data', 'satismeter_legacy_responses') }}

UNION ALL

SELECT 
  survey_content_id,
  survey_content_title,
  email AS respondent_email,
  organization_id,
  organization_name,
  answers.question_id AS question_id,
  answers.answered_at AS answered_at,
  answers.response AS response
FROM {{ source('user_activity_events_production', 'intercom_survey_result_created') }}, 
UNNEST(answers) AS answers
ORDER BY answered_at DESC