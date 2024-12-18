#!/bin/sh
dbt deps --project-dir intercom-survey-responses --profiles-dir . --target prod
dbt source freshness --project-dir intercom-survey-responses --profiles-dir . --target prod
dbt build --project-dir intercom-survey-responses --profiles-dir . --target prod
