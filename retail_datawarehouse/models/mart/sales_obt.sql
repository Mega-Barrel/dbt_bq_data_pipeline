-- Sales one big table

WITH dim_products AS (
    SELECT
        *
    FROM
        {{ ref('int_dim_products') }}
),

dim_dates AS (
    SELECT
        *
    FROM
        {{ ref('int_dim_dates') }}
),

dim_customers AS (
    SELECT
        *
    FROM
        {{ ref('int_dim_customers') }}
)

SELECT
    fi.invoice_no,
    fi.datetime_id,
    fi.customer_id,
    fi.product_id,
    {# Product dim columns #}
    stock_code,
    description,
    is_cancelled,
    {# Date dim columns #}
    dd.date,
    dd.week_number,
    dd.week,
    dd.year,
    dd.month_no,
    dd.month,
    dd.hour,
    dd.minute,
    dd.quarter,
    dd.year_month,
    dd.year_month_full,
    {# customer dim columns #}
    dc.country,
    {# Fact column #}
    fi.quantity,
    fi.unit_price,
    fi.total_sale
FROM
    {{ ref('int_fct_invoice') }} fi
INNER JOIN
    dim_products dp ON fi.product_id = dp.product_id
INNER JOIN
    dim_dates dd ON fi.datetime_id = dd.date_id
INNER JOIN
    dim_customers dc ON fi.customer_id = dc.customer_id
