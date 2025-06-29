

WITH base AS (
    SELECT
        id,
        amount,
        currency,
        status
    FROM default.raw__transactions
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