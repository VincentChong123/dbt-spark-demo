
    select
      count(*) as failures,
      count(*) != 0 as should_warn,
      count(*) != 0 as should_error
    from (
      
        select *
        from default_dbt_test__audit.accepted_values_transactions_currency__USD__SGD
    
      
    ) dbt_internal_test