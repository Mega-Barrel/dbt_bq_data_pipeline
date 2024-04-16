
WITH raw_dates AS (
    SELECT
        DISTINCT InvoiceDate AS invoice_date
    FROM
        {{ source('public', 'retail_sales') }}
)

SELECT
    invoice_date AS date_id,
    EXTRACT(DATE FROM invoice_date) AS date,
    EXTRACT(DAYOFWEEK FROM invoice_date) AS weekday,
    EXTRACT(YEAR FROM invoice_date) AS year,
    EXTRACT(MONTH FROM invoice_date) AS month,
    EXTRACT(QUARTER FROM invoice_date) AS quarter,
    FORMAT_DATETIME('%m-%Y', invoice_date) AS month_year,
    FORMAT_DATETIME('%B-%Y', invoice_date) AS month_year_full
FROM
    raw_dates
