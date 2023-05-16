
{% macro combinations(items1, items2, multiple_columns=False) -%}

    {% if multiple_columns %}
        select 
            trim(split_part(value, ',', 1), '" ') as value_1,
            trim(split_part(value, ',', 2), '" ') as value_2 
    {% else %}
        select trim(value, '"') as value 
    {%- endif -%}
    
        from table(flatten(array_construct(
    {%- for item1 in items1 -%}

        {%- for item2 in items2 %}

            '{{item1}}, {{item2}}'
            
            {%- if not loop.last -%}
                ,
            {%- endif -%}
        
        {%- endfor -%}
        
        {%- if not loop.last -%}
            ,
        {%- endif -%}
    
    {%- endfor %}
    )))
    
{%- endmacro %}