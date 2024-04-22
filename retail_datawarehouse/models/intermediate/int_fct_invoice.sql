
WITH fact_invoices AS (

    SELECT
        invoice_no,
        invoice_date AS datetime_id,
        {{ dbt_utils.generate_surrogate_key(['customer_id', 'country']) }} as customer_id,
        {{ dbt_utils.generate_surrogate_key(['stock_code', 'description', 'unit_price']) }} as product_id,
        quantity,
        unit_price,
        ROUND(quantity * unit_price, 2) AS total_sale
    FROM
        {{ ref('stg_retail') }}
    WHERE
        quantity > 0
)

SELECT
    invoice_no,
    datetime_id,
    customer_id,
    product_id,
    quantity,
    unit_price,
    total_sale
FROM
    fact_invoices
