{% macro create_rla_employees(database, schema) %}
    {{ log('Creating ' ~ database ~ '.' ~ schema ~ '.rla_employees', info = True) }}

    {% set seed_schema='seeds' %}
    {% if target.name.startswith('dev') %}
        {% set seed_schema=target.schema ~ '_seeds' %}
    {% else %}
        {% set seed_schema='seeds' %}
    {% endif %}

    CREATE OR REPLACE ROW ACCESS POLICY {{ database }}.{{ schema }}.rla_employees
    AS (team int) RETURNS BOOLEAN ->
        'ACCOUNTADMIN' = CURRENT_ROLE()
        OR 'DEVELOPER' = CURRENT_ROLE()
        OR EXISTS (
                SELECT * FROM {{ database }}.{{ seed_schema }}.manager_table
                WHERE 1=1
                    AND 'TEAM_MANAGER' = CURRENT_ROLE()
                    AND username = lower(CURRENT_USER())
                    AND team = manager_of_team
            )
{% endmacro %}