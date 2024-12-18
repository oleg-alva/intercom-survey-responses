SELECT 
  survey_content_id, -- int
  survey_content_title, -- string
  email as respondent_email, -- string
  organization_id, -- int
  organization_name, -- string
  answers.question_id, -- int
  answers.answered_at, -- timestamp
  answers.response -- int
FROM {{ source('user_activity_events_production', 'intercom_survey_result_created') }}, unnest(answers) as answers
