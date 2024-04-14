
WITH raw_dates AS (
    SELECT
        DISTINCT InvoiceDate AS invoice_date
    FROM
        {{ source('public', 'retail_sales') }}
)

SELECT
    invoice_date,
    EXTRACT(DATE FROM invoice_date) AS dt,
    EXTRACT(WEEK FROM invoice_date) AS dt_wk,
    EXTRACT(YEAR FROM invoice_date) AS dt_yr,
    EXTRACT(MONTH FROM invoice_date) AS dt_m
FROM
    raw_dates
