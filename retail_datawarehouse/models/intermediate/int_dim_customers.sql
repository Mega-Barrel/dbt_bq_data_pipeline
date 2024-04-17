-- Intermediate Customer dim Model

WITH customer_dim AS (
    SELECT
        {{ dbt_utils.generate_surrogate_key(['Customer_id', 'Country']) }} as customer_id,
        country
    FROM
        {{ ref('stg_retail') }}
)

SELECT
    *
FROM
    customer_dim
