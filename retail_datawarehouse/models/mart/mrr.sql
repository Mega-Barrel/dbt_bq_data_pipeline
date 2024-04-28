-- Monthly MRR by products

SELECT
    year,
    country,
    ROUND(SUM(total_sale), 2) AS product_sales
FROM
    {{ ref('sales_obt') }}
WHERE
    is_cancelled IS NOT FALSE
GROUP BY
    1, 2
ORDER BY
    1 ASC,
    3 DESC
