{% macro pivot_status_counts(status_column, status_list) -%}

    {%- for status in status_list -%}
        sum(case when {{ status_column }} = '{{ status }}' then 1 else 0 end) as staus_{{ status }}
        {%- if not loop.last %}, {% endif -%}
    {%- endfor -%}

{%- endmacro %}