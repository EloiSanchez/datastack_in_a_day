{% macro create_masking_policy_masking_employee(node_database,node_schema) %}

CREATE MASKING POLICY IF NOT EXISTS {{node_database}}.{{node_schema}}.masking_employee AS (end_date date) 
  RETURNS date ->
      CASE WHEN CURRENT_ROLE() IN ('ACCOUNTADMIN', 'TEAM_MANAGER') THEN end_date 
           WHEN CURRENT_ROLE() IN ('DEVELOPER') THEN TO_DATE('0001-01-01')
      ELSE TO_DATE('9999-11-11')
      END

{% endmacro %}