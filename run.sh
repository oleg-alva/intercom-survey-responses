#!/bin/sh
dbt deps --project-dir dbt_pipeline --profiles-dir . --target prod
dbt source freshness --project-dir dbt_pipeline --profiles-dir . --target prod
dbt build --project-dir dbt_pipeline --profiles-dir . --target prod