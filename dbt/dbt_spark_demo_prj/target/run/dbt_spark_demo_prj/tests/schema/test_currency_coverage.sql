
    select
      count(*) as failures,
      count(*) != 0 as should_warn,
      count(*) != 0 as should_error
    from (
      
    
  -- tests/schema/test_currency_coverage.sql


SELECT *
FROM default.transactions
WHERE branch_marker NOT IN (
    'USD_BRANCH',
    'SGD_BRANCH',
    'UNKNOWN_BRANCH')
  
  
      
    ) dbt_internal_test