WITH source AS (
    SELECT
        u.id AS user_id,
        u.email,
        o.id AS organization_id,
        o.name AS organization_name,
        COALESCE(e.is_key_member, FALSE) AS is_key_member,
        UPPER(ag.name) AS access_group_name
    FROM {{ source('main', 'auth_user') }} u
    INNER JOIN {{ source('main', 'employment') }} e 
        ON e.user_id = u.id
    INNER JOIN {{ source('main', 'organization') }} o 
        ON o.id = e.organization_id
    LEFT JOIN {{ source('main', 'access_group_table') }} ag 
        ON ag.id = e.access_group_id
    WHERE u.email IS NOT NULL
    AND NOT u.email LIKE '%alvalabs.io'
    AND TRIM(u.email) != ''
)

SELECT
    user_id, -- int
    email, -- string
    organization_id, -- int
    organization_name, -- string
    is_key_member, -- boolean
    access_group_name -- string
FROM source
