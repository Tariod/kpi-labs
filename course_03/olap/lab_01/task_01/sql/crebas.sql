-- DROP TABLE INVOICE CASCADE;

-- DROP TABLE SALES CASCADE;

-- DROP TABLE STORE CASCADE;

/*==============================================================*/
/* Database: SALE                                               */
/*==============================================================*/
CREATE DATABASE SALE;

/*==============================================================*/
/* Table: INVOICE                                               */
/*==============================================================*/
CREATE TABLE INVOICE (
   ID_STUFF			VARCHAR(128)	NOT NULL,
   STAFF_NAME       VARCHAR(128),
   E_MAIL           VARCHAR(128),
   INVOICE          VARCHAR(128),
   SUPPLIER         VARCHAR(128),
   PRODUCT          VARCHAR(128),
   QUANTITY         VARCHAR(128),
   PRICE            VARCHAR(128),
   INVOICE_DATE     VARCHAR(128)
);

COMMENT ON TABLE INVOICE IS
'Інформація про розрахунок.';

COMMENT ON COLUMN INVOICE.ID_STUFF IS
'Унікальний ідентифікатор оплати.';

COMMENT ON COLUMN INVOICE.E_MAIL IS
'Час виконання оплати.';

/*==============================================================*/
/* Table: SALES                                                 */
/*==============================================================*/
CREATE TABLE SALES  (
   ID_STUFF					VARCHAR(128)	NOT NULL,
   STAFF_NAME				VARCHAR(128),
   PRODUCT					VARCHAR(128),
   SOLD_IN_JANUARY_2013		VARCHAR(128),
   SOLD_IN_FEBRUARY_2013	VARCHAR(128),
   SOLD_IN_MARCH_2013		VARCHAR(128),
   SOLD_IN_APRIL_2013		VARCHAR(128),
   SOLD_IN_MAY_2013			VARCHAR(128),
   SOLD_IN_JUNE_2013		VARCHAR(128),
   SOLD_IN_JULY_2013		VARCHAR(128),
   SOLD_IN_AUGUST_2013		VARCHAR(128),
   SOLD_IN_SEPTEMBER_2013	VARCHAR(128),
   SOLD_IN_OCTOBER_2013		VARCHAR(128),
   SOLD_IN_NOVEMBER_2013	VARCHAR(128),
   SOLD_IN_DECEMBER_2013	VARCHAR(128)
);

COMMENT ON TABLE SALES IS
'Інофрмація про продажі.';

COMMENT ON COLUMN SALES.ID_STUFF IS
'Унікальний ідентифікатор товару.';

COMMENT ON COLUMN SALES.STAFF_NAME IS
'Назва товару.';

COMMENT ON COLUMN SALES.PRODUCT IS
'Одиниця виміру.';

COMMENT ON COLUMN SALES.SOLD_IN_JANUARY_2013 IS
'Опис товару.';

COMMENT ON COLUMN SALES.SOLD_IN_FEBRUARY_2013 IS
'Ціна товару.';

COMMENT ON COLUMN SALES.SOLD_IN_MARCH_2013 IS
'Постачальник.';

COMMENT ON COLUMN SALES.SOLD_IN_APRIL_2013 IS
'Тип товару.';

/*==============================================================*/
/* Table: STORE                                                 */
/*==============================================================*/
CREATE TABLE STORE  (
   STUFF_NAME		VARCHAR(124) 	NOT NULL,
   SUPPLIER			VARCHAR(124),
   SHELF			VARCHAR(124),
   PRODUCT			VARCHAR(124),
   QUANTITY			VARCHAR(124),
   OPER_TYPE		VARCHAR(124),
   STORE_DATE		VARCHAR(124)
);

COMMENT ON TABLE STORE IS
'Інформація про склад';

COMMENT ON COLUMN STORE.STUFF_NAME IS
'Унікальний ідентифікатор сховища.';

COMMENT ON COLUMN STORE.SUPPLIER IS
'Номер полиці складу.';

COMMENT ON COLUMN STORE.SHELF IS
'Кількітсь товару.';