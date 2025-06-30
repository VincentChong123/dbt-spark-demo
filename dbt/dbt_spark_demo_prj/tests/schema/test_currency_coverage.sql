-- tests/schema/test_currency_coverage.sql


SELECT *
FROM {{ ref('transactions') }}
WHERE branch_marker NOT IN (
    'USD_BRANCH',
    'SGD_BRANCH',
    'UNKNOWN_BRANCH')