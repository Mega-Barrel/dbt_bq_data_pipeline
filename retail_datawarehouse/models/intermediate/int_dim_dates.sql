
WITH raw_dates AS (
    SELECT
        DISTINCT InvoiceDate AS invoice_date
    FROM
        {{ source('public', 'retail_sales') }}
)

SELECT
    invoice_date AS date_id,
    EXTRACT(DATE FROM invoice_date) AS date,
    EXTRACT(DAYOFWEEK FROM invoice_date) AS week_number,
    DATE_TRUNC(DATE(invoice_date), week) AS week,
    EXTRACT(YEAR FROM invoice_date) AS year,
    EXTRACT(MONTH FROM invoice_date) AS month_no,
    FORMAT_DATETIME('%B', invoice_date) AS month,
    EXTRACT(HOUR FROM invoice_date) AS hour,
    EXTRACT(MINUTE FROM invoice_date) AS minute,
    EXTRACT(QUARTER FROM invoice_date) AS quarter,
    FORMAT_DATETIME('%Y-%m', invoice_date) AS year_month,
    FORMAT_DATETIME('%Y-%B', invoice_date) AS year_month_full
FROM
    raw_dates
