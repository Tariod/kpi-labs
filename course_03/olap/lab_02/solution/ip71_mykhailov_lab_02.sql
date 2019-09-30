-- Task 1
-- Показати ранг кожного товару у групі/категорії (відповідно до зменшення
-- ціни в групі). Запит реалізувати через функції rank() та dense_rank().
-- Порівняти результати виконання. Крім того сформуйте запит без використання
-- аналітичних функцій.
SELECT
       product_type_name,
       product_name,
       price,
       rank() OVER (
           PARTITION BY p.id_product_type
           ORDER BY price DESC
        ) price_rank
FROM product p
    JOIN product_type pt
        ON p.id_product_type = pt.id_product_type;

SELECT
       product_type_name,
       product_name,
       price,
       dense_rank() OVER (
           PARTITION BY p.id_product_type
           ORDER BY price DESC
        ) price_rank
FROM product p
    JOIN product_type pt
        ON p.id_product_type = pt.id_product_type;

SELECT
       product_type_name,
       product_name,
       price,
       (
           SELECT
                  1 + count(*)
           FROM product p2
           WHERE p2.id_product_type = p.id_product_type AND
                 p2.price > p.price
           ) AS price_rank
FROM product p
    JOIN product_type pt
        ON p.id_product_type = pt.id_product_type
ORDER BY product_type_name, price DESC;

-- Task 2
-- За допомогою аналітичного SQL сформуйте запит для виведення списку із трьох
-- найдешевших товарів у кожній групі. Крім того сформуйте запит без
-- використання аналітичних функцій.

SELECT * FROM (
              SELECT
                     product_type_name,
                     product_name,
                     price,
                     rank() OVER (
                         PARTITION BY p.id_product_type
                         ORDER BY price
                         ) price_rank
              FROM product p JOIN product_type pt
                  ON p.id_product_type = pt.id_product_type
                  ) three_cheapest
WHERE price_rank <= 3;

SELECT * FROM (
    SELECT
           product_type_name,
           product_name,
           price,
           (
               SELECT
                      1 + count(*)
               FROM product p2
               WHERE p2.id_product_type = p.id_product_type AND
                     p2.price < p.price
               ) AS price_rank
    FROM product p
        JOIN product_type pt
            ON p.id_product_type = pt.id_product_type
    ) three_cheapest
WHERE price_rank <= 3 ORDER BY product_type_name;

-- Task 3
-- f1 – продукти по яким здійснюються продажі, f2 – номер місяця, f3 – продажі
-- по товару за певний місяць 2012 року, f4 – продажі по товару за певний
-- місяць 2013 року, f5 – наростаючий підсумок продажів по товару за певний
-- місяць 2012 року, f5 – наростаючий підсумок продажів по товару за певний
-- місяць 2013 року. Крім того сформуйте запит без використання аналітичних
-- функцій.

WITH invoice_2012_2013 AS (
    SELECT * FROM (
        SELECT
               i.id_invoice,
               date_part('year', purchase_time) AS year_of_purchase,
               date_part('month', purchase_time) AS month_of_purchase,
               id_product,
               quantity
        FROM invoice i
            JOIN invoice_detail id
                ON i.id_invoice = id.id_invoice
        ) i2012_2013
    WHERE year_of_purchase = 2012 OR year_of_purchase = 2013
    ), invoice_2012 AS (
        SELECT * FROM invoice_2012_2013
        WHERE year_of_purchase = 2012
    ), invoice_2013 AS (
        SELECT * FROM invoice_2012_2013
        WHERE year_of_purchase = 2013
    )
SELECT
       *,
        sum(income_2012) OVER (
            PARTITION BY product_name
            ORDER BY month_of_purchase
            ) AS gained_income_2012,
        sum(income_2013) OVER (
            PARTITION BY product_name
            ORDER BY month_of_purchase
            ) AS gained_income_2013
FROM (
    SELECT
           product_name,
           i.month_of_purchase,
           sum(i2012.quantity * price) AS income_2012,
           sum(i2013.quantity * price) AS income_2013
    FROM product p
        JOIN invoice_2012_2013 i
            ON p.id_product = i.id_product
        LEFT JOIN invoice_2012 i2012
            ON i.id_invoice = i2012.id_invoice AND i.id_product = i2012.id_product
        LEFT JOIN invoice_2013 i2013
            ON i.id_invoice = i2013.id_invoice AND i.id_product = i2013.id_product
    GROUP BY product_name, i.month_of_purchase
    ) gained_income;

WITH invoice_2012_2013 AS (
    SELECT * FROM (
        SELECT
               i.id_invoice,
               date_part('year', purchase_time) AS year_of_purchase,
               date_part('month', purchase_time) AS month_of_purchase,
               id_product,
               quantity
        FROM invoice i
            JOIN invoice_detail id
                ON i.id_invoice = id.id_invoice
        ) i2012_2013
    WHERE year_of_purchase = 2012 OR year_of_purchase = 2013
    ), invoice_2012 AS (
        SELECT * FROM invoice_2012_2013
        WHERE year_of_purchase = 2012
    ), invoice_2013 AS (
        SELECT * FROM invoice_2012_2013
        WHERE year_of_purchase = 2013
    ), income AS (
        SELECT
               product_name,
               i.month_of_purchase,
               sum(i2012.quantity * price) AS income_2012,
               sum(i2013.quantity * price) AS income_2013
        FROM product p
            JOIN invoice_2012_2013 i
                ON p.id_product = i.id_product
            LEFT JOIN invoice_2012 i2012
                ON i.id_invoice = i2012.id_invoice AND i.id_product = i2012.id_product
            LEFT JOIN invoice_2013 i2013
                ON i.id_invoice = i2013.id_invoice AND i.id_product = i2013.id_product
        GROUP BY product_name, i.month_of_purchase
    )
SELECT
       *,
        (
            SELECT
                   sum(income_2012)
            FROM income i2
            WHERE i.product_name = i2.product_name AND
                  i.month_of_purchase >= i2.month_of_purchase
            ) AS gained_income_2012,
        (
            SELECT
                   sum(income_2013)
            FROM income i3
            WHERE i.product_name = i3.product_name AND
                  i.month_of_purchase >= i3.month_of_purchase
            ) AS gained_income_2013
FROM income i;

-- Task 4
-- Показати, які товари по кожній групі мають найбільші та найменші продажі.
-- Крім того сформуйте запит без використання аналітичних функцій.

SELECT product_type_name, product_name, income FROM (
    SELECT
           product_type_name,
           product_name,
           income,
           first_value(income) OVER (
               PARTITION BY pt.id_product_type
               ORDER BY income
               ) AS minimum_sales,
           first_value(income) OVER (
               PARTITION BY pt.id_product_type
               ORDER BY income DESC
               ) AS maximum_sales
    FROM (
        SELECT
               id_product_type,
               p.id_product,
               product_name,
               sum(quantity * price) AS income
        FROM product p
            JOIN invoice_detail id
                ON p.id_product = id.id_product
        GROUP BY p.id_product
             ) p
        JOIN product_type pt
            ON p.id_product_type = pt.id_product_type
) extreme_product_in_group
WHERE
      income = maximum_sales OR
      income = minimum_sales;

WITH income_by_product AS (
    SELECT
           id_product_type,
           p.id_product,
           product_name,
           sum(quantity * price) AS income
    FROM product p
        JOIN invoice_detail id
            ON p.id_product = id.id_product
    GROUP BY p.id_product
)
SELECT
    product_type_name,
    product_name,
    income
FROM income_by_product ip
         JOIN product_type pt
              ON ip.id_product_type = pt.id_product_type
         JOIN (
             SELECT
                    id_product_type,
                    max(income) AS maximum_sales,
                    min(income) AS minimum_sales
             FROM income_by_product
             GROUP BY id_product_type
) extreme_product_in_group
             ON ip.id_product_type = extreme_product_in_group.id_product_type
WHERE
      income = maximum_sales OR
      income = minimum_sales
ORDER BY product_type_name, income;

-- Task 5
-- По кожному товару підрахувати кількість товарів, у яких вартість вища від
-- даного товару у діапазоні від 5 до 10 включно. Наприклад якщо прайс
-- товару 6, то знайти кількість товарів, у яких діапазон прайсів від 11 до 16.

SELECT
       product_name,
       price,
       count(*) OVER (
           ORDER BY price
           RANGE BETWEEN 5 FOLLOWING AND
               10 FOLLOWING
           )
FROM product;

-- Task 6
-- По кожному товару вивести першу(f3) та останню(f4) дату продажів по кожному
-- місяцю, cуму продажів (f5), відсоток від річної суми(f6).

WITH extended_invoice AS (
    SELECT
           *,
           date_part('year', purchase_time) AS year_of_purchase,
           date_part('month', purchase_time) AS month_of_purchase
    FROM invoice
    )
SELECT
       product_name,
       ei.year_of_purchase,
       month_of_purchase,
       first_value(purchase_time) OVER (
           PARTITION BY product_name, ei.year_of_purchase, month_of_purchase
           ORDER BY purchase_time
           ) AS first_purchase,
       first_value(purchase_time) OVER (
           PARTITION BY product_name, ei.year_of_purchase, month_of_purchase
           ORDER BY purchase_time DESC
           ) AS last_purchase,
       sum(quantity * price) AS month_income,
       sum(quantity * price) / year_income * 100 AS month_to_year_income
FROM product p
    JOIN invoice_detail id
        ON p.id_product = id.id_product
    JOIN extended_invoice ei
        ON id.id_invoice = ei.id_invoice
    JOIN (
        SELECT
               p.id_product,
               year_of_purchase,
               sum(quantity * price) AS year_income
        FROM product p
            JOIN invoice_detail id
                ON p.id_product = id.id_product
            JOIN extended_invoice ei ON id.id_invoice = ei.id_invoice
        GROUP BY p.id_product, year_of_purchase
    ) yp ON p.id_product = yp.id_product AND ei.year_of_purchase = yp.year_of_purchase
GROUP BY product_name, ei.year_of_purchase, month_of_purchase, purchase_time, year_income;

-- Task 7
-- За допомогою ROLLUP та CUBE виведіть проміжні суми продажу по групам товарів.

SELECT
       product_type_name,
       product_name,
       sum(quantity * price)
FROM product p
    JOIN product_type pt
        ON p.id_product_type = pt.id_product_type
    JOIN invoice_detail id
        ON p.id_product = id.id_product
GROUP BY
ROLLUP (product_type_name, product_name)
ORDER BY product_type_name, product_name;

SELECT
       product_type_name,
       date_part('year', purchase_time),
       sum(quantity * price)
FROM product p
    JOIN product_type pt
        ON p.id_product_type = pt.id_product_type
    JOIN invoice_detail id
        ON p.id_product = id.id_product
    JOIN invoice i
        ON id.id_invoice = i.id_invoice
GROUP BY
CUBE (product_type_name, date_part('year', purchase_time))
ORDER BY product_type_name;
