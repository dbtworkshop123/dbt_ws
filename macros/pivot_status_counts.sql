{% macro pivot_status_counts(status_column) -%}

    {%- set status_list = ['completed', 'returned', 'return_pending', 'shipped', 'placed'] -%}

    {%- for status in status_list %}
        sum(case when {{ status_column }} = '{{ status }}' then 1 else 0 end) as status_{{ status }}
        {%- if not loop.last %},{% endif %}
    {%- endfor -%}

{%- endmacro %}