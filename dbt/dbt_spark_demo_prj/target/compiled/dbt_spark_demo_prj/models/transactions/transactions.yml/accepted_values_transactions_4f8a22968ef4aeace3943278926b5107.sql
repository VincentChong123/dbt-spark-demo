
    
    

with all_values as (

    select
        branch_marker as value_field,
        count(*) as n_records

    from default.transactions
    group by branch_marker

)

select *
from all_values
where value_field not in (
    'USD_BRANCH','SGD_BRANCH','UNKNOWN_BRANCH'
)


