-- Intermediate Customer dim Model

WITH customer_dim AS (
    SELECT
        {{ dbt_utils.generate_surrogate_key(['customer_id', 'country']) }} as customer_id,
        country
    FROM
        {{ ref('stg_retail') }}
    WHERE
        customer_id IS NOT NULL
)

SELECT
    DISTINCT customer_id,
    country
FROM
    customer_dim
