{% macro add_audit_columns() %}

    current_user()::varchar(100)           as user_name,
    '{{ invocation_id }}'::varchar(100)    as run_id,
    current_timestamp::timestamp_ntz       as modelcreated

{% endmacro %}