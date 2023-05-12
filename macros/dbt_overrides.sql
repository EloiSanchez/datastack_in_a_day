-- By default, custom schema name will be combined with target.schema name
-- Override this schema to based on requirements

{% macro generate_schema_name(custom_schema_name, node) -%}

{%- set default_schema = target.schema -%}

{%- if custom_schema_name is none -%}
	{{ default_schema }}
	{{ log("Setting Default Schema: {0}".format(target.schema)) }}
{%- elif target.name.startswith('dev') -%}
    {%- set dev_schema =  default_schema + custom_schema_name -%}
    {{ default_schema | trim }}_{{ custom_schema_name | trim}}
	{{ log("Setting Development Schema: {0}".format(dev_schema)) }}
{%- else -%}
	{{ custom_schema_name | trim }}
	{{ log("Setting Custom Schema: {0}".format(custom_schema_name | trim)) }}
{%- endif -%}

{%- endmacro %}