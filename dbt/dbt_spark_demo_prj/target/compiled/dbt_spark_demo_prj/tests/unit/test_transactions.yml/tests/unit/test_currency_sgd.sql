

WITH  __dbt__cte__raw__transactions as (

-- Fixture for raw__transactions
select cast(2 as bigint)
 as id, cast(100 as bigint)
 as amount, cast('SGD' as string)
 as currency, cast('ACTIVE' as string)
 as status
), base AS (
    SELECT
        id,
        amount,
        currency,
        status
    FROM __dbt__cte__raw__transactions
),

filtered AS (
    SELECT *
    FROM base
    WHERE status = 'ACTIVE'
),

final AS (
    SELECT
        id,
        amount,
        currency,
        CASE
            WHEN currency = 'USD' THEN amount
            WHEN currency = 'SGD' THEN amount * 0.74
            -- ELSE NULL
        END AS amount_usd,
        CASE
            WHEN currency = 'USD' THEN 'USD_BRANCH'
            WHEN currency = 'SGD' THEN 'SGD_BRANCH'
            ELSE 'UNKNOWN_BRANCH'
        END AS branch_marker
    FROM filtered
)

SELECT *
FROM final