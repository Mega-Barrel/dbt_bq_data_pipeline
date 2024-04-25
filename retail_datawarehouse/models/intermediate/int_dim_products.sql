
WITH product_dim AS (
    SELECT DISTINCT
        {{ dbt_utils.generate_surrogate_key(['stock_code', 'description', 'unit_price']) }} as product_id,
        stock_code,
        description,
        CASE
            WHEN invoice_no LIKE 'C%' THEN TRUE 
            ELSE FALSE
        END AS is_cancelled
    FROM
        {{ ref('stg_retail') }}
    WHERE
        unit_price > 0
)

SELECT
    *
FROM
    product_dim
WHERE
    stock_code IS NOT NULL
