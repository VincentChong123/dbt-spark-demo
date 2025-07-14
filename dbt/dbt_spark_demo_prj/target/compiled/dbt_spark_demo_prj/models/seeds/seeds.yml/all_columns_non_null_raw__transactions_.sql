
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
        case when `status` is null then 'status' else null end
        
      
    from default.raw__transactions
    where
      
        `id` is null
         or 
      
        `amount` is null
         or 
      
        `currency` is null
         or 
      
        `status` is null
        
      
  

