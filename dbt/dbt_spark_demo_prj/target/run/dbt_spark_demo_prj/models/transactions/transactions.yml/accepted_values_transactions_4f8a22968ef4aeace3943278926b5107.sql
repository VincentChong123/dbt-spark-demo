
    select
      count(*) as failures,
      count(*) != 0 as should_warn,
      count(*) != 0 as should_error
    from (
      
        select *
        from default_dbt_test__audit.accepted_values_transactions_4f8a22968ef4aeace3943278926b5107
    
      
    ) dbt_internal_test