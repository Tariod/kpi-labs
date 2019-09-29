CREATE TYPE CUSTOMER_CONTACT_TYPE AS ENUM (
    'Email',
    'Telephone number'
);

CREATE TYPE EMPLOYEE_CONTACT_TYPE AS ENUM (
    'Email',
    'Telephone number'
);

CREATE TABLE discounts (
    "Id"                VARCHAR(13)         UNIQUE,
    "Status"            BOOLEAN             DEFAULT false,
    "Discount"          SMALLINT            DEFAULT 0
);

CREATE TABLE customers (
    "Id"                  SERIAL PRIMARY KEY,
    "Login"               VARCHAR(30) REFERENCES discounts("Id") ON DELETE RESTRICT,
    "LastName"            VARCHAR(30),
    "FirstName"           VARCHAR(30),
    "RegistrationDate"    DATE DEFAULT CURRENT_DATE
);

CREATE TABLE customer_contacts (
    "CustomerId"      INT REFERENCES customers("Id") ON DELETE RESTRICT,
    "ContactType"     CUSTOMER_CONTACT_TYPE   NOT NULL,
    "Contact"         TEXT                    NOT NULL
);

CREATE TABLE departments (
    "Id"              SERIAL PRIMARY KEY,
    "Address"         TEXT            NOT NULL,
    "DepartmentName"  TEXT            NOT NULL
);

CREATE TABLE branches (
    "Id"              SERIAL PRIMARY KEY,
    "DepartmentId"    INT REFERENCES departments("Id") ON DELETE RESTRICT,
    "Address"         TEXT                NOT NULL,
    "BranchName"      TEXT                NOT NULL,
    "TelephoneNumber" VARCHAR(13)         NOT NULL
);

CREATE TABLE job_type (
    "Id"      SERIAL PRIMARY KEY,
    "Type"    TEXT         NOT NULL UNIQUE
);

CREATE TABLE employees (
    "Id"          SERIAL PRIMARY KEY,
    "BranchId"    INT REFERENCES branches("Id") ON DELETE RESTRICT,
    "JobId"       INT REFERENCES job_type("Id") ON DELETE RESTRICT,
    "Login"       VARCHAR(13)         NOT NULL UNIQUE,
    "LastName"    TEXT                NOT NULL,
    "FirstName"   TEXT                NOT NULL,
    "HireDate"    DATE                DEFAULT CURRENT_DATE
);

CREATE TABLE features (
  "Id" SERIAL PRIMARY KEY,
  "Feature" TEXT NOT NULL
);

CREATE TABLE employee_contacts (
    "EmployeeId"      INT REFERENCES employees("Id") ON DELETE RESTRICT,
    "ContactType"     EMPLOYEE_CONTACT_TYPE         NOT NULL,
    "Contact"         TEXT                          NOT NULL
);

CREATE TABLE categories (
    "ParentId"        INT REFERENCES categories("Id") ON DELETE RESTRICT,
    "Id"              SERIAL            UNIQUE,
    "CategoryName"    TEXT              UNIQUE
);

CREATE TABLE category_features (
    "CategoryId" INT REFERENCES categories("Id") ON DELETE RESTRICT,
    "FeatureId" INT REFERENCES features("Id") ON DELETE RESTRICT
);

CREATE TABLE suppliers (
    "Id"                  SERIAL PRIMARY KEY,
    "Address"             TEXT                NOT NULL,
    "CompanyName"         TEXT                UNIQUE NOT NULL,
    "TelephoneNumber"     VARCHAR(13)         NOT NULL
);

CREATE TABLE products (
    "Id"                SERIAL PRIMARY KEY,
    "CategoryId"        INT REFERENCES categories("Id") ON DELETE RESTRICT,
    "SupplierId"        INT REFERENCES suppliers("Id") ON DELETE RESTRICT,
    "ProductName"       TEXT            NOT NULL,
    "UnitPrice"         REAL            NOT NULL,
    "Discontinued"      BOOLEAN         DEFAULT FALSE
);

CREATE TABLE product_features (
    "ProductId" INT REFERENCES products("Id") ON DELETE RESTRICT,
    "FeatureId" INT REFERENCES features("Id") ON DELETE RESTRICT,
    "Value" TEXT
);

CREATE TABLE cells (
    "Id"            SERIAL PRIMARY KEY,
    "CellName"      VARCHAR(10)         UNIQUE NOT NULL,
    "Free"          BOOLEAN             DEFAULT true
);

CREATE TABLE store (
    "ProductId"     INT REFERENCES products("Id") ON DELETE RESTRICT,
    "CellId"        INT REFERENCES cells("Id") ON DELETE RESTRICT,
    "Quantity"      INT         NOT NULL
);

CREATE TABLE orders (
    "Id"              SERIAL PRIMARY KEY,
    "CustomerId"      INT REFERENCES customers("Id") ON DELETE RESTRICT,
    "EmployeeId"      INT REFERENCES employees("Id") ON DELETE RESTRICT,
    "OrderDate"       DATE            DEFAULT CURRENT_DATE NOT NULL,
    "ShippedDate"     DATE,
    "Address"         TEXT
);

CREATE TABLE order_details (
    "OrderId"       INT REFERENCES orders("Id") ON DELETE RESTRICT,
    "ProductId"     INT REFERENCES products("Id") ON DELETE RESTRICT,
    "UnitPrice"     REAL            NOT NULL,
    "Quantity"      INT             NOT NULL
);

INSERT INTO discounts ("Id", "Status", "Discount")
    VALUES (null, false, 0),
        ('1000000000000', false, 5),
        ('1000000000001', true, 5);

INSERT INTO customers ("Login", "LastName", "FirstName")
    VALUES (null, 'Default', 'User'),
        ('1000000000001', 'Иванов', 'Иван');

INSERT INTO customer_contacts ("CustomerId", "ContactType", "Contact")
    VALUES (
        (SELECT "Id" FROM customers WHERE "Login" = '1000000000001'),
        'Email',
        'qwert12345@gmail.com'
    );

INSERT INTO departments ("DepartmentName", "Address")
    VALUES ('Магазин в Smart Plaza', 'пр. Победы, 24');

INSERT INTO branches ("DepartmentId", "BranchName", "Address", "TelephoneNumber")
    VALUES (
        (SELECT "Id" FROM departments WHERE "DepartmentName" = 'Магазин в Smart Plaza'),
        'Отдел продаж',
        'пр. Победы, 24',
        '+380671935816'
    ), (
        (SELECT "Id" FROM departments WHERE "DepartmentName" = 'Магазин в Smart Plaza'),
        'Служба безопасности',
        'пр. Победы, 24',
        '+380671935817'
    );

INSERT INTO job_type ("Type")
    VALUES ('Начальник службы безопасности'),
        ('Охранник'),
        ('Старший кассир'),
        ('Кассир');

INSERT INTO employees ("BranchId", "JobId", "Login", "LastName", "FirstName")
    VALUES (
        (SELECT branches."Id" FROM branches
        JOIN departments ON branches."DepartmentId" = departments."Id"
            WHERE "BranchName" = 'Служба безопасности'
                AND "DepartmentName" = 'Магазин в Smart Plaza'),
        (SELECT "Id" FROM job_type WHERE "Type" = 'Начальник службы безопасности'),
        'login1',
        'Иванов',
        'Иван'
    ), (
        (SELECT branches."Id" FROM branches
        JOIN departments ON branches."DepartmentId" = departments."Id"
            WHERE "BranchName" = 'Служба безопасности'
                AND "DepartmentName" = 'Магазин в Smart Plaza'),
        (SELECT "Id" FROM job_type WHERE "Type" = 'Охранник'),
        'login2',
        'Иванов',
        'Андрей'
        ),(
           (SELECT branches."Id" FROM branches
            JOIN departments ON branches."DepartmentId" = departments."Id"
                WHERE "BranchName" = 'Отдел продаж'
                    AND "DepartmentName" = 'Магазин в Smart Plaza'),
            (SELECT "Id" FROM job_type WHERE "Type" = 'Старший кассир'),
            'login3',
           'Смирнов',
           'Иван'
           ), (
               (SELECT branches."Id" FROM branches
                JOIN departments ON branches."DepartmentId" = departments."Id"
                    WHERE "BranchName" = 'Отдел продаж'
                        AND "DepartmentName" = 'Магазин в Smart Plaza'),
                (SELECT "Id" FROM job_type WHERE "Type" = 'Кассир'),
                'login4',
               'Смирнов',
               'Андрей'
            );

INSERT INTO employee_contacts ("EmployeeId", "ContactType", "Contact")
    VALUES (
        (SELECT "Id" FROM employees WHERE "Login" = 'login1'),
        'Email',
        'qwert12346@gmail.com'
    ), (
        (SELECT "Id" FROM employees WHERE "Login" = 'login2'),
        'Email',
        'qwert12347@gmail.com'
    ), (
        (SELECT "Id" FROM employees WHERE "Login" = 'login3'),
        'Email',
        'qwert12348@gmail.com'
    ), (
        (SELECT "Id" FROM employees WHERE "Login" = 'login4'),
        'Email',
        'qwert12349@gmail.com'
    );

INSERT INTO categories ("ParentId", "CategoryName")
    VALUES (NULL, 'Root');
INSERT INTO categories ("ParentId", "CategoryName")
    VALUES ((SELECT "Id" FROM categories WHERE "CategoryName" = 'Root'),'Кровля и водосток'),
        ((SELECT "Id" FROM categories WHERE "CategoryName" = 'Root'), 'Отделочные материалы');
-- Кровля и водосток/
INSERT INTO categories ("ParentId", "CategoryName")
    VALUES ((SELECT "Id" FROM categories WHERE "CategoryName" = 'Кровля и водосток'), 'Профнастил'),
        ((SELECT "Id" FROM categories WHERE "CategoryName" = 'Кровля и водосток'), 'Водосточные системы для крыши'),
        ((SELECT "Id" FROM categories WHERE "CategoryName" = 'Кровля и водосток'), 'Козырьки и навесы');
-- Отделочные материалы/
INSERT INTO categories ("ParentId", "CategoryName")
    VALUES ((SELECT "Id" FROM categories WHERE "CategoryName" = 'Отделочные материалы'), 'Сухие строительные смеси'),
        ((SELECT "Id" FROM categories WHERE "CategoryName" = 'Отделочные материалы'), 'Лакокрасочные материалы');
-- Отделочные материалы/Сухие строительные смеси/
INSERT INTO categories ("ParentId", "CategoryName")
    VALUES ((SELECT "Id" FROM categories WHERE "CategoryName" = 'Сухие строительные смеси'), 'Штукатурка');
-- Отделочные материалы/Лакокрасочные материалы/
INSERT INTO categories ("ParentId", "CategoryName")
    VALUES ((SELECT "Id" FROM categories WHERE "CategoryName" = 'Лакокрасочные материалы'), 'Пигменты');
-- Отделочные материалы/Лакокрасочные материалы/Пигменты/
INSERT INTO categories ("ParentId", "CategoryName")
    VALUES ((SELECT "Id" FROM categories WHERE "CategoryName" = 'Пигменты'), 'Люминофоры');

INSERT INTO suppliers ("CompanyName", "Address", "TelephoneNumber")
    VALUES ('TanDem', '1', '+380395552053'),
        ('Profil', '2', '+380731555070'),
        ('НСК', '3', '+380421355587'),
        ('TermoBravo', '4', '+380635550178'),
        ('ENIGMA', '5', '+380167255505'),
        ('ТАТ', '6', '+380635550047');

INSERT INTO products ("CategoryId", "SupplierId", "ProductName", "UnitPrice")
    VALUES (
        (SELECT "Id" FROM categories WHERE "CategoryName"='Профнастил'),
        (SELECT "Id" FROM suppliers WHERE "CompanyName" ='TanDem'),
        'Козырек "TanDem" 1500х930х280мм Бронза с Сотовым Поликарбонатом 4мм Бронза',
        3000.0
    ), (
        (SELECT "Id" FROM categories WHERE "CategoryName"='Профнастил'),
        (SELECT "Id" FROM suppliers WHERE "CompanyName" ='TanDem'),
        'Козырек "TanDem" 1500х930х280мм Бронза с Сотовым Поликарбонатом 4мм Прозрачный',
        3100.0
    ), (
        (SELECT "Id" FROM categories WHERE "CategoryName"='Профнастил'),
        (SELECT "Id" FROM suppliers WHERE "CompanyName" ='TanDem'),
        'Козырек "TanDem" 3000х930х280мм Бронза с Монолитным Поликарбонатом 4мм Бронза',
        5000.0
    ), (
        (SELECT "Id" FROM categories WHERE "CategoryName"='Водосточные системы для крыши'),
        (SELECT "Id" FROM suppliers WHERE "CompanyName" ='Profil'),
        'Желоб Profil 100/3 м Красный',
        104.0
    ), (
        (SELECT "Id" FROM categories WHERE "CategoryName"='Водосточные системы для крыши'),
        (SELECT "Id" FROM suppliers WHERE "CompanyName" ='Profil'),
        'Колено водосточной трубы двухраструбное Profil 100 Красное',
        89.0
    ), (
        (SELECT "Id" FROM categories WHERE "CategoryName"='Козырьки и навесы'),
        (SELECT "Id" FROM suppliers WHERE "CompanyName" ='НСК'),
        'Козырек из стекла триплекс с фурнитурой НСК 250смх120см, толщина 0.5см+0.5см, прозрачный',
        5839.0
    ), (
        (SELECT "Id" FROM categories WHERE "CategoryName"='Штукатурка'),
        (SELECT "Id" FROM suppliers WHERE "CompanyName" ='TermoBravo'),
        'Мозаичная штукатурка TermoBravo М57 25кг',
        500.0
    ), (
        (SELECT "Id" FROM categories WHERE "CategoryName"='Штукатурка'),
        (SELECT "Id" FROM suppliers WHERE "CompanyName" ='TermoBravo'),
        'Мраморная штукатурка TermoBravo Н223 25кг',
        500.0
    ), (
        (SELECT "Id" FROM categories WHERE "CategoryName"='Штукатурка'),
        (SELECT "Id" FROM suppliers WHERE "CompanyName" ='TermoBravo'),
        'Мозаичная штукатурка TermoBravo М70 25кг',
        500.0
    ), (
        (SELECT "Id" FROM categories WHERE "CategoryName"='Штукатурка'),
        (SELECT "Id" FROM suppliers WHERE "CompanyName" ='ENIGMA'),
        'Декоративное покрытие ENIGMA ELEMENT DECOR 1 кг',
        139.0
    ), (
        (SELECT "Id" FROM categories WHERE "CategoryName"='Люминофоры'),
        (SELECT "Id" FROM suppliers WHERE "CompanyName" ='ТАТ'),
        'Люминофор повышенной яркости ТАТ 33 базовый голубой 100 г 80 микрон',
        509.0
    ), (
        (SELECT "Id" FROM categories WHERE "CategoryName"='Люминофоры'),
        (SELECT "Id" FROM suppliers WHERE "CompanyName" ='ТАТ'),
        'Люминофор повышенной яркости ТАТ 33 базовый зеленый 100 г 60 микрон',
        509.0
    ), (
        (SELECT "Id" FROM categories WHERE "CategoryName"='Люминофоры'),
        (SELECT "Id" FROM suppliers WHERE "CompanyName" ='ТАТ'),
        'Люминофор повышенной яркости ТАТ 33 базовый голубой 10 г 30 микрон',
        139.0
    ), (
        (SELECT "Id" FROM categories WHERE "CategoryName"='Люминофоры'),
        (SELECT "Id" FROM suppliers WHERE "CompanyName" ='ТАТ'),
        'Люминофор повышенной яркости ТАТ 33 полупрозрачный днем с белым свечением 100 г 60 микрон',
        509.0
    ), (
        (SELECT "Id" FROM categories WHERE "CategoryName"='Люминофоры'),
        (SELECT "Id" FROM suppliers WHERE "CompanyName" ='ТАТ'),
        'Люминофор повышенной яркости ТАТ 33 темно-желтый 100 г 60 микрон',
        509.0
    );

-- Виведіть дерево категорій товарів з кількістю товарів
-- на всіх рівнях.
WITH RECURSIVE hierarchy ("Id", "Path") AS (
    SELECT "Id", ARRAY["CategoryName"] FROM categories
        WHERE "ParentId" IS NULL
    UNION ALL
    SELECT c."Id", ARRAY_APPEND(h."Path", c."CategoryName") FROM categories c
    INNER JOIN hierarchy h ON h."Id" = c."ParentId"
)
SELECT ARRAY_TO_STRING("Path", '/') AS "Path", count(p."Id") AS "Quantity" FROM hierarchy h
LEFT JOIN products p ON h."Id" = p."CategoryId"
GROUP BY h."Path"
ORDER BY h."Path";

WITH RECURSIVE hierarchy ("Id", "CategoryName", "Level", "Path") AS (
    SELECT "Id", "CategoryName", 0, ARRAY["CategoryName"] FROM categories
        WHERE "ParentId" IS NULL
    UNION ALL
    SELECT c."Id", c."CategoryName", h."Level" + 1, ARRAY_APPEND(h."Path", c."CategoryName") FROM categories c
    INNER JOIN hierarchy h ON h."Id" = c."ParentId"
)
SELECT "Level", "CategoryName", ARRAY_TO_STRING("Path", '/') AS "Path" FROM hierarchy;

-- INSERT INTO cells ("CellName", "Free") VALUES ();

-- INSERT INTO store ("ProductId", "CellId", "Quantity") VALUES ();

-- INSERT INTO orders ("CustomerId", "EmployeeId", "OrderDate", "ShippedDate") VALUES ();

-- INSERT INTO order_details ("OrderId", "ProductId", "UnitPrice", "Quantity") VALUES ();

