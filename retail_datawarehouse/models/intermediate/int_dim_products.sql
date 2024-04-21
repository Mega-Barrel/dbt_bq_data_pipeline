
WITH product_dim AS (
    SELECT DISTINCT
        {{ dbt_utils.generate_surrogate_key(['stock_code', 'description', 'unit_price']) }} as product_id,
        stock_code,
        description,
        unit_price
    FROM
        {{ ref('stg_retail') }}
)

SELECT
    *
FROM
    product_dim
WHERE
    stock_code IS NOT NULL
AND
    unit_price > 0
