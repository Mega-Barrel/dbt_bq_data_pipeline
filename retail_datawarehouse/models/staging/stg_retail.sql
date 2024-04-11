
{{
  config(
    materialized = 'view',
    )
}}

WITH test_data AS (
    SELECT
        InvoiceNo AS invoice_no,
        StockCode AS stock_code,
        Quantity AS quantity,
        InvoiceDate AS invoice_date,
        UnitPrice AS unit_price,
        CustomerID AS customer_id,
        Country AS country
    FROM
        {{ source('public', 'retail_sales') }}
)

SELECT
    *
FROM
    test_data
