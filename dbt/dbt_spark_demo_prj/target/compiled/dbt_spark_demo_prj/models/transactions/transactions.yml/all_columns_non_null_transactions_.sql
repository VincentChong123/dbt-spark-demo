
    select
      
        -- For better debugging, return the rows where a null is found
        case when `id` is null then 'id' else null end
        , 
      
        -- For better debugging, return the rows where a null is found
        case when `amount` is null then 'amount' else null end
        , 
      
        -- For better debugging, return the rows where a null is found
        case when `currency` is null then 'currency' else null end
        , 
      
        -- For better debugging, return the rows where a null is found
        case when `amount_usd` is null then 'amount_usd' else null end
        , 
      
        -- For better debugging, return the rows where a null is found
        case when `branch_marker` is null then 'branch_marker' else null end
        
      
    from default.transactions
    where
      
        `id` is null
         or 
      
        `amount` is null
         or 
      
        `currency` is null
         or 
      
        `amount_usd` is null
         or 
      
        `branch_marker` is null
        
      
  

