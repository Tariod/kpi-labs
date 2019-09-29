-- Назва поставщика повинна бути унікальна у рамках назв товарів.
-- Тобто, наприклад поле SUPPLIER = ‘Lg’ не може бути у різних
-- Product (TV-10).

SELECT s2.supplier, s2.product FROM (SELECT product FROM store
    GROUP BY product
        HAVING count(DISTINCT supplier) = 1) s1
JOIN store s2 ON s1.product = s2.product;

-- Максимальна кількість товарів на полиці STORE.SHELF – 30.
-- З урахуванням того, що STORE.QUANTITY – кількість товарів
-- на полиці STORE.SHELF.

SELECT shelf, sum(quantity::INTEGER) AS shelf_sum FROM store
    WHERE quantity ~ '^[0-9]+$'
        GROUP BY shelf
            HAVING sum(quantity::INTEGER) <= 30
    ORDER BY shelf_sum;

-- Діапазон дат: 01.01.2011 -  31.05.2014. Використайте
-- регулярні вирази.

SELECT * FROM invoice
    WHERE invoice_date ~ '\d{2}.\d{2}.\d{4}'
        AND invoice_date::DATE BETWEEN '2011-01-01' AND '2014-05-31';

-- Одному і тому ж значенню поля ID_STUFF повинні відповідати
-- одні й ті ж значення полів STUFF_NAME, E_MAIL таблиці INVOICE.

SELECT id_stuff FROM invoice
    GROUP BY id_stuff
    HAVING count(DISTINCT staff_name) = 1
       AND count(DISTINCT e_mail) = 1;

-- Типи операцій на складі – лише IN, OUT (незалежно від регістра).
-- Використайте регулярні вирази.

SELECT * FROM store
    WHERE oper_type ~* '^(in|out)$';
