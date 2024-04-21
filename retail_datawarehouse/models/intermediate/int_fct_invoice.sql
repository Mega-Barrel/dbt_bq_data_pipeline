
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
    dt.date_id,
    dp.product_id,
    dc.customer_id,
    quantity,
    fi.unit_price,
    total_sale
FROM
    fact_invoices fi
INNER JOIN {{ ref('int_dim_dates') }} dt ON fi.datetime_id = dt.date_id
INNER JOIN {{ ref('int_dim_products') }} dp ON fi.product_id = dp.product_id
INNER JOIN {{ ref('int_dim_customers') }} dc ON fi.customer_id = dc.customer_id



