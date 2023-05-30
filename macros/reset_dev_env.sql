{% macro drop_dev_env() %}

    {{ log('Dropping all schemas from database ' ~ target.database, info=True) }}

    {% set query = 'show schemas' %}

    {% set results = run_query(query) %}

    {% set databases = results.columns['database_name'].values() %}
    {% set schemas = results.columns['name'].values() %}

    {% for schema, database in zip(schemas, databases) %}
        {% set database = database.lower() %}
        {% set schema = schema.lower() %}

        {% if database == target.database and schema not in ('information_schema', 'public') %}
            {% set query = 'DROP SCHEMA ' ~ database ~ '.' ~ schema ~ ';' %}
            {{ log('{}'.format(query), info=True) }}
            {{ run_query(query) }}
        {% else %}
            {{ log('Ignoring ' ~ database ~ '.' ~ schema, info=True) }}
        {% endif %}
    {% endfor %}

{% endmacro %}


{% macro clone_env(prefix = None, database = 'PRODUCTION') %}

    {{ log('Cloning environment from production to ' ~ target.name ~ ' in database ' ~ target.database, info=True) }}

    {% if prefix == None %}
        {% set prefix = target.schema %}
    {% endif %}

    {% set query= 'SHOW SCHEMAS IN DATABASE {}'.format(database) %}
    {% set results = run_query(query) %}
    
    {% set schemas = results.columns['name'].values() %}

    {% set database = database.lower() %}

    {% for schema in schemas %}
        {% set schema = schema.lower() %}

        {% if schema not in ('information_schema', 'public') %}
            {% set query = 'CREATE SCHEMA {}.{} CLONE {}.{};'.format(target.database, prefix ~ '_' ~ schema, database, schema) %}
            {{ log('{}'.format(query), info=True) }}
            {{ run_query(query) }}
        {% else %}
            {{ log('Ignoring ' ~ database ~ '.' ~ schema, info=True) }}
        {% endif %}
    {% endfor %}

{% endmacro %}


{% macro reset_env(prefix = None, database = 'PRODUCTION') %}

    {{ log('Resetting current environment and cloning from database {}'.format(database.upper()), info=True) }}


    {{ log('Deleting development environment...', info=True) }}

    {{ drop_dev_env() }}

    {{ log('Done', info=True) }}

    {{ log('Cloning from database {}'.format(database.upper()), info=True) }}

    {{ clone_env(prefix, database) }}

    {{ log('Done', info=True) }}

{% endmacro %}