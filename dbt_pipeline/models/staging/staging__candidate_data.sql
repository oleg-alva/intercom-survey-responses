WITH source AS (
    SELECT 
        u.id AS user_id,
        u.email,
        o.id AS organization_id,
        o.name AS organization_name,
        COUNT(1) AS total_job_applications
    FROM {{ source('main', 'auth_user') }} u
    INNER JOIN {{ source('main', 'job_application') }} a 
        ON a.user_id = u.id
    INNER JOIN {{ source('main', 'job_position') }} p 
        ON p.id = a.job_position_id
    INNER JOIN {{ source('main', 'organization') }} o 
        ON o.id = p.organization_id
    WHERE u.email IS NOT NULL
        AND TRIM(u.email) != ''
        AND NOT u.email LIKE '%alvalabs.io'
    GROUP BY 1, 2, 3, 4
)

SELECT 
    user_id, -- int
    email, -- string
    organization_id, -- int
    organization_name, -- string
    total_job_applications -- int
FROM source
