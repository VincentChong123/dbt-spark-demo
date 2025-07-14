
    select
      count(*) as failures,
      count(*) != 0 as should_warn,
      count(*) != 0 as should_error
    from (
      
        select *
        from default_dbt_test__audit.all_columns_non_null_in_seeds_transactions_
    
      
    ) dbt_internal_test