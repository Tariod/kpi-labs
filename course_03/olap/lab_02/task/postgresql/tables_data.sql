-- PL/SQL Developer import file
--  Created on 2 Квітень 2014 р. by ryta
-- Creating PAYMENT_TYPE...
create table PAYMENT_TYPE
(
  id_type           INT not null,
  payment_type_name VARCHAR(128),
  description       VARCHAR(256)
)
tablespace REPO_DATA
  pctfree 10
  initrans 1
  maxtrans 255
  storage
  (
    initial 64K
    minextents 1
    maxextents unlimited
  );
comment on table PAYMENT_TYPE
  is 'Інформація про тип оплати.';
comment on column PAYMENT_TYPE.id_type
  is 'Унікальний ідентифікатор типу оплати.';
comment on column PAYMENT_TYPE.payment_type_name
  is 'Назва типу оплати.';
comment on column PAYMENT_TYPE.description
  is 'Опис типу полати.';
alter table PAYMENT_TYPE
  add constraint PK_PAYMENT_TYPE primary key (ID_TYPE)
  using index 
  tablespace REPO_DATA
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
    minextents 1
    maxextents unlimited
  );

-- Creating POSITION...
create table POSITION
(
  id_position   INT not null,
  position_name VARCHAR(128) not null,
  salary        INT,
  description   VARCHAR(1024)
)
tablespace REPO_DATA
  pctfree 10
  initrans 1
  maxtrans 255
  storage
  (
    initial 64K
    minextents 1
    maxextents unlimited
  );
comment on table POSITION
  is 'Опис посад.';
comment on column POSITION.id_position
  is 'Унікальний ідентифікатор посади.';
comment on column POSITION.position_name
  is 'Назва позиції.';
comment on column POSITION.salary
  is 'Заробітна плата.';
comment on column POSITION.description
  is 'Опис посади.';
alter table POSITION
  add constraint PK_POSITION primary key (ID_POSITION)
  using index 
  tablespace REPO_DATA
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
    minextents 1
    maxextents unlimited
  );

-- Creating STUFF...
create table STUFF
(
  id_stuff    INT not null,
  id_position INT not null,
  name        VARCHAR(64),
  surname     VARCHAR(64),
  phone       VARCHAR(64),
  address     VARCHAR(256),
  email       VARCHAR(64)
)
tablespace REPO_DATA
  pctfree 10
  initrans 1
  maxtrans 255
  storage
  (
    initial 64K
    minextents 1
    maxextents unlimited
  );
comment on table STUFF
  is 'Інфнормація про працюючий персонал.';
comment on column STUFF.id_stuff
  is 'Інікальний ідентифікатор робітника.';
comment on column STUFF.id_position
  is 'Ідентифікатор посади.';
comment on column STUFF.name
  is 'Імя працівника.';
comment on column STUFF.surname
  is 'Прізвище працівника.';
comment on column STUFF.phone
  is 'Контактний номер телефону.';
comment on column STUFF.address
  is 'Адреса працівника.';
comment on column STUFF.email
  is 'Електронна поштова адреса.';
alter table STUFF
  add constraint PK_STUFF primary key (ID_STUFF)
  using index 
  tablespace REPO_DATA
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
    minextents 1
    maxextents unlimited
  );
alter table STUFF
  add constraint FK_STUFF_POSITION foreign key (ID_POSITION)
  references POSITION (ID_POSITION);

-- Creating INVOICE...
create table INVOICE
(
  id_invoice    INT not null,
  id_type       INT not null,
  id_stuff      INT not null,
  purchase_time DATE
)
tablespace REPO_DATA
  pctfree 10
  initrans 1
  maxtrans 255
  storage
  (
    initial 64K
    minextents 1
    maxextents unlimited
  );
comment on table INVOICE
  is 'Інформація про оплату.';
comment on column INVOICE.id_invoice
  is 'Унікальний ідентифікатор оплати.';
comment on column INVOICE.id_type
  is 'Ідентифікатор типу оплати.';
comment on column INVOICE.id_stuff
  is 'Ідентифікатор працівника, що оформив оплату.';
comment on column INVOICE.purchase_time
  is 'Час виконання оплати.';
create index FK_STUFF on INVOICE (ID_STUFF)
  tablespace REPO_DATA
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
    minextents 1
    maxextents unlimited
  );
create index FK_TYPE on INVOICE (ID_TYPE)
  tablespace REPO_DATA
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
    minextents 1
    maxextents unlimited
  );
alter table INVOICE
  add constraint PK_INVOICE primary key (ID_INVOICE)
  using index 
  tablespace REPO_DATA
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
    minextents 1
    maxextents unlimited
  );
alter table INVOICE
  add constraint FK_INVOICE_PAYMENT_TYPE foreign key (ID_TYPE)
  references PAYMENT_TYPE (ID_TYPE);
alter table INVOICE
  add constraint FK_INVOICE_STUFF foreign key (ID_STUFF)
  references STUFF (ID_STUFF);

-- Creating PRODUCT_TYPE...
create table PRODUCT_TYPE
(
  id_product_type   INT not null,
  product_type_name VARCHAR(128)
)
tablespace REPO_DATA
  pctfree 10
  initrans 1
  maxtrans 255
  storage
  (
    initial 64K
    minextents 1
    maxextents unlimited
  );
comment on table PRODUCT_TYPE
  is 'Інформація про типи продуктів.';
comment on column PRODUCT_TYPE.id_product_type
  is 'Унікальний ідентифікатор типу продукту.';
comment on column PRODUCT_TYPE.product_type_name
  is 'Назва типу продукту.';
alter table PRODUCT_TYPE
  add constraint PK_PRODUCT_TYPE primary key (ID_PRODUCT_TYPE)
  using index 
  tablespace REPO_DATA
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
    minextents 1
    maxextents unlimited
  );

-- Creating SUPPLIER...
create table SUPPLIER
(
  id_supplier   INT not null,
  supplier_name VARCHAR(128),
  supplier_info VARCHAR(1024)
)
tablespace REPO_DATA
  pctfree 10
  initrans 1
  maxtrans 255
  storage
  (
    initial 64K
    minextents 1
    maxextents unlimited
  );
comment on table SUPPLIER
  is 'Інформація про постачальників.';
comment on column SUPPLIER.id_supplier
  is 'Унікальний ідентифікатор постачальника.';
comment on column SUPPLIER.supplier_name
  is 'Назва постачальника.';
comment on column SUPPLIER.supplier_info
  is 'Інфомація про постачальника. Адреса, контактний телефон.';
alter table SUPPLIER
  add constraint PK_SUPPLIER primary key (ID_SUPPLIER)
  using index 
  tablespace REPO_DATA
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
    minextents 1
    maxextents unlimited
  );

-- Creating UNIT...
create table UNIT
(
  id_unit     INT not null,
  unit_name   VARCHAR(128),
  description VARCHAR(512)
)
tablespace REPO_DATA
  pctfree 10
  initrans 1
  maxtrans 255
  storage
  (
    initial 64K
    minextents 1
    maxextents unlimited
  );
comment on column UNIT.description
  is 'Опис одиниці виміру.';
alter table UNIT
  add constraint PK_UNIT primary key (ID_UNIT)
  using index 
  tablespace REPO_DATA
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
    minextents 1
    maxextents unlimited
  );

-- Creating PRODUCT...
create table PRODUCT
(
  id_product      INT not null,
  id_product_type INT not null,
  id_supplier     INT not null,
  id_unit         INT not null,
  product_name    VARCHAR(128) not null,
  description     VARCHAR(128),
  price           INTEGER
)
tablespace REPO_DATA
  pctfree 10
  initrans 1
  maxtrans 255
  storage
  (
    initial 64K
    minextents 1
    maxextents unlimited
  );
comment on table PRODUCT
  is 'Інофрмація про товари.';
comment on column PRODUCT.id_product
  is 'Унікальний ідентифікатор товару.';
comment on column PRODUCT.id_product_type
  is 'Ідентифікатор типу товару.';
comment on column PRODUCT.id_supplier
  is 'Ідентифікатор постачальника.';
comment on column PRODUCT.product_name
  is 'Назва товару.';
comment on column PRODUCT.description
  is 'Опис товару.';
comment on column PRODUCT.price
  is 'Ціна товару.';
alter table PRODUCT
  add constraint PK_PRODUCT primary key (ID_PRODUCT)
  using index 
  tablespace REPO_DATA
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
    minextents 1
    maxextents unlimited
  );
alter table PRODUCT
  add constraint FK_PROD_PROD_TYPE foreign key (ID_PRODUCT_TYPE)
  references PRODUCT_TYPE (ID_PRODUCT_TYPE);
alter table PRODUCT
  add constraint FK_PROD_SUPPLIER foreign key (ID_SUPPLIER)
  references SUPPLIER (ID_SUPPLIER);
alter table PRODUCT
  add constraint FK_PROD_UNIT foreign key (ID_UNIT)
  references UNIT (ID_UNIT);

-- Creating INVOICE_DETAIL...
create table INVOICE_DETAIL
(
  id_invoice  INT not null,
  id_product  INT not null,
  quantity    NUMERIC(10,2) not null,
  description VARCHAR(500)
)
tablespace REPO_DATA
  pctfree 10
  initrans 1
  maxtrans 255
  storage
  (
    initial 64K
    minextents 1
    maxextents unlimited
  );
comment on table INVOICE_DETAIL
  is 'Оплата за продукти.';
comment on column INVOICE_DETAIL.quantity
  is 'Кількість товару.';
comment on column INVOICE_DETAIL.description
  is 'Опис придбання.';
alter table INVOICE_DETAIL
  add constraint PK_INVOICE_DETAIL primary key (ID_INVOICE, ID_PRODUCT)
  using index 
  tablespace REPO_DATA
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
    minextents 1
    maxextents unlimited
  );
alter table INVOICE_DETAIL
  add constraint FK_INVOICE_DET_INV foreign key (ID_INVOICE)
  references INVOICE (ID_INVOICE);
alter table INVOICE_DETAIL
  add constraint FK_INVOICE_DET_PRODUCT foreign key (ID_PRODUCT)
  references PRODUCT (ID_PRODUCT);

-- Creating TYPE_OPER...
create table TYPE_OPER
(
  id_oper_type INTEGER not null,
  name_oper    VARCHAR(3) not null,
  description  VARCHAR(100)
)
tablespace REPO_DATA
  pctfree 10
  initrans 1
  maxtrans 255
  storage
  (
    initial 64K
    minextents 1
    maxextents unlimited
  );
comment on table TYPE_OPER
  is 'Довідник операцій.';
comment on column TYPE_OPER.id_oper_type
  is 'ідентифікатор операції.';
comment on column TYPE_OPER.name_oper
  is 'Назва операції.';
comment on column TYPE_OPER.description
  is 'Опис типу операції.
';
alter table TYPE_OPER
  add constraint PK_TYPE_OPER primary key (ID_OPER_TYPE)
  using index 
  tablespace REPO_DATA
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
    minextents 1
    maxextents unlimited
  );

-- Creating STORE...
create table STORE
(
  id_store     INT not null,
  id_product   INT not null,
  shelf        VARCHAR(10) not null,
  date_oper    DATE not null,
  id_oper_type INTEGER not null,
  quantity     INT not null
)
tablespace REPO_DATA
  pctfree 10
  initrans 1
  maxtrans 255
  storage
  (
    initial 64K
    minextents 1
    maxextents unlimited
  );
comment on table STORE
  is 'Інформація про склад';
comment on column STORE.id_store
  is 'Унікальний ідентифікатор сховища.';
comment on column STORE.id_product
  is 'Унікальний ідентифікатор продукту.
';
comment on column STORE.shelf
  is 'Номер полиці складу.';
comment on column STORE.date_oper
  is 'дата операції';
comment on column STORE.id_oper_type
  is 'Тип опреції (in,out).';
comment on column STORE.quantity
  is 'Кількітсь товару.';
alter table STORE
  add constraint PK_STORE primary key (ID_STORE)
  using index 
  tablespace REPO_DATA
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
    minextents 1
    maxextents unlimited
  );
alter table STORE
  add constraint FK_STORE_FK_STORE__TYPE_OPE foreign key (ID_OPER_TYPE)
  references TYPE_OPER (ID_OPER_TYPE);
alter table STORE
  add constraint FK_STORE_PROD foreign key (ID_PRODUCT)
  references PRODUCT (ID_PRODUCT);

-- Creating WORKB_INVOICE...
create table WORKB_INVOICE
(
  id_invoice    INT not null,
  id_type       INT not null,
  id_stuff      INT not null,
  purchase_time INT
)
tablespace REPO_DATA
  pctfree 10
  initrans 1
  maxtrans 255
  storage
  (
    initial 64K
    minextents 1
    maxextents unlimited
  );
comment on table WORKB_INVOICE
  is 'Для побудови аналітики (вказано час)';

-- Creating WORKB_TIME...
create table WORKB_TIME
(
  id_date    NUMERIC(6) not null,
  date_doc   DATE not null,
  id_day     NUMERIC(6) not null,
  day_desc   INT,
  id_month   NUMERIC(6) not null,
  id_quart   NUMERIC(6) not null,
  id_year    NUMERIC(6) not null,
  is_holiday NUMERIC(1) default 0
)
tablespace REPO_DATA
  pctfree 10
  initrans 1
  maxtrans 255
  storage
  (
    initial 64K
    minextents 1
    maxextents unlimited
  );
comment on table WORKB_TIME
  is 'Часовий вимір';
comment on column WORKB_TIME.id_date
  is 'Ідентифікатор дати';
comment on column WORKB_TIME.date_doc
  is 'Дата документа';
comment on column WORKB_TIME.id_day
  is 'Ідентифікатор дню';
comment on column WORKB_TIME.day_desc
  is 'День тижня';
comment on column WORKB_TIME.id_month
  is 'Ідентифікатор місяця';
comment on column WORKB_TIME.id_quart
  is 'Ідентифікатор кварталу ';
comment on column WORKB_TIME.id_year
  is 'Ідентифікатор року';
comment on column WORKB_TIME.is_holiday
  is 'Чи є день святковим (вихідним) . 1- святковий(вихідний),  0 - будній.';

-- Creating WORKB_TIME_CHAR...
create table WORKB_TIME_CHAR
(
  id_date    VARCHAR(6) not null,
  date_doc   DATE not null,
  id_day     VARCHAR(6) not null,
  day_desc   VARCHAR(12),
  id_month   VARCHAR(6) not null,
  id_quart   VARCHAR(6) not null,
  id_year    VARCHAR(6) not null,
  is_holiday VARCHAR(1) default 0
)
tablespace REPO_DATA
  pctfree 10
  initrans 1
  maxtrans 255
  storage
  (
    initial 64K
    minextents 1
    maxextents unlimited
  );
comment on table WORKB_TIME_CHAR
  is 'Часовий вимір';
comment on column WORKB_TIME_CHAR.id_date
  is 'Ідентифікатор дати';
comment on column WORKB_TIME_CHAR.date_doc
  is 'Дата документа';
comment on column WORKB_TIME_CHAR.id_day
  is 'Ідентифікатор дню';
comment on column WORKB_TIME_CHAR.day_desc
  is 'День тижня';
comment on column WORKB_TIME_CHAR.id_month
  is 'Ідентифікатор місяця';
comment on column WORKB_TIME_CHAR.id_quart
  is 'Ідентифікатор кварталу ';
comment on column WORKB_TIME_CHAR.id_year
  is 'Ідентифікатор року';
comment on column WORKB_TIME_CHAR.is_holiday
  is 'Чи є день святковим (вихідним) . 1- святковий(вихідний),  0 - будній.';

-- Disabling triggers for PAYMENT_TYPE...
alter table PAYMENT_TYPE disable trigger all;
-- Disabling triggers for POSITION...
alter table POSITION disable trigger all;
-- Disabling triggers for STUFF...
alter table STUFF disable trigger all;
-- Disabling triggers for INVOICE...
alter table INVOICE disable trigger all;
-- Disabling triggers for PRODUCT_TYPE...
alter table PRODUCT_TYPE disable trigger all;
-- Disabling triggers for SUPPLIER...
alter table SUPPLIER disable trigger all;
-- Disabling triggers for UNIT...
alter table UNIT disable trigger all;
-- Disabling triggers for PRODUCT...
alter table PRODUCT disable trigger all;
-- Disabling triggers for INVOICE_DETAIL...
alter table INVOICE_DETAIL disable trigger all;
-- Disabling triggers for TYPE_OPER...
alter table TYPE_OPER disable trigger all;
-- Disabling triggers for STORE...
alter table STORE disable trigger all;
-- Disabling triggers for WORKB_INVOICE...
alter table WORKB_INVOICE disable trigger all;
-- Disabling triggers for WORKB_TIME...
alter table WORKB_TIME disable trigger all;
-- Disabling triggers for WORKB_TIME_CHAR...
alter table WORKB_TIME_CHAR disable trigger all;
-- TODO Disabling FK
-- Disabling foreign key constraints for STUFF...
-- alter table STUFF disable constraint FK_STUFF_POSITION;
-- Disabling foreign key constraints for INVOICE...
-- alter table INVOICE disable constraint FK_INVOICE_PAYMENT_TYPE;
-- alter table INVOICE disable constraint FK_INVOICE_STUFF;
-- Disabling foreign key constraints for PRODUCT...
-- alter table PRODUCT disable constraint FK_PROD_PROD_TYPE;
-- alter table PRODUCT disable constraint FK_PROD_SUPPLIER;
-- alter table PRODUCT disable constraint FK_PROD_UNIT;
-- Disabling foreign key constraints for INVOICE_DETAIL...
-- alter table INVOICE_DETAIL disable constraint FK_INVOICE_DET_INV;
-- alter table INVOICE_DETAIL disable constraint FK_INVOICE_DET_PRODUCT;
-- Disabling foreign key constraints for STORE...
-- alter table STORE disable constraint FK_STORE_FK_STORE__TYPE_OPE;
-- alter table STORE disable constraint FK_STORE_PROD;
-- Deleting WORKB_TIME_CHAR...
delete from WORKB_TIME_CHAR;
commit;
-- Deleting WORKB_TIME...
delete from WORKB_TIME;
commit;
-- Deleting WORKB_INVOICE...
delete from WORKB_INVOICE;
commit;
-- Deleting STORE...
delete from STORE;
commit;
-- Deleting TYPE_OPER...
delete from TYPE_OPER;
commit;
-- Deleting INVOICE_DETAIL...
delete from INVOICE_DETAIL;
commit;
-- Deleting PRODUCT...
delete from PRODUCT;
commit;
-- Deleting UNIT...
delete from UNIT;
commit;
-- Deleting SUPPLIER...
delete from SUPPLIER;
commit;
-- Deleting PRODUCT_TYPE...
delete from PRODUCT_TYPE;
commit;
-- Deleting INVOICE...
delete from INVOICE;
commit;
-- Deleting STUFF...
delete from STUFF;
commit;
-- Deleting POSITION...
delete from POSITION;
commit;
-- Deleting PAYMENT_TYPE...
delete from PAYMENT_TYPE;
commit;
-- Loading PAYMENT_TYPE...
insert into PAYMENT_TYPE (id_type, payment_type_name, description)
values (1, 'Готівковий розрахунок', null);
insert into PAYMENT_TYPE (id_type, payment_type_name, description)
values (2, 'Безготівковий розрахонок', null);
commit;
-- 2 records loaded
-- Loading POSITION...
insert into POSITION (id_position, position_name, salary, description)
values (1, 'Продавець-касир', 3000, null);
insert into POSITION (id_position, position_name, salary, description)
values (2, 'Охоронець', 5000, null);
insert into POSITION (id_position, position_name, salary, description)
values (3, 'Менеджер відділу продажу', 7000, null);
insert into POSITION (id_position, position_name, salary, description)
values (4, 'Кухар', 6000, null);
insert into POSITION (id_position, position_name, salary, description)
values (5, 'Пекар', 6000, null);
commit;
-- 5 records loaded
-- Loading STUFF...
insert into STUFF (id_stuff, id_position, name, surname, phone, address, email)
values (1, 1, 'Aaron', 'Smih', '365-54-87', 'Київ', 'Smih@market.com');
insert into STUFF (id_stuff, id_position, name, surname, phone, address, email)
values (2, 1, 'Adam', 'Thomas', '584-98-44', 'Київ', 'Thomas@market.com');
insert into STUFF (id_stuff, id_position, name, surname, phone, address, email)
values (3, 1, 'Barry', 'Davies', '063-564-54-54', 'Київ', 'Davies@market.com');
insert into STUFF (id_stuff, id_position, name, surname, phone, address, email)
values (4, 1, 'Basil', 'White', '097-347-44-99', 'Київ', 'White@market.com');
insert into STUFF (id_stuff, id_position, name, surname, phone, address, email)
values (5, 1, 'Simon', 'Hughes', '050-54-21', 'Київ', 'Hughes@market.com');
insert into STUFF (id_stuff, id_position, name, surname, phone, address, email)
values (6, 1, 'Carlton', 'Edwards', '546-21-64', 'Київ', 'Edwards@market.com');
insert into STUFF (id_stuff, id_position, name, surname, phone, address, email)
values (7, 2, 'Sebastian', 'Green', '878-54-63', 'Київ', 'Green@market.com');
insert into STUFF (id_stuff, id_position, name, surname, phone, address, email)
values (8, 3, 'Scott', 'Wood', '050-879-54-16', 'Київ', 'Wood@market.com');
insert into STUFF (id_stuff, id_position, name, surname, phone, address, email)
values (9, 4, 'Galvin', 'Harris', '093-879-23-54', 'Київ', 'Harris@market.com');
insert into STUFF (id_stuff, id_position, name, surname, phone, address, email)
values (10, 5, 'Bob', 'Martin', '097-213-54-69', 'Київ', 'Martin@market.com');
insert into STUFF (id_stuff, id_position, name, surname, phone, address, email)
values (11, 4, 'Hunter', 'Anderson', '023-878-54-96', 'Виноградар', 'Anderson@market.com');
commit;
-- 11 records loaded
-- Loading INVOICE...
insert into INVOICE (id_invoice, id_type, id_stuff, purchase_time)
values (3, 1, 5, to_date('12-09-2011 13:24:43', 'dd-mm-yyyy hh24:mi:ss'));
insert into INVOICE (id_invoice, id_type, id_stuff, purchase_time)
values (4, 1, 3, to_date('25-09-2011 08:57:03', 'dd-mm-yyyy hh24:mi:ss'));
insert into INVOICE (id_invoice, id_type, id_stuff, purchase_time)
values (5, 1, 5, to_date('01-08-2012 08:51:18', 'dd-mm-yyyy hh24:mi:ss'));
insert into INVOICE (id_invoice, id_type, id_stuff, purchase_time)
values (6, 2, 6, to_date('11-03-2013 15:41:48', 'dd-mm-yyyy hh24:mi:ss'));
insert into INVOICE (id_invoice, id_type, id_stuff, purchase_time)
values (7, 1, 1, to_date('16-02-2012 08:18:04', 'dd-mm-yyyy hh24:mi:ss'));
insert into INVOICE (id_invoice, id_type, id_stuff, purchase_time)
values (8, 1, 3, to_date('17-10-2012 21:40:40', 'dd-mm-yyyy hh24:mi:ss'));
insert into INVOICE (id_invoice, id_type, id_stuff, purchase_time)
values (9, 2, 5, to_date('24-12-2012 02:36:56', 'dd-mm-yyyy hh24:mi:ss'));
insert into INVOICE (id_invoice, id_type, id_stuff, purchase_time)
values (10, 2, 5, to_date('09-06-2013 08:45:01', 'dd-mm-yyyy hh24:mi:ss'));
insert into INVOICE (id_invoice, id_type, id_stuff, purchase_time)
values (11, 1, 3, to_date('27-09-2011 19:18:38', 'dd-mm-yyyy hh24:mi:ss'));
insert into INVOICE (id_invoice, id_type, id_stuff, purchase_time)
values (12, 2, 4, to_date('21-01-2014 14:06:15', 'dd-mm-yyyy hh24:mi:ss'));
insert into INVOICE (id_invoice, id_type, id_stuff, purchase_time)
values (13, 2, 2, to_date('01-10-2012 05:20:36', 'dd-mm-yyyy hh24:mi:ss'));
insert into INVOICE (id_invoice, id_type, id_stuff, purchase_time)
values (14, 2, 3, to_date('20-01-2014 20:42:28', 'dd-mm-yyyy hh24:mi:ss'));
insert into INVOICE (id_invoice, id_type, id_stuff, purchase_time)
values (15, 1, 2, to_date('11-08-2013 05:16:26', 'dd-mm-yyyy hh24:mi:ss'));
insert into INVOICE (id_invoice, id_type, id_stuff, purchase_time)
values (16, 1, 3, to_date('10-02-2012 13:18:18', 'dd-mm-yyyy hh24:mi:ss'));
insert into INVOICE (id_invoice, id_type, id_stuff, purchase_time)
values (17, 2, 5, to_date('07-02-2013 11:27:05', 'dd-mm-yyyy hh24:mi:ss'));
insert into INVOICE (id_invoice, id_type, id_stuff, purchase_time)
values (18, 1, 6, to_date('14-01-2012 20:16:22', 'dd-mm-yyyy hh24:mi:ss'));
insert into INVOICE (id_invoice, id_type, id_stuff, purchase_time)
values (19, 1, 5, to_date('29-10-2012 04:08:29', 'dd-mm-yyyy hh24:mi:ss'));
insert into INVOICE (id_invoice, id_type, id_stuff, purchase_time)
values (20, 1, 3, to_date('05-10-2012 21:25:57', 'dd-mm-yyyy hh24:mi:ss'));
insert into INVOICE (id_invoice, id_type, id_stuff, purchase_time)
values (21, 1, 3, to_date('28-05-2013 05:26:35', 'dd-mm-yyyy hh24:mi:ss'));
insert into INVOICE (id_invoice, id_type, id_stuff, purchase_time)
values (22, 2, 5, to_date('01-12-2013 10:50:08', 'dd-mm-yyyy hh24:mi:ss'));
insert into INVOICE (id_invoice, id_type, id_stuff, purchase_time)
values (23, 2, 1, to_date('03-11-2013 14:52:01', 'dd-mm-yyyy hh24:mi:ss'));
insert into INVOICE (id_invoice, id_type, id_stuff, purchase_time)
values (24, 1, 5, to_date('09-04-2013 07:57:24', 'dd-mm-yyyy hh24:mi:ss'));
insert into INVOICE (id_invoice, id_type, id_stuff, purchase_time)
values (25, 1, 4, to_date('17-07-2013 10:20:27', 'dd-mm-yyyy hh24:mi:ss'));
insert into INVOICE (id_invoice, id_type, id_stuff, purchase_time)
values (26, 2, 4, to_date('27-11-2011 18:32:05', 'dd-mm-yyyy hh24:mi:ss'));
insert into INVOICE (id_invoice, id_type, id_stuff, purchase_time)
values (27, 1, 4, to_date('03-08-2012 10:48:37', 'dd-mm-yyyy hh24:mi:ss'));
insert into INVOICE (id_invoice, id_type, id_stuff, purchase_time)
values (28, 2, 6, to_date('09-03-2012 01:03:23', 'dd-mm-yyyy hh24:mi:ss'));
insert into INVOICE (id_invoice, id_type, id_stuff, purchase_time)
values (29, 2, 4, to_date('11-11-2013 04:36:39', 'dd-mm-yyyy hh24:mi:ss'));
insert into INVOICE (id_invoice, id_type, id_stuff, purchase_time)
values (30, 1, 2, to_date('09-01-2014 15:44:54', 'dd-mm-yyyy hh24:mi:ss'));
insert into INVOICE (id_invoice, id_type, id_stuff, purchase_time)
values (31, 1, 2, to_date('06-05-2012 07:49:15', 'dd-mm-yyyy hh24:mi:ss'));
insert into INVOICE (id_invoice, id_type, id_stuff, purchase_time)
values (32, 2, 4, to_date('04-09-2013 08:14:46', 'dd-mm-yyyy hh24:mi:ss'));
insert into INVOICE (id_invoice, id_type, id_stuff, purchase_time)
values (33, 1, 2, to_date('22-07-2013 14:35:10', 'dd-mm-yyyy hh24:mi:ss'));
insert into INVOICE (id_invoice, id_type, id_stuff, purchase_time)
values (34, 1, 3, to_date('16-11-2013 11:03:24', 'dd-mm-yyyy hh24:mi:ss'));
insert into INVOICE (id_invoice, id_type, id_stuff, purchase_time)
values (35, 1, 6, to_date('23-02-2013 05:31:46', 'dd-mm-yyyy hh24:mi:ss'));
insert into INVOICE (id_invoice, id_type, id_stuff, purchase_time)
values (36, 2, 6, to_date('22-10-2012 18:44:39', 'dd-mm-yyyy hh24:mi:ss'));
insert into INVOICE (id_invoice, id_type, id_stuff, purchase_time)
values (37, 2, 4, to_date('25-01-2013 15:24:26', 'dd-mm-yyyy hh24:mi:ss'));
insert into INVOICE (id_invoice, id_type, id_stuff, purchase_time)
values (38, 2, 2, to_date('15-04-2013 15:05:48', 'dd-mm-yyyy hh24:mi:ss'));
insert into INVOICE (id_invoice, id_type, id_stuff, purchase_time)
values (39, 1, 2, to_date('03-12-2013 04:19:46', 'dd-mm-yyyy hh24:mi:ss'));
insert into INVOICE (id_invoice, id_type, id_stuff, purchase_time)
values (40, 1, 1, to_date('24-12-2013 09:58:12', 'dd-mm-yyyy hh24:mi:ss'));
insert into INVOICE (id_invoice, id_type, id_stuff, purchase_time)
values (41, 1, 3, to_date('17-05-2013 03:40:53', 'dd-mm-yyyy hh24:mi:ss'));
insert into INVOICE (id_invoice, id_type, id_stuff, purchase_time)
values (42, 2, 5, to_date('11-02-2013 12:47:52', 'dd-mm-yyyy hh24:mi:ss'));
insert into INVOICE (id_invoice, id_type, id_stuff, purchase_time)
values (43, 1, 3, to_date('07-02-2012 07:44:03', 'dd-mm-yyyy hh24:mi:ss'));
insert into INVOICE (id_invoice, id_type, id_stuff, purchase_time)
values (44, 1, 2, to_date('04-01-2014 12:02:39', 'dd-mm-yyyy hh24:mi:ss'));
insert into INVOICE (id_invoice, id_type, id_stuff, purchase_time)
values (45, 2, 2, to_date('04-05-2012 09:15:55', 'dd-mm-yyyy hh24:mi:ss'));
insert into INVOICE (id_invoice, id_type, id_stuff, purchase_time)
values (46, 2, 2, to_date('09-09-2011 01:36:13', 'dd-mm-yyyy hh24:mi:ss'));
insert into INVOICE (id_invoice, id_type, id_stuff, purchase_time)
values (47, 1, 3, to_date('20-01-2013 16:59:33', 'dd-mm-yyyy hh24:mi:ss'));
insert into INVOICE (id_invoice, id_type, id_stuff, purchase_time)
values (48, 1, 2, to_date('18-10-2012 18:56:28', 'dd-mm-yyyy hh24:mi:ss'));
insert into INVOICE (id_invoice, id_type, id_stuff, purchase_time)
values (49, 1, 4, to_date('08-12-2012 14:28:05', 'dd-mm-yyyy hh24:mi:ss'));
insert into INVOICE (id_invoice, id_type, id_stuff, purchase_time)
values (50, 2, 1, to_date('26-04-2012 12:57:33', 'dd-mm-yyyy hh24:mi:ss'));
insert into INVOICE (id_invoice, id_type, id_stuff, purchase_time)
values (51, 1, 2, to_date('09-09-2012 02:50:28', 'dd-mm-yyyy hh24:mi:ss'));
insert into INVOICE (id_invoice, id_type, id_stuff, purchase_time)
values (52, 1, 6, to_date('01-07-2013 23:05:28', 'dd-mm-yyyy hh24:mi:ss'));
insert into INVOICE (id_invoice, id_type, id_stuff, purchase_time)
values (53, 1, 3, to_date('14-01-2013 06:36:47', 'dd-mm-yyyy hh24:mi:ss'));
insert into INVOICE (id_invoice, id_type, id_stuff, purchase_time)
values (54, 1, 6, to_date('01-11-2013 21:10:02', 'dd-mm-yyyy hh24:mi:ss'));
insert into INVOICE (id_invoice, id_type, id_stuff, purchase_time)
values (55, 1, 3, to_date('22-09-2011 06:18:04', 'dd-mm-yyyy hh24:mi:ss'));
insert into INVOICE (id_invoice, id_type, id_stuff, purchase_time)
values (56, 2, 5, to_date('10-08-2012 18:36:02', 'dd-mm-yyyy hh24:mi:ss'));
insert into INVOICE (id_invoice, id_type, id_stuff, purchase_time)
values (57, 1, 3, to_date('05-02-2012 11:48:44', 'dd-mm-yyyy hh24:mi:ss'));
insert into INVOICE (id_invoice, id_type, id_stuff, purchase_time)
values (58, 1, 5, to_date('20-03-2013 01:55:39', 'dd-mm-yyyy hh24:mi:ss'));
insert into INVOICE (id_invoice, id_type, id_stuff, purchase_time)
values (59, 1, 3, to_date('25-05-2011 23:57:59', 'dd-mm-yyyy hh24:mi:ss'));
insert into INVOICE (id_invoice, id_type, id_stuff, purchase_time)
values (60, 2, 3, to_date('06-12-2011 01:10:27', 'dd-mm-yyyy hh24:mi:ss'));
insert into INVOICE (id_invoice, id_type, id_stuff, purchase_time)
values (61, 2, 4, to_date('04-09-2012 09:25:25', 'dd-mm-yyyy hh24:mi:ss'));
insert into INVOICE (id_invoice, id_type, id_stuff, purchase_time)
values (62, 1, 5, to_date('04-11-2013 07:53:38', 'dd-mm-yyyy hh24:mi:ss'));
insert into INVOICE (id_invoice, id_type, id_stuff, purchase_time)
values (63, 1, 2, to_date('16-05-2012 01:03:31', 'dd-mm-yyyy hh24:mi:ss'));
insert into INVOICE (id_invoice, id_type, id_stuff, purchase_time)
values (64, 1, 6, to_date('29-06-2013 13:55:40', 'dd-mm-yyyy hh24:mi:ss'));
insert into INVOICE (id_invoice, id_type, id_stuff, purchase_time)
values (65, 2, 4, to_date('21-08-2011 19:34:44', 'dd-mm-yyyy hh24:mi:ss'));
insert into INVOICE (id_invoice, id_type, id_stuff, purchase_time)
values (66, 1, 3, to_date('18-08-2013 01:02:38', 'dd-mm-yyyy hh24:mi:ss'));
insert into INVOICE (id_invoice, id_type, id_stuff, purchase_time)
values (67, 2, 3, to_date('21-06-2011 07:39:50', 'dd-mm-yyyy hh24:mi:ss'));
insert into INVOICE (id_invoice, id_type, id_stuff, purchase_time)
values (68, 1, 2, to_date('25-11-2011 06:15:42', 'dd-mm-yyyy hh24:mi:ss'));
insert into INVOICE (id_invoice, id_type, id_stuff, purchase_time)
values (69, 2, 4, to_date('16-09-2012 22:54:17', 'dd-mm-yyyy hh24:mi:ss'));
insert into INVOICE (id_invoice, id_type, id_stuff, purchase_time)
values (70, 1, 2, to_date('09-02-2013 09:00:59', 'dd-mm-yyyy hh24:mi:ss'));
insert into INVOICE (id_invoice, id_type, id_stuff, purchase_time)
values (71, 2, 3, to_date('13-12-2013 03:13:58', 'dd-mm-yyyy hh24:mi:ss'));
insert into INVOICE (id_invoice, id_type, id_stuff, purchase_time)
values (72, 2, 2, to_date('20-01-2012 21:15:45', 'dd-mm-yyyy hh24:mi:ss'));
insert into INVOICE (id_invoice, id_type, id_stuff, purchase_time)
values (73, 1, 5, to_date('03-04-2012 05:11:38', 'dd-mm-yyyy hh24:mi:ss'));
insert into INVOICE (id_invoice, id_type, id_stuff, purchase_time)
values (74, 1, 6, to_date('23-11-2011 16:14:37', 'dd-mm-yyyy hh24:mi:ss'));
insert into INVOICE (id_invoice, id_type, id_stuff, purchase_time)
values (75, 2, 2, to_date('08-07-2011 00:13:37', 'dd-mm-yyyy hh24:mi:ss'));
insert into INVOICE (id_invoice, id_type, id_stuff, purchase_time)
values (76, 2, 4, to_date('22-07-2013 06:06:43', 'dd-mm-yyyy hh24:mi:ss'));
insert into INVOICE (id_invoice, id_type, id_stuff, purchase_time)
values (77, 1, 3, to_date('28-10-2011 12:19:24', 'dd-mm-yyyy hh24:mi:ss'));
insert into INVOICE (id_invoice, id_type, id_stuff, purchase_time)
values (78, 2, 5, to_date('18-09-2012 23:39:35', 'dd-mm-yyyy hh24:mi:ss'));
insert into INVOICE (id_invoice, id_type, id_stuff, purchase_time)
values (79, 2, 6, to_date('26-04-2013 12:53:43', 'dd-mm-yyyy hh24:mi:ss'));
insert into INVOICE (id_invoice, id_type, id_stuff, purchase_time)
values (80, 1, 4, to_date('21-07-2011 10:57:36', 'dd-mm-yyyy hh24:mi:ss'));
insert into INVOICE (id_invoice, id_type, id_stuff, purchase_time)
values (81, 1, 2, to_date('20-03-2012 10:24:23', 'dd-mm-yyyy hh24:mi:ss'));
insert into INVOICE (id_invoice, id_type, id_stuff, purchase_time)
values (82, 2, 5, to_date('09-07-2013 08:47:30', 'dd-mm-yyyy hh24:mi:ss'));
insert into INVOICE (id_invoice, id_type, id_stuff, purchase_time)
values (83, 2, 2, to_date('28-02-2013 23:51:41', 'dd-mm-yyyy hh24:mi:ss'));
insert into INVOICE (id_invoice, id_type, id_stuff, purchase_time)
values (84, 2, 4, to_date('18-11-2012 16:35:27', 'dd-mm-yyyy hh24:mi:ss'));
insert into INVOICE (id_invoice, id_type, id_stuff, purchase_time)
values (85, 2, 5, to_date('17-07-2012 18:21:57', 'dd-mm-yyyy hh24:mi:ss'));
insert into INVOICE (id_invoice, id_type, id_stuff, purchase_time)
values (86, 2, 5, to_date('08-01-2012 09:26:12', 'dd-mm-yyyy hh24:mi:ss'));
insert into INVOICE (id_invoice, id_type, id_stuff, purchase_time)
values (87, 2, 3, to_date('21-08-2013 20:55:45', 'dd-mm-yyyy hh24:mi:ss'));
insert into INVOICE (id_invoice, id_type, id_stuff, purchase_time)
values (88, 1, 3, to_date('10-08-2011 12:11:45', 'dd-mm-yyyy hh24:mi:ss'));
insert into INVOICE (id_invoice, id_type, id_stuff, purchase_time)
values (89, 2, 4, to_date('23-02-2013 21:36:16', 'dd-mm-yyyy hh24:mi:ss'));
insert into INVOICE (id_invoice, id_type, id_stuff, purchase_time)
values (90, 1, 5, to_date('31-05-2011 16:34:18', 'dd-mm-yyyy hh24:mi:ss'));
insert into INVOICE (id_invoice, id_type, id_stuff, purchase_time)
values (91, 2, 4, to_date('20-07-2011 08:40:25', 'dd-mm-yyyy hh24:mi:ss'));
insert into INVOICE (id_invoice, id_type, id_stuff, purchase_time)
values (92, 1, 2, to_date('21-08-2011 03:48:55', 'dd-mm-yyyy hh24:mi:ss'));
insert into INVOICE (id_invoice, id_type, id_stuff, purchase_time)
values (93, 2, 4, to_date('16-06-2013 22:39:09', 'dd-mm-yyyy hh24:mi:ss'));
insert into INVOICE (id_invoice, id_type, id_stuff, purchase_time)
values (94, 1, 2, to_date('15-02-2013 06:37:04', 'dd-mm-yyyy hh24:mi:ss'));
insert into INVOICE (id_invoice, id_type, id_stuff, purchase_time)
values (95, 2, 3, to_date('14-06-2013 19:52:18', 'dd-mm-yyyy hh24:mi:ss'));
insert into INVOICE (id_invoice, id_type, id_stuff, purchase_time)
values (96, 1, 5, to_date('10-08-2012 09:27:01', 'dd-mm-yyyy hh24:mi:ss'));
insert into INVOICE (id_invoice, id_type, id_stuff, purchase_time)
values (97, 1, 4, to_date('06-02-2013 13:51:03', 'dd-mm-yyyy hh24:mi:ss'));
insert into INVOICE (id_invoice, id_type, id_stuff, purchase_time)
values (98, 1, 3, to_date('20-10-2013 03:10:14', 'dd-mm-yyyy hh24:mi:ss'));
insert into INVOICE (id_invoice, id_type, id_stuff, purchase_time)
values (99, 2, 2, to_date('13-12-2011 22:27:04', 'dd-mm-yyyy hh24:mi:ss'));
insert into INVOICE (id_invoice, id_type, id_stuff, purchase_time)
values (100, 1, 6, to_date('14-12-2011 11:37:45', 'dd-mm-yyyy hh24:mi:ss'));
insert into INVOICE (id_invoice, id_type, id_stuff, purchase_time)
values (1, 1, 4, to_date('12-02-2012 05:09:10', 'dd-mm-yyyy hh24:mi:ss'));
insert into INVOICE (id_invoice, id_type, id_stuff, purchase_time)
values (2, 1, 5, to_date('14-10-2011 21:39:12', 'dd-mm-yyyy hh24:mi:ss'));
commit;
-- 100 records loaded
-- Loading PRODUCT_TYPE...
insert into PRODUCT_TYPE (id_product_type, product_type_name)
values (9, 'Кава');
insert into PRODUCT_TYPE (id_product_type, product_type_name)
values (1, 'Солодощі');
insert into PRODUCT_TYPE (id_product_type, product_type_name)
values (2, 'Концерви та пресерви');
insert into PRODUCT_TYPE (id_product_type, product_type_name)
values (3, 'Молочні продукти');
insert into PRODUCT_TYPE (id_product_type, product_type_name)
values (4, 'Сири');
insert into PRODUCT_TYPE (id_product_type, product_type_name)
values (5, 'М`ясо');
insert into PRODUCT_TYPE (id_product_type, product_type_name)
values (6, 'Ковбаси');
insert into PRODUCT_TYPE (id_product_type, product_type_name)
values (7, 'Хлібо-булочні вироби');
commit;
-- 8 records loaded
-- Loading SUPPLIER...
insert into SUPPLIER (id_supplier, supplier_name, supplier_info)
values (1, 'ROSHEN', null);
insert into SUPPLIER (id_supplier, supplier_name, supplier_info)
values (2, 'АВК', null);
insert into SUPPLIER (id_supplier, supplier_name, supplier_info)
values (3, 'Киев-Конти', null);
insert into SUPPLIER (id_supplier, supplier_name, supplier_info)
values (4, 'Nestle', null);
insert into SUPPLIER (id_supplier, supplier_name, supplier_info)
values (5, 'Ferrero', null);
insert into SUPPLIER (id_supplier, supplier_name, supplier_info)
values (6, 'Kraft Food', null);
insert into SUPPLIER (id_supplier, supplier_name, supplier_info)
values (7, 'Словяночка', null);
insert into SUPPLIER (id_supplier, supplier_name, supplier_info)
values (8, 'Простоквашино', null);
insert into SUPPLIER (id_supplier, supplier_name, supplier_info)
values (9, 'Danone', null);
insert into SUPPLIER (id_supplier, supplier_name, supplier_info)
values (10, 'Галичина', null);
insert into SUPPLIER (id_supplier, supplier_name, supplier_info)
values (11, 'Геркулес', null);
insert into SUPPLIER (id_supplier, supplier_name, supplier_info)
values (12, 'Наша Ряба', null);
insert into SUPPLIER (id_supplier, supplier_name, supplier_info)
values (13, 'Сімейні ковбаси', null);
insert into SUPPLIER (id_supplier, supplier_name, supplier_info)
values (14, 'Кременчуцький мясозавод', null);
insert into SUPPLIER (id_supplier, supplier_name, supplier_info)
values (15, 'БКК', null);
insert into SUPPLIER (id_supplier, supplier_name, supplier_info)
values (16, 'Київхліб', null);
commit;
-- 16 records loaded
-- Loading UNIT...
insert into UNIT (id_unit, unit_name, description)
values (1, 'кг', 'кілограм');
insert into UNIT (id_unit, unit_name, description)
values (2, 'уп', 'упаковка');
insert into UNIT (id_unit, unit_name, description)
values (3, 'п', 'пачка');
insert into UNIT (id_unit, unit_name, description)
values (4, 'б', 'банка');
insert into UNIT (id_unit, unit_name, description)
values (5, 'ящ', 'ящик');
insert into UNIT (id_unit, unit_name, description)
values (6, 'шт', 'штук');
commit;
-- 6 records loaded
-- Loading PRODUCT...
insert into PRODUCT (id_product, id_product_type, id_supplier, id_unit, product_name, description, price)
values (1, 1, 1, 6, 'Чорний шоколад з начинкою «LoungeBar ROSHEN» горіхове праліне', ' sweet', 5);
insert into PRODUCT (id_product, id_product_type, id_supplier, id_unit, product_name, description, price)
values (2, 1, 1, 6, '«ROSHEN» білий з цілими лісовими горіхами', null, 10);
insert into PRODUCT (id_product, id_product_type, id_supplier, id_unit, product_name, description, price)
values (3, 1, 1, 6, '«Есмеральда» шоколадна зі шматочками шоколадної глазурі', null, 10);
insert into PRODUCT (id_product, id_product_type, id_supplier, id_unit, product_name, description, price)
values (5, 1, 2, 1, '"Королівський Шедевр" з горіховою начинкою та цілим фундуком', null, 65);
insert into PRODUCT (id_product, id_product_type, id_supplier, id_unit, product_name, description, price)
values (6, 1, 2, 1, 'Трюфель молочний', null, 55);
insert into PRODUCT (id_product, id_product_type, id_supplier, id_unit, product_name, description, price)
values (7, 1, 3, 1, 'Цукерки EsfeRo Crema', null, 78);
insert into PRODUCT (id_product, id_product_type, id_supplier, id_unit, product_name, description, price)
values (8, 1, 4, 4, 'Nescafe Gold', null, 60);
insert into PRODUCT (id_product, id_product_type, id_supplier, id_unit, product_name, description, price)
values (9, 3, 7, 2, 'Молоко', null, 12);
insert into PRODUCT (id_product, id_product_type, id_supplier, id_unit, product_name, description, price)
values (10, 4, 7, 1, 'Сир російський', null, 65);
insert into PRODUCT (id_product, id_product_type, id_supplier, id_unit, product_name, description, price)
values (11, 3, 7, 2, 'Кефір', null, 12);
insert into PRODUCT (id_product, id_product_type, id_supplier, id_unit, product_name, description, price)
values (12, 3, 8, 2, 'Сир домашній', null, 15);
insert into PRODUCT (id_product, id_product_type, id_supplier, id_unit, product_name, description, price)
values (13, 3, 8, 2, 'Ряженка', null, 15);
insert into PRODUCT (id_product, id_product_type, id_supplier, id_unit, product_name, description, price)
values (14, 5, 12, 1, 'Курячі гомілки', null, 25);
insert into PRODUCT (id_product, id_product_type, id_supplier, id_unit, product_name, description, price)
values (15, 5, 12, 1, 'Куряче філе', null, 30);
insert into PRODUCT (id_product, id_product_type, id_supplier, id_unit, product_name, description, price)
values (16, 3, 10, 2, 'Йогурт', null, 15);
insert into PRODUCT (id_product, id_product_type, id_supplier, id_unit, product_name, description, price)
values (17, 6, 13, 1, 'Ковбаса докторська', null, 100);
insert into PRODUCT (id_product, id_product_type, id_supplier, id_unit, product_name, description, price)
values (18, 6, 13, 1, 'Ковбаса домашня', null, 120);
insert into PRODUCT (id_product, id_product_type, id_supplier, id_unit, product_name, description, price)
values (19, 6, 13, 1, 'Салямі італійська', null, 170);
insert into PRODUCT (id_product, id_product_type, id_supplier, id_unit, product_name, description, price)
values (20, 5, 14, 1, 'Балик', null, 98);
insert into PRODUCT (id_product, id_product_type, id_supplier, id_unit, product_name, description, price)
values (21, 5, 14, 1, 'Буженіна', null, 95);
insert into PRODUCT (id_product, id_product_type, id_supplier, id_unit, product_name, description, price)
values (22, 7, 15, 6, 'Хліб український', null, 4);
insert into PRODUCT (id_product, id_product_type, id_supplier, id_unit, product_name, description, price)
values (23, 7, 15, 6, 'Хліб білоруський', null, 7);
insert into PRODUCT (id_product, id_product_type, id_supplier, id_unit, product_name, description, price)
values (24, 7, 16, 6, 'Хліб білий', null, 3);
insert into PRODUCT (id_product, id_product_type, id_supplier, id_unit, product_name, description, price)
values (4, 7, 16, 6, 'Паляниця', null, 3);
commit;
-- 24 records loaded
-- Loading INVOICE_DETAIL...
insert into INVOICE_DETAIL (id_invoice, id_product, quantity, description)
values (2, 9, 3, null);
insert into INVOICE_DETAIL (id_invoice, id_product, quantity, description)
values (3, 15, 10, null);
insert into INVOICE_DETAIL (id_invoice, id_product, quantity, description)
values (4, 12, 6, null);
insert into INVOICE_DETAIL (id_invoice, id_product, quantity, description)
values (5, 16, 10, null);
insert into INVOICE_DETAIL (id_invoice, id_product, quantity, description)
values (6, 16, 2, null);
insert into INVOICE_DETAIL (id_invoice, id_product, quantity, description)
values (7, 19, 3, null);
insert into INVOICE_DETAIL (id_invoice, id_product, quantity, description)
values (8, 18, 5, null);
insert into INVOICE_DETAIL (id_invoice, id_product, quantity, description)
values (9, 16, 3, null);
insert into INVOICE_DETAIL (id_invoice, id_product, quantity, description)
values (10, 6, 9, null);
insert into INVOICE_DETAIL (id_invoice, id_product, quantity, description)
values (11, 5, 5, null);
insert into INVOICE_DETAIL (id_invoice, id_product, quantity, description)
values (12, 9, 8, null);
insert into INVOICE_DETAIL (id_invoice, id_product, quantity, description)
values (13, 14, 3, null);
insert into INVOICE_DETAIL (id_invoice, id_product, quantity, description)
values (14, 22, 9, null);
insert into INVOICE_DETAIL (id_invoice, id_product, quantity, description)
values (15, 16, 5, null);
insert into INVOICE_DETAIL (id_invoice, id_product, quantity, description)
values (16, 2, 8, null);
insert into INVOICE_DETAIL (id_invoice, id_product, quantity, description)
values (17, 8, 4, null);
insert into INVOICE_DETAIL (id_invoice, id_product, quantity, description)
values (18, 7, 4, null);
insert into INVOICE_DETAIL (id_invoice, id_product, quantity, description)
values (19, 6, 8, null);
insert into INVOICE_DETAIL (id_invoice, id_product, quantity, description)
values (20, 13, 5, null);
insert into INVOICE_DETAIL (id_invoice, id_product, quantity, description)
values (21, 1, 2, null);
insert into INVOICE_DETAIL (id_invoice, id_product, quantity, description)
values (22, 6, 2, null);
insert into INVOICE_DETAIL (id_invoice, id_product, quantity, description)
values (23, 4, 9, null);
insert into INVOICE_DETAIL (id_invoice, id_product, quantity, description)
values (24, 4, 5, null);
insert into INVOICE_DETAIL (id_invoice, id_product, quantity, description)
values (25, 15, 1, null);
insert into INVOICE_DETAIL (id_invoice, id_product, quantity, description)
values (26, 7, 7, null);
insert into INVOICE_DETAIL (id_invoice, id_product, quantity, description)
values (27, 11, 3, null);
insert into INVOICE_DETAIL (id_invoice, id_product, quantity, description)
values (28, 6, 9, null);
insert into INVOICE_DETAIL (id_invoice, id_product, quantity, description)
values (29, 20, 4, null);
insert into INVOICE_DETAIL (id_invoice, id_product, quantity, description)
values (30, 22, 4, null);
insert into INVOICE_DETAIL (id_invoice, id_product, quantity, description)
values (31, 6, 6, null);
insert into INVOICE_DETAIL (id_invoice, id_product, quantity, description)
values (32, 4, 11, null);
insert into INVOICE_DETAIL (id_invoice, id_product, quantity, description)
values (33, 5, 10, null);
insert into INVOICE_DETAIL (id_invoice, id_product, quantity, description)
values (34, 10, 11, null);
insert into INVOICE_DETAIL (id_invoice, id_product, quantity, description)
values (35, 22, 4, null);
insert into INVOICE_DETAIL (id_invoice, id_product, quantity, description)
values (36, 18, 8, null);
insert into INVOICE_DETAIL (id_invoice, id_product, quantity, description)
values (37, 9, 5, null);
insert into INVOICE_DETAIL (id_invoice, id_product, quantity, description)
values (38, 23, 4, null);
insert into INVOICE_DETAIL (id_invoice, id_product, quantity, description)
values (39, 5, 6, null);
insert into INVOICE_DETAIL (id_invoice, id_product, quantity, description)
values (40, 4, 3, null);
insert into INVOICE_DETAIL (id_invoice, id_product, quantity, description)
values (41, 7, 3, null);
insert into INVOICE_DETAIL (id_invoice, id_product, quantity, description)
values (42, 9, 2, null);
insert into INVOICE_DETAIL (id_invoice, id_product, quantity, description)
values (43, 14, 4, null);
insert into INVOICE_DETAIL (id_invoice, id_product, quantity, description)
values (44, 13, 3, null);
insert into INVOICE_DETAIL (id_invoice, id_product, quantity, description)
values (45, 14, 3, null);
insert into INVOICE_DETAIL (id_invoice, id_product, quantity, description)
values (46, 14, 6, null);
insert into INVOICE_DETAIL (id_invoice, id_product, quantity, description)
values (47, 8, 8, null);
insert into INVOICE_DETAIL (id_invoice, id_product, quantity, description)
values (48, 9, 3, null);
insert into INVOICE_DETAIL (id_invoice, id_product, quantity, description)
values (49, 2, 7, null);
insert into INVOICE_DETAIL (id_invoice, id_product, quantity, description)
values (50, 3, 1, null);
insert into INVOICE_DETAIL (id_invoice, id_product, quantity, description)
values (51, 3, 10, null);
insert into INVOICE_DETAIL (id_invoice, id_product, quantity, description)
values (52, 3, 10, null);
insert into INVOICE_DETAIL (id_invoice, id_product, quantity, description)
values (53, 11, 3, null);
insert into INVOICE_DETAIL (id_invoice, id_product, quantity, description)
values (54, 22, 7, null);
insert into INVOICE_DETAIL (id_invoice, id_product, quantity, description)
values (55, 17, 5, null);
insert into INVOICE_DETAIL (id_invoice, id_product, quantity, description)
values (56, 2, 2, null);
insert into INVOICE_DETAIL (id_invoice, id_product, quantity, description)
values (57, 12, 4, null);
insert into INVOICE_DETAIL (id_invoice, id_product, quantity, description)
values (58, 9, 9, null);
insert into INVOICE_DETAIL (id_invoice, id_product, quantity, description)
values (59, 20, 7, null);
insert into INVOICE_DETAIL (id_invoice, id_product, quantity, description)
values (60, 4, 8, null);
insert into INVOICE_DETAIL (id_invoice, id_product, quantity, description)
values (61, 4, 10, null);
insert into INVOICE_DETAIL (id_invoice, id_product, quantity, description)
values (62, 11, 3, null);
insert into INVOICE_DETAIL (id_invoice, id_product, quantity, description)
values (63, 22, 2, null);
insert into INVOICE_DETAIL (id_invoice, id_product, quantity, description)
values (64, 20, 5, null);
insert into INVOICE_DETAIL (id_invoice, id_product, quantity, description)
values (65, 1, 2, null);
insert into INVOICE_DETAIL (id_invoice, id_product, quantity, description)
values (66, 8, 4, null);
insert into INVOICE_DETAIL (id_invoice, id_product, quantity, description)
values (67, 10, 3, null);
insert into INVOICE_DETAIL (id_invoice, id_product, quantity, description)
values (68, 4, 8, null);
insert into INVOICE_DETAIL (id_invoice, id_product, quantity, description)
values (69, 11, 4, null);
insert into INVOICE_DETAIL (id_invoice, id_product, quantity, description)
values (70, 18, 4, null);
insert into INVOICE_DETAIL (id_invoice, id_product, quantity, description)
values (71, 16, 6, null);
insert into INVOICE_DETAIL (id_invoice, id_product, quantity, description)
values (72, 7, 1, null);
insert into INVOICE_DETAIL (id_invoice, id_product, quantity, description)
values (73, 11, 10, null);
insert into INVOICE_DETAIL (id_invoice, id_product, quantity, description)
values (74, 7, 2, null);
insert into INVOICE_DETAIL (id_invoice, id_product, quantity, description)
values (75, 8, 6, null);
insert into INVOICE_DETAIL (id_invoice, id_product, quantity, description)
values (76, 22, 3, null);
insert into INVOICE_DETAIL (id_invoice, id_product, quantity, description)
values (77, 13, 7, null);
insert into INVOICE_DETAIL (id_invoice, id_product, quantity, description)
values (78, 5, 1, null);
insert into INVOICE_DETAIL (id_invoice, id_product, quantity, description)
values (79, 1, 10, null);
insert into INVOICE_DETAIL (id_invoice, id_product, quantity, description)
values (80, 9, 6, null);
insert into INVOICE_DETAIL (id_invoice, id_product, quantity, description)
values (81, 7, 3, null);
insert into INVOICE_DETAIL (id_invoice, id_product, quantity, description)
values (82, 21, 2, null);
insert into INVOICE_DETAIL (id_invoice, id_product, quantity, description)
values (83, 14, 3, null);
insert into INVOICE_DETAIL (id_invoice, id_product, quantity, description)
values (84, 20, 10, null);
insert into INVOICE_DETAIL (id_invoice, id_product, quantity, description)
values (85, 13, 2, null);
insert into INVOICE_DETAIL (id_invoice, id_product, quantity, description)
values (86, 3, 6, null);
insert into INVOICE_DETAIL (id_invoice, id_product, quantity, description)
values (87, 5, 5, null);
insert into INVOICE_DETAIL (id_invoice, id_product, quantity, description)
values (88, 19, 7, null);
insert into INVOICE_DETAIL (id_invoice, id_product, quantity, description)
values (89, 21, 8, null);
insert into INVOICE_DETAIL (id_invoice, id_product, quantity, description)
values (90, 8, 3, null);
insert into INVOICE_DETAIL (id_invoice, id_product, quantity, description)
values (91, 15, 8, null);
insert into INVOICE_DETAIL (id_invoice, id_product, quantity, description)
values (92, 14, 6, null);
insert into INVOICE_DETAIL (id_invoice, id_product, quantity, description)
values (93, 15, 6, null);
insert into INVOICE_DETAIL (id_invoice, id_product, quantity, description)
values (94, 7, 5, null);
insert into INVOICE_DETAIL (id_invoice, id_product, quantity, description)
values (95, 3, 6, null);
insert into INVOICE_DETAIL (id_invoice, id_product, quantity, description)
values (96, 5, 8, null);
insert into INVOICE_DETAIL (id_invoice, id_product, quantity, description)
values (97, 12, 7, null);
insert into INVOICE_DETAIL (id_invoice, id_product, quantity, description)
values (98, 9, 3, null);
insert into INVOICE_DETAIL (id_invoice, id_product, quantity, description)
values (99, 17, 2, null);
insert into INVOICE_DETAIL (id_invoice, id_product, quantity, description)
values (100, 23, 11, null);
commit;
-- 99 records loaded
-- Loading TYPE_OPER...
insert into TYPE_OPER (id_oper_type, name_oper, description)
values (1, 'IN', 'Надходження до складу.');
insert into TYPE_OPER (id_oper_type, name_oper, description)
values (2, 'OUT', null);
commit;
-- 2 records loaded
-- Loading STORE...
insert into STORE (id_store, id_product, shelf, date_oper, id_oper_type, quantity)
values (1, 24, '7', to_date('22-05-2012 21:14:02', 'dd-mm-yyyy hh24:mi:ss'), 1, 9);
insert into STORE (id_store, id_product, shelf, date_oper, id_oper_type, quantity)
values (2, 17, '15', to_date('16-11-2013 09:54:21', 'dd-mm-yyyy hh24:mi:ss'), 1, 5);
insert into STORE (id_store, id_product, shelf, date_oper, id_oper_type, quantity)
values (3, 7, '13', to_date('20-05-2012 01:12:18', 'dd-mm-yyyy hh24:mi:ss'), 2, 1);
insert into STORE (id_store, id_product, shelf, date_oper, id_oper_type, quantity)
values (4, 21, '14', to_date('08-08-2013 17:16:10', 'dd-mm-yyyy hh24:mi:ss'), 1, 7);
insert into STORE (id_store, id_product, shelf, date_oper, id_oper_type, quantity)
values (5, 15, '1', to_date('14-06-2012 18:34:32', 'dd-mm-yyyy hh24:mi:ss'), 1, 7);
insert into STORE (id_store, id_product, shelf, date_oper, id_oper_type, quantity)
values (6, 11, '15', to_date('01-09-2011 16:16:32', 'dd-mm-yyyy hh24:mi:ss'), 2, 8);
insert into STORE (id_store, id_product, shelf, date_oper, id_oper_type, quantity)
values (7, 13, '17', to_date('26-11-2013 22:10:58', 'dd-mm-yyyy hh24:mi:ss'), 2, 8);
insert into STORE (id_store, id_product, shelf, date_oper, id_oper_type, quantity)
values (8, 13, '9', to_date('20-04-2013 13:11:13', 'dd-mm-yyyy hh24:mi:ss'), 2, 9);
insert into STORE (id_store, id_product, shelf, date_oper, id_oper_type, quantity)
values (9, 23, '11', to_date('01-01-2014 14:11:30', 'dd-mm-yyyy hh24:mi:ss'), 2, 4);
insert into STORE (id_store, id_product, shelf, date_oper, id_oper_type, quantity)
values (10, 6, '12', to_date('01-08-2013 19:20:29', 'dd-mm-yyyy hh24:mi:ss'), 2, 8);
insert into STORE (id_store, id_product, shelf, date_oper, id_oper_type, quantity)
values (11, 21, '7', to_date('28-09-2013 11:20:31', 'dd-mm-yyyy hh24:mi:ss'), 2, 10);
insert into STORE (id_store, id_product, shelf, date_oper, id_oper_type, quantity)
values (12, 17, '15', to_date('05-03-2013 10:35:54', 'dd-mm-yyyy hh24:mi:ss'), 1, 5);
insert into STORE (id_store, id_product, shelf, date_oper, id_oper_type, quantity)
values (13, 11, '6', to_date('15-05-2013 09:14:03', 'dd-mm-yyyy hh24:mi:ss'), 1, 5);
insert into STORE (id_store, id_product, shelf, date_oper, id_oper_type, quantity)
values (14, 24, '4', to_date('18-12-2013 08:15:11', 'dd-mm-yyyy hh24:mi:ss'), 1, 10);
insert into STORE (id_store, id_product, shelf, date_oper, id_oper_type, quantity)
values (15, 19, '14', to_date('15-02-2012 08:31:12', 'dd-mm-yyyy hh24:mi:ss'), 1, 4);
insert into STORE (id_store, id_product, shelf, date_oper, id_oper_type, quantity)
values (16, 23, '5', to_date('09-08-2013 08:14:07', 'dd-mm-yyyy hh24:mi:ss'), 1, 5);
insert into STORE (id_store, id_product, shelf, date_oper, id_oper_type, quantity)
values (17, 6, '12', to_date('16-07-2013 06:52:47', 'dd-mm-yyyy hh24:mi:ss'), 2, 3);
insert into STORE (id_store, id_product, shelf, date_oper, id_oper_type, quantity)
values (18, 13, '11', to_date('03-11-2011 16:10:13', 'dd-mm-yyyy hh24:mi:ss'), 1, 2);
insert into STORE (id_store, id_product, shelf, date_oper, id_oper_type, quantity)
values (19, 23, '17', to_date('27-07-2012 07:36:18', 'dd-mm-yyyy hh24:mi:ss'), 1, 3);
insert into STORE (id_store, id_product, shelf, date_oper, id_oper_type, quantity)
values (20, 10, '11', to_date('22-07-2013 14:19:40', 'dd-mm-yyyy hh24:mi:ss'), 2, 6);
insert into STORE (id_store, id_product, shelf, date_oper, id_oper_type, quantity)
values (21, 5, '7', to_date('30-09-2011 15:17:05', 'dd-mm-yyyy hh24:mi:ss'), 1, 4);
insert into STORE (id_store, id_product, shelf, date_oper, id_oper_type, quantity)
values (22, 7, '7', to_date('17-02-2013 18:08:34', 'dd-mm-yyyy hh24:mi:ss'), 2, 3);
insert into STORE (id_store, id_product, shelf, date_oper, id_oper_type, quantity)
values (23, 5, '20', to_date('21-07-2011 15:46:42', 'dd-mm-yyyy hh24:mi:ss'), 2, 1);
insert into STORE (id_store, id_product, shelf, date_oper, id_oper_type, quantity)
values (24, 17, '16', to_date('12-11-2011 11:01:37', 'dd-mm-yyyy hh24:mi:ss'), 1, 7);
insert into STORE (id_store, id_product, shelf, date_oper, id_oper_type, quantity)
values (25, 3, '3', to_date('25-08-2011 00:42:06', 'dd-mm-yyyy hh24:mi:ss'), 2, 3);
insert into STORE (id_store, id_product, shelf, date_oper, id_oper_type, quantity)
values (26, 23, '2', to_date('23-05-2013 14:16:33', 'dd-mm-yyyy hh24:mi:ss'), 2, 2);
insert into STORE (id_store, id_product, shelf, date_oper, id_oper_type, quantity)
values (27, 12, '9', to_date('01-09-2012 22:28:36', 'dd-mm-yyyy hh24:mi:ss'), 1, 10);
insert into STORE (id_store, id_product, shelf, date_oper, id_oper_type, quantity)
values (28, 13, '17', to_date('28-09-2012 21:48:09', 'dd-mm-yyyy hh24:mi:ss'), 2, 10);
insert into STORE (id_store, id_product, shelf, date_oper, id_oper_type, quantity)
values (29, 18, '15', to_date('29-11-2011 09:50:10', 'dd-mm-yyyy hh24:mi:ss'), 1, 7);
insert into STORE (id_store, id_product, shelf, date_oper, id_oper_type, quantity)
values (30, 24, '11', to_date('05-02-2013 19:44:18', 'dd-mm-yyyy hh24:mi:ss'), 1, 4);
insert into STORE (id_store, id_product, shelf, date_oper, id_oper_type, quantity)
values (31, 1, '13', to_date('09-04-2013 08:10:42', 'dd-mm-yyyy hh24:mi:ss'), 2, 3);
insert into STORE (id_store, id_product, shelf, date_oper, id_oper_type, quantity)
values (32, 9, '7', to_date('15-08-2011 17:01:05', 'dd-mm-yyyy hh24:mi:ss'), 2, 10);
insert into STORE (id_store, id_product, shelf, date_oper, id_oper_type, quantity)
values (33, 9, '16', to_date('19-01-2012 22:30:10', 'dd-mm-yyyy hh24:mi:ss'), 1, 3);
insert into STORE (id_store, id_product, shelf, date_oper, id_oper_type, quantity)
values (34, 4, '10', to_date('05-01-2012 11:08:56', 'dd-mm-yyyy hh24:mi:ss'), 1, 1);
insert into STORE (id_store, id_product, shelf, date_oper, id_oper_type, quantity)
values (35, 16, '11', to_date('14-08-2012 21:50:13', 'dd-mm-yyyy hh24:mi:ss'), 2, 8);
insert into STORE (id_store, id_product, shelf, date_oper, id_oper_type, quantity)
values (36, 19, '3', to_date('05-12-2012 08:03:59', 'dd-mm-yyyy hh24:mi:ss'), 1, 3);
insert into STORE (id_store, id_product, shelf, date_oper, id_oper_type, quantity)
values (37, 9, '2', to_date('21-08-2011 17:00:04', 'dd-mm-yyyy hh24:mi:ss'), 2, 8);
insert into STORE (id_store, id_product, shelf, date_oper, id_oper_type, quantity)
values (38, 18, '15', to_date('30-05-2013 03:46:16', 'dd-mm-yyyy hh24:mi:ss'), 2, 7);
insert into STORE (id_store, id_product, shelf, date_oper, id_oper_type, quantity)
values (39, 12, '4', to_date('02-05-2013 21:13:05', 'dd-mm-yyyy hh24:mi:ss'), 2, 3);
insert into STORE (id_store, id_product, shelf, date_oper, id_oper_type, quantity)
values (40, 23, '18', to_date('25-04-2013 18:03:30', 'dd-mm-yyyy hh24:mi:ss'), 2, 7);
insert into STORE (id_store, id_product, shelf, date_oper, id_oper_type, quantity)
values (41, 24, '4', to_date('19-08-2011 01:21:17', 'dd-mm-yyyy hh24:mi:ss'), 2, 4);
insert into STORE (id_store, id_product, shelf, date_oper, id_oper_type, quantity)
values (42, 20, '9', to_date('13-01-2013 02:08:47', 'dd-mm-yyyy hh24:mi:ss'), 1, 4);
insert into STORE (id_store, id_product, shelf, date_oper, id_oper_type, quantity)
values (43, 13, '13', to_date('13-06-2011 08:57:10', 'dd-mm-yyyy hh24:mi:ss'), 2, 9);
insert into STORE (id_store, id_product, shelf, date_oper, id_oper_type, quantity)
values (44, 3, '11', to_date('10-10-2012 14:13:29', 'dd-mm-yyyy hh24:mi:ss'), 1, 3);
insert into STORE (id_store, id_product, shelf, date_oper, id_oper_type, quantity)
values (45, 21, '19', to_date('15-07-2011 19:21:25', 'dd-mm-yyyy hh24:mi:ss'), 1, 7);
insert into STORE (id_store, id_product, shelf, date_oper, id_oper_type, quantity)
values (46, 20, '10', to_date('19-12-2012 09:26:49', 'dd-mm-yyyy hh24:mi:ss'), 1, 7);
insert into STORE (id_store, id_product, shelf, date_oper, id_oper_type, quantity)
values (47, 12, '2', to_date('07-06-2012 18:06:56', 'dd-mm-yyyy hh24:mi:ss'), 2, 7);
insert into STORE (id_store, id_product, shelf, date_oper, id_oper_type, quantity)
values (48, 16, '18', to_date('26-03-2013 19:05:52', 'dd-mm-yyyy hh24:mi:ss'), 1, 8);
insert into STORE (id_store, id_product, shelf, date_oper, id_oper_type, quantity)
values (49, 2, '6', to_date('04-10-2012 06:46:01', 'dd-mm-yyyy hh24:mi:ss'), 2, 4);
insert into STORE (id_store, id_product, shelf, date_oper, id_oper_type, quantity)
values (50, 10, '6', to_date('06-12-2011 18:02:35', 'dd-mm-yyyy hh24:mi:ss'), 1, 3);
insert into STORE (id_store, id_product, shelf, date_oper, id_oper_type, quantity)
values (51, 4, '15', to_date('30-05-2013 03:46:16', 'dd-mm-yyyy hh24:mi:ss'), 2, 1);
insert into STORE (id_store, id_product, shelf, date_oper, id_oper_type, quantity)
values (52, 17, '1', to_date('01-01-2013 00:11:03', 'dd-mm-yyyy hh24:mi:ss'), 2, 6);
insert into STORE (id_store, id_product, shelf, date_oper, id_oper_type, quantity)
values (53, 13, '18', to_date('26-10-2012 17:35:00', 'dd-mm-yyyy hh24:mi:ss'), 2, 3);
insert into STORE (id_store, id_product, shelf, date_oper, id_oper_type, quantity)
values (54, 6, '6', to_date('07-10-2011 16:57:07', 'dd-mm-yyyy hh24:mi:ss'), 2, 3);
insert into STORE (id_store, id_product, shelf, date_oper, id_oper_type, quantity)
values (55, 20, '11', to_date('01-02-2012 09:12:51', 'dd-mm-yyyy hh24:mi:ss'), 2, 2);
insert into STORE (id_store, id_product, shelf, date_oper, id_oper_type, quantity)
values (56, 6, '8', to_date('10-08-2013 00:45:12', 'dd-mm-yyyy hh24:mi:ss'), 1, 9);
insert into STORE (id_store, id_product, shelf, date_oper, id_oper_type, quantity)
values (57, 2, '13', to_date('03-09-2013 06:33:48', 'dd-mm-yyyy hh24:mi:ss'), 1, 6);
insert into STORE (id_store, id_product, shelf, date_oper, id_oper_type, quantity)
values (58, 13, '16', to_date('02-06-2012 08:04:54', 'dd-mm-yyyy hh24:mi:ss'), 1, 7);
insert into STORE (id_store, id_product, shelf, date_oper, id_oper_type, quantity)
values (59, 4, '9', to_date('22-06-2013 01:26:21', 'dd-mm-yyyy hh24:mi:ss'), 2, 5);
insert into STORE (id_store, id_product, shelf, date_oper, id_oper_type, quantity)
values (60, 8, '10', to_date('26-12-2011 02:39:26', 'dd-mm-yyyy hh24:mi:ss'), 2, 4);
insert into STORE (id_store, id_product, shelf, date_oper, id_oper_type, quantity)
values (61, 17, '3', to_date('03-03-2013 10:24:25', 'dd-mm-yyyy hh24:mi:ss'), 2, 8);
insert into STORE (id_store, id_product, shelf, date_oper, id_oper_type, quantity)
values (62, 5, '19', to_date('18-05-2012 14:52:32', 'dd-mm-yyyy hh24:mi:ss'), 1, 2);
insert into STORE (id_store, id_product, shelf, date_oper, id_oper_type, quantity)
values (63, 15, '2', to_date('07-01-2014 17:40:12', 'dd-mm-yyyy hh24:mi:ss'), 1, 10);
insert into STORE (id_store, id_product, shelf, date_oper, id_oper_type, quantity)
values (64, 3, '9', to_date('28-05-2013 02:01:33', 'dd-mm-yyyy hh24:mi:ss'), 1, 7);
insert into STORE (id_store, id_product, shelf, date_oper, id_oper_type, quantity)
values (65, 21, '9', to_date('11-05-2013 08:12:40', 'dd-mm-yyyy hh24:mi:ss'), 1, 2);
insert into STORE (id_store, id_product, shelf, date_oper, id_oper_type, quantity)
values (66, 7, '17', to_date('03-07-2013 08:02:53', 'dd-mm-yyyy hh24:mi:ss'), 1, 8);
insert into STORE (id_store, id_product, shelf, date_oper, id_oper_type, quantity)
values (67, 13, '2', to_date('16-05-2013 14:11:38', 'dd-mm-yyyy hh24:mi:ss'), 1, 8);
insert into STORE (id_store, id_product, shelf, date_oper, id_oper_type, quantity)
values (68, 19, '17', to_date('13-10-2013 16:33:00', 'dd-mm-yyyy hh24:mi:ss'), 1, 6);
insert into STORE (id_store, id_product, shelf, date_oper, id_oper_type, quantity)
values (69, 16, '8', to_date('17-04-2012 19:22:57', 'dd-mm-yyyy hh24:mi:ss'), 1, 8);
insert into STORE (id_store, id_product, shelf, date_oper, id_oper_type, quantity)
values (70, 3, '11', to_date('04-04-2012 01:19:20', 'dd-mm-yyyy hh24:mi:ss'), 1, 7);
insert into STORE (id_store, id_product, shelf, date_oper, id_oper_type, quantity)
values (71, 22, '8', to_date('26-07-2013 00:10:16', 'dd-mm-yyyy hh24:mi:ss'), 2, 5);
insert into STORE (id_store, id_product, shelf, date_oper, id_oper_type, quantity)
values (72, 18, '7', to_date('03-08-2013 15:44:20', 'dd-mm-yyyy hh24:mi:ss'), 1, 1);
insert into STORE (id_store, id_product, shelf, date_oper, id_oper_type, quantity)
values (73, 24, '10', to_date('17-03-2012 03:07:07', 'dd-mm-yyyy hh24:mi:ss'), 1, 6);
insert into STORE (id_store, id_product, shelf, date_oper, id_oper_type, quantity)
values (74, 10, '17', to_date('14-10-2011 02:39:15', 'dd-mm-yyyy hh24:mi:ss'), 1, 1);
insert into STORE (id_store, id_product, shelf, date_oper, id_oper_type, quantity)
values (75, 16, '3', to_date('03-05-2012 20:09:05', 'dd-mm-yyyy hh24:mi:ss'), 2, 10);
insert into STORE (id_store, id_product, shelf, date_oper, id_oper_type, quantity)
values (76, 15, '11', to_date('24-12-2011 15:20:51', 'dd-mm-yyyy hh24:mi:ss'), 2, 2);
insert into STORE (id_store, id_product, shelf, date_oper, id_oper_type, quantity)
values (77, 22, '15', to_date('04-07-2012 14:09:14', 'dd-mm-yyyy hh24:mi:ss'), 1, 8);
insert into STORE (id_store, id_product, shelf, date_oper, id_oper_type, quantity)
values (78, 23, '17', to_date('12-06-2012 03:53:04', 'dd-mm-yyyy hh24:mi:ss'), 2, 9);
insert into STORE (id_store, id_product, shelf, date_oper, id_oper_type, quantity)
values (79, 19, '16', to_date('09-07-2012 17:15:30', 'dd-mm-yyyy hh24:mi:ss'), 2, 8);
insert into STORE (id_store, id_product, shelf, date_oper, id_oper_type, quantity)
values (80, 6, '16', to_date('16-10-2012 05:07:19', 'dd-mm-yyyy hh24:mi:ss'), 1, 9);
insert into STORE (id_store, id_product, shelf, date_oper, id_oper_type, quantity)
values (81, 4, '4', to_date('18-12-2011 19:14:29', 'dd-mm-yyyy hh24:mi:ss'), 2, 6);
insert into STORE (id_store, id_product, shelf, date_oper, id_oper_type, quantity)
values (82, 22, '20', to_date('22-02-2012 10:58:35', 'dd-mm-yyyy hh24:mi:ss'), 2, 3);
insert into STORE (id_store, id_product, shelf, date_oper, id_oper_type, quantity)
values (83, 21, '6', to_date('04-07-2011 07:41:05', 'dd-mm-yyyy hh24:mi:ss'), 2, 5);
insert into STORE (id_store, id_product, shelf, date_oper, id_oper_type, quantity)
values (84, 19, '9', to_date('10-09-2012 18:24:29', 'dd-mm-yyyy hh24:mi:ss'), 2, 2);
insert into STORE (id_store, id_product, shelf, date_oper, id_oper_type, quantity)
values (85, 8, '12', to_date('03-05-2012 21:03:34', 'dd-mm-yyyy hh24:mi:ss'), 2, 8);
insert into STORE (id_store, id_product, shelf, date_oper, id_oper_type, quantity)
values (86, 11, '7', to_date('01-12-2012 07:43:31', 'dd-mm-yyyy hh24:mi:ss'), 1, 3);
insert into STORE (id_store, id_product, shelf, date_oper, id_oper_type, quantity)
values (87, 13, '13', to_date('02-08-2011 01:53:09', 'dd-mm-yyyy hh24:mi:ss'), 2, 8);
insert into STORE (id_store, id_product, shelf, date_oper, id_oper_type, quantity)
values (88, 11, '14', to_date('24-07-2012 01:06:20', 'dd-mm-yyyy hh24:mi:ss'), 1, 6);
insert into STORE (id_store, id_product, shelf, date_oper, id_oper_type, quantity)
values (89, 5, '14', to_date('11-10-2011 08:11:48', 'dd-mm-yyyy hh24:mi:ss'), 2, 6);
insert into STORE (id_store, id_product, shelf, date_oper, id_oper_type, quantity)
values (90, 7, '12', to_date('06-06-2011 19:11:55', 'dd-mm-yyyy hh24:mi:ss'), 1, 7);
insert into STORE (id_store, id_product, shelf, date_oper, id_oper_type, quantity)
values (91, 10, '3', to_date('16-11-2013 09:28:41', 'dd-mm-yyyy hh24:mi:ss'), 2, 7);
insert into STORE (id_store, id_product, shelf, date_oper, id_oper_type, quantity)
values (92, 22, '12', to_date('21-10-2013 14:01:39', 'dd-mm-yyyy hh24:mi:ss'), 1, 9);
insert into STORE (id_store, id_product, shelf, date_oper, id_oper_type, quantity)
values (93, 3, '11', to_date('12-02-2013 15:30:28', 'dd-mm-yyyy hh24:mi:ss'), 2, 9);
insert into STORE (id_store, id_product, shelf, date_oper, id_oper_type, quantity)
values (94, 16, '14', to_date('09-06-2012 14:30:30', 'dd-mm-yyyy hh24:mi:ss'), 1, 7);
insert into STORE (id_store, id_product, shelf, date_oper, id_oper_type, quantity)
values (95, 8, '12', to_date('10-07-2013 03:34:16', 'dd-mm-yyyy hh24:mi:ss'), 2, 7);
insert into STORE (id_store, id_product, shelf, date_oper, id_oper_type, quantity)
values (96, 21, '17', to_date('15-07-2013 08:50:07', 'dd-mm-yyyy hh24:mi:ss'), 2, 1);
insert into STORE (id_store, id_product, shelf, date_oper, id_oper_type, quantity)
values (97, 4, '14', to_date('30-08-2012 04:22:53', 'dd-mm-yyyy hh24:mi:ss'), 1, 1);
insert into STORE (id_store, id_product, shelf, date_oper, id_oper_type, quantity)
values (98, 6, '11', to_date('05-09-2012 05:11:05', 'dd-mm-yyyy hh24:mi:ss'), 2, 9);
insert into STORE (id_store, id_product, shelf, date_oper, id_oper_type, quantity)
values (99, 9, '15', to_date('11-12-2013 09:54:21', 'dd-mm-yyyy hh24:mi:ss'), 2, 3);
insert into STORE (id_store, id_product, shelf, date_oper, id_oper_type, quantity)
values (100, 2, '8', to_date('11-08-2012 19:46:56', 'dd-mm-yyyy hh24:mi:ss'), 1, 8);
commit;
-- 100 records loaded
-- Loading WORKB_INVOICE...
insert into WORKB_INVOICE (id_invoice, id_type, id_stuff, purchase_time)
values (5, 1, 5, 214);
insert into WORKB_INVOICE (id_invoice, id_type, id_stuff, purchase_time)
values (6, 2, 6, 436);
insert into WORKB_INVOICE (id_invoice, id_type, id_stuff, purchase_time)
values (7, 1, 1, 47);
insert into WORKB_INVOICE (id_invoice, id_type, id_stuff, purchase_time)
values (8, 1, 3, 291);
insert into WORKB_INVOICE (id_invoice, id_type, id_stuff, purchase_time)
values (9, 2, 5, 359);
insert into WORKB_INVOICE (id_invoice, id_type, id_stuff, purchase_time)
values (10, 2, 5, 526);
insert into WORKB_INVOICE (id_invoice, id_type, id_stuff, purchase_time)
values (13, 2, 2, 275);
insert into WORKB_INVOICE (id_invoice, id_type, id_stuff, purchase_time)
values (15, 1, 2, 589);
insert into WORKB_INVOICE (id_invoice, id_type, id_stuff, purchase_time)
values (16, 1, 3, 41);
insert into WORKB_INVOICE (id_invoice, id_type, id_stuff, purchase_time)
values (17, 2, 5, 404);
insert into WORKB_INVOICE (id_invoice, id_type, id_stuff, purchase_time)
values (18, 1, 6, 14);
insert into WORKB_INVOICE (id_invoice, id_type, id_stuff, purchase_time)
values (19, 1, 5, 303);
insert into WORKB_INVOICE (id_invoice, id_type, id_stuff, purchase_time)
values (20, 1, 3, 279);
insert into WORKB_INVOICE (id_invoice, id_type, id_stuff, purchase_time)
values (21, 1, 3, 514);
insert into WORKB_INVOICE (id_invoice, id_type, id_stuff, purchase_time)
values (22, 2, 5, 701);
insert into WORKB_INVOICE (id_invoice, id_type, id_stuff, purchase_time)
values (23, 2, 1, 673);
insert into WORKB_INVOICE (id_invoice, id_type, id_stuff, purchase_time)
values (24, 1, 5, 465);
insert into WORKB_INVOICE (id_invoice, id_type, id_stuff, purchase_time)
values (25, 1, 4, 564);
insert into WORKB_INVOICE (id_invoice, id_type, id_stuff, purchase_time)
values (27, 1, 4, 216);
insert into WORKB_INVOICE (id_invoice, id_type, id_stuff, purchase_time)
values (28, 2, 6, 69);
insert into WORKB_INVOICE (id_invoice, id_type, id_stuff, purchase_time)
values (29, 2, 4, 681);
insert into WORKB_INVOICE (id_invoice, id_type, id_stuff, purchase_time)
values (31, 1, 2, 127);
insert into WORKB_INVOICE (id_invoice, id_type, id_stuff, purchase_time)
values (32, 2, 4, 613);
insert into WORKB_INVOICE (id_invoice, id_type, id_stuff, purchase_time)
values (33, 1, 2, 569);
insert into WORKB_INVOICE (id_invoice, id_type, id_stuff, purchase_time)
values (34, 1, 3, 686);
insert into WORKB_INVOICE (id_invoice, id_type, id_stuff, purchase_time)
values (35, 1, 6, 420);
insert into WORKB_INVOICE (id_invoice, id_type, id_stuff, purchase_time)
values (36, 2, 6, 296);
insert into WORKB_INVOICE (id_invoice, id_type, id_stuff, purchase_time)
values (37, 2, 4, 391);
insert into WORKB_INVOICE (id_invoice, id_type, id_stuff, purchase_time)
values (38, 2, 2, 471);
insert into WORKB_INVOICE (id_invoice, id_type, id_stuff, purchase_time)
values (39, 1, 2, 703);
insert into WORKB_INVOICE (id_invoice, id_type, id_stuff, purchase_time)
values (40, 1, 1, 724);
insert into WORKB_INVOICE (id_invoice, id_type, id_stuff, purchase_time)
values (41, 1, 3, 503);
insert into WORKB_INVOICE (id_invoice, id_type, id_stuff, purchase_time)
values (42, 2, 5, 408);
insert into WORKB_INVOICE (id_invoice, id_type, id_stuff, purchase_time)
values (43, 1, 3, 38);
insert into WORKB_INVOICE (id_invoice, id_type, id_stuff, purchase_time)
values (45, 2, 2, 125);
insert into WORKB_INVOICE (id_invoice, id_type, id_stuff, purchase_time)
values (47, 1, 3, 386);
insert into WORKB_INVOICE (id_invoice, id_type, id_stuff, purchase_time)
values (48, 1, 2, 292);
insert into WORKB_INVOICE (id_invoice, id_type, id_stuff, purchase_time)
values (49, 1, 4, 343);
insert into WORKB_INVOICE (id_invoice, id_type, id_stuff, purchase_time)
values (50, 2, 1, 117);
insert into WORKB_INVOICE (id_invoice, id_type, id_stuff, purchase_time)
values (51, 1, 2, 253);
insert into WORKB_INVOICE (id_invoice, id_type, id_stuff, purchase_time)
values (52, 1, 6, 548);
insert into WORKB_INVOICE (id_invoice, id_type, id_stuff, purchase_time)
values (53, 1, 3, 380);
insert into WORKB_INVOICE (id_invoice, id_type, id_stuff, purchase_time)
values (54, 1, 6, 671);
insert into WORKB_INVOICE (id_invoice, id_type, id_stuff, purchase_time)
values (56, 2, 5, 223);
insert into WORKB_INVOICE (id_invoice, id_type, id_stuff, purchase_time)
values (57, 1, 3, 36);
insert into WORKB_INVOICE (id_invoice, id_type, id_stuff, purchase_time)
values (58, 1, 5, 445);
insert into WORKB_INVOICE (id_invoice, id_type, id_stuff, purchase_time)
values (61, 2, 4, 248);
insert into WORKB_INVOICE (id_invoice, id_type, id_stuff, purchase_time)
values (62, 1, 5, 674);
insert into WORKB_INVOICE (id_invoice, id_type, id_stuff, purchase_time)
values (63, 1, 2, 137);
insert into WORKB_INVOICE (id_invoice, id_type, id_stuff, purchase_time)
values (64, 1, 6, 546);
insert into WORKB_INVOICE (id_invoice, id_type, id_stuff, purchase_time)
values (66, 1, 3, 596);
insert into WORKB_INVOICE (id_invoice, id_type, id_stuff, purchase_time)
values (69, 2, 4, 260);
insert into WORKB_INVOICE (id_invoice, id_type, id_stuff, purchase_time)
values (70, 1, 2, 406);
insert into WORKB_INVOICE (id_invoice, id_type, id_stuff, purchase_time)
values (71, 2, 3, 713);
insert into WORKB_INVOICE (id_invoice, id_type, id_stuff, purchase_time)
values (72, 2, 2, 20);
insert into WORKB_INVOICE (id_invoice, id_type, id_stuff, purchase_time)
values (73, 1, 5, 94);
insert into WORKB_INVOICE (id_invoice, id_type, id_stuff, purchase_time)
values (76, 2, 4, 569);
insert into WORKB_INVOICE (id_invoice, id_type, id_stuff, purchase_time)
values (78, 2, 5, 262);
insert into WORKB_INVOICE (id_invoice, id_type, id_stuff, purchase_time)
values (79, 2, 6, 482);
insert into WORKB_INVOICE (id_invoice, id_type, id_stuff, purchase_time)
values (81, 1, 2, 80);
insert into WORKB_INVOICE (id_invoice, id_type, id_stuff, purchase_time)
values (82, 2, 5, 556);
insert into WORKB_INVOICE (id_invoice, id_type, id_stuff, purchase_time)
values (83, 2, 2, 425);
insert into WORKB_INVOICE (id_invoice, id_type, id_stuff, purchase_time)
values (84, 2, 4, 323);
insert into WORKB_INVOICE (id_invoice, id_type, id_stuff, purchase_time)
values (85, 2, 5, 199);
insert into WORKB_INVOICE (id_invoice, id_type, id_stuff, purchase_time)
values (86, 2, 5, 8);
insert into WORKB_INVOICE (id_invoice, id_type, id_stuff, purchase_time)
values (87, 2, 3, 599);
insert into WORKB_INVOICE (id_invoice, id_type, id_stuff, purchase_time)
values (89, 2, 4, 420);
insert into WORKB_INVOICE (id_invoice, id_type, id_stuff, purchase_time)
values (93, 2, 4, 533);
insert into WORKB_INVOICE (id_invoice, id_type, id_stuff, purchase_time)
values (94, 1, 2, 412);
insert into WORKB_INVOICE (id_invoice, id_type, id_stuff, purchase_time)
values (95, 2, 3, 531);
insert into WORKB_INVOICE (id_invoice, id_type, id_stuff, purchase_time)
values (96, 1, 5, 223);
insert into WORKB_INVOICE (id_invoice, id_type, id_stuff, purchase_time)
values (97, 1, 4, 403);
insert into WORKB_INVOICE (id_invoice, id_type, id_stuff, purchase_time)
values (98, 1, 3, 659);
insert into WORKB_INVOICE (id_invoice, id_type, id_stuff, purchase_time)
values (1, 1, 4, 43);
commit;
-- 74 records loaded
-- Loading WORKB_TIME...
insert into WORKB_TIME (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values (248, to_date('04-09-2012', 'dd-mm-yyyy'), 4, 2, 9, 3, 2012, 0);
insert into WORKB_TIME (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values (249, to_date('05-09-2012', 'dd-mm-yyyy'), 5, 3, 9, 3, 2012, 0);
insert into WORKB_TIME (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values (250, to_date('06-09-2012', 'dd-mm-yyyy'), 6, 4, 9, 3, 2012, 0);
insert into WORKB_TIME (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values (251, to_date('07-09-2012', 'dd-mm-yyyy'), 7, 5, 9, 3, 2012, 0);
insert into WORKB_TIME (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values (252, to_date('08-09-2012', 'dd-mm-yyyy'), 8, 6, 9, 3, 2012, 1);
insert into WORKB_TIME (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values (253, to_date('09-09-2012', 'dd-mm-yyyy'), 9, 7, 9, 3, 2012, 1);
insert into WORKB_TIME (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values (254, to_date('10-09-2012', 'dd-mm-yyyy'), 10, 1, 9, 3, 2012, 0);
insert into WORKB_TIME (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values (255, to_date('11-09-2012', 'dd-mm-yyyy'), 11, 2, 9, 3, 2012, 0);
insert into WORKB_TIME (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values (256, to_date('12-09-2012', 'dd-mm-yyyy'), 12, 3, 9, 3, 2012, 0);
insert into WORKB_TIME (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values (257, to_date('13-09-2012', 'dd-mm-yyyy'), 13, 4, 9, 3, 2012, 0);
insert into WORKB_TIME (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values (258, to_date('14-09-2012', 'dd-mm-yyyy'), 14, 5, 9, 3, 2012, 0);
insert into WORKB_TIME (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values (259, to_date('15-09-2012', 'dd-mm-yyyy'), 15, 6, 9, 3, 2012, 1);
insert into WORKB_TIME (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values (260, to_date('16-09-2012', 'dd-mm-yyyy'), 16, 7, 9, 3, 2012, 1);
insert into WORKB_TIME (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values (261, to_date('17-09-2012', 'dd-mm-yyyy'), 17, 1, 9, 3, 2012, 0);
insert into WORKB_TIME (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values (262, to_date('18-09-2012', 'dd-mm-yyyy'), 18, 2, 9, 3, 2012, 0);
insert into WORKB_TIME (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values (263, to_date('19-09-2012', 'dd-mm-yyyy'), 19, 3, 9, 3, 2012, 0);
insert into WORKB_TIME (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values (264, to_date('20-09-2012', 'dd-mm-yyyy'), 20, 4, 9, 3, 2012, 0);
insert into WORKB_TIME (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values (265, to_date('21-09-2012', 'dd-mm-yyyy'), 21, 5, 9, 3, 2012, 0);
insert into WORKB_TIME (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values (266, to_date('22-09-2012', 'dd-mm-yyyy'), 22, 6, 9, 3, 2012, 1);
insert into WORKB_TIME (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values (267, to_date('23-09-2012', 'dd-mm-yyyy'), 23, 7, 9, 3, 2012, 1);
insert into WORKB_TIME (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values (268, to_date('24-09-2012', 'dd-mm-yyyy'), 24, 1, 9, 3, 2012, 0);
insert into WORKB_TIME (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values (269, to_date('25-09-2012', 'dd-mm-yyyy'), 25, 2, 9, 3, 2012, 0);
insert into WORKB_TIME (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values (270, to_date('26-09-2012', 'dd-mm-yyyy'), 26, 3, 9, 3, 2012, 0);
insert into WORKB_TIME (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values (271, to_date('27-09-2012', 'dd-mm-yyyy'), 27, 4, 9, 3, 2012, 0);
insert into WORKB_TIME (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values (272, to_date('28-09-2012', 'dd-mm-yyyy'), 28, 5, 9, 3, 2012, 0);
insert into WORKB_TIME (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values (273, to_date('29-09-2012', 'dd-mm-yyyy'), 29, 6, 9, 3, 2012, 1);
insert into WORKB_TIME (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values (274, to_date('30-09-2012', 'dd-mm-yyyy'), 30, 7, 9, 3, 2012, 1);
insert into WORKB_TIME (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values (275, to_date('01-10-2012', 'dd-mm-yyyy'), 1, 1, 10, 4, 2012, 0);
insert into WORKB_TIME (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values (276, to_date('02-10-2012', 'dd-mm-yyyy'), 2, 2, 10, 4, 2012, 0);
insert into WORKB_TIME (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values (277, to_date('03-10-2012', 'dd-mm-yyyy'), 3, 3, 10, 4, 2012, 0);
insert into WORKB_TIME (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values (278, to_date('04-10-2012', 'dd-mm-yyyy'), 4, 4, 10, 4, 2012, 0);
insert into WORKB_TIME (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values (279, to_date('05-10-2012', 'dd-mm-yyyy'), 5, 5, 10, 4, 2012, 0);
insert into WORKB_TIME (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values (280, to_date('06-10-2012', 'dd-mm-yyyy'), 6, 6, 10, 4, 2012, 1);
insert into WORKB_TIME (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values (281, to_date('07-10-2012', 'dd-mm-yyyy'), 7, 7, 10, 4, 2012, 1);
insert into WORKB_TIME (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values (282, to_date('08-10-2012', 'dd-mm-yyyy'), 8, 1, 10, 4, 2012, 0);
insert into WORKB_TIME (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values (283, to_date('09-10-2012', 'dd-mm-yyyy'), 9, 2, 10, 4, 2012, 0);
insert into WORKB_TIME (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values (284, to_date('10-10-2012', 'dd-mm-yyyy'), 10, 3, 10, 4, 2012, 0);
insert into WORKB_TIME (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values (285, to_date('11-10-2012', 'dd-mm-yyyy'), 11, 4, 10, 4, 2012, 0);
insert into WORKB_TIME (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values (286, to_date('12-10-2012', 'dd-mm-yyyy'), 12, 5, 10, 4, 2012, 0);
insert into WORKB_TIME (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values (287, to_date('13-10-2012', 'dd-mm-yyyy'), 13, 6, 10, 4, 2012, 1);
insert into WORKB_TIME (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values (288, to_date('14-10-2012', 'dd-mm-yyyy'), 14, 7, 10, 4, 2012, 1);
insert into WORKB_TIME (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values (289, to_date('15-10-2012', 'dd-mm-yyyy'), 15, 1, 10, 4, 2012, 0);
insert into WORKB_TIME (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values (290, to_date('16-10-2012', 'dd-mm-yyyy'), 16, 2, 10, 4, 2012, 0);
insert into WORKB_TIME (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values (291, to_date('17-10-2012', 'dd-mm-yyyy'), 17, 3, 10, 4, 2012, 0);
insert into WORKB_TIME (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values (292, to_date('18-10-2012', 'dd-mm-yyyy'), 18, 4, 10, 4, 2012, 0);
insert into WORKB_TIME (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values (293, to_date('19-10-2012', 'dd-mm-yyyy'), 19, 5, 10, 4, 2012, 0);
insert into WORKB_TIME (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values (294, to_date('20-10-2012', 'dd-mm-yyyy'), 20, 6, 10, 4, 2012, 1);
insert into WORKB_TIME (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values (295, to_date('21-10-2012', 'dd-mm-yyyy'), 21, 7, 10, 4, 2012, 1);
insert into WORKB_TIME (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values (296, to_date('22-10-2012', 'dd-mm-yyyy'), 22, 1, 10, 4, 2012, 0);
insert into WORKB_TIME (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values (297, to_date('23-10-2012', 'dd-mm-yyyy'), 23, 2, 10, 4, 2012, 0);
insert into WORKB_TIME (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values (298, to_date('24-10-2012', 'dd-mm-yyyy'), 24, 3, 10, 4, 2012, 0);
insert into WORKB_TIME (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values (299, to_date('25-10-2012', 'dd-mm-yyyy'), 25, 4, 10, 4, 2012, 0);
insert into WORKB_TIME (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values (300, to_date('26-10-2012', 'dd-mm-yyyy'), 26, 5, 10, 4, 2012, 0);
insert into WORKB_TIME (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values (301, to_date('27-10-2012', 'dd-mm-yyyy'), 27, 6, 10, 4, 2012, 1);
insert into WORKB_TIME (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values (302, to_date('28-10-2012', 'dd-mm-yyyy'), 28, 7, 10, 4, 2012, 1);
insert into WORKB_TIME (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values (303, to_date('29-10-2012', 'dd-mm-yyyy'), 29, 1, 10, 4, 2012, 0);
insert into WORKB_TIME (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values (304, to_date('30-10-2012', 'dd-mm-yyyy'), 30, 2, 10, 4, 2012, 0);
insert into WORKB_TIME (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values (305, to_date('31-10-2012', 'dd-mm-yyyy'), 31, 3, 10, 4, 2012, 0);
insert into WORKB_TIME (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values (306, to_date('01-11-2012', 'dd-mm-yyyy'), 1, 4, 11, 4, 2012, 0);
insert into WORKB_TIME (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values (307, to_date('02-11-2012', 'dd-mm-yyyy'), 2, 5, 11, 4, 2012, 0);
insert into WORKB_TIME (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values (308, to_date('03-11-2012', 'dd-mm-yyyy'), 3, 6, 11, 4, 2012, 1);
insert into WORKB_TIME (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values (309, to_date('04-11-2012', 'dd-mm-yyyy'), 4, 7, 11, 4, 2012, 1);
insert into WORKB_TIME (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values (310, to_date('05-11-2012', 'dd-mm-yyyy'), 5, 1, 11, 4, 2012, 0);
insert into WORKB_TIME (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values (311, to_date('06-11-2012', 'dd-mm-yyyy'), 6, 2, 11, 4, 2012, 0);
insert into WORKB_TIME (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values (312, to_date('07-11-2012', 'dd-mm-yyyy'), 7, 3, 11, 4, 2012, 0);
insert into WORKB_TIME (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values (313, to_date('08-11-2012', 'dd-mm-yyyy'), 8, 4, 11, 4, 2012, 0);
insert into WORKB_TIME (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values (314, to_date('09-11-2012', 'dd-mm-yyyy'), 9, 5, 11, 4, 2012, 0);
insert into WORKB_TIME (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values (315, to_date('10-11-2012', 'dd-mm-yyyy'), 10, 6, 11, 4, 2012, 1);
insert into WORKB_TIME (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values (316, to_date('11-11-2012', 'dd-mm-yyyy'), 11, 7, 11, 4, 2012, 1);
insert into WORKB_TIME (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values (317, to_date('12-11-2012', 'dd-mm-yyyy'), 12, 1, 11, 4, 2012, 0);
insert into WORKB_TIME (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values (318, to_date('13-11-2012', 'dd-mm-yyyy'), 13, 2, 11, 4, 2012, 0);
insert into WORKB_TIME (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values (319, to_date('14-11-2012', 'dd-mm-yyyy'), 14, 3, 11, 4, 2012, 0);
insert into WORKB_TIME (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values (320, to_date('15-11-2012', 'dd-mm-yyyy'), 15, 4, 11, 4, 2012, 0);
insert into WORKB_TIME (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values (321, to_date('16-11-2012', 'dd-mm-yyyy'), 16, 5, 11, 4, 2012, 0);
insert into WORKB_TIME (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values (322, to_date('17-11-2012', 'dd-mm-yyyy'), 17, 6, 11, 4, 2012, 1);
insert into WORKB_TIME (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values (323, to_date('18-11-2012', 'dd-mm-yyyy'), 18, 7, 11, 4, 2012, 1);
insert into WORKB_TIME (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values (324, to_date('19-11-2012', 'dd-mm-yyyy'), 19, 1, 11, 4, 2012, 0);
insert into WORKB_TIME (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values (325, to_date('20-11-2012', 'dd-mm-yyyy'), 20, 2, 11, 4, 2012, 0);
insert into WORKB_TIME (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values (326, to_date('21-11-2012', 'dd-mm-yyyy'), 21, 3, 11, 4, 2012, 0);
insert into WORKB_TIME (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values (327, to_date('22-11-2012', 'dd-mm-yyyy'), 22, 4, 11, 4, 2012, 0);
insert into WORKB_TIME (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values (328, to_date('23-11-2012', 'dd-mm-yyyy'), 23, 5, 11, 4, 2012, 0);
insert into WORKB_TIME (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values (329, to_date('24-11-2012', 'dd-mm-yyyy'), 24, 6, 11, 4, 2012, 1);
insert into WORKB_TIME (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values (330, to_date('25-11-2012', 'dd-mm-yyyy'), 25, 7, 11, 4, 2012, 1);
insert into WORKB_TIME (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values (331, to_date('26-11-2012', 'dd-mm-yyyy'), 26, 1, 11, 4, 2012, 0);
insert into WORKB_TIME (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values (332, to_date('27-11-2012', 'dd-mm-yyyy'), 27, 2, 11, 4, 2012, 0);
insert into WORKB_TIME (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values (333, to_date('28-11-2012', 'dd-mm-yyyy'), 28, 3, 11, 4, 2012, 0);
insert into WORKB_TIME (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values (334, to_date('29-11-2012', 'dd-mm-yyyy'), 29, 4, 11, 4, 2012, 0);
insert into WORKB_TIME (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values (335, to_date('30-11-2012', 'dd-mm-yyyy'), 30, 5, 11, 4, 2012, 0);
insert into WORKB_TIME (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values (336, to_date('01-12-2012', 'dd-mm-yyyy'), 1, 6, 12, 4, 2012, 1);
insert into WORKB_TIME (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values (337, to_date('02-12-2012', 'dd-mm-yyyy'), 2, 7, 12, 4, 2012, 1);
insert into WORKB_TIME (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values (338, to_date('03-12-2012', 'dd-mm-yyyy'), 3, 1, 12, 4, 2012, 0);
insert into WORKB_TIME (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values (339, to_date('04-12-2012', 'dd-mm-yyyy'), 4, 2, 12, 4, 2012, 0);
insert into WORKB_TIME (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values (340, to_date('05-12-2012', 'dd-mm-yyyy'), 5, 3, 12, 4, 2012, 0);
insert into WORKB_TIME (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values (341, to_date('06-12-2012', 'dd-mm-yyyy'), 6, 4, 12, 4, 2012, 0);
insert into WORKB_TIME (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values (342, to_date('07-12-2012', 'dd-mm-yyyy'), 7, 5, 12, 4, 2012, 0);
insert into WORKB_TIME (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values (343, to_date('08-12-2012', 'dd-mm-yyyy'), 8, 6, 12, 4, 2012, 1);
insert into WORKB_TIME (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values (344, to_date('09-12-2012', 'dd-mm-yyyy'), 9, 7, 12, 4, 2012, 1);
insert into WORKB_TIME (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values (345, to_date('10-12-2012', 'dd-mm-yyyy'), 10, 1, 12, 4, 2012, 0);
insert into WORKB_TIME (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values (346, to_date('11-12-2012', 'dd-mm-yyyy'), 11, 2, 12, 4, 2012, 0);
insert into WORKB_TIME (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values (347, to_date('12-12-2012', 'dd-mm-yyyy'), 12, 3, 12, 4, 2012, 0);
commit;
-- 100 records committed...
insert into WORKB_TIME (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values (348, to_date('13-12-2012', 'dd-mm-yyyy'), 13, 4, 12, 4, 2012, 0);
insert into WORKB_TIME (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values (349, to_date('14-12-2012', 'dd-mm-yyyy'), 14, 5, 12, 4, 2012, 0);
insert into WORKB_TIME (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values (350, to_date('15-12-2012', 'dd-mm-yyyy'), 15, 6, 12, 4, 2012, 1);
insert into WORKB_TIME (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values (351, to_date('16-12-2012', 'dd-mm-yyyy'), 16, 7, 12, 4, 2012, 1);
insert into WORKB_TIME (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values (352, to_date('17-12-2012', 'dd-mm-yyyy'), 17, 1, 12, 4, 2012, 0);
insert into WORKB_TIME (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values (353, to_date('18-12-2012', 'dd-mm-yyyy'), 18, 2, 12, 4, 2012, 0);
insert into WORKB_TIME (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values (354, to_date('19-12-2012', 'dd-mm-yyyy'), 19, 3, 12, 4, 2012, 0);
insert into WORKB_TIME (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values (355, to_date('20-12-2012', 'dd-mm-yyyy'), 20, 4, 12, 4, 2012, 0);
insert into WORKB_TIME (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values (356, to_date('21-12-2012', 'dd-mm-yyyy'), 21, 5, 12, 4, 2012, 0);
insert into WORKB_TIME (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values (367, to_date('01-01-2013', 'dd-mm-yyyy'), 1, 2, 1, 1, 2013, 0);
insert into WORKB_TIME (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values (368, to_date('02-01-2013', 'dd-mm-yyyy'), 2, 3, 1, 1, 2013, 0);
insert into WORKB_TIME (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values (369, to_date('03-01-2013', 'dd-mm-yyyy'), 3, 4, 1, 1, 2013, 0);
insert into WORKB_TIME (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values (370, to_date('04-01-2013', 'dd-mm-yyyy'), 4, 5, 1, 1, 2013, 0);
insert into WORKB_TIME (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values (371, to_date('05-01-2013', 'dd-mm-yyyy'), 5, 6, 1, 1, 2013, 0);
insert into WORKB_TIME (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values (372, to_date('06-01-2013', 'dd-mm-yyyy'), 6, 7, 1, 1, 2013, 0);
insert into WORKB_TIME (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values (373, to_date('07-01-2013', 'dd-mm-yyyy'), 7, 1, 1, 1, 2013, 0);
insert into WORKB_TIME (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values (374, to_date('08-01-2013', 'dd-mm-yyyy'), 8, 2, 1, 1, 2013, 0);
insert into WORKB_TIME (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values (375, to_date('09-01-2013', 'dd-mm-yyyy'), 9, 3, 1, 1, 2013, 0);
insert into WORKB_TIME (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values (376, to_date('10-01-2013', 'dd-mm-yyyy'), 10, 4, 1, 1, 2013, 0);
insert into WORKB_TIME (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values (377, to_date('11-01-2013', 'dd-mm-yyyy'), 11, 5, 1, 1, 2013, 0);
insert into WORKB_TIME (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values (378, to_date('12-01-2013', 'dd-mm-yyyy'), 12, 6, 1, 1, 2013, 0);
insert into WORKB_TIME (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values (379, to_date('13-01-2013', 'dd-mm-yyyy'), 13, 7, 1, 1, 2013, 0);
insert into WORKB_TIME (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values (380, to_date('14-01-2013', 'dd-mm-yyyy'), 14, 1, 1, 1, 2013, 0);
insert into WORKB_TIME (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values (381, to_date('15-01-2013', 'dd-mm-yyyy'), 15, 2, 1, 1, 2013, 0);
insert into WORKB_TIME (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values (382, to_date('16-01-2013', 'dd-mm-yyyy'), 16, 3, 1, 1, 2013, 0);
insert into WORKB_TIME (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values (383, to_date('17-01-2013', 'dd-mm-yyyy'), 17, 4, 1, 1, 2013, 0);
insert into WORKB_TIME (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values (384, to_date('18-01-2013', 'dd-mm-yyyy'), 18, 5, 1, 1, 2013, 0);
insert into WORKB_TIME (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values (385, to_date('19-01-2013', 'dd-mm-yyyy'), 19, 6, 1, 1, 2013, 0);
insert into WORKB_TIME (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values (386, to_date('20-01-2013', 'dd-mm-yyyy'), 20, 7, 1, 1, 2013, 0);
insert into WORKB_TIME (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values (387, to_date('21-01-2013', 'dd-mm-yyyy'), 21, 1, 1, 1, 2013, 0);
insert into WORKB_TIME (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values (388, to_date('22-01-2013', 'dd-mm-yyyy'), 22, 2, 1, 1, 2013, 0);
insert into WORKB_TIME (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values (389, to_date('23-01-2013', 'dd-mm-yyyy'), 23, 3, 1, 1, 2013, 0);
insert into WORKB_TIME (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values (390, to_date('24-01-2013', 'dd-mm-yyyy'), 24, 4, 1, 1, 2013, 0);
insert into WORKB_TIME (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values (391, to_date('25-01-2013', 'dd-mm-yyyy'), 25, 5, 1, 1, 2013, 0);
insert into WORKB_TIME (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values (392, to_date('26-01-2013', 'dd-mm-yyyy'), 26, 6, 1, 1, 2013, 0);
insert into WORKB_TIME (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values (393, to_date('27-01-2013', 'dd-mm-yyyy'), 27, 7, 1, 1, 2013, 0);
insert into WORKB_TIME (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values (394, to_date('28-01-2013', 'dd-mm-yyyy'), 28, 1, 1, 1, 2013, 0);
insert into WORKB_TIME (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values (395, to_date('29-01-2013', 'dd-mm-yyyy'), 29, 2, 1, 1, 2013, 0);
insert into WORKB_TIME (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values (396, to_date('30-01-2013', 'dd-mm-yyyy'), 30, 3, 1, 1, 2013, 0);
insert into WORKB_TIME (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values (397, to_date('31-01-2013', 'dd-mm-yyyy'), 31, 4, 1, 1, 2013, 0);
insert into WORKB_TIME (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values (398, to_date('01-02-2013', 'dd-mm-yyyy'), 1, 5, 2, 1, 2013, 0);
insert into WORKB_TIME (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values (399, to_date('02-02-2013', 'dd-mm-yyyy'), 2, 6, 2, 1, 2013, 0);
insert into WORKB_TIME (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values (400, to_date('03-02-2013', 'dd-mm-yyyy'), 3, 7, 2, 1, 2013, 0);
insert into WORKB_TIME (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values (401, to_date('04-02-2013', 'dd-mm-yyyy'), 4, 1, 2, 1, 2013, 0);
insert into WORKB_TIME (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values (402, to_date('05-02-2013', 'dd-mm-yyyy'), 5, 2, 2, 1, 2013, 0);
insert into WORKB_TIME (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values (403, to_date('06-02-2013', 'dd-mm-yyyy'), 6, 3, 2, 1, 2013, 0);
insert into WORKB_TIME (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values (404, to_date('07-02-2013', 'dd-mm-yyyy'), 7, 4, 2, 1, 2013, 0);
insert into WORKB_TIME (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values (405, to_date('08-02-2013', 'dd-mm-yyyy'), 8, 5, 2, 1, 2013, 0);
insert into WORKB_TIME (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values (406, to_date('09-02-2013', 'dd-mm-yyyy'), 9, 6, 2, 1, 2013, 0);
insert into WORKB_TIME (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values (407, to_date('10-02-2013', 'dd-mm-yyyy'), 10, 7, 2, 1, 2013, 0);
insert into WORKB_TIME (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values (408, to_date('11-02-2013', 'dd-mm-yyyy'), 11, 1, 2, 1, 2013, 0);
insert into WORKB_TIME (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values (409, to_date('12-02-2013', 'dd-mm-yyyy'), 12, 2, 2, 1, 2013, 0);
insert into WORKB_TIME (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values (410, to_date('13-02-2013', 'dd-mm-yyyy'), 13, 3, 2, 1, 2013, 0);
insert into WORKB_TIME (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values (411, to_date('14-02-2013', 'dd-mm-yyyy'), 14, 4, 2, 1, 2013, 0);
insert into WORKB_TIME (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values (412, to_date('15-02-2013', 'dd-mm-yyyy'), 15, 5, 2, 1, 2013, 0);
insert into WORKB_TIME (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values (413, to_date('16-02-2013', 'dd-mm-yyyy'), 16, 6, 2, 1, 2013, 0);
insert into WORKB_TIME (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values (414, to_date('17-02-2013', 'dd-mm-yyyy'), 17, 7, 2, 1, 2013, 0);
insert into WORKB_TIME (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values (415, to_date('18-02-2013', 'dd-mm-yyyy'), 18, 1, 2, 1, 2013, 0);
insert into WORKB_TIME (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values (416, to_date('19-02-2013', 'dd-mm-yyyy'), 19, 2, 2, 1, 2013, 0);
insert into WORKB_TIME (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values (417, to_date('20-02-2013', 'dd-mm-yyyy'), 20, 3, 2, 1, 2013, 0);
insert into WORKB_TIME (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values (418, to_date('21-02-2013', 'dd-mm-yyyy'), 21, 4, 2, 1, 2013, 0);
insert into WORKB_TIME (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values (419, to_date('22-02-2013', 'dd-mm-yyyy'), 22, 5, 2, 1, 2013, 0);
insert into WORKB_TIME (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values (420, to_date('23-02-2013', 'dd-mm-yyyy'), 23, 6, 2, 1, 2013, 1);
insert into WORKB_TIME (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values (421, to_date('24-02-2013', 'dd-mm-yyyy'), 24, 7, 2, 1, 2013, 0);
insert into WORKB_TIME (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values (422, to_date('25-02-2013', 'dd-mm-yyyy'), 25, 1, 2, 1, 2013, 0);
insert into WORKB_TIME (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values (423, to_date('26-02-2013', 'dd-mm-yyyy'), 26, 2, 2, 1, 2013, 0);
insert into WORKB_TIME (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values (424, to_date('27-02-2013', 'dd-mm-yyyy'), 27, 3, 2, 1, 2013, 0);
insert into WORKB_TIME (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values (425, to_date('28-02-2013', 'dd-mm-yyyy'), 28, 4, 2, 1, 2013, 0);
insert into WORKB_TIME (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values (426, to_date('01-03-2013', 'dd-mm-yyyy'), 1, 5, 3, 1, 2013, 0);
insert into WORKB_TIME (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values (427, to_date('02-03-2013', 'dd-mm-yyyy'), 2, 6, 3, 1, 2013, 0);
insert into WORKB_TIME (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values (428, to_date('03-03-2013', 'dd-mm-yyyy'), 3, 7, 3, 1, 2013, 0);
insert into WORKB_TIME (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values (429, to_date('04-03-2013', 'dd-mm-yyyy'), 4, 1, 3, 1, 2013, 0);
insert into WORKB_TIME (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values (430, to_date('05-03-2013', 'dd-mm-yyyy'), 5, 2, 3, 1, 2013, 0);
insert into WORKB_TIME (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values (431, to_date('06-03-2013', 'dd-mm-yyyy'), 6, 3, 3, 1, 2013, 0);
insert into WORKB_TIME (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values (432, to_date('07-03-2013', 'dd-mm-yyyy'), 7, 4, 3, 1, 2013, 0);
insert into WORKB_TIME (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values (433, to_date('08-03-2013', 'dd-mm-yyyy'), 8, 5, 3, 1, 2013, 1);
insert into WORKB_TIME (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values (434, to_date('09-03-2013', 'dd-mm-yyyy'), 9, 6, 3, 1, 2013, 0);
insert into WORKB_TIME (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values (435, to_date('10-03-2013', 'dd-mm-yyyy'), 10, 7, 3, 1, 2013, 0);
insert into WORKB_TIME (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values (436, to_date('11-03-2013', 'dd-mm-yyyy'), 11, 1, 3, 1, 2013, 0);
insert into WORKB_TIME (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values (437, to_date('12-03-2013', 'dd-mm-yyyy'), 12, 2, 3, 1, 2013, 0);
insert into WORKB_TIME (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values (438, to_date('13-03-2013', 'dd-mm-yyyy'), 13, 3, 3, 1, 2013, 0);
insert into WORKB_TIME (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values (439, to_date('14-03-2013', 'dd-mm-yyyy'), 14, 4, 3, 1, 2013, 0);
insert into WORKB_TIME (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values (440, to_date('15-03-2013', 'dd-mm-yyyy'), 15, 5, 3, 1, 2013, 0);
insert into WORKB_TIME (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values (441, to_date('16-03-2013', 'dd-mm-yyyy'), 16, 6, 3, 1, 2013, 0);
insert into WORKB_TIME (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values (442, to_date('17-03-2013', 'dd-mm-yyyy'), 17, 7, 3, 1, 2013, 0);
insert into WORKB_TIME (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values (443, to_date('18-03-2013', 'dd-mm-yyyy'), 18, 1, 3, 1, 2013, 0);
insert into WORKB_TIME (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values (444, to_date('19-03-2013', 'dd-mm-yyyy'), 19, 2, 3, 1, 2013, 0);
insert into WORKB_TIME (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values (445, to_date('20-03-2013', 'dd-mm-yyyy'), 20, 3, 3, 1, 2013, 0);
insert into WORKB_TIME (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values (446, to_date('21-03-2013', 'dd-mm-yyyy'), 21, 4, 3, 1, 2013, 0);
insert into WORKB_TIME (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values (447, to_date('22-03-2013', 'dd-mm-yyyy'), 22, 5, 3, 1, 2013, 0);
insert into WORKB_TIME (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values (448, to_date('23-03-2013', 'dd-mm-yyyy'), 23, 6, 3, 1, 2013, 0);
insert into WORKB_TIME (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values (449, to_date('24-03-2013', 'dd-mm-yyyy'), 24, 7, 3, 1, 2013, 0);
insert into WORKB_TIME (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values (450, to_date('25-03-2013', 'dd-mm-yyyy'), 25, 1, 3, 1, 2013, 0);
insert into WORKB_TIME (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values (451, to_date('26-03-2013', 'dd-mm-yyyy'), 26, 2, 3, 1, 2013, 0);
insert into WORKB_TIME (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values (452, to_date('27-03-2013', 'dd-mm-yyyy'), 27, 3, 3, 1, 2013, 0);
insert into WORKB_TIME (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values (453, to_date('28-03-2013', 'dd-mm-yyyy'), 28, 4, 3, 1, 2013, 0);
insert into WORKB_TIME (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values (454, to_date('29-03-2013', 'dd-mm-yyyy'), 29, 5, 3, 1, 2013, 0);
insert into WORKB_TIME (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values (455, to_date('30-03-2013', 'dd-mm-yyyy'), 30, 6, 3, 1, 2013, 0);
insert into WORKB_TIME (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values (456, to_date('31-03-2013', 'dd-mm-yyyy'), 31, 7, 3, 1, 2013, 0);
insert into WORKB_TIME (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values (457, to_date('01-04-2013', 'dd-mm-yyyy'), 1, 1, 4, 2, 2013, 0);
commit;
-- 200 records committed...
insert into WORKB_TIME (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values (458, to_date('02-04-2013', 'dd-mm-yyyy'), 2, 2, 4, 2, 2013, 0);
insert into WORKB_TIME (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values (459, to_date('03-04-2013', 'dd-mm-yyyy'), 3, 3, 4, 2, 2013, 0);
insert into WORKB_TIME (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values (460, to_date('04-04-2013', 'dd-mm-yyyy'), 4, 4, 4, 2, 2013, 0);
insert into WORKB_TIME (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values (461, to_date('05-04-2013', 'dd-mm-yyyy'), 5, 5, 4, 2, 2013, 0);
insert into WORKB_TIME (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values (462, to_date('06-04-2013', 'dd-mm-yyyy'), 6, 6, 4, 2, 2013, 0);
insert into WORKB_TIME (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values (463, to_date('07-04-2013', 'dd-mm-yyyy'), 7, 7, 4, 2, 2013, 0);
insert into WORKB_TIME (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values (464, to_date('08-04-2013', 'dd-mm-yyyy'), 8, 1, 4, 2, 2013, 0);
insert into WORKB_TIME (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values (465, to_date('09-04-2013', 'dd-mm-yyyy'), 9, 2, 4, 2, 2013, 0);
insert into WORKB_TIME (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values (466, to_date('10-04-2013', 'dd-mm-yyyy'), 10, 3, 4, 2, 2013, 0);
insert into WORKB_TIME (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values (467, to_date('11-04-2013', 'dd-mm-yyyy'), 11, 4, 4, 2, 2013, 0);
insert into WORKB_TIME (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values (468, to_date('12-04-2013', 'dd-mm-yyyy'), 12, 5, 4, 2, 2013, 0);
insert into WORKB_TIME (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values (469, to_date('13-04-2013', 'dd-mm-yyyy'), 13, 6, 4, 2, 2013, 0);
insert into WORKB_TIME (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values (470, to_date('14-04-2013', 'dd-mm-yyyy'), 14, 7, 4, 2, 2013, 0);
insert into WORKB_TIME (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values (471, to_date('15-04-2013', 'dd-mm-yyyy'), 15, 1, 4, 2, 2013, 0);
insert into WORKB_TIME (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values (472, to_date('16-04-2013', 'dd-mm-yyyy'), 16, 2, 4, 2, 2013, 0);
insert into WORKB_TIME (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values (473, to_date('17-04-2013', 'dd-mm-yyyy'), 17, 3, 4, 2, 2013, 0);
insert into WORKB_TIME (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values (474, to_date('18-04-2013', 'dd-mm-yyyy'), 18, 4, 4, 2, 2013, 0);
insert into WORKB_TIME (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values (475, to_date('19-04-2013', 'dd-mm-yyyy'), 19, 5, 4, 2, 2013, 0);
insert into WORKB_TIME (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values (476, to_date('20-04-2013', 'dd-mm-yyyy'), 20, 6, 4, 2, 2013, 0);
insert into WORKB_TIME (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values (477, to_date('21-04-2013', 'dd-mm-yyyy'), 21, 7, 4, 2, 2013, 0);
insert into WORKB_TIME (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values (478, to_date('22-04-2013', 'dd-mm-yyyy'), 22, 1, 4, 2, 2013, 0);
insert into WORKB_TIME (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values (479, to_date('23-04-2013', 'dd-mm-yyyy'), 23, 2, 4, 2, 2013, 0);
insert into WORKB_TIME (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values (480, to_date('24-04-2013', 'dd-mm-yyyy'), 24, 3, 4, 2, 2013, 0);
insert into WORKB_TIME (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values (481, to_date('25-04-2013', 'dd-mm-yyyy'), 25, 4, 4, 2, 2013, 0);
insert into WORKB_TIME (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values (482, to_date('26-04-2013', 'dd-mm-yyyy'), 26, 5, 4, 2, 2013, 0);
insert into WORKB_TIME (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values (483, to_date('27-04-2013', 'dd-mm-yyyy'), 27, 6, 4, 2, 2013, 0);
insert into WORKB_TIME (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values (484, to_date('28-04-2013', 'dd-mm-yyyy'), 28, 7, 4, 2, 2013, 0);
insert into WORKB_TIME (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values (485, to_date('29-04-2013', 'dd-mm-yyyy'), 29, 1, 4, 2, 2013, 0);
insert into WORKB_TIME (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values (486, to_date('30-04-2013', 'dd-mm-yyyy'), 30, 2, 4, 2, 2013, 0);
insert into WORKB_TIME (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values (487, to_date('01-05-2013', 'dd-mm-yyyy'), 1, 3, 5, 2, 2013, 0);
insert into WORKB_TIME (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values (488, to_date('02-05-2013', 'dd-mm-yyyy'), 2, 4, 5, 2, 2013, 0);
insert into WORKB_TIME (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values (489, to_date('03-05-2013', 'dd-mm-yyyy'), 3, 5, 5, 2, 2013, 0);
insert into WORKB_TIME (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values (490, to_date('04-05-2013', 'dd-mm-yyyy'), 4, 6, 5, 2, 2013, 0);
insert into WORKB_TIME (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values (491, to_date('05-05-2013', 'dd-mm-yyyy'), 5, 7, 5, 2, 2013, 0);
insert into WORKB_TIME (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values (492, to_date('06-05-2013', 'dd-mm-yyyy'), 6, 1, 5, 2, 2013, 0);
insert into WORKB_TIME (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values (493, to_date('07-05-2013', 'dd-mm-yyyy'), 7, 2, 5, 2, 2013, 0);
insert into WORKB_TIME (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values (494, to_date('08-05-2013', 'dd-mm-yyyy'), 8, 3, 5, 2, 2013, 0);
insert into WORKB_TIME (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values (495, to_date('09-05-2013', 'dd-mm-yyyy'), 9, 4, 5, 2, 2013, 0);
insert into WORKB_TIME (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values (496, to_date('10-05-2013', 'dd-mm-yyyy'), 10, 5, 5, 2, 2013, 0);
insert into WORKB_TIME (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values (497, to_date('11-05-2013', 'dd-mm-yyyy'), 11, 6, 5, 2, 2013, 0);
insert into WORKB_TIME (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values (498, to_date('12-05-2013', 'dd-mm-yyyy'), 12, 7, 5, 2, 2013, 0);
insert into WORKB_TIME (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values (499, to_date('13-05-2013', 'dd-mm-yyyy'), 13, 1, 5, 2, 2013, 0);
insert into WORKB_TIME (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values (500, to_date('14-05-2013', 'dd-mm-yyyy'), 14, 2, 5, 2, 2013, 0);
insert into WORKB_TIME (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values (501, to_date('15-05-2013', 'dd-mm-yyyy'), 15, 3, 5, 2, 2013, 0);
insert into WORKB_TIME (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values (502, to_date('16-05-2013', 'dd-mm-yyyy'), 16, 4, 5, 2, 2013, 0);
insert into WORKB_TIME (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values (503, to_date('17-05-2013', 'dd-mm-yyyy'), 17, 5, 5, 2, 2013, 0);
insert into WORKB_TIME (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values (504, to_date('18-05-2013', 'dd-mm-yyyy'), 18, 6, 5, 2, 2013, 0);
insert into WORKB_TIME (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values (505, to_date('19-05-2013', 'dd-mm-yyyy'), 19, 7, 5, 2, 2013, 0);
insert into WORKB_TIME (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values (506, to_date('20-05-2013', 'dd-mm-yyyy'), 20, 1, 5, 2, 2013, 0);
insert into WORKB_TIME (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values (507, to_date('21-05-2013', 'dd-mm-yyyy'), 21, 2, 5, 2, 2013, 0);
insert into WORKB_TIME (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values (508, to_date('22-05-2013', 'dd-mm-yyyy'), 22, 3, 5, 2, 2013, 0);
insert into WORKB_TIME (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values (509, to_date('23-05-2013', 'dd-mm-yyyy'), 23, 4, 5, 2, 2013, 0);
insert into WORKB_TIME (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values (510, to_date('24-05-2013', 'dd-mm-yyyy'), 24, 5, 5, 2, 2013, 0);
insert into WORKB_TIME (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values (511, to_date('25-05-2013', 'dd-mm-yyyy'), 25, 6, 5, 2, 2013, 0);
insert into WORKB_TIME (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values (512, to_date('26-05-2013', 'dd-mm-yyyy'), 26, 7, 5, 2, 2013, 0);
insert into WORKB_TIME (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values (513, to_date('27-05-2013', 'dd-mm-yyyy'), 27, 1, 5, 2, 2013, 0);
insert into WORKB_TIME (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values (514, to_date('28-05-2013', 'dd-mm-yyyy'), 28, 2, 5, 2, 2013, 0);
insert into WORKB_TIME (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values (515, to_date('29-05-2013', 'dd-mm-yyyy'), 29, 3, 5, 2, 2013, 0);
insert into WORKB_TIME (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values (516, to_date('30-05-2013', 'dd-mm-yyyy'), 30, 4, 5, 2, 2013, 0);
insert into WORKB_TIME (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values (517, to_date('31-05-2013', 'dd-mm-yyyy'), 31, 5, 5, 2, 2013, 0);
insert into WORKB_TIME (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values (518, to_date('01-06-2013', 'dd-mm-yyyy'), 1, 6, 6, 2, 2013, 0);
insert into WORKB_TIME (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values (519, to_date('02-06-2013', 'dd-mm-yyyy'), 2, 7, 6, 2, 2013, 0);
insert into WORKB_TIME (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values (520, to_date('03-06-2013', 'dd-mm-yyyy'), 3, 1, 6, 2, 2013, 0);
insert into WORKB_TIME (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values (521, to_date('04-06-2013', 'dd-mm-yyyy'), 4, 2, 6, 2, 2013, 0);
insert into WORKB_TIME (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values (522, to_date('05-06-2013', 'dd-mm-yyyy'), 5, 3, 6, 2, 2013, 0);
insert into WORKB_TIME (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values (523, to_date('06-06-2013', 'dd-mm-yyyy'), 6, 4, 6, 2, 2013, 0);
insert into WORKB_TIME (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values (524, to_date('07-06-2013', 'dd-mm-yyyy'), 7, 5, 6, 2, 2013, 0);
insert into WORKB_TIME (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values (525, to_date('08-06-2013', 'dd-mm-yyyy'), 8, 6, 6, 2, 2013, 0);
insert into WORKB_TIME (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values (526, to_date('09-06-2013', 'dd-mm-yyyy'), 9, 7, 6, 2, 2013, 0);
insert into WORKB_TIME (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values (527, to_date('10-06-2013', 'dd-mm-yyyy'), 10, 1, 6, 2, 2013, 0);
insert into WORKB_TIME (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values (528, to_date('11-06-2013', 'dd-mm-yyyy'), 11, 2, 6, 2, 2013, 0);
insert into WORKB_TIME (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values (529, to_date('12-06-2013', 'dd-mm-yyyy'), 12, 3, 6, 2, 2013, 0);
insert into WORKB_TIME (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values (530, to_date('13-06-2013', 'dd-mm-yyyy'), 13, 4, 6, 2, 2013, 0);
insert into WORKB_TIME (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values (531, to_date('14-06-2013', 'dd-mm-yyyy'), 14, 5, 6, 2, 2013, 0);
insert into WORKB_TIME (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values (532, to_date('15-06-2013', 'dd-mm-yyyy'), 15, 6, 6, 2, 2013, 0);
insert into WORKB_TIME (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values (533, to_date('16-06-2013', 'dd-mm-yyyy'), 16, 7, 6, 2, 2013, 0);
insert into WORKB_TIME (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values (534, to_date('17-06-2013', 'dd-mm-yyyy'), 17, 1, 6, 2, 2013, 0);
insert into WORKB_TIME (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values (535, to_date('18-06-2013', 'dd-mm-yyyy'), 18, 2, 6, 2, 2013, 0);
insert into WORKB_TIME (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values (536, to_date('19-06-2013', 'dd-mm-yyyy'), 19, 3, 6, 2, 2013, 0);
insert into WORKB_TIME (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values (537, to_date('20-06-2013', 'dd-mm-yyyy'), 20, 4, 6, 2, 2013, 0);
insert into WORKB_TIME (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values (538, to_date('21-06-2013', 'dd-mm-yyyy'), 21, 5, 6, 2, 2013, 0);
insert into WORKB_TIME (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values (539, to_date('22-06-2013', 'dd-mm-yyyy'), 22, 6, 6, 2, 2013, 0);
insert into WORKB_TIME (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values (540, to_date('23-06-2013', 'dd-mm-yyyy'), 23, 7, 6, 2, 2013, 0);
insert into WORKB_TIME (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values (541, to_date('24-06-2013', 'dd-mm-yyyy'), 24, 1, 6, 2, 2013, 0);
insert into WORKB_TIME (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values (542, to_date('25-06-2013', 'dd-mm-yyyy'), 25, 2, 6, 2, 2013, 0);
insert into WORKB_TIME (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values (543, to_date('26-06-2013', 'dd-mm-yyyy'), 26, 3, 6, 2, 2013, 0);
insert into WORKB_TIME (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values (544, to_date('27-06-2013', 'dd-mm-yyyy'), 27, 4, 6, 2, 2013, 0);
insert into WORKB_TIME (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values (545, to_date('28-06-2013', 'dd-mm-yyyy'), 28, 5, 6, 2, 2013, 0);
insert into WORKB_TIME (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values (546, to_date('29-06-2013', 'dd-mm-yyyy'), 29, 6, 6, 2, 2013, 0);
insert into WORKB_TIME (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values (547, to_date('30-06-2013', 'dd-mm-yyyy'), 30, 7, 6, 2, 2013, 0);
insert into WORKB_TIME (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values (548, to_date('01-07-2013', 'dd-mm-yyyy'), 1, 1, 7, 3, 2013, 0);
insert into WORKB_TIME (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values (549, to_date('02-07-2013', 'dd-mm-yyyy'), 2, 2, 7, 3, 2013, 0);
insert into WORKB_TIME (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values (550, to_date('03-07-2013', 'dd-mm-yyyy'), 3, 3, 7, 3, 2013, 0);
insert into WORKB_TIME (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values (551, to_date('04-07-2013', 'dd-mm-yyyy'), 4, 4, 7, 3, 2013, 0);
insert into WORKB_TIME (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values (552, to_date('05-07-2013', 'dd-mm-yyyy'), 5, 5, 7, 3, 2013, 0);
insert into WORKB_TIME (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values (553, to_date('06-07-2013', 'dd-mm-yyyy'), 6, 6, 7, 3, 2013, 0);
insert into WORKB_TIME (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values (554, to_date('07-07-2013', 'dd-mm-yyyy'), 7, 7, 7, 3, 2013, 0);
insert into WORKB_TIME (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values (555, to_date('08-07-2013', 'dd-mm-yyyy'), 8, 1, 7, 3, 2013, 0);
insert into WORKB_TIME (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values (556, to_date('09-07-2013', 'dd-mm-yyyy'), 9, 2, 7, 3, 2013, 0);
insert into WORKB_TIME (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values (557, to_date('10-07-2013', 'dd-mm-yyyy'), 10, 3, 7, 3, 2013, 0);
commit;
-- 300 records committed...
insert into WORKB_TIME (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values (558, to_date('11-07-2013', 'dd-mm-yyyy'), 11, 4, 7, 3, 2013, 0);
insert into WORKB_TIME (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values (559, to_date('12-07-2013', 'dd-mm-yyyy'), 12, 5, 7, 3, 2013, 0);
insert into WORKB_TIME (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values (560, to_date('13-07-2013', 'dd-mm-yyyy'), 13, 6, 7, 3, 2013, 0);
insert into WORKB_TIME (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values (561, to_date('14-07-2013', 'dd-mm-yyyy'), 14, 7, 7, 3, 2013, 0);
insert into WORKB_TIME (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values (562, to_date('15-07-2013', 'dd-mm-yyyy'), 15, 1, 7, 3, 2013, 0);
insert into WORKB_TIME (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values (563, to_date('16-07-2013', 'dd-mm-yyyy'), 16, 2, 7, 3, 2013, 0);
insert into WORKB_TIME (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values (564, to_date('17-07-2013', 'dd-mm-yyyy'), 17, 3, 7, 3, 2013, 0);
insert into WORKB_TIME (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values (565, to_date('18-07-2013', 'dd-mm-yyyy'), 18, 4, 7, 3, 2013, 0);
insert into WORKB_TIME (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values (566, to_date('19-07-2013', 'dd-mm-yyyy'), 19, 5, 7, 3, 2013, 0);
insert into WORKB_TIME (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values (567, to_date('20-07-2013', 'dd-mm-yyyy'), 20, 6, 7, 3, 2013, 0);
insert into WORKB_TIME (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values (568, to_date('21-07-2013', 'dd-mm-yyyy'), 21, 7, 7, 3, 2013, 0);
insert into WORKB_TIME (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values (569, to_date('22-07-2013', 'dd-mm-yyyy'), 22, 1, 7, 3, 2013, 0);
insert into WORKB_TIME (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values (570, to_date('23-07-2013', 'dd-mm-yyyy'), 23, 2, 7, 3, 2013, 0);
insert into WORKB_TIME (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values (571, to_date('24-07-2013', 'dd-mm-yyyy'), 24, 3, 7, 3, 2013, 0);
insert into WORKB_TIME (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values (572, to_date('25-07-2013', 'dd-mm-yyyy'), 25, 4, 7, 3, 2013, 0);
insert into WORKB_TIME (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values (573, to_date('26-07-2013', 'dd-mm-yyyy'), 26, 5, 7, 3, 2013, 0);
insert into WORKB_TIME (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values (574, to_date('27-07-2013', 'dd-mm-yyyy'), 27, 6, 7, 3, 2013, 0);
insert into WORKB_TIME (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values (575, to_date('28-07-2013', 'dd-mm-yyyy'), 28, 7, 7, 3, 2013, 0);
insert into WORKB_TIME (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values (576, to_date('29-07-2013', 'dd-mm-yyyy'), 29, 1, 7, 3, 2013, 0);
insert into WORKB_TIME (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values (577, to_date('30-07-2013', 'dd-mm-yyyy'), 30, 2, 7, 3, 2013, 0);
insert into WORKB_TIME (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values (578, to_date('31-07-2013', 'dd-mm-yyyy'), 31, 3, 7, 3, 2013, 0);
insert into WORKB_TIME (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values (579, to_date('01-08-2013', 'dd-mm-yyyy'), 1, 4, 8, 3, 2013, 0);
insert into WORKB_TIME (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values (580, to_date('02-08-2013', 'dd-mm-yyyy'), 2, 5, 8, 3, 2013, 0);
insert into WORKB_TIME (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values (581, to_date('03-08-2013', 'dd-mm-yyyy'), 3, 6, 8, 3, 2013, 0);
insert into WORKB_TIME (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values (582, to_date('04-08-2013', 'dd-mm-yyyy'), 4, 7, 8, 3, 2013, 0);
insert into WORKB_TIME (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values (583, to_date('05-08-2013', 'dd-mm-yyyy'), 5, 1, 8, 3, 2013, 0);
insert into WORKB_TIME (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values (584, to_date('06-08-2013', 'dd-mm-yyyy'), 6, 2, 8, 3, 2013, 0);
insert into WORKB_TIME (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values (585, to_date('07-08-2013', 'dd-mm-yyyy'), 7, 3, 8, 3, 2013, 0);
insert into WORKB_TIME (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values (586, to_date('08-08-2013', 'dd-mm-yyyy'), 8, 4, 8, 3, 2013, 0);
insert into WORKB_TIME (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values (587, to_date('09-08-2013', 'dd-mm-yyyy'), 9, 5, 8, 3, 2013, 0);
insert into WORKB_TIME (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values (588, to_date('10-08-2013', 'dd-mm-yyyy'), 10, 6, 8, 3, 2013, 0);
insert into WORKB_TIME (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values (589, to_date('11-08-2013', 'dd-mm-yyyy'), 11, 7, 8, 3, 2013, 0);
insert into WORKB_TIME (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values (590, to_date('12-08-2013', 'dd-mm-yyyy'), 12, 1, 8, 3, 2013, 0);
insert into WORKB_TIME (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values (591, to_date('13-08-2013', 'dd-mm-yyyy'), 13, 2, 8, 3, 2013, 0);
insert into WORKB_TIME (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values (592, to_date('14-08-2013', 'dd-mm-yyyy'), 14, 3, 8, 3, 2013, 0);
insert into WORKB_TIME (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values (593, to_date('15-08-2013', 'dd-mm-yyyy'), 15, 4, 8, 3, 2013, 0);
insert into WORKB_TIME (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values (594, to_date('16-08-2013', 'dd-mm-yyyy'), 16, 5, 8, 3, 2013, 0);
insert into WORKB_TIME (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values (595, to_date('17-08-2013', 'dd-mm-yyyy'), 17, 6, 8, 3, 2013, 0);
insert into WORKB_TIME (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values (596, to_date('18-08-2013', 'dd-mm-yyyy'), 18, 7, 8, 3, 2013, 0);
insert into WORKB_TIME (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values (597, to_date('19-08-2013', 'dd-mm-yyyy'), 19, 1, 8, 3, 2013, 0);
insert into WORKB_TIME (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values (598, to_date('20-08-2013', 'dd-mm-yyyy'), 20, 2, 8, 3, 2013, 0);
insert into WORKB_TIME (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values (599, to_date('21-08-2013', 'dd-mm-yyyy'), 21, 3, 8, 3, 2013, 0);
insert into WORKB_TIME (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values (600, to_date('22-08-2013', 'dd-mm-yyyy'), 22, 4, 8, 3, 2013, 0);
insert into WORKB_TIME (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values (601, to_date('23-08-2013', 'dd-mm-yyyy'), 23, 5, 8, 3, 2013, 0);
insert into WORKB_TIME (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values (602, to_date('24-08-2013', 'dd-mm-yyyy'), 24, 6, 8, 3, 2013, 0);
insert into WORKB_TIME (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values (603, to_date('25-08-2013', 'dd-mm-yyyy'), 25, 7, 8, 3, 2013, 0);
insert into WORKB_TIME (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values (604, to_date('26-08-2013', 'dd-mm-yyyy'), 26, 1, 8, 3, 2013, 0);
insert into WORKB_TIME (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values (605, to_date('27-08-2013', 'dd-mm-yyyy'), 27, 2, 8, 3, 2013, 0);
insert into WORKB_TIME (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values (606, to_date('28-08-2013', 'dd-mm-yyyy'), 28, 3, 8, 3, 2013, 0);
insert into WORKB_TIME (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values (607, to_date('29-08-2013', 'dd-mm-yyyy'), 29, 4, 8, 3, 2013, 0);
insert into WORKB_TIME (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values (608, to_date('30-08-2013', 'dd-mm-yyyy'), 30, 5, 8, 3, 2013, 0);
insert into WORKB_TIME (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values (609, to_date('31-08-2013', 'dd-mm-yyyy'), 31, 6, 8, 3, 2013, 0);
insert into WORKB_TIME (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values (610, to_date('01-09-2013', 'dd-mm-yyyy'), 1, 7, 9, 3, 2013, 0);
insert into WORKB_TIME (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values (611, to_date('02-09-2013', 'dd-mm-yyyy'), 2, 1, 9, 3, 2013, 0);
insert into WORKB_TIME (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values (612, to_date('03-09-2013', 'dd-mm-yyyy'), 3, 2, 9, 3, 2013, 0);
insert into WORKB_TIME (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values (613, to_date('04-09-2013', 'dd-mm-yyyy'), 4, 3, 9, 3, 2013, 0);
insert into WORKB_TIME (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values (614, to_date('05-09-2013', 'dd-mm-yyyy'), 5, 4, 9, 3, 2013, 0);
insert into WORKB_TIME (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values (615, to_date('06-09-2013', 'dd-mm-yyyy'), 6, 5, 9, 3, 2013, 0);
insert into WORKB_TIME (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values (616, to_date('07-09-2013', 'dd-mm-yyyy'), 7, 6, 9, 3, 2013, 0);
insert into WORKB_TIME (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values (617, to_date('08-09-2013', 'dd-mm-yyyy'), 8, 7, 9, 3, 2013, 0);
insert into WORKB_TIME (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values (618, to_date('09-09-2013', 'dd-mm-yyyy'), 9, 1, 9, 3, 2013, 0);
insert into WORKB_TIME (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values (619, to_date('10-09-2013', 'dd-mm-yyyy'), 10, 2, 9, 3, 2013, 0);
insert into WORKB_TIME (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values (620, to_date('11-09-2013', 'dd-mm-yyyy'), 11, 3, 9, 3, 2013, 0);
insert into WORKB_TIME (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values (621, to_date('12-09-2013', 'dd-mm-yyyy'), 12, 4, 9, 3, 2013, 0);
insert into WORKB_TIME (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values (622, to_date('13-09-2013', 'dd-mm-yyyy'), 13, 5, 9, 3, 2013, 0);
insert into WORKB_TIME (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values (623, to_date('14-09-2013', 'dd-mm-yyyy'), 14, 6, 9, 3, 2013, 0);
insert into WORKB_TIME (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values (624, to_date('15-09-2013', 'dd-mm-yyyy'), 15, 7, 9, 3, 2013, 0);
insert into WORKB_TIME (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values (625, to_date('16-09-2013', 'dd-mm-yyyy'), 16, 1, 9, 3, 2013, 0);
insert into WORKB_TIME (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values (626, to_date('17-09-2013', 'dd-mm-yyyy'), 17, 2, 9, 3, 2013, 0);
insert into WORKB_TIME (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values (627, to_date('18-09-2013', 'dd-mm-yyyy'), 18, 3, 9, 3, 2013, 0);
insert into WORKB_TIME (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values (628, to_date('19-09-2013', 'dd-mm-yyyy'), 19, 4, 9, 3, 2013, 0);
insert into WORKB_TIME (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values (629, to_date('20-09-2013', 'dd-mm-yyyy'), 20, 5, 9, 3, 2013, 0);
insert into WORKB_TIME (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values (630, to_date('21-09-2013', 'dd-mm-yyyy'), 21, 6, 9, 3, 2013, 0);
insert into WORKB_TIME (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values (631, to_date('22-09-2013', 'dd-mm-yyyy'), 22, 7, 9, 3, 2013, 0);
insert into WORKB_TIME (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values (632, to_date('23-09-2013', 'dd-mm-yyyy'), 23, 1, 9, 3, 2013, 0);
insert into WORKB_TIME (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values (633, to_date('24-09-2013', 'dd-mm-yyyy'), 24, 2, 9, 3, 2013, 0);
insert into WORKB_TIME (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values (634, to_date('25-09-2013', 'dd-mm-yyyy'), 25, 3, 9, 3, 2013, 0);
insert into WORKB_TIME (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values (635, to_date('26-09-2013', 'dd-mm-yyyy'), 26, 4, 9, 3, 2013, 0);
insert into WORKB_TIME (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values (636, to_date('27-09-2013', 'dd-mm-yyyy'), 27, 5, 9, 3, 2013, 0);
insert into WORKB_TIME (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values (637, to_date('28-09-2013', 'dd-mm-yyyy'), 28, 6, 9, 3, 2013, 0);
insert into WORKB_TIME (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values (638, to_date('29-09-2013', 'dd-mm-yyyy'), 29, 7, 9, 3, 2013, 0);
insert into WORKB_TIME (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values (639, to_date('30-09-2013', 'dd-mm-yyyy'), 30, 1, 9, 3, 2013, 0);
insert into WORKB_TIME (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values (640, to_date('01-10-2013', 'dd-mm-yyyy'), 1, 2, 10, 4, 2013, 0);
insert into WORKB_TIME (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values (641, to_date('02-10-2013', 'dd-mm-yyyy'), 2, 3, 10, 4, 2013, 0);
insert into WORKB_TIME (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values (642, to_date('03-10-2013', 'dd-mm-yyyy'), 3, 4, 10, 4, 2013, 0);
insert into WORKB_TIME (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values (643, to_date('04-10-2013', 'dd-mm-yyyy'), 4, 5, 10, 4, 2013, 0);
insert into WORKB_TIME (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values (644, to_date('05-10-2013', 'dd-mm-yyyy'), 5, 6, 10, 4, 2013, 0);
insert into WORKB_TIME (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values (645, to_date('06-10-2013', 'dd-mm-yyyy'), 6, 7, 10, 4, 2013, 0);
insert into WORKB_TIME (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values (646, to_date('07-10-2013', 'dd-mm-yyyy'), 7, 1, 10, 4, 2013, 0);
insert into WORKB_TIME (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values (647, to_date('08-10-2013', 'dd-mm-yyyy'), 8, 2, 10, 4, 2013, 0);
insert into WORKB_TIME (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values (648, to_date('09-10-2013', 'dd-mm-yyyy'), 9, 3, 10, 4, 2013, 0);
insert into WORKB_TIME (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values (649, to_date('10-10-2013', 'dd-mm-yyyy'), 10, 4, 10, 4, 2013, 0);
insert into WORKB_TIME (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values (650, to_date('11-10-2013', 'dd-mm-yyyy'), 11, 5, 10, 4, 2013, 0);
insert into WORKB_TIME (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values (651, to_date('12-10-2013', 'dd-mm-yyyy'), 12, 6, 10, 4, 2013, 0);
insert into WORKB_TIME (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values (652, to_date('13-10-2013', 'dd-mm-yyyy'), 13, 7, 10, 4, 2013, 0);
insert into WORKB_TIME (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values (653, to_date('14-10-2013', 'dd-mm-yyyy'), 14, 1, 10, 4, 2013, 0);
insert into WORKB_TIME (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values (654, to_date('15-10-2013', 'dd-mm-yyyy'), 15, 2, 10, 4, 2013, 0);
insert into WORKB_TIME (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values (655, to_date('16-10-2013', 'dd-mm-yyyy'), 16, 3, 10, 4, 2013, 0);
insert into WORKB_TIME (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values (656, to_date('17-10-2013', 'dd-mm-yyyy'), 17, 4, 10, 4, 2013, 0);
insert into WORKB_TIME (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values (657, to_date('18-10-2013', 'dd-mm-yyyy'), 18, 5, 10, 4, 2013, 0);
commit;
-- 400 records committed...
insert into WORKB_TIME (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values (658, to_date('19-10-2013', 'dd-mm-yyyy'), 19, 6, 10, 4, 2013, 0);
insert into WORKB_TIME (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values (659, to_date('20-10-2013', 'dd-mm-yyyy'), 20, 7, 10, 4, 2013, 0);
insert into WORKB_TIME (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values (660, to_date('21-10-2013', 'dd-mm-yyyy'), 21, 1, 10, 4, 2013, 0);
insert into WORKB_TIME (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values (661, to_date('22-10-2013', 'dd-mm-yyyy'), 22, 2, 10, 4, 2013, 0);
insert into WORKB_TIME (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values (662, to_date('23-10-2013', 'dd-mm-yyyy'), 23, 3, 10, 4, 2013, 0);
insert into WORKB_TIME (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values (663, to_date('24-10-2013', 'dd-mm-yyyy'), 24, 4, 10, 4, 2013, 0);
insert into WORKB_TIME (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values (664, to_date('25-10-2013', 'dd-mm-yyyy'), 25, 5, 10, 4, 2013, 0);
insert into WORKB_TIME (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values (665, to_date('26-10-2013', 'dd-mm-yyyy'), 26, 6, 10, 4, 2013, 0);
insert into WORKB_TIME (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values (666, to_date('27-10-2013', 'dd-mm-yyyy'), 27, 7, 10, 4, 2013, 0);
insert into WORKB_TIME (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values (667, to_date('28-10-2013', 'dd-mm-yyyy'), 28, 1, 10, 4, 2013, 0);
insert into WORKB_TIME (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values (668, to_date('29-10-2013', 'dd-mm-yyyy'), 29, 2, 10, 4, 2013, 0);
insert into WORKB_TIME (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values (669, to_date('30-10-2013', 'dd-mm-yyyy'), 30, 3, 10, 4, 2013, 0);
insert into WORKB_TIME (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values (670, to_date('31-10-2013', 'dd-mm-yyyy'), 31, 4, 10, 4, 2013, 0);
insert into WORKB_TIME (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values (671, to_date('01-11-2013', 'dd-mm-yyyy'), 1, 5, 11, 4, 2013, 0);
insert into WORKB_TIME (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values (672, to_date('02-11-2013', 'dd-mm-yyyy'), 2, 6, 11, 4, 2013, 0);
insert into WORKB_TIME (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values (673, to_date('03-11-2013', 'dd-mm-yyyy'), 3, 7, 11, 4, 2013, 0);
insert into WORKB_TIME (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values (674, to_date('04-11-2013', 'dd-mm-yyyy'), 4, 1, 11, 4, 2013, 0);
insert into WORKB_TIME (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values (675, to_date('05-11-2013', 'dd-mm-yyyy'), 5, 2, 11, 4, 2013, 0);
insert into WORKB_TIME (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values (676, to_date('06-11-2013', 'dd-mm-yyyy'), 6, 3, 11, 4, 2013, 0);
insert into WORKB_TIME (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values (677, to_date('07-11-2013', 'dd-mm-yyyy'), 7, 4, 11, 4, 2013, 0);
insert into WORKB_TIME (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values (678, to_date('08-11-2013', 'dd-mm-yyyy'), 8, 5, 11, 4, 2013, 0);
insert into WORKB_TIME (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values (679, to_date('09-11-2013', 'dd-mm-yyyy'), 9, 6, 11, 4, 2013, 0);
insert into WORKB_TIME (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values (680, to_date('10-11-2013', 'dd-mm-yyyy'), 10, 7, 11, 4, 2013, 0);
insert into WORKB_TIME (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values (681, to_date('11-11-2013', 'dd-mm-yyyy'), 11, 1, 11, 4, 2013, 0);
insert into WORKB_TIME (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values (682, to_date('12-11-2013', 'dd-mm-yyyy'), 12, 2, 11, 4, 2013, 0);
insert into WORKB_TIME (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values (683, to_date('13-11-2013', 'dd-mm-yyyy'), 13, 3, 11, 4, 2013, 0);
insert into WORKB_TIME (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values (684, to_date('14-11-2013', 'dd-mm-yyyy'), 14, 4, 11, 4, 2013, 0);
insert into WORKB_TIME (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values (685, to_date('15-11-2013', 'dd-mm-yyyy'), 15, 5, 11, 4, 2013, 0);
insert into WORKB_TIME (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values (686, to_date('16-11-2013', 'dd-mm-yyyy'), 16, 6, 11, 4, 2013, 0);
insert into WORKB_TIME (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values (687, to_date('17-11-2013', 'dd-mm-yyyy'), 17, 7, 11, 4, 2013, 0);
insert into WORKB_TIME (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values (688, to_date('18-11-2013', 'dd-mm-yyyy'), 18, 1, 11, 4, 2013, 0);
insert into WORKB_TIME (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values (689, to_date('19-11-2013', 'dd-mm-yyyy'), 19, 2, 11, 4, 2013, 0);
insert into WORKB_TIME (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values (690, to_date('20-11-2013', 'dd-mm-yyyy'), 20, 3, 11, 4, 2013, 0);
insert into WORKB_TIME (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values (691, to_date('21-11-2013', 'dd-mm-yyyy'), 21, 4, 11, 4, 2013, 0);
insert into WORKB_TIME (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values (692, to_date('22-11-2013', 'dd-mm-yyyy'), 22, 5, 11, 4, 2013, 0);
insert into WORKB_TIME (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values (693, to_date('23-11-2013', 'dd-mm-yyyy'), 23, 6, 11, 4, 2013, 0);
insert into WORKB_TIME (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values (694, to_date('24-11-2013', 'dd-mm-yyyy'), 24, 7, 11, 4, 2013, 0);
insert into WORKB_TIME (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values (695, to_date('25-11-2013', 'dd-mm-yyyy'), 25, 1, 11, 4, 2013, 0);
insert into WORKB_TIME (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values (696, to_date('26-11-2013', 'dd-mm-yyyy'), 26, 2, 11, 4, 2013, 0);
insert into WORKB_TIME (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values (697, to_date('27-11-2013', 'dd-mm-yyyy'), 27, 3, 11, 4, 2013, 0);
insert into WORKB_TIME (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values (698, to_date('28-11-2013', 'dd-mm-yyyy'), 28, 4, 11, 4, 2013, 0);
insert into WORKB_TIME (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values (699, to_date('29-11-2013', 'dd-mm-yyyy'), 29, 5, 11, 4, 2013, 0);
insert into WORKB_TIME (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values (700, to_date('30-11-2013', 'dd-mm-yyyy'), 30, 6, 11, 4, 2013, 0);
insert into WORKB_TIME (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values (701, to_date('01-12-2013', 'dd-mm-yyyy'), 1, 7, 12, 4, 2013, 0);
insert into WORKB_TIME (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values (702, to_date('02-12-2013', 'dd-mm-yyyy'), 2, 1, 12, 4, 2013, 0);
insert into WORKB_TIME (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values (703, to_date('03-12-2013', 'dd-mm-yyyy'), 3, 2, 12, 4, 2013, 0);
insert into WORKB_TIME (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values (704, to_date('04-12-2013', 'dd-mm-yyyy'), 4, 3, 12, 4, 2013, 0);
insert into WORKB_TIME (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values (705, to_date('05-12-2013', 'dd-mm-yyyy'), 5, 4, 12, 4, 2013, 0);
insert into WORKB_TIME (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values (706, to_date('06-12-2013', 'dd-mm-yyyy'), 6, 5, 12, 4, 2013, 0);
insert into WORKB_TIME (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values (707, to_date('07-12-2013', 'dd-mm-yyyy'), 7, 6, 12, 4, 2013, 0);
insert into WORKB_TIME (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values (708, to_date('08-12-2013', 'dd-mm-yyyy'), 8, 7, 12, 4, 2013, 0);
insert into WORKB_TIME (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values (709, to_date('09-12-2013', 'dd-mm-yyyy'), 9, 1, 12, 4, 2013, 0);
insert into WORKB_TIME (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values (710, to_date('10-12-2013', 'dd-mm-yyyy'), 10, 2, 12, 4, 2013, 0);
insert into WORKB_TIME (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values (711, to_date('11-12-2013', 'dd-mm-yyyy'), 11, 3, 12, 4, 2013, 0);
insert into WORKB_TIME (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values (712, to_date('12-12-2013', 'dd-mm-yyyy'), 12, 4, 12, 4, 2013, 0);
insert into WORKB_TIME (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values (713, to_date('13-12-2013', 'dd-mm-yyyy'), 13, 5, 12, 4, 2013, 0);
insert into WORKB_TIME (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values (714, to_date('14-12-2013', 'dd-mm-yyyy'), 14, 6, 12, 4, 2013, 0);
insert into WORKB_TIME (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values (715, to_date('15-12-2013', 'dd-mm-yyyy'), 15, 7, 12, 4, 2013, 0);
insert into WORKB_TIME (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values (716, to_date('16-12-2013', 'dd-mm-yyyy'), 16, 1, 12, 4, 2013, 0);
insert into WORKB_TIME (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values (717, to_date('17-12-2013', 'dd-mm-yyyy'), 17, 2, 12, 4, 2013, 0);
insert into WORKB_TIME (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values (718, to_date('18-12-2013', 'dd-mm-yyyy'), 18, 3, 12, 4, 2013, 0);
insert into WORKB_TIME (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values (719, to_date('19-12-2013', 'dd-mm-yyyy'), 19, 4, 12, 4, 2013, 0);
insert into WORKB_TIME (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values (720, to_date('20-12-2013', 'dd-mm-yyyy'), 20, 5, 12, 4, 2013, 0);
insert into WORKB_TIME (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values (721, to_date('21-12-2013', 'dd-mm-yyyy'), 21, 6, 12, 4, 2013, 0);
insert into WORKB_TIME (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values (722, to_date('22-12-2013', 'dd-mm-yyyy'), 22, 7, 12, 4, 2013, 0);
insert into WORKB_TIME (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values (723, to_date('23-12-2013', 'dd-mm-yyyy'), 23, 1, 12, 4, 2013, 0);
insert into WORKB_TIME (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values (724, to_date('24-12-2013', 'dd-mm-yyyy'), 24, 2, 12, 4, 2013, 0);
insert into WORKB_TIME (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values (725, to_date('25-12-2013', 'dd-mm-yyyy'), 25, 3, 12, 4, 2013, 0);
insert into WORKB_TIME (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values (726, to_date('26-12-2013', 'dd-mm-yyyy'), 26, 4, 12, 4, 2013, 0);
insert into WORKB_TIME (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values (727, to_date('27-12-2013', 'dd-mm-yyyy'), 27, 5, 12, 4, 2013, 0);
insert into WORKB_TIME (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values (728, to_date('28-12-2013', 'dd-mm-yyyy'), 28, 6, 12, 4, 2013, 0);
insert into WORKB_TIME (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values (729, to_date('29-12-2013', 'dd-mm-yyyy'), 29, 7, 12, 4, 2013, 0);
insert into WORKB_TIME (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values (730, to_date('30-12-2013', 'dd-mm-yyyy'), 30, 1, 12, 4, 2013, 0);
insert into WORKB_TIME (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values (731, to_date('31-12-2013', 'dd-mm-yyyy'), 31, 2, 12, 4, 2013, 0);
insert into WORKB_TIME (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values (39, to_date('08-02-2012', 'dd-mm-yyyy'), 8, 3, 2, 1, 2012, 0);
insert into WORKB_TIME (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values (40, to_date('09-02-2012', 'dd-mm-yyyy'), 9, 4, 2, 1, 2012, 0);
insert into WORKB_TIME (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values (41, to_date('10-02-2012', 'dd-mm-yyyy'), 10, 5, 2, 1, 2012, 0);
insert into WORKB_TIME (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values (42, to_date('11-02-2012', 'dd-mm-yyyy'), 11, 6, 2, 1, 2012, 1);
insert into WORKB_TIME (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values (43, to_date('12-02-2012', 'dd-mm-yyyy'), 12, 7, 2, 1, 2012, 1);
insert into WORKB_TIME (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values (44, to_date('13-02-2012', 'dd-mm-yyyy'), 13, 1, 2, 1, 2012, 0);
insert into WORKB_TIME (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values (45, to_date('14-02-2012', 'dd-mm-yyyy'), 14, 2, 2, 1, 2012, 0);
insert into WORKB_TIME (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values (46, to_date('15-02-2012', 'dd-mm-yyyy'), 15, 3, 2, 1, 2012, 0);
insert into WORKB_TIME (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values (47, to_date('16-02-2012', 'dd-mm-yyyy'), 16, 4, 2, 1, 2012, 0);
insert into WORKB_TIME (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values (48, to_date('17-02-2012', 'dd-mm-yyyy'), 17, 5, 2, 1, 2012, 0);
insert into WORKB_TIME (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values (49, to_date('18-02-2012', 'dd-mm-yyyy'), 18, 6, 2, 1, 2012, 1);
insert into WORKB_TIME (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values (50, to_date('19-02-2012', 'dd-mm-yyyy'), 19, 7, 2, 1, 2012, 1);
insert into WORKB_TIME (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values (51, to_date('20-02-2012', 'dd-mm-yyyy'), 20, 1, 2, 1, 2012, 0);
insert into WORKB_TIME (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values (52, to_date('21-02-2012', 'dd-mm-yyyy'), 21, 2, 2, 1, 2012, 0);
insert into WORKB_TIME (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values (53, to_date('22-02-2012', 'dd-mm-yyyy'), 22, 3, 2, 1, 2012, 0);
insert into WORKB_TIME (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values (54, to_date('23-02-2012', 'dd-mm-yyyy'), 23, 4, 2, 1, 2012, 0);
insert into WORKB_TIME (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values (55, to_date('24-02-2012', 'dd-mm-yyyy'), 24, 5, 2, 1, 2012, 0);
insert into WORKB_TIME (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values (56, to_date('25-02-2012', 'dd-mm-yyyy'), 25, 6, 2, 1, 2012, 1);
insert into WORKB_TIME (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values (57, to_date('26-02-2012', 'dd-mm-yyyy'), 26, 7, 2, 1, 2012, 1);
insert into WORKB_TIME (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values (58, to_date('27-02-2012', 'dd-mm-yyyy'), 27, 1, 2, 1, 2012, 0);
insert into WORKB_TIME (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values (59, to_date('28-02-2012', 'dd-mm-yyyy'), 28, 2, 2, 1, 2012, 0);
insert into WORKB_TIME (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values (60, to_date('29-02-2012', 'dd-mm-yyyy'), 29, 3, 2, 1, 2012, 0);
insert into WORKB_TIME (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values (61, to_date('01-03-2012', 'dd-mm-yyyy'), 1, 4, 3, 1, 2012, 0);
insert into WORKB_TIME (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values (62, to_date('02-03-2012', 'dd-mm-yyyy'), 2, 5, 3, 1, 2012, 0);
insert into WORKB_TIME (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values (63, to_date('03-03-2012', 'dd-mm-yyyy'), 3, 6, 3, 1, 2012, 1);
insert into WORKB_TIME (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values (64, to_date('04-03-2012', 'dd-mm-yyyy'), 4, 7, 3, 1, 2012, 1);
commit;
-- 500 records committed...
insert into WORKB_TIME (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values (65, to_date('05-03-2012', 'dd-mm-yyyy'), 5, 1, 3, 1, 2012, 0);
insert into WORKB_TIME (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values (66, to_date('06-03-2012', 'dd-mm-yyyy'), 6, 2, 3, 1, 2012, 0);
insert into WORKB_TIME (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values (67, to_date('07-03-2012', 'dd-mm-yyyy'), 7, 3, 3, 1, 2012, 0);
insert into WORKB_TIME (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values (68, to_date('08-03-2012', 'dd-mm-yyyy'), 8, 4, 3, 1, 2012, 0);
insert into WORKB_TIME (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values (69, to_date('09-03-2012', 'dd-mm-yyyy'), 9, 5, 3, 1, 2012, 0);
insert into WORKB_TIME (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values (70, to_date('10-03-2012', 'dd-mm-yyyy'), 10, 6, 3, 1, 2012, 1);
insert into WORKB_TIME (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values (71, to_date('11-03-2012', 'dd-mm-yyyy'), 11, 7, 3, 1, 2012, 1);
insert into WORKB_TIME (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values (72, to_date('12-03-2012', 'dd-mm-yyyy'), 12, 1, 3, 1, 2012, 0);
insert into WORKB_TIME (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values (73, to_date('13-03-2012', 'dd-mm-yyyy'), 13, 2, 3, 1, 2012, 0);
insert into WORKB_TIME (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values (74, to_date('14-03-2012', 'dd-mm-yyyy'), 14, 3, 3, 1, 2012, 0);
insert into WORKB_TIME (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values (75, to_date('15-03-2012', 'dd-mm-yyyy'), 15, 4, 3, 1, 2012, 0);
insert into WORKB_TIME (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values (76, to_date('16-03-2012', 'dd-mm-yyyy'), 16, 5, 3, 1, 2012, 0);
insert into WORKB_TIME (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values (77, to_date('17-03-2012', 'dd-mm-yyyy'), 17, 6, 3, 1, 2012, 1);
insert into WORKB_TIME (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values (78, to_date('18-03-2012', 'dd-mm-yyyy'), 18, 7, 3, 1, 2012, 1);
insert into WORKB_TIME (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values (79, to_date('19-03-2012', 'dd-mm-yyyy'), 19, 1, 3, 1, 2012, 0);
insert into WORKB_TIME (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values (80, to_date('20-03-2012', 'dd-mm-yyyy'), 20, 2, 3, 1, 2012, 0);
insert into WORKB_TIME (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values (81, to_date('21-03-2012', 'dd-mm-yyyy'), 21, 3, 3, 1, 2012, 0);
insert into WORKB_TIME (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values (82, to_date('22-03-2012', 'dd-mm-yyyy'), 22, 4, 3, 1, 2012, 0);
insert into WORKB_TIME (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values (83, to_date('23-03-2012', 'dd-mm-yyyy'), 23, 5, 3, 1, 2012, 0);
insert into WORKB_TIME (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values (84, to_date('24-03-2012', 'dd-mm-yyyy'), 24, 6, 3, 1, 2012, 1);
insert into WORKB_TIME (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values (85, to_date('25-03-2012', 'dd-mm-yyyy'), 25, 7, 3, 1, 2012, 1);
insert into WORKB_TIME (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values (86, to_date('26-03-2012', 'dd-mm-yyyy'), 26, 1, 3, 1, 2012, 0);
insert into WORKB_TIME (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values (87, to_date('27-03-2012', 'dd-mm-yyyy'), 27, 2, 3, 1, 2012, 0);
insert into WORKB_TIME (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values (88, to_date('28-03-2012', 'dd-mm-yyyy'), 28, 3, 3, 1, 2012, 0);
insert into WORKB_TIME (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values (89, to_date('29-03-2012', 'dd-mm-yyyy'), 29, 4, 3, 1, 2012, 0);
insert into WORKB_TIME (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values (90, to_date('30-03-2012', 'dd-mm-yyyy'), 30, 5, 3, 1, 2012, 0);
insert into WORKB_TIME (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values (91, to_date('31-03-2012', 'dd-mm-yyyy'), 31, 6, 3, 1, 2012, 1);
insert into WORKB_TIME (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values (92, to_date('01-04-2012', 'dd-mm-yyyy'), 1, 7, 4, 2, 2012, 1);
insert into WORKB_TIME (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values (93, to_date('02-04-2012', 'dd-mm-yyyy'), 2, 1, 4, 2, 2012, 0);
insert into WORKB_TIME (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values (94, to_date('03-04-2012', 'dd-mm-yyyy'), 3, 2, 4, 2, 2012, 0);
insert into WORKB_TIME (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values (95, to_date('04-04-2012', 'dd-mm-yyyy'), 4, 3, 4, 2, 2012, 0);
insert into WORKB_TIME (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values (96, to_date('05-04-2012', 'dd-mm-yyyy'), 5, 4, 4, 2, 2012, 0);
insert into WORKB_TIME (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values (97, to_date('06-04-2012', 'dd-mm-yyyy'), 6, 5, 4, 2, 2012, 0);
insert into WORKB_TIME (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values (98, to_date('07-04-2012', 'dd-mm-yyyy'), 7, 6, 4, 2, 2012, 1);
insert into WORKB_TIME (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values (99, to_date('08-04-2012', 'dd-mm-yyyy'), 8, 7, 4, 2, 2012, 1);
insert into WORKB_TIME (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values (100, to_date('09-04-2012', 'dd-mm-yyyy'), 9, 1, 4, 2, 2012, 0);
insert into WORKB_TIME (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values (101, to_date('10-04-2012', 'dd-mm-yyyy'), 10, 2, 4, 2, 2012, 0);
insert into WORKB_TIME (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values (102, to_date('11-04-2012', 'dd-mm-yyyy'), 11, 3, 4, 2, 2012, 0);
insert into WORKB_TIME (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values (103, to_date('12-04-2012', 'dd-mm-yyyy'), 12, 4, 4, 2, 2012, 0);
insert into WORKB_TIME (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values (104, to_date('13-04-2012', 'dd-mm-yyyy'), 13, 5, 4, 2, 2012, 0);
insert into WORKB_TIME (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values (105, to_date('14-04-2012', 'dd-mm-yyyy'), 14, 6, 4, 2, 2012, 1);
insert into WORKB_TIME (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values (106, to_date('15-04-2012', 'dd-mm-yyyy'), 15, 7, 4, 2, 2012, 1);
insert into WORKB_TIME (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values (107, to_date('16-04-2012', 'dd-mm-yyyy'), 16, 1, 4, 2, 2012, 0);
insert into WORKB_TIME (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values (108, to_date('17-04-2012', 'dd-mm-yyyy'), 17, 2, 4, 2, 2012, 0);
insert into WORKB_TIME (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values (109, to_date('18-04-2012', 'dd-mm-yyyy'), 18, 3, 4, 2, 2012, 0);
insert into WORKB_TIME (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values (110, to_date('19-04-2012', 'dd-mm-yyyy'), 19, 4, 4, 2, 2012, 0);
insert into WORKB_TIME (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values (111, to_date('20-04-2012', 'dd-mm-yyyy'), 20, 5, 4, 2, 2012, 0);
insert into WORKB_TIME (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values (112, to_date('21-04-2012', 'dd-mm-yyyy'), 21, 6, 4, 2, 2012, 1);
insert into WORKB_TIME (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values (113, to_date('22-04-2012', 'dd-mm-yyyy'), 22, 7, 4, 2, 2012, 1);
insert into WORKB_TIME (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values (114, to_date('23-04-2012', 'dd-mm-yyyy'), 23, 1, 4, 2, 2012, 0);
insert into WORKB_TIME (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values (115, to_date('24-04-2012', 'dd-mm-yyyy'), 24, 2, 4, 2, 2012, 0);
insert into WORKB_TIME (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values (116, to_date('25-04-2012', 'dd-mm-yyyy'), 25, 3, 4, 2, 2012, 0);
insert into WORKB_TIME (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values (117, to_date('26-04-2012', 'dd-mm-yyyy'), 26, 4, 4, 2, 2012, 0);
insert into WORKB_TIME (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values (118, to_date('27-04-2012', 'dd-mm-yyyy'), 27, 5, 4, 2, 2012, 0);
insert into WORKB_TIME (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values (119, to_date('28-04-2012', 'dd-mm-yyyy'), 28, 6, 4, 2, 2012, 1);
insert into WORKB_TIME (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values (120, to_date('29-04-2012', 'dd-mm-yyyy'), 29, 7, 4, 2, 2012, 1);
insert into WORKB_TIME (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values (121, to_date('30-04-2012', 'dd-mm-yyyy'), 30, 1, 4, 2, 2012, 0);
insert into WORKB_TIME (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values (122, to_date('01-05-2012', 'dd-mm-yyyy'), 1, 2, 5, 2, 2012, 0);
insert into WORKB_TIME (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values (123, to_date('02-05-2012', 'dd-mm-yyyy'), 2, 3, 5, 2, 2012, 0);
insert into WORKB_TIME (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values (124, to_date('03-05-2012', 'dd-mm-yyyy'), 3, 4, 5, 2, 2012, 0);
insert into WORKB_TIME (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values (125, to_date('04-05-2012', 'dd-mm-yyyy'), 4, 5, 5, 2, 2012, 0);
insert into WORKB_TIME (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values (126, to_date('05-05-2012', 'dd-mm-yyyy'), 5, 6, 5, 2, 2012, 1);
insert into WORKB_TIME (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values (127, to_date('06-05-2012', 'dd-mm-yyyy'), 6, 7, 5, 2, 2012, 1);
insert into WORKB_TIME (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values (128, to_date('07-05-2012', 'dd-mm-yyyy'), 7, 1, 5, 2, 2012, 0);
insert into WORKB_TIME (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values (129, to_date('08-05-2012', 'dd-mm-yyyy'), 8, 2, 5, 2, 2012, 0);
insert into WORKB_TIME (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values (130, to_date('09-05-2012', 'dd-mm-yyyy'), 9, 3, 5, 2, 2012, 1);
insert into WORKB_TIME (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values (131, to_date('10-05-2012', 'dd-mm-yyyy'), 10, 4, 5, 2, 2012, 0);
insert into WORKB_TIME (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values (132, to_date('11-05-2012', 'dd-mm-yyyy'), 11, 5, 5, 2, 2012, 0);
insert into WORKB_TIME (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values (133, to_date('12-05-2012', 'dd-mm-yyyy'), 12, 6, 5, 2, 2012, 1);
insert into WORKB_TIME (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values (134, to_date('13-05-2012', 'dd-mm-yyyy'), 13, 7, 5, 2, 2012, 1);
insert into WORKB_TIME (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values (135, to_date('14-05-2012', 'dd-mm-yyyy'), 14, 1, 5, 2, 2012, 0);
insert into WORKB_TIME (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values (136, to_date('15-05-2012', 'dd-mm-yyyy'), 15, 2, 5, 2, 2012, 0);
insert into WORKB_TIME (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values (137, to_date('16-05-2012', 'dd-mm-yyyy'), 16, 3, 5, 2, 2012, 0);
insert into WORKB_TIME (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values (138, to_date('17-05-2012', 'dd-mm-yyyy'), 17, 4, 5, 2, 2012, 0);
insert into WORKB_TIME (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values (139, to_date('18-05-2012', 'dd-mm-yyyy'), 18, 5, 5, 2, 2012, 0);
insert into WORKB_TIME (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values (140, to_date('19-05-2012', 'dd-mm-yyyy'), 19, 6, 5, 2, 2012, 1);
insert into WORKB_TIME (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values (141, to_date('20-05-2012', 'dd-mm-yyyy'), 20, 7, 5, 2, 2012, 1);
insert into WORKB_TIME (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values (142, to_date('21-05-2012', 'dd-mm-yyyy'), 21, 1, 5, 2, 2012, 0);
insert into WORKB_TIME (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values (143, to_date('22-05-2012', 'dd-mm-yyyy'), 22, 2, 5, 2, 2012, 0);
insert into WORKB_TIME (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values (144, to_date('23-05-2012', 'dd-mm-yyyy'), 23, 3, 5, 2, 2012, 0);
insert into WORKB_TIME (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values (145, to_date('24-05-2012', 'dd-mm-yyyy'), 24, 4, 5, 2, 2012, 0);
insert into WORKB_TIME (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values (146, to_date('25-05-2012', 'dd-mm-yyyy'), 25, 5, 5, 2, 2012, 0);
insert into WORKB_TIME (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values (147, to_date('26-05-2012', 'dd-mm-yyyy'), 26, 6, 5, 2, 2012, 1);
insert into WORKB_TIME (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values (148, to_date('27-05-2012', 'dd-mm-yyyy'), 27, 7, 5, 2, 2012, 1);
insert into WORKB_TIME (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values (149, to_date('28-05-2012', 'dd-mm-yyyy'), 28, 1, 5, 2, 2012, 0);
insert into WORKB_TIME (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values (150, to_date('29-05-2012', 'dd-mm-yyyy'), 29, 2, 5, 2, 2012, 0);
insert into WORKB_TIME (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values (151, to_date('30-05-2012', 'dd-mm-yyyy'), 30, 3, 5, 2, 2012, 0);
insert into WORKB_TIME (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values (152, to_date('31-05-2012', 'dd-mm-yyyy'), 31, 4, 5, 2, 2012, 0);
insert into WORKB_TIME (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values (153, to_date('01-06-2012', 'dd-mm-yyyy'), 1, 5, 6, 2, 2012, 0);
insert into WORKB_TIME (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values (154, to_date('02-06-2012', 'dd-mm-yyyy'), 2, 6, 6, 2, 2012, 1);
insert into WORKB_TIME (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values (155, to_date('03-06-2012', 'dd-mm-yyyy'), 3, 7, 6, 2, 2012, 1);
insert into WORKB_TIME (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values (156, to_date('04-06-2012', 'dd-mm-yyyy'), 4, 1, 6, 2, 2012, 0);
insert into WORKB_TIME (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values (157, to_date('05-06-2012', 'dd-mm-yyyy'), 5, 2, 6, 2, 2012, 0);
insert into WORKB_TIME (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values (158, to_date('06-06-2012', 'dd-mm-yyyy'), 6, 3, 6, 2, 2012, 0);
insert into WORKB_TIME (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values (159, to_date('07-06-2012', 'dd-mm-yyyy'), 7, 4, 6, 2, 2012, 0);
insert into WORKB_TIME (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values (160, to_date('08-06-2012', 'dd-mm-yyyy'), 8, 5, 6, 2, 2012, 0);
insert into WORKB_TIME (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values (161, to_date('09-06-2012', 'dd-mm-yyyy'), 9, 6, 6, 2, 2012, 1);
insert into WORKB_TIME (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values (162, to_date('10-06-2012', 'dd-mm-yyyy'), 10, 7, 6, 2, 2012, 1);
insert into WORKB_TIME (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values (163, to_date('11-06-2012', 'dd-mm-yyyy'), 11, 1, 6, 2, 2012, 0);
insert into WORKB_TIME (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values (164, to_date('12-06-2012', 'dd-mm-yyyy'), 12, 2, 6, 2, 2012, 0);
commit;
-- 600 records committed...
insert into WORKB_TIME (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values (165, to_date('13-06-2012', 'dd-mm-yyyy'), 13, 3, 6, 2, 2012, 0);
insert into WORKB_TIME (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values (166, to_date('14-06-2012', 'dd-mm-yyyy'), 14, 4, 6, 2, 2012, 0);
insert into WORKB_TIME (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values (167, to_date('15-06-2012', 'dd-mm-yyyy'), 15, 5, 6, 2, 2012, 0);
insert into WORKB_TIME (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values (168, to_date('16-06-2012', 'dd-mm-yyyy'), 16, 6, 6, 2, 2012, 1);
insert into WORKB_TIME (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values (169, to_date('17-06-2012', 'dd-mm-yyyy'), 17, 7, 6, 2, 2012, 1);
insert into WORKB_TIME (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values (170, to_date('18-06-2012', 'dd-mm-yyyy'), 18, 1, 6, 2, 2012, 0);
insert into WORKB_TIME (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values (171, to_date('19-06-2012', 'dd-mm-yyyy'), 19, 2, 6, 2, 2012, 0);
insert into WORKB_TIME (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values (172, to_date('20-06-2012', 'dd-mm-yyyy'), 20, 3, 6, 2, 2012, 0);
insert into WORKB_TIME (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values (173, to_date('21-06-2012', 'dd-mm-yyyy'), 21, 4, 6, 2, 2012, 0);
insert into WORKB_TIME (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values (174, to_date('22-06-2012', 'dd-mm-yyyy'), 22, 5, 6, 2, 2012, 0);
insert into WORKB_TIME (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values (175, to_date('23-06-2012', 'dd-mm-yyyy'), 23, 6, 6, 2, 2012, 1);
insert into WORKB_TIME (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values (176, to_date('24-06-2012', 'dd-mm-yyyy'), 24, 7, 6, 2, 2012, 1);
insert into WORKB_TIME (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values (177, to_date('25-06-2012', 'dd-mm-yyyy'), 25, 1, 6, 2, 2012, 0);
insert into WORKB_TIME (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values (178, to_date('26-06-2012', 'dd-mm-yyyy'), 26, 2, 6, 2, 2012, 0);
insert into WORKB_TIME (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values (179, to_date('27-06-2012', 'dd-mm-yyyy'), 27, 3, 6, 2, 2012, 0);
insert into WORKB_TIME (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values (180, to_date('28-06-2012', 'dd-mm-yyyy'), 28, 4, 6, 2, 2012, 1);
insert into WORKB_TIME (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values (181, to_date('29-06-2012', 'dd-mm-yyyy'), 29, 5, 6, 2, 2012, 0);
insert into WORKB_TIME (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values (182, to_date('30-06-2012', 'dd-mm-yyyy'), 30, 6, 6, 2, 2012, 1);
insert into WORKB_TIME (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values (183, to_date('01-07-2012', 'dd-mm-yyyy'), 1, 7, 7, 3, 2012, 1);
insert into WORKB_TIME (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values (184, to_date('02-07-2012', 'dd-mm-yyyy'), 2, 1, 7, 3, 2012, 0);
insert into WORKB_TIME (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values (185, to_date('03-07-2012', 'dd-mm-yyyy'), 3, 2, 7, 3, 2012, 0);
insert into WORKB_TIME (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values (186, to_date('04-07-2012', 'dd-mm-yyyy'), 4, 3, 7, 3, 2012, 0);
insert into WORKB_TIME (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values (187, to_date('05-07-2012', 'dd-mm-yyyy'), 5, 4, 7, 3, 2012, 0);
insert into WORKB_TIME (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values (188, to_date('06-07-2012', 'dd-mm-yyyy'), 6, 5, 7, 3, 2012, 0);
insert into WORKB_TIME (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values (189, to_date('07-07-2012', 'dd-mm-yyyy'), 7, 6, 7, 3, 2012, 1);
insert into WORKB_TIME (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values (190, to_date('08-07-2012', 'dd-mm-yyyy'), 8, 7, 7, 3, 2012, 1);
insert into WORKB_TIME (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values (191, to_date('09-07-2012', 'dd-mm-yyyy'), 9, 1, 7, 3, 2012, 0);
insert into WORKB_TIME (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values (192, to_date('10-07-2012', 'dd-mm-yyyy'), 10, 2, 7, 3, 2012, 0);
insert into WORKB_TIME (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values (193, to_date('11-07-2012', 'dd-mm-yyyy'), 11, 3, 7, 3, 2012, 0);
insert into WORKB_TIME (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values (194, to_date('12-07-2012', 'dd-mm-yyyy'), 12, 4, 7, 3, 2012, 0);
insert into WORKB_TIME (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values (195, to_date('13-07-2012', 'dd-mm-yyyy'), 13, 5, 7, 3, 2012, 0);
insert into WORKB_TIME (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values (196, to_date('14-07-2012', 'dd-mm-yyyy'), 14, 6, 7, 3, 2012, 1);
insert into WORKB_TIME (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values (357, to_date('22-12-2012', 'dd-mm-yyyy'), 22, 6, 12, 4, 2012, 1);
insert into WORKB_TIME (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values (358, to_date('23-12-2012', 'dd-mm-yyyy'), 23, 7, 12, 4, 2012, 1);
insert into WORKB_TIME (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values (359, to_date('24-12-2012', 'dd-mm-yyyy'), 24, 1, 12, 4, 2012, 0);
insert into WORKB_TIME (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values (360, to_date('25-12-2012', 'dd-mm-yyyy'), 25, 2, 12, 4, 2012, 0);
insert into WORKB_TIME (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values (361, to_date('26-12-2012', 'dd-mm-yyyy'), 26, 3, 12, 4, 2012, 0);
insert into WORKB_TIME (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values (362, to_date('27-12-2012', 'dd-mm-yyyy'), 27, 4, 12, 4, 2012, 0);
insert into WORKB_TIME (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values (363, to_date('28-12-2012', 'dd-mm-yyyy'), 28, 5, 12, 4, 2012, 0);
insert into WORKB_TIME (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values (364, to_date('29-12-2012', 'dd-mm-yyyy'), 29, 6, 12, 4, 2012, 1);
insert into WORKB_TIME (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values (365, to_date('30-12-2012', 'dd-mm-yyyy'), 30, 7, 12, 4, 2012, 1);
insert into WORKB_TIME (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values (366, to_date('31-12-2012', 'dd-mm-yyyy'), 31, 1, 12, 4, 2012, 0);
insert into WORKB_TIME (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values (1, to_date('01-01-2012', 'dd-mm-yyyy'), 1, 7, 1, 1, 2012, 1);
insert into WORKB_TIME (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values (2, to_date('02-01-2012', 'dd-mm-yyyy'), 2, 1, 1, 1, 2012, 0);
insert into WORKB_TIME (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values (3, to_date('03-01-2012', 'dd-mm-yyyy'), 3, 2, 1, 1, 2012, 0);
insert into WORKB_TIME (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values (4, to_date('04-01-2012', 'dd-mm-yyyy'), 4, 3, 1, 1, 2012, 0);
insert into WORKB_TIME (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values (5, to_date('05-01-2012', 'dd-mm-yyyy'), 5, 4, 1, 1, 2012, 0);
insert into WORKB_TIME (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values (6, to_date('06-01-2012', 'dd-mm-yyyy'), 6, 5, 1, 1, 2012, 0);
insert into WORKB_TIME (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values (7, to_date('07-01-2012', 'dd-mm-yyyy'), 7, 6, 1, 1, 2012, 1);
insert into WORKB_TIME (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values (8, to_date('08-01-2012', 'dd-mm-yyyy'), 8, 7, 1, 1, 2012, 1);
insert into WORKB_TIME (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values (9, to_date('09-01-2012', 'dd-mm-yyyy'), 9, 1, 1, 1, 2012, 0);
insert into WORKB_TIME (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values (10, to_date('10-01-2012', 'dd-mm-yyyy'), 10, 2, 1, 1, 2012, 0);
insert into WORKB_TIME (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values (11, to_date('11-01-2012', 'dd-mm-yyyy'), 11, 3, 1, 1, 2012, 0);
insert into WORKB_TIME (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values (12, to_date('12-01-2012', 'dd-mm-yyyy'), 12, 4, 1, 1, 2012, 0);
insert into WORKB_TIME (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values (13, to_date('13-01-2012', 'dd-mm-yyyy'), 13, 5, 1, 1, 2012, 0);
insert into WORKB_TIME (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values (14, to_date('14-01-2012', 'dd-mm-yyyy'), 14, 6, 1, 1, 2012, 1);
insert into WORKB_TIME (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values (15, to_date('15-01-2012', 'dd-mm-yyyy'), 15, 7, 1, 1, 2012, 1);
insert into WORKB_TIME (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values (16, to_date('16-01-2012', 'dd-mm-yyyy'), 16, 1, 1, 1, 2012, 0);
insert into WORKB_TIME (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values (17, to_date('17-01-2012', 'dd-mm-yyyy'), 17, 2, 1, 1, 2012, 0);
insert into WORKB_TIME (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values (18, to_date('18-01-2012', 'dd-mm-yyyy'), 18, 3, 1, 1, 2012, 0);
insert into WORKB_TIME (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values (19, to_date('19-01-2012', 'dd-mm-yyyy'), 19, 4, 1, 1, 2012, 0);
insert into WORKB_TIME (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values (20, to_date('20-01-2012', 'dd-mm-yyyy'), 20, 5, 1, 1, 2012, 0);
insert into WORKB_TIME (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values (21, to_date('21-01-2012', 'dd-mm-yyyy'), 21, 6, 1, 1, 2012, 1);
insert into WORKB_TIME (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values (22, to_date('22-01-2012', 'dd-mm-yyyy'), 22, 7, 1, 1, 2012, 1);
insert into WORKB_TIME (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values (23, to_date('23-01-2012', 'dd-mm-yyyy'), 23, 1, 1, 1, 2012, 0);
insert into WORKB_TIME (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values (24, to_date('24-01-2012', 'dd-mm-yyyy'), 24, 2, 1, 1, 2012, 0);
insert into WORKB_TIME (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values (25, to_date('25-01-2012', 'dd-mm-yyyy'), 25, 3, 1, 1, 2012, 0);
insert into WORKB_TIME (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values (26, to_date('26-01-2012', 'dd-mm-yyyy'), 26, 4, 1, 1, 2012, 0);
insert into WORKB_TIME (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values (27, to_date('27-01-2012', 'dd-mm-yyyy'), 27, 5, 1, 1, 2012, 0);
insert into WORKB_TIME (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values (28, to_date('28-01-2012', 'dd-mm-yyyy'), 28, 6, 1, 1, 2012, 1);
insert into WORKB_TIME (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values (29, to_date('29-01-2012', 'dd-mm-yyyy'), 29, 7, 1, 1, 2012, 1);
insert into WORKB_TIME (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values (30, to_date('30-01-2012', 'dd-mm-yyyy'), 30, 1, 1, 1, 2012, 0);
insert into WORKB_TIME (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values (31, to_date('31-01-2012', 'dd-mm-yyyy'), 31, 2, 1, 1, 2012, 0);
insert into WORKB_TIME (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values (32, to_date('01-02-2012', 'dd-mm-yyyy'), 1, 3, 2, 1, 2012, 0);
insert into WORKB_TIME (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values (33, to_date('02-02-2012', 'dd-mm-yyyy'), 2, 4, 2, 1, 2012, 0);
insert into WORKB_TIME (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values (34, to_date('03-02-2012', 'dd-mm-yyyy'), 3, 5, 2, 1, 2012, 0);
insert into WORKB_TIME (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values (35, to_date('04-02-2012', 'dd-mm-yyyy'), 4, 6, 2, 1, 2012, 1);
insert into WORKB_TIME (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values (36, to_date('05-02-2012', 'dd-mm-yyyy'), 5, 7, 2, 1, 2012, 1);
insert into WORKB_TIME (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values (37, to_date('06-02-2012', 'dd-mm-yyyy'), 6, 1, 2, 1, 2012, 0);
insert into WORKB_TIME (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values (38, to_date('07-02-2012', 'dd-mm-yyyy'), 7, 2, 2, 1, 2012, 0);
insert into WORKB_TIME (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values (197, to_date('15-07-2012', 'dd-mm-yyyy'), 15, 7, 7, 3, 2012, 1);
insert into WORKB_TIME (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values (198, to_date('16-07-2012', 'dd-mm-yyyy'), 16, 1, 7, 3, 2012, 0);
insert into WORKB_TIME (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values (199, to_date('17-07-2012', 'dd-mm-yyyy'), 17, 2, 7, 3, 2012, 0);
insert into WORKB_TIME (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values (200, to_date('18-07-2012', 'dd-mm-yyyy'), 18, 3, 7, 3, 2012, 0);
insert into WORKB_TIME (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values (201, to_date('19-07-2012', 'dd-mm-yyyy'), 19, 4, 7, 3, 2012, 0);
insert into WORKB_TIME (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values (202, to_date('20-07-2012', 'dd-mm-yyyy'), 20, 5, 7, 3, 2012, 0);
insert into WORKB_TIME (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values (203, to_date('21-07-2012', 'dd-mm-yyyy'), 21, 6, 7, 3, 2012, 1);
insert into WORKB_TIME (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values (204, to_date('22-07-2012', 'dd-mm-yyyy'), 22, 7, 7, 3, 2012, 1);
insert into WORKB_TIME (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values (205, to_date('23-07-2012', 'dd-mm-yyyy'), 23, 1, 7, 3, 2012, 0);
insert into WORKB_TIME (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values (206, to_date('24-07-2012', 'dd-mm-yyyy'), 24, 2, 7, 3, 2012, 0);
insert into WORKB_TIME (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values (207, to_date('25-07-2012', 'dd-mm-yyyy'), 25, 3, 7, 3, 2012, 0);
insert into WORKB_TIME (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values (208, to_date('26-07-2012', 'dd-mm-yyyy'), 26, 4, 7, 3, 2012, 0);
insert into WORKB_TIME (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values (209, to_date('27-07-2012', 'dd-mm-yyyy'), 27, 5, 7, 3, 2012, 0);
insert into WORKB_TIME (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values (210, to_date('28-07-2012', 'dd-mm-yyyy'), 28, 6, 7, 3, 2012, 1);
insert into WORKB_TIME (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values (211, to_date('29-07-2012', 'dd-mm-yyyy'), 29, 7, 7, 3, 2012, 1);
insert into WORKB_TIME (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values (212, to_date('30-07-2012', 'dd-mm-yyyy'), 30, 1, 7, 3, 2012, 0);
insert into WORKB_TIME (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values (213, to_date('31-07-2012', 'dd-mm-yyyy'), 31, 2, 7, 3, 2012, 0);
insert into WORKB_TIME (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values (214, to_date('01-08-2012', 'dd-mm-yyyy'), 1, 3, 8, 3, 2012, 0);
insert into WORKB_TIME (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values (215, to_date('02-08-2012', 'dd-mm-yyyy'), 2, 4, 8, 3, 2012, 0);
insert into WORKB_TIME (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values (216, to_date('03-08-2012', 'dd-mm-yyyy'), 3, 5, 8, 3, 2012, 0);
commit;
-- 700 records committed...
insert into WORKB_TIME (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values (217, to_date('04-08-2012', 'dd-mm-yyyy'), 4, 6, 8, 3, 2012, 1);
insert into WORKB_TIME (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values (218, to_date('05-08-2012', 'dd-mm-yyyy'), 5, 7, 8, 3, 2012, 1);
insert into WORKB_TIME (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values (219, to_date('06-08-2012', 'dd-mm-yyyy'), 6, 1, 8, 3, 2012, 0);
insert into WORKB_TIME (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values (220, to_date('07-08-2012', 'dd-mm-yyyy'), 7, 2, 8, 3, 2012, 0);
insert into WORKB_TIME (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values (221, to_date('08-08-2012', 'dd-mm-yyyy'), 8, 3, 8, 3, 2012, 0);
insert into WORKB_TIME (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values (222, to_date('09-08-2012', 'dd-mm-yyyy'), 9, 4, 8, 3, 2012, 0);
insert into WORKB_TIME (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values (223, to_date('10-08-2012', 'dd-mm-yyyy'), 10, 5, 8, 3, 2012, 0);
insert into WORKB_TIME (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values (224, to_date('11-08-2012', 'dd-mm-yyyy'), 11, 6, 8, 3, 2012, 1);
insert into WORKB_TIME (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values (225, to_date('12-08-2012', 'dd-mm-yyyy'), 12, 7, 8, 3, 2012, 1);
insert into WORKB_TIME (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values (226, to_date('13-08-2012', 'dd-mm-yyyy'), 13, 1, 8, 3, 2012, 0);
insert into WORKB_TIME (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values (227, to_date('14-08-2012', 'dd-mm-yyyy'), 14, 2, 8, 3, 2012, 0);
insert into WORKB_TIME (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values (228, to_date('15-08-2012', 'dd-mm-yyyy'), 15, 3, 8, 3, 2012, 0);
insert into WORKB_TIME (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values (229, to_date('16-08-2012', 'dd-mm-yyyy'), 16, 4, 8, 3, 2012, 0);
insert into WORKB_TIME (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values (230, to_date('17-08-2012', 'dd-mm-yyyy'), 17, 5, 8, 3, 2012, 0);
insert into WORKB_TIME (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values (231, to_date('18-08-2012', 'dd-mm-yyyy'), 18, 6, 8, 3, 2012, 1);
insert into WORKB_TIME (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values (232, to_date('19-08-2012', 'dd-mm-yyyy'), 19, 7, 8, 3, 2012, 1);
insert into WORKB_TIME (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values (233, to_date('20-08-2012', 'dd-mm-yyyy'), 20, 1, 8, 3, 2012, 0);
insert into WORKB_TIME (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values (234, to_date('21-08-2012', 'dd-mm-yyyy'), 21, 2, 8, 3, 2012, 0);
insert into WORKB_TIME (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values (235, to_date('22-08-2012', 'dd-mm-yyyy'), 22, 3, 8, 3, 2012, 0);
insert into WORKB_TIME (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values (236, to_date('23-08-2012', 'dd-mm-yyyy'), 23, 4, 8, 3, 2012, 0);
insert into WORKB_TIME (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values (237, to_date('24-08-2012', 'dd-mm-yyyy'), 24, 5, 8, 3, 2012, 1);
insert into WORKB_TIME (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values (238, to_date('25-08-2012', 'dd-mm-yyyy'), 25, 6, 8, 3, 2012, 1);
insert into WORKB_TIME (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values (239, to_date('26-08-2012', 'dd-mm-yyyy'), 26, 7, 8, 3, 2012, 1);
insert into WORKB_TIME (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values (240, to_date('27-08-2012', 'dd-mm-yyyy'), 27, 1, 8, 3, 2012, 0);
insert into WORKB_TIME (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values (241, to_date('28-08-2012', 'dd-mm-yyyy'), 28, 2, 8, 3, 2012, 0);
insert into WORKB_TIME (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values (242, to_date('29-08-2012', 'dd-mm-yyyy'), 29, 3, 8, 3, 2012, 0);
insert into WORKB_TIME (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values (243, to_date('30-08-2012', 'dd-mm-yyyy'), 30, 4, 8, 3, 2012, 0);
insert into WORKB_TIME (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values (244, to_date('31-08-2012', 'dd-mm-yyyy'), 31, 5, 8, 3, 2012, 0);
insert into WORKB_TIME (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values (245, to_date('01-09-2012', 'dd-mm-yyyy'), 1, 6, 9, 3, 2012, 1);
insert into WORKB_TIME (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values (246, to_date('02-09-2012', 'dd-mm-yyyy'), 2, 7, 9, 3, 2012, 1);
insert into WORKB_TIME (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values (247, to_date('03-09-2012', 'dd-mm-yyyy'), 3, 1, 9, 3, 2012, 0);
commit;
-- 731 records loaded
-- Loading WORKB_TIME_CHAR...
insert into WORKB_TIME_CHAR (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values ('248', to_date('04-09-2012', 'dd-mm-yyyy'), '4', '2', '9', '3', '2012', '0');
insert into WORKB_TIME_CHAR (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values ('249', to_date('05-09-2012', 'dd-mm-yyyy'), '5', '3', '9', '3', '2012', '0');
insert into WORKB_TIME_CHAR (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values ('250', to_date('06-09-2012', 'dd-mm-yyyy'), '6', '4', '9', '3', '2012', '0');
insert into WORKB_TIME_CHAR (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values ('251', to_date('07-09-2012', 'dd-mm-yyyy'), '7', '5', '9', '3', '2012', '0');
insert into WORKB_TIME_CHAR (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values ('252', to_date('08-09-2012', 'dd-mm-yyyy'), '8', '6', '9', '3', '2012', '1');
insert into WORKB_TIME_CHAR (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values ('253', to_date('09-09-2012', 'dd-mm-yyyy'), '9', '7', '9', '3', '2012', '1');
insert into WORKB_TIME_CHAR (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values ('254', to_date('10-09-2012', 'dd-mm-yyyy'), '10', '1', '9', '3', '2012', '0');
insert into WORKB_TIME_CHAR (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values ('255', to_date('11-09-2012', 'dd-mm-yyyy'), '11', '2', '9', '3', '2012', '0');
insert into WORKB_TIME_CHAR (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values ('256', to_date('12-09-2012', 'dd-mm-yyyy'), '12', '3', '9', '3', '2012', '0');
insert into WORKB_TIME_CHAR (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values ('257', to_date('13-09-2012', 'dd-mm-yyyy'), '13', '4', '9', '3', '2012', '0');
insert into WORKB_TIME_CHAR (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values ('258', to_date('14-09-2012', 'dd-mm-yyyy'), '14', '5', '9', '3', '2012', '0');
insert into WORKB_TIME_CHAR (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values ('259', to_date('15-09-2012', 'dd-mm-yyyy'), '15', '6', '9', '3', '2012', '1');
insert into WORKB_TIME_CHAR (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values ('260', to_date('16-09-2012', 'dd-mm-yyyy'), '16', '7', '9', '3', '2012', '1');
insert into WORKB_TIME_CHAR (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values ('261', to_date('17-09-2012', 'dd-mm-yyyy'), '17', '1', '9', '3', '2012', '0');
insert into WORKB_TIME_CHAR (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values ('262', to_date('18-09-2012', 'dd-mm-yyyy'), '18', '2', '9', '3', '2012', '0');
insert into WORKB_TIME_CHAR (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values ('263', to_date('19-09-2012', 'dd-mm-yyyy'), '19', '3', '9', '3', '2012', '0');
insert into WORKB_TIME_CHAR (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values ('264', to_date('20-09-2012', 'dd-mm-yyyy'), '20', '4', '9', '3', '2012', '0');
insert into WORKB_TIME_CHAR (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values ('265', to_date('21-09-2012', 'dd-mm-yyyy'), '21', '5', '9', '3', '2012', '0');
insert into WORKB_TIME_CHAR (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values ('266', to_date('22-09-2012', 'dd-mm-yyyy'), '22', '6', '9', '3', '2012', '1');
insert into WORKB_TIME_CHAR (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values ('267', to_date('23-09-2012', 'dd-mm-yyyy'), '23', '7', '9', '3', '2012', '1');
insert into WORKB_TIME_CHAR (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values ('268', to_date('24-09-2012', 'dd-mm-yyyy'), '24', '1', '9', '3', '2012', '0');
insert into WORKB_TIME_CHAR (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values ('269', to_date('25-09-2012', 'dd-mm-yyyy'), '25', '2', '9', '3', '2012', '0');
insert into WORKB_TIME_CHAR (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values ('270', to_date('26-09-2012', 'dd-mm-yyyy'), '26', '3', '9', '3', '2012', '0');
insert into WORKB_TIME_CHAR (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values ('271', to_date('27-09-2012', 'dd-mm-yyyy'), '27', '4', '9', '3', '2012', '0');
insert into WORKB_TIME_CHAR (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values ('272', to_date('28-09-2012', 'dd-mm-yyyy'), '28', '5', '9', '3', '2012', '0');
insert into WORKB_TIME_CHAR (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values ('273', to_date('29-09-2012', 'dd-mm-yyyy'), '29', '6', '9', '3', '2012', '1');
insert into WORKB_TIME_CHAR (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values ('274', to_date('30-09-2012', 'dd-mm-yyyy'), '30', '7', '9', '3', '2012', '1');
insert into WORKB_TIME_CHAR (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values ('275', to_date('01-10-2012', 'dd-mm-yyyy'), '1', '1', '10', '4', '2012', '0');
insert into WORKB_TIME_CHAR (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values ('276', to_date('02-10-2012', 'dd-mm-yyyy'), '2', '2', '10', '4', '2012', '0');
insert into WORKB_TIME_CHAR (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values ('277', to_date('03-10-2012', 'dd-mm-yyyy'), '3', '3', '10', '4', '2012', '0');
insert into WORKB_TIME_CHAR (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values ('278', to_date('04-10-2012', 'dd-mm-yyyy'), '4', '4', '10', '4', '2012', '0');
insert into WORKB_TIME_CHAR (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values ('279', to_date('05-10-2012', 'dd-mm-yyyy'), '5', '5', '10', '4', '2012', '0');
insert into WORKB_TIME_CHAR (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values ('280', to_date('06-10-2012', 'dd-mm-yyyy'), '6', '6', '10', '4', '2012', '1');
insert into WORKB_TIME_CHAR (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values ('281', to_date('07-10-2012', 'dd-mm-yyyy'), '7', '7', '10', '4', '2012', '1');
insert into WORKB_TIME_CHAR (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values ('282', to_date('08-10-2012', 'dd-mm-yyyy'), '8', '1', '10', '4', '2012', '0');
insert into WORKB_TIME_CHAR (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values ('283', to_date('09-10-2012', 'dd-mm-yyyy'), '9', '2', '10', '4', '2012', '0');
insert into WORKB_TIME_CHAR (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values ('284', to_date('10-10-2012', 'dd-mm-yyyy'), '10', '3', '10', '4', '2012', '0');
insert into WORKB_TIME_CHAR (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values ('285', to_date('11-10-2012', 'dd-mm-yyyy'), '11', '4', '10', '4', '2012', '0');
insert into WORKB_TIME_CHAR (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values ('286', to_date('12-10-2012', 'dd-mm-yyyy'), '12', '5', '10', '4', '2012', '0');
insert into WORKB_TIME_CHAR (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values ('287', to_date('13-10-2012', 'dd-mm-yyyy'), '13', '6', '10', '4', '2012', '1');
insert into WORKB_TIME_CHAR (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values ('288', to_date('14-10-2012', 'dd-mm-yyyy'), '14', '7', '10', '4', '2012', '1');
insert into WORKB_TIME_CHAR (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values ('289', to_date('15-10-2012', 'dd-mm-yyyy'), '15', '1', '10', '4', '2012', '0');
insert into WORKB_TIME_CHAR (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values ('290', to_date('16-10-2012', 'dd-mm-yyyy'), '16', '2', '10', '4', '2012', '0');
insert into WORKB_TIME_CHAR (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values ('291', to_date('17-10-2012', 'dd-mm-yyyy'), '17', '3', '10', '4', '2012', '0');
insert into WORKB_TIME_CHAR (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values ('292', to_date('18-10-2012', 'dd-mm-yyyy'), '18', '4', '10', '4', '2012', '0');
insert into WORKB_TIME_CHAR (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values ('293', to_date('19-10-2012', 'dd-mm-yyyy'), '19', '5', '10', '4', '2012', '0');
insert into WORKB_TIME_CHAR (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values ('294', to_date('20-10-2012', 'dd-mm-yyyy'), '20', '6', '10', '4', '2012', '1');
insert into WORKB_TIME_CHAR (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values ('295', to_date('21-10-2012', 'dd-mm-yyyy'), '21', '7', '10', '4', '2012', '1');
insert into WORKB_TIME_CHAR (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values ('296', to_date('22-10-2012', 'dd-mm-yyyy'), '22', '1', '10', '4', '2012', '0');
insert into WORKB_TIME_CHAR (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values ('297', to_date('23-10-2012', 'dd-mm-yyyy'), '23', '2', '10', '4', '2012', '0');
insert into WORKB_TIME_CHAR (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values ('298', to_date('24-10-2012', 'dd-mm-yyyy'), '24', '3', '10', '4', '2012', '0');
insert into WORKB_TIME_CHAR (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values ('299', to_date('25-10-2012', 'dd-mm-yyyy'), '25', '4', '10', '4', '2012', '0');
insert into WORKB_TIME_CHAR (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values ('300', to_date('26-10-2012', 'dd-mm-yyyy'), '26', '5', '10', '4', '2012', '0');
insert into WORKB_TIME_CHAR (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values ('301', to_date('27-10-2012', 'dd-mm-yyyy'), '27', '6', '10', '4', '2012', '1');
insert into WORKB_TIME_CHAR (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values ('302', to_date('28-10-2012', 'dd-mm-yyyy'), '28', '7', '10', '4', '2012', '1');
insert into WORKB_TIME_CHAR (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values ('303', to_date('29-10-2012', 'dd-mm-yyyy'), '29', '1', '10', '4', '2012', '0');
insert into WORKB_TIME_CHAR (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values ('304', to_date('30-10-2012', 'dd-mm-yyyy'), '30', '2', '10', '4', '2012', '0');
insert into WORKB_TIME_CHAR (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values ('305', to_date('31-10-2012', 'dd-mm-yyyy'), '31', '3', '10', '4', '2012', '0');
insert into WORKB_TIME_CHAR (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values ('306', to_date('01-11-2012', 'dd-mm-yyyy'), '1', '4', '11', '4', '2012', '0');
insert into WORKB_TIME_CHAR (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values ('307', to_date('02-11-2012', 'dd-mm-yyyy'), '2', '5', '11', '4', '2012', '0');
insert into WORKB_TIME_CHAR (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values ('308', to_date('03-11-2012', 'dd-mm-yyyy'), '3', '6', '11', '4', '2012', '1');
insert into WORKB_TIME_CHAR (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values ('309', to_date('04-11-2012', 'dd-mm-yyyy'), '4', '7', '11', '4', '2012', '1');
insert into WORKB_TIME_CHAR (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values ('310', to_date('05-11-2012', 'dd-mm-yyyy'), '5', '1', '11', '4', '2012', '0');
insert into WORKB_TIME_CHAR (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values ('311', to_date('06-11-2012', 'dd-mm-yyyy'), '6', '2', '11', '4', '2012', '0');
insert into WORKB_TIME_CHAR (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values ('312', to_date('07-11-2012', 'dd-mm-yyyy'), '7', '3', '11', '4', '2012', '0');
insert into WORKB_TIME_CHAR (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values ('313', to_date('08-11-2012', 'dd-mm-yyyy'), '8', '4', '11', '4', '2012', '0');
insert into WORKB_TIME_CHAR (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values ('314', to_date('09-11-2012', 'dd-mm-yyyy'), '9', '5', '11', '4', '2012', '0');
insert into WORKB_TIME_CHAR (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values ('315', to_date('10-11-2012', 'dd-mm-yyyy'), '10', '6', '11', '4', '2012', '1');
insert into WORKB_TIME_CHAR (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values ('316', to_date('11-11-2012', 'dd-mm-yyyy'), '11', '7', '11', '4', '2012', '1');
insert into WORKB_TIME_CHAR (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values ('317', to_date('12-11-2012', 'dd-mm-yyyy'), '12', '1', '11', '4', '2012', '0');
insert into WORKB_TIME_CHAR (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values ('318', to_date('13-11-2012', 'dd-mm-yyyy'), '13', '2', '11', '4', '2012', '0');
insert into WORKB_TIME_CHAR (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values ('319', to_date('14-11-2012', 'dd-mm-yyyy'), '14', '3', '11', '4', '2012', '0');
insert into WORKB_TIME_CHAR (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values ('320', to_date('15-11-2012', 'dd-mm-yyyy'), '15', '4', '11', '4', '2012', '0');
insert into WORKB_TIME_CHAR (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values ('321', to_date('16-11-2012', 'dd-mm-yyyy'), '16', '5', '11', '4', '2012', '0');
insert into WORKB_TIME_CHAR (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values ('322', to_date('17-11-2012', 'dd-mm-yyyy'), '17', '6', '11', '4', '2012', '1');
insert into WORKB_TIME_CHAR (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values ('323', to_date('18-11-2012', 'dd-mm-yyyy'), '18', '7', '11', '4', '2012', '1');
insert into WORKB_TIME_CHAR (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values ('324', to_date('19-11-2012', 'dd-mm-yyyy'), '19', '1', '11', '4', '2012', '0');
insert into WORKB_TIME_CHAR (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values ('325', to_date('20-11-2012', 'dd-mm-yyyy'), '20', '2', '11', '4', '2012', '0');
insert into WORKB_TIME_CHAR (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values ('326', to_date('21-11-2012', 'dd-mm-yyyy'), '21', '3', '11', '4', '2012', '0');
insert into WORKB_TIME_CHAR (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values ('327', to_date('22-11-2012', 'dd-mm-yyyy'), '22', '4', '11', '4', '2012', '0');
insert into WORKB_TIME_CHAR (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values ('328', to_date('23-11-2012', 'dd-mm-yyyy'), '23', '5', '11', '4', '2012', '0');
insert into WORKB_TIME_CHAR (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values ('329', to_date('24-11-2012', 'dd-mm-yyyy'), '24', '6', '11', '4', '2012', '1');
insert into WORKB_TIME_CHAR (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values ('330', to_date('25-11-2012', 'dd-mm-yyyy'), '25', '7', '11', '4', '2012', '1');
insert into WORKB_TIME_CHAR (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values ('331', to_date('26-11-2012', 'dd-mm-yyyy'), '26', '1', '11', '4', '2012', '0');
insert into WORKB_TIME_CHAR (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values ('332', to_date('27-11-2012', 'dd-mm-yyyy'), '27', '2', '11', '4', '2012', '0');
insert into WORKB_TIME_CHAR (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values ('333', to_date('28-11-2012', 'dd-mm-yyyy'), '28', '3', '11', '4', '2012', '0');
insert into WORKB_TIME_CHAR (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values ('334', to_date('29-11-2012', 'dd-mm-yyyy'), '29', '4', '11', '4', '2012', '0');
insert into WORKB_TIME_CHAR (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values ('335', to_date('30-11-2012', 'dd-mm-yyyy'), '30', '5', '11', '4', '2012', '0');
insert into WORKB_TIME_CHAR (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values ('336', to_date('01-12-2012', 'dd-mm-yyyy'), '1', '6', '12', '4', '2012', '1');
insert into WORKB_TIME_CHAR (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values ('337', to_date('02-12-2012', 'dd-mm-yyyy'), '2', '7', '12', '4', '2012', '1');
insert into WORKB_TIME_CHAR (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values ('338', to_date('03-12-2012', 'dd-mm-yyyy'), '3', '1', '12', '4', '2012', '0');
insert into WORKB_TIME_CHAR (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values ('339', to_date('04-12-2012', 'dd-mm-yyyy'), '4', '2', '12', '4', '2012', '0');
insert into WORKB_TIME_CHAR (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values ('340', to_date('05-12-2012', 'dd-mm-yyyy'), '5', '3', '12', '4', '2012', '0');
insert into WORKB_TIME_CHAR (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values ('341', to_date('06-12-2012', 'dd-mm-yyyy'), '6', '4', '12', '4', '2012', '0');
insert into WORKB_TIME_CHAR (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values ('342', to_date('07-12-2012', 'dd-mm-yyyy'), '7', '5', '12', '4', '2012', '0');
insert into WORKB_TIME_CHAR (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values ('343', to_date('08-12-2012', 'dd-mm-yyyy'), '8', '6', '12', '4', '2012', '1');
insert into WORKB_TIME_CHAR (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values ('344', to_date('09-12-2012', 'dd-mm-yyyy'), '9', '7', '12', '4', '2012', '1');
insert into WORKB_TIME_CHAR (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values ('345', to_date('10-12-2012', 'dd-mm-yyyy'), '10', '1', '12', '4', '2012', '0');
insert into WORKB_TIME_CHAR (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values ('346', to_date('11-12-2012', 'dd-mm-yyyy'), '11', '2', '12', '4', '2012', '0');
insert into WORKB_TIME_CHAR (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values ('347', to_date('12-12-2012', 'dd-mm-yyyy'), '12', '3', '12', '4', '2012', '0');
commit;
-- 100 records committed...
insert into WORKB_TIME_CHAR (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values ('348', to_date('13-12-2012', 'dd-mm-yyyy'), '13', '4', '12', '4', '2012', '0');
insert into WORKB_TIME_CHAR (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values ('349', to_date('14-12-2012', 'dd-mm-yyyy'), '14', '5', '12', '4', '2012', '0');
insert into WORKB_TIME_CHAR (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values ('350', to_date('15-12-2012', 'dd-mm-yyyy'), '15', '6', '12', '4', '2012', '1');
insert into WORKB_TIME_CHAR (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values ('351', to_date('16-12-2012', 'dd-mm-yyyy'), '16', '7', '12', '4', '2012', '1');
insert into WORKB_TIME_CHAR (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values ('352', to_date('17-12-2012', 'dd-mm-yyyy'), '17', '1', '12', '4', '2012', '0');
insert into WORKB_TIME_CHAR (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values ('353', to_date('18-12-2012', 'dd-mm-yyyy'), '18', '2', '12', '4', '2012', '0');
insert into WORKB_TIME_CHAR (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values ('354', to_date('19-12-2012', 'dd-mm-yyyy'), '19', '3', '12', '4', '2012', '0');
insert into WORKB_TIME_CHAR (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values ('355', to_date('20-12-2012', 'dd-mm-yyyy'), '20', '4', '12', '4', '2012', '0');
insert into WORKB_TIME_CHAR (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values ('356', to_date('21-12-2012', 'dd-mm-yyyy'), '21', '5', '12', '4', '2012', '0');
insert into WORKB_TIME_CHAR (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values ('367', to_date('01-01-2013', 'dd-mm-yyyy'), '1', '2', '1', '1', '2013', '0');
insert into WORKB_TIME_CHAR (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values ('368', to_date('02-01-2013', 'dd-mm-yyyy'), '2', '3', '1', '1', '2013', '0');
insert into WORKB_TIME_CHAR (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values ('369', to_date('03-01-2013', 'dd-mm-yyyy'), '3', '4', '1', '1', '2013', '0');
insert into WORKB_TIME_CHAR (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values ('370', to_date('04-01-2013', 'dd-mm-yyyy'), '4', '5', '1', '1', '2013', '0');
insert into WORKB_TIME_CHAR (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values ('371', to_date('05-01-2013', 'dd-mm-yyyy'), '5', '6', '1', '1', '2013', '0');
insert into WORKB_TIME_CHAR (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values ('372', to_date('06-01-2013', 'dd-mm-yyyy'), '6', '7', '1', '1', '2013', '0');
insert into WORKB_TIME_CHAR (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values ('373', to_date('07-01-2013', 'dd-mm-yyyy'), '7', '1', '1', '1', '2013', '0');
insert into WORKB_TIME_CHAR (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values ('374', to_date('08-01-2013', 'dd-mm-yyyy'), '8', '2', '1', '1', '2013', '0');
insert into WORKB_TIME_CHAR (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values ('375', to_date('09-01-2013', 'dd-mm-yyyy'), '9', '3', '1', '1', '2013', '0');
insert into WORKB_TIME_CHAR (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values ('376', to_date('10-01-2013', 'dd-mm-yyyy'), '10', '4', '1', '1', '2013', '0');
insert into WORKB_TIME_CHAR (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values ('377', to_date('11-01-2013', 'dd-mm-yyyy'), '11', '5', '1', '1', '2013', '0');
insert into WORKB_TIME_CHAR (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values ('378', to_date('12-01-2013', 'dd-mm-yyyy'), '12', '6', '1', '1', '2013', '0');
insert into WORKB_TIME_CHAR (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values ('379', to_date('13-01-2013', 'dd-mm-yyyy'), '13', '7', '1', '1', '2013', '0');
insert into WORKB_TIME_CHAR (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values ('380', to_date('14-01-2013', 'dd-mm-yyyy'), '14', '1', '1', '1', '2013', '0');
insert into WORKB_TIME_CHAR (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values ('381', to_date('15-01-2013', 'dd-mm-yyyy'), '15', '2', '1', '1', '2013', '0');
insert into WORKB_TIME_CHAR (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values ('382', to_date('16-01-2013', 'dd-mm-yyyy'), '16', '3', '1', '1', '2013', '0');
insert into WORKB_TIME_CHAR (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values ('383', to_date('17-01-2013', 'dd-mm-yyyy'), '17', '4', '1', '1', '2013', '0');
insert into WORKB_TIME_CHAR (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values ('384', to_date('18-01-2013', 'dd-mm-yyyy'), '18', '5', '1', '1', '2013', '0');
insert into WORKB_TIME_CHAR (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values ('385', to_date('19-01-2013', 'dd-mm-yyyy'), '19', '6', '1', '1', '2013', '0');
insert into WORKB_TIME_CHAR (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values ('386', to_date('20-01-2013', 'dd-mm-yyyy'), '20', '7', '1', '1', '2013', '0');
insert into WORKB_TIME_CHAR (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values ('387', to_date('21-01-2013', 'dd-mm-yyyy'), '21', '1', '1', '1', '2013', '0');
insert into WORKB_TIME_CHAR (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values ('388', to_date('22-01-2013', 'dd-mm-yyyy'), '22', '2', '1', '1', '2013', '0');
insert into WORKB_TIME_CHAR (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values ('389', to_date('23-01-2013', 'dd-mm-yyyy'), '23', '3', '1', '1', '2013', '0');
insert into WORKB_TIME_CHAR (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values ('390', to_date('24-01-2013', 'dd-mm-yyyy'), '24', '4', '1', '1', '2013', '0');
insert into WORKB_TIME_CHAR (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values ('391', to_date('25-01-2013', 'dd-mm-yyyy'), '25', '5', '1', '1', '2013', '0');
insert into WORKB_TIME_CHAR (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values ('392', to_date('26-01-2013', 'dd-mm-yyyy'), '26', '6', '1', '1', '2013', '0');
insert into WORKB_TIME_CHAR (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values ('393', to_date('27-01-2013', 'dd-mm-yyyy'), '27', '7', '1', '1', '2013', '0');
insert into WORKB_TIME_CHAR (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values ('394', to_date('28-01-2013', 'dd-mm-yyyy'), '28', '1', '1', '1', '2013', '0');
insert into WORKB_TIME_CHAR (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values ('395', to_date('29-01-2013', 'dd-mm-yyyy'), '29', '2', '1', '1', '2013', '0');
insert into WORKB_TIME_CHAR (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values ('396', to_date('30-01-2013', 'dd-mm-yyyy'), '30', '3', '1', '1', '2013', '0');
insert into WORKB_TIME_CHAR (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values ('397', to_date('31-01-2013', 'dd-mm-yyyy'), '31', '4', '1', '1', '2013', '0');
insert into WORKB_TIME_CHAR (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values ('398', to_date('01-02-2013', 'dd-mm-yyyy'), '1', '5', '2', '1', '2013', '0');
insert into WORKB_TIME_CHAR (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values ('399', to_date('02-02-2013', 'dd-mm-yyyy'), '2', '6', '2', '1', '2013', '0');
insert into WORKB_TIME_CHAR (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values ('400', to_date('03-02-2013', 'dd-mm-yyyy'), '3', '7', '2', '1', '2013', '0');
insert into WORKB_TIME_CHAR (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values ('401', to_date('04-02-2013', 'dd-mm-yyyy'), '4', '1', '2', '1', '2013', '0');
insert into WORKB_TIME_CHAR (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values ('402', to_date('05-02-2013', 'dd-mm-yyyy'), '5', '2', '2', '1', '2013', '0');
insert into WORKB_TIME_CHAR (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values ('403', to_date('06-02-2013', 'dd-mm-yyyy'), '6', '3', '2', '1', '2013', '0');
insert into WORKB_TIME_CHAR (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values ('404', to_date('07-02-2013', 'dd-mm-yyyy'), '7', '4', '2', '1', '2013', '0');
insert into WORKB_TIME_CHAR (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values ('405', to_date('08-02-2013', 'dd-mm-yyyy'), '8', '5', '2', '1', '2013', '0');
insert into WORKB_TIME_CHAR (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values ('406', to_date('09-02-2013', 'dd-mm-yyyy'), '9', '6', '2', '1', '2013', '0');
insert into WORKB_TIME_CHAR (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values ('407', to_date('10-02-2013', 'dd-mm-yyyy'), '10', '7', '2', '1', '2013', '0');
insert into WORKB_TIME_CHAR (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values ('408', to_date('11-02-2013', 'dd-mm-yyyy'), '11', '1', '2', '1', '2013', '0');
insert into WORKB_TIME_CHAR (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values ('409', to_date('12-02-2013', 'dd-mm-yyyy'), '12', '2', '2', '1', '2013', '0');
insert into WORKB_TIME_CHAR (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values ('410', to_date('13-02-2013', 'dd-mm-yyyy'), '13', '3', '2', '1', '2013', '0');
insert into WORKB_TIME_CHAR (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values ('411', to_date('14-02-2013', 'dd-mm-yyyy'), '14', '4', '2', '1', '2013', '0');
insert into WORKB_TIME_CHAR (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values ('412', to_date('15-02-2013', 'dd-mm-yyyy'), '15', '5', '2', '1', '2013', '0');
insert into WORKB_TIME_CHAR (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values ('413', to_date('16-02-2013', 'dd-mm-yyyy'), '16', '6', '2', '1', '2013', '0');
insert into WORKB_TIME_CHAR (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values ('414', to_date('17-02-2013', 'dd-mm-yyyy'), '17', '7', '2', '1', '2013', '0');
insert into WORKB_TIME_CHAR (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values ('415', to_date('18-02-2013', 'dd-mm-yyyy'), '18', '1', '2', '1', '2013', '0');
insert into WORKB_TIME_CHAR (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values ('416', to_date('19-02-2013', 'dd-mm-yyyy'), '19', '2', '2', '1', '2013', '0');
insert into WORKB_TIME_CHAR (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values ('417', to_date('20-02-2013', 'dd-mm-yyyy'), '20', '3', '2', '1', '2013', '0');
insert into WORKB_TIME_CHAR (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values ('418', to_date('21-02-2013', 'dd-mm-yyyy'), '21', '4', '2', '1', '2013', '0');
insert into WORKB_TIME_CHAR (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values ('419', to_date('22-02-2013', 'dd-mm-yyyy'), '22', '5', '2', '1', '2013', '0');
insert into WORKB_TIME_CHAR (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values ('420', to_date('23-02-2013', 'dd-mm-yyyy'), '23', '6', '2', '1', '2013', '1');
insert into WORKB_TIME_CHAR (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values ('421', to_date('24-02-2013', 'dd-mm-yyyy'), '24', '7', '2', '1', '2013', '0');
insert into WORKB_TIME_CHAR (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values ('422', to_date('25-02-2013', 'dd-mm-yyyy'), '25', '1', '2', '1', '2013', '0');
insert into WORKB_TIME_CHAR (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values ('423', to_date('26-02-2013', 'dd-mm-yyyy'), '26', '2', '2', '1', '2013', '0');
insert into WORKB_TIME_CHAR (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values ('424', to_date('27-02-2013', 'dd-mm-yyyy'), '27', '3', '2', '1', '2013', '0');
insert into WORKB_TIME_CHAR (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values ('425', to_date('28-02-2013', 'dd-mm-yyyy'), '28', '4', '2', '1', '2013', '0');
insert into WORKB_TIME_CHAR (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values ('426', to_date('01-03-2013', 'dd-mm-yyyy'), '1', '5', '3', '1', '2013', '0');
insert into WORKB_TIME_CHAR (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values ('427', to_date('02-03-2013', 'dd-mm-yyyy'), '2', '6', '3', '1', '2013', '0');
insert into WORKB_TIME_CHAR (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values ('428', to_date('03-03-2013', 'dd-mm-yyyy'), '3', '7', '3', '1', '2013', '0');
insert into WORKB_TIME_CHAR (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values ('429', to_date('04-03-2013', 'dd-mm-yyyy'), '4', '1', '3', '1', '2013', '0');
insert into WORKB_TIME_CHAR (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values ('430', to_date('05-03-2013', 'dd-mm-yyyy'), '5', '2', '3', '1', '2013', '0');
insert into WORKB_TIME_CHAR (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values ('431', to_date('06-03-2013', 'dd-mm-yyyy'), '6', '3', '3', '1', '2013', '0');
insert into WORKB_TIME_CHAR (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values ('432', to_date('07-03-2013', 'dd-mm-yyyy'), '7', '4', '3', '1', '2013', '0');
insert into WORKB_TIME_CHAR (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values ('433', to_date('08-03-2013', 'dd-mm-yyyy'), '8', '5', '3', '1', '2013', '1');
insert into WORKB_TIME_CHAR (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values ('434', to_date('09-03-2013', 'dd-mm-yyyy'), '9', '6', '3', '1', '2013', '0');
insert into WORKB_TIME_CHAR (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values ('435', to_date('10-03-2013', 'dd-mm-yyyy'), '10', '7', '3', '1', '2013', '0');
insert into WORKB_TIME_CHAR (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values ('436', to_date('11-03-2013', 'dd-mm-yyyy'), '11', '1', '3', '1', '2013', '0');
insert into WORKB_TIME_CHAR (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values ('437', to_date('12-03-2013', 'dd-mm-yyyy'), '12', '2', '3', '1', '2013', '0');
insert into WORKB_TIME_CHAR (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values ('438', to_date('13-03-2013', 'dd-mm-yyyy'), '13', '3', '3', '1', '2013', '0');
insert into WORKB_TIME_CHAR (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values ('439', to_date('14-03-2013', 'dd-mm-yyyy'), '14', '4', '3', '1', '2013', '0');
insert into WORKB_TIME_CHAR (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values ('440', to_date('15-03-2013', 'dd-mm-yyyy'), '15', '5', '3', '1', '2013', '0');
insert into WORKB_TIME_CHAR (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values ('441', to_date('16-03-2013', 'dd-mm-yyyy'), '16', '6', '3', '1', '2013', '0');
insert into WORKB_TIME_CHAR (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values ('442', to_date('17-03-2013', 'dd-mm-yyyy'), '17', '7', '3', '1', '2013', '0');
insert into WORKB_TIME_CHAR (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values ('443', to_date('18-03-2013', 'dd-mm-yyyy'), '18', '1', '3', '1', '2013', '0');
insert into WORKB_TIME_CHAR (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values ('444', to_date('19-03-2013', 'dd-mm-yyyy'), '19', '2', '3', '1', '2013', '0');
insert into WORKB_TIME_CHAR (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values ('445', to_date('20-03-2013', 'dd-mm-yyyy'), '20', '3', '3', '1', '2013', '0');
insert into WORKB_TIME_CHAR (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values ('446', to_date('21-03-2013', 'dd-mm-yyyy'), '21', '4', '3', '1', '2013', '0');
insert into WORKB_TIME_CHAR (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values ('447', to_date('22-03-2013', 'dd-mm-yyyy'), '22', '5', '3', '1', '2013', '0');
insert into WORKB_TIME_CHAR (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values ('448', to_date('23-03-2013', 'dd-mm-yyyy'), '23', '6', '3', '1', '2013', '0');
insert into WORKB_TIME_CHAR (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values ('449', to_date('24-03-2013', 'dd-mm-yyyy'), '24', '7', '3', '1', '2013', '0');
insert into WORKB_TIME_CHAR (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values ('450', to_date('25-03-2013', 'dd-mm-yyyy'), '25', '1', '3', '1', '2013', '0');
insert into WORKB_TIME_CHAR (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values ('451', to_date('26-03-2013', 'dd-mm-yyyy'), '26', '2', '3', '1', '2013', '0');
insert into WORKB_TIME_CHAR (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values ('452', to_date('27-03-2013', 'dd-mm-yyyy'), '27', '3', '3', '1', '2013', '0');
insert into WORKB_TIME_CHAR (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values ('453', to_date('28-03-2013', 'dd-mm-yyyy'), '28', '4', '3', '1', '2013', '0');
insert into WORKB_TIME_CHAR (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values ('454', to_date('29-03-2013', 'dd-mm-yyyy'), '29', '5', '3', '1', '2013', '0');
insert into WORKB_TIME_CHAR (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values ('455', to_date('30-03-2013', 'dd-mm-yyyy'), '30', '6', '3', '1', '2013', '0');
insert into WORKB_TIME_CHAR (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values ('456', to_date('31-03-2013', 'dd-mm-yyyy'), '31', '7', '3', '1', '2013', '0');
insert into WORKB_TIME_CHAR (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values ('457', to_date('01-04-2013', 'dd-mm-yyyy'), '1', '1', '4', '2', '2013', '0');
commit;
-- 200 records committed...
insert into WORKB_TIME_CHAR (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values ('458', to_date('02-04-2013', 'dd-mm-yyyy'), '2', '2', '4', '2', '2013', '0');
insert into WORKB_TIME_CHAR (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values ('459', to_date('03-04-2013', 'dd-mm-yyyy'), '3', '3', '4', '2', '2013', '0');
insert into WORKB_TIME_CHAR (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values ('460', to_date('04-04-2013', 'dd-mm-yyyy'), '4', '4', '4', '2', '2013', '0');
insert into WORKB_TIME_CHAR (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values ('461', to_date('05-04-2013', 'dd-mm-yyyy'), '5', '5', '4', '2', '2013', '0');
insert into WORKB_TIME_CHAR (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values ('462', to_date('06-04-2013', 'dd-mm-yyyy'), '6', '6', '4', '2', '2013', '0');
insert into WORKB_TIME_CHAR (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values ('463', to_date('07-04-2013', 'dd-mm-yyyy'), '7', '7', '4', '2', '2013', '0');
insert into WORKB_TIME_CHAR (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values ('464', to_date('08-04-2013', 'dd-mm-yyyy'), '8', '1', '4', '2', '2013', '0');
insert into WORKB_TIME_CHAR (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values ('465', to_date('09-04-2013', 'dd-mm-yyyy'), '9', '2', '4', '2', '2013', '0');
insert into WORKB_TIME_CHAR (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values ('466', to_date('10-04-2013', 'dd-mm-yyyy'), '10', '3', '4', '2', '2013', '0');
insert into WORKB_TIME_CHAR (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values ('467', to_date('11-04-2013', 'dd-mm-yyyy'), '11', '4', '4', '2', '2013', '0');
insert into WORKB_TIME_CHAR (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values ('468', to_date('12-04-2013', 'dd-mm-yyyy'), '12', '5', '4', '2', '2013', '0');
insert into WORKB_TIME_CHAR (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values ('469', to_date('13-04-2013', 'dd-mm-yyyy'), '13', '6', '4', '2', '2013', '0');
insert into WORKB_TIME_CHAR (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values ('470', to_date('14-04-2013', 'dd-mm-yyyy'), '14', '7', '4', '2', '2013', '0');
insert into WORKB_TIME_CHAR (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values ('471', to_date('15-04-2013', 'dd-mm-yyyy'), '15', '1', '4', '2', '2013', '0');
insert into WORKB_TIME_CHAR (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values ('472', to_date('16-04-2013', 'dd-mm-yyyy'), '16', '2', '4', '2', '2013', '0');
insert into WORKB_TIME_CHAR (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values ('473', to_date('17-04-2013', 'dd-mm-yyyy'), '17', '3', '4', '2', '2013', '0');
insert into WORKB_TIME_CHAR (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values ('474', to_date('18-04-2013', 'dd-mm-yyyy'), '18', '4', '4', '2', '2013', '0');
insert into WORKB_TIME_CHAR (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values ('475', to_date('19-04-2013', 'dd-mm-yyyy'), '19', '5', '4', '2', '2013', '0');
insert into WORKB_TIME_CHAR (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values ('476', to_date('20-04-2013', 'dd-mm-yyyy'), '20', '6', '4', '2', '2013', '0');
insert into WORKB_TIME_CHAR (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values ('477', to_date('21-04-2013', 'dd-mm-yyyy'), '21', '7', '4', '2', '2013', '0');
insert into WORKB_TIME_CHAR (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values ('478', to_date('22-04-2013', 'dd-mm-yyyy'), '22', '1', '4', '2', '2013', '0');
insert into WORKB_TIME_CHAR (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values ('479', to_date('23-04-2013', 'dd-mm-yyyy'), '23', '2', '4', '2', '2013', '0');
insert into WORKB_TIME_CHAR (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values ('480', to_date('24-04-2013', 'dd-mm-yyyy'), '24', '3', '4', '2', '2013', '0');
insert into WORKB_TIME_CHAR (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values ('481', to_date('25-04-2013', 'dd-mm-yyyy'), '25', '4', '4', '2', '2013', '0');
insert into WORKB_TIME_CHAR (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values ('482', to_date('26-04-2013', 'dd-mm-yyyy'), '26', '5', '4', '2', '2013', '0');
insert into WORKB_TIME_CHAR (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values ('483', to_date('27-04-2013', 'dd-mm-yyyy'), '27', '6', '4', '2', '2013', '0');
insert into WORKB_TIME_CHAR (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values ('484', to_date('28-04-2013', 'dd-mm-yyyy'), '28', '7', '4', '2', '2013', '0');
insert into WORKB_TIME_CHAR (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values ('485', to_date('29-04-2013', 'dd-mm-yyyy'), '29', '1', '4', '2', '2013', '0');
insert into WORKB_TIME_CHAR (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values ('486', to_date('30-04-2013', 'dd-mm-yyyy'), '30', '2', '4', '2', '2013', '0');
insert into WORKB_TIME_CHAR (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values ('487', to_date('01-05-2013', 'dd-mm-yyyy'), '1', '3', '5', '2', '2013', '0');
insert into WORKB_TIME_CHAR (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values ('488', to_date('02-05-2013', 'dd-mm-yyyy'), '2', '4', '5', '2', '2013', '0');
insert into WORKB_TIME_CHAR (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values ('489', to_date('03-05-2013', 'dd-mm-yyyy'), '3', '5', '5', '2', '2013', '0');
insert into WORKB_TIME_CHAR (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values ('490', to_date('04-05-2013', 'dd-mm-yyyy'), '4', '6', '5', '2', '2013', '0');
insert into WORKB_TIME_CHAR (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values ('491', to_date('05-05-2013', 'dd-mm-yyyy'), '5', '7', '5', '2', '2013', '0');
insert into WORKB_TIME_CHAR (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values ('492', to_date('06-05-2013', 'dd-mm-yyyy'), '6', '1', '5', '2', '2013', '0');
insert into WORKB_TIME_CHAR (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values ('493', to_date('07-05-2013', 'dd-mm-yyyy'), '7', '2', '5', '2', '2013', '0');
insert into WORKB_TIME_CHAR (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values ('494', to_date('08-05-2013', 'dd-mm-yyyy'), '8', '3', '5', '2', '2013', '0');
insert into WORKB_TIME_CHAR (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values ('495', to_date('09-05-2013', 'dd-mm-yyyy'), '9', '4', '5', '2', '2013', '0');
insert into WORKB_TIME_CHAR (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values ('496', to_date('10-05-2013', 'dd-mm-yyyy'), '10', '5', '5', '2', '2013', '0');
insert into WORKB_TIME_CHAR (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values ('497', to_date('11-05-2013', 'dd-mm-yyyy'), '11', '6', '5', '2', '2013', '0');
insert into WORKB_TIME_CHAR (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values ('498', to_date('12-05-2013', 'dd-mm-yyyy'), '12', '7', '5', '2', '2013', '0');
insert into WORKB_TIME_CHAR (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values ('499', to_date('13-05-2013', 'dd-mm-yyyy'), '13', '1', '5', '2', '2013', '0');
insert into WORKB_TIME_CHAR (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values ('500', to_date('14-05-2013', 'dd-mm-yyyy'), '14', '2', '5', '2', '2013', '0');
insert into WORKB_TIME_CHAR (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values ('501', to_date('15-05-2013', 'dd-mm-yyyy'), '15', '3', '5', '2', '2013', '0');
insert into WORKB_TIME_CHAR (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values ('502', to_date('16-05-2013', 'dd-mm-yyyy'), '16', '4', '5', '2', '2013', '0');
insert into WORKB_TIME_CHAR (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values ('503', to_date('17-05-2013', 'dd-mm-yyyy'), '17', '5', '5', '2', '2013', '0');
insert into WORKB_TIME_CHAR (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values ('504', to_date('18-05-2013', 'dd-mm-yyyy'), '18', '6', '5', '2', '2013', '0');
insert into WORKB_TIME_CHAR (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values ('505', to_date('19-05-2013', 'dd-mm-yyyy'), '19', '7', '5', '2', '2013', '0');
insert into WORKB_TIME_CHAR (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values ('506', to_date('20-05-2013', 'dd-mm-yyyy'), '20', '1', '5', '2', '2013', '0');
insert into WORKB_TIME_CHAR (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values ('507', to_date('21-05-2013', 'dd-mm-yyyy'), '21', '2', '5', '2', '2013', '0');
insert into WORKB_TIME_CHAR (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values ('508', to_date('22-05-2013', 'dd-mm-yyyy'), '22', '3', '5', '2', '2013', '0');
insert into WORKB_TIME_CHAR (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values ('509', to_date('23-05-2013', 'dd-mm-yyyy'), '23', '4', '5', '2', '2013', '0');
insert into WORKB_TIME_CHAR (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values ('510', to_date('24-05-2013', 'dd-mm-yyyy'), '24', '5', '5', '2', '2013', '0');
insert into WORKB_TIME_CHAR (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values ('511', to_date('25-05-2013', 'dd-mm-yyyy'), '25', '6', '5', '2', '2013', '0');
insert into WORKB_TIME_CHAR (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values ('512', to_date('26-05-2013', 'dd-mm-yyyy'), '26', '7', '5', '2', '2013', '0');
insert into WORKB_TIME_CHAR (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values ('513', to_date('27-05-2013', 'dd-mm-yyyy'), '27', '1', '5', '2', '2013', '0');
insert into WORKB_TIME_CHAR (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values ('514', to_date('28-05-2013', 'dd-mm-yyyy'), '28', '2', '5', '2', '2013', '0');
insert into WORKB_TIME_CHAR (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values ('515', to_date('29-05-2013', 'dd-mm-yyyy'), '29', '3', '5', '2', '2013', '0');
insert into WORKB_TIME_CHAR (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values ('516', to_date('30-05-2013', 'dd-mm-yyyy'), '30', '4', '5', '2', '2013', '0');
insert into WORKB_TIME_CHAR (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values ('517', to_date('31-05-2013', 'dd-mm-yyyy'), '31', '5', '5', '2', '2013', '0');
insert into WORKB_TIME_CHAR (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values ('518', to_date('01-06-2013', 'dd-mm-yyyy'), '1', '6', '6', '2', '2013', '0');
insert into WORKB_TIME_CHAR (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values ('519', to_date('02-06-2013', 'dd-mm-yyyy'), '2', '7', '6', '2', '2013', '0');
insert into WORKB_TIME_CHAR (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values ('520', to_date('03-06-2013', 'dd-mm-yyyy'), '3', '1', '6', '2', '2013', '0');
insert into WORKB_TIME_CHAR (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values ('521', to_date('04-06-2013', 'dd-mm-yyyy'), '4', '2', '6', '2', '2013', '0');
insert into WORKB_TIME_CHAR (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values ('522', to_date('05-06-2013', 'dd-mm-yyyy'), '5', '3', '6', '2', '2013', '0');
insert into WORKB_TIME_CHAR (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values ('523', to_date('06-06-2013', 'dd-mm-yyyy'), '6', '4', '6', '2', '2013', '0');
insert into WORKB_TIME_CHAR (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values ('524', to_date('07-06-2013', 'dd-mm-yyyy'), '7', '5', '6', '2', '2013', '0');
insert into WORKB_TIME_CHAR (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values ('525', to_date('08-06-2013', 'dd-mm-yyyy'), '8', '6', '6', '2', '2013', '0');
insert into WORKB_TIME_CHAR (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values ('526', to_date('09-06-2013', 'dd-mm-yyyy'), '9', '7', '6', '2', '2013', '0');
insert into WORKB_TIME_CHAR (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values ('527', to_date('10-06-2013', 'dd-mm-yyyy'), '10', '1', '6', '2', '2013', '0');
insert into WORKB_TIME_CHAR (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values ('528', to_date('11-06-2013', 'dd-mm-yyyy'), '11', '2', '6', '2', '2013', '0');
insert into WORKB_TIME_CHAR (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values ('529', to_date('12-06-2013', 'dd-mm-yyyy'), '12', '3', '6', '2', '2013', '0');
insert into WORKB_TIME_CHAR (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values ('530', to_date('13-06-2013', 'dd-mm-yyyy'), '13', '4', '6', '2', '2013', '0');
insert into WORKB_TIME_CHAR (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values ('531', to_date('14-06-2013', 'dd-mm-yyyy'), '14', '5', '6', '2', '2013', '0');
insert into WORKB_TIME_CHAR (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values ('532', to_date('15-06-2013', 'dd-mm-yyyy'), '15', '6', '6', '2', '2013', '0');
insert into WORKB_TIME_CHAR (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values ('533', to_date('16-06-2013', 'dd-mm-yyyy'), '16', '7', '6', '2', '2013', '0');
insert into WORKB_TIME_CHAR (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values ('534', to_date('17-06-2013', 'dd-mm-yyyy'), '17', '1', '6', '2', '2013', '0');
insert into WORKB_TIME_CHAR (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values ('535', to_date('18-06-2013', 'dd-mm-yyyy'), '18', '2', '6', '2', '2013', '0');
insert into WORKB_TIME_CHAR (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values ('536', to_date('19-06-2013', 'dd-mm-yyyy'), '19', '3', '6', '2', '2013', '0');
insert into WORKB_TIME_CHAR (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values ('537', to_date('20-06-2013', 'dd-mm-yyyy'), '20', '4', '6', '2', '2013', '0');
insert into WORKB_TIME_CHAR (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values ('538', to_date('21-06-2013', 'dd-mm-yyyy'), '21', '5', '6', '2', '2013', '0');
insert into WORKB_TIME_CHAR (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values ('539', to_date('22-06-2013', 'dd-mm-yyyy'), '22', '6', '6', '2', '2013', '0');
insert into WORKB_TIME_CHAR (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values ('540', to_date('23-06-2013', 'dd-mm-yyyy'), '23', '7', '6', '2', '2013', '0');
insert into WORKB_TIME_CHAR (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values ('541', to_date('24-06-2013', 'dd-mm-yyyy'), '24', '1', '6', '2', '2013', '0');
insert into WORKB_TIME_CHAR (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values ('542', to_date('25-06-2013', 'dd-mm-yyyy'), '25', '2', '6', '2', '2013', '0');
insert into WORKB_TIME_CHAR (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values ('543', to_date('26-06-2013', 'dd-mm-yyyy'), '26', '3', '6', '2', '2013', '0');
insert into WORKB_TIME_CHAR (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values ('544', to_date('27-06-2013', 'dd-mm-yyyy'), '27', '4', '6', '2', '2013', '0');
insert into WORKB_TIME_CHAR (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values ('545', to_date('28-06-2013', 'dd-mm-yyyy'), '28', '5', '6', '2', '2013', '0');
insert into WORKB_TIME_CHAR (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values ('546', to_date('29-06-2013', 'dd-mm-yyyy'), '29', '6', '6', '2', '2013', '0');
insert into WORKB_TIME_CHAR (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values ('547', to_date('30-06-2013', 'dd-mm-yyyy'), '30', '7', '6', '2', '2013', '0');
insert into WORKB_TIME_CHAR (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values ('548', to_date('01-07-2013', 'dd-mm-yyyy'), '1', '1', '7', '3', '2013', '0');
insert into WORKB_TIME_CHAR (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values ('549', to_date('02-07-2013', 'dd-mm-yyyy'), '2', '2', '7', '3', '2013', '0');
insert into WORKB_TIME_CHAR (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values ('550', to_date('03-07-2013', 'dd-mm-yyyy'), '3', '3', '7', '3', '2013', '0');
insert into WORKB_TIME_CHAR (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values ('551', to_date('04-07-2013', 'dd-mm-yyyy'), '4', '4', '7', '3', '2013', '0');
insert into WORKB_TIME_CHAR (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values ('552', to_date('05-07-2013', 'dd-mm-yyyy'), '5', '5', '7', '3', '2013', '0');
insert into WORKB_TIME_CHAR (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values ('553', to_date('06-07-2013', 'dd-mm-yyyy'), '6', '6', '7', '3', '2013', '0');
insert into WORKB_TIME_CHAR (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values ('554', to_date('07-07-2013', 'dd-mm-yyyy'), '7', '7', '7', '3', '2013', '0');
insert into WORKB_TIME_CHAR (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values ('555', to_date('08-07-2013', 'dd-mm-yyyy'), '8', '1', '7', '3', '2013', '0');
insert into WORKB_TIME_CHAR (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values ('556', to_date('09-07-2013', 'dd-mm-yyyy'), '9', '2', '7', '3', '2013', '0');
insert into WORKB_TIME_CHAR (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values ('557', to_date('10-07-2013', 'dd-mm-yyyy'), '10', '3', '7', '3', '2013', '0');
commit;
-- 300 records committed...
insert into WORKB_TIME_CHAR (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values ('558', to_date('11-07-2013', 'dd-mm-yyyy'), '11', '4', '7', '3', '2013', '0');
insert into WORKB_TIME_CHAR (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values ('559', to_date('12-07-2013', 'dd-mm-yyyy'), '12', '5', '7', '3', '2013', '0');
insert into WORKB_TIME_CHAR (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values ('560', to_date('13-07-2013', 'dd-mm-yyyy'), '13', '6', '7', '3', '2013', '0');
insert into WORKB_TIME_CHAR (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values ('561', to_date('14-07-2013', 'dd-mm-yyyy'), '14', '7', '7', '3', '2013', '0');
insert into WORKB_TIME_CHAR (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values ('562', to_date('15-07-2013', 'dd-mm-yyyy'), '15', '1', '7', '3', '2013', '0');
insert into WORKB_TIME_CHAR (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values ('563', to_date('16-07-2013', 'dd-mm-yyyy'), '16', '2', '7', '3', '2013', '0');
insert into WORKB_TIME_CHAR (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values ('564', to_date('17-07-2013', 'dd-mm-yyyy'), '17', '3', '7', '3', '2013', '0');
insert into WORKB_TIME_CHAR (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values ('565', to_date('18-07-2013', 'dd-mm-yyyy'), '18', '4', '7', '3', '2013', '0');
insert into WORKB_TIME_CHAR (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values ('566', to_date('19-07-2013', 'dd-mm-yyyy'), '19', '5', '7', '3', '2013', '0');
insert into WORKB_TIME_CHAR (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values ('567', to_date('20-07-2013', 'dd-mm-yyyy'), '20', '6', '7', '3', '2013', '0');
insert into WORKB_TIME_CHAR (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values ('568', to_date('21-07-2013', 'dd-mm-yyyy'), '21', '7', '7', '3', '2013', '0');
insert into WORKB_TIME_CHAR (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values ('569', to_date('22-07-2013', 'dd-mm-yyyy'), '22', '1', '7', '3', '2013', '0');
insert into WORKB_TIME_CHAR (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values ('570', to_date('23-07-2013', 'dd-mm-yyyy'), '23', '2', '7', '3', '2013', '0');
insert into WORKB_TIME_CHAR (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values ('571', to_date('24-07-2013', 'dd-mm-yyyy'), '24', '3', '7', '3', '2013', '0');
insert into WORKB_TIME_CHAR (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values ('572', to_date('25-07-2013', 'dd-mm-yyyy'), '25', '4', '7', '3', '2013', '0');
insert into WORKB_TIME_CHAR (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values ('573', to_date('26-07-2013', 'dd-mm-yyyy'), '26', '5', '7', '3', '2013', '0');
insert into WORKB_TIME_CHAR (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values ('574', to_date('27-07-2013', 'dd-mm-yyyy'), '27', '6', '7', '3', '2013', '0');
insert into WORKB_TIME_CHAR (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values ('575', to_date('28-07-2013', 'dd-mm-yyyy'), '28', '7', '7', '3', '2013', '0');
insert into WORKB_TIME_CHAR (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values ('576', to_date('29-07-2013', 'dd-mm-yyyy'), '29', '1', '7', '3', '2013', '0');
insert into WORKB_TIME_CHAR (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values ('577', to_date('30-07-2013', 'dd-mm-yyyy'), '30', '2', '7', '3', '2013', '0');
insert into WORKB_TIME_CHAR (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values ('578', to_date('31-07-2013', 'dd-mm-yyyy'), '31', '3', '7', '3', '2013', '0');
insert into WORKB_TIME_CHAR (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values ('579', to_date('01-08-2013', 'dd-mm-yyyy'), '1', '4', '8', '3', '2013', '0');
insert into WORKB_TIME_CHAR (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values ('580', to_date('02-08-2013', 'dd-mm-yyyy'), '2', '5', '8', '3', '2013', '0');
insert into WORKB_TIME_CHAR (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values ('581', to_date('03-08-2013', 'dd-mm-yyyy'), '3', '6', '8', '3', '2013', '0');
insert into WORKB_TIME_CHAR (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values ('582', to_date('04-08-2013', 'dd-mm-yyyy'), '4', '7', '8', '3', '2013', '0');
insert into WORKB_TIME_CHAR (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values ('583', to_date('05-08-2013', 'dd-mm-yyyy'), '5', '1', '8', '3', '2013', '0');
insert into WORKB_TIME_CHAR (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values ('584', to_date('06-08-2013', 'dd-mm-yyyy'), '6', '2', '8', '3', '2013', '0');
insert into WORKB_TIME_CHAR (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values ('585', to_date('07-08-2013', 'dd-mm-yyyy'), '7', '3', '8', '3', '2013', '0');
insert into WORKB_TIME_CHAR (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values ('586', to_date('08-08-2013', 'dd-mm-yyyy'), '8', '4', '8', '3', '2013', '0');
insert into WORKB_TIME_CHAR (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values ('587', to_date('09-08-2013', 'dd-mm-yyyy'), '9', '5', '8', '3', '2013', '0');
insert into WORKB_TIME_CHAR (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values ('588', to_date('10-08-2013', 'dd-mm-yyyy'), '10', '6', '8', '3', '2013', '0');
insert into WORKB_TIME_CHAR (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values ('589', to_date('11-08-2013', 'dd-mm-yyyy'), '11', '7', '8', '3', '2013', '0');
insert into WORKB_TIME_CHAR (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values ('590', to_date('12-08-2013', 'dd-mm-yyyy'), '12', '1', '8', '3', '2013', '0');
insert into WORKB_TIME_CHAR (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values ('591', to_date('13-08-2013', 'dd-mm-yyyy'), '13', '2', '8', '3', '2013', '0');
insert into WORKB_TIME_CHAR (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values ('592', to_date('14-08-2013', 'dd-mm-yyyy'), '14', '3', '8', '3', '2013', '0');
insert into WORKB_TIME_CHAR (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values ('593', to_date('15-08-2013', 'dd-mm-yyyy'), '15', '4', '8', '3', '2013', '0');
insert into WORKB_TIME_CHAR (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values ('594', to_date('16-08-2013', 'dd-mm-yyyy'), '16', '5', '8', '3', '2013', '0');
insert into WORKB_TIME_CHAR (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values ('595', to_date('17-08-2013', 'dd-mm-yyyy'), '17', '6', '8', '3', '2013', '0');
insert into WORKB_TIME_CHAR (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values ('596', to_date('18-08-2013', 'dd-mm-yyyy'), '18', '7', '8', '3', '2013', '0');
insert into WORKB_TIME_CHAR (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values ('597', to_date('19-08-2013', 'dd-mm-yyyy'), '19', '1', '8', '3', '2013', '0');
insert into WORKB_TIME_CHAR (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values ('598', to_date('20-08-2013', 'dd-mm-yyyy'), '20', '2', '8', '3', '2013', '0');
insert into WORKB_TIME_CHAR (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values ('599', to_date('21-08-2013', 'dd-mm-yyyy'), '21', '3', '8', '3', '2013', '0');
insert into WORKB_TIME_CHAR (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values ('600', to_date('22-08-2013', 'dd-mm-yyyy'), '22', '4', '8', '3', '2013', '0');
insert into WORKB_TIME_CHAR (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values ('601', to_date('23-08-2013', 'dd-mm-yyyy'), '23', '5', '8', '3', '2013', '0');
insert into WORKB_TIME_CHAR (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values ('602', to_date('24-08-2013', 'dd-mm-yyyy'), '24', '6', '8', '3', '2013', '0');
insert into WORKB_TIME_CHAR (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values ('603', to_date('25-08-2013', 'dd-mm-yyyy'), '25', '7', '8', '3', '2013', '0');
insert into WORKB_TIME_CHAR (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values ('604', to_date('26-08-2013', 'dd-mm-yyyy'), '26', '1', '8', '3', '2013', '0');
insert into WORKB_TIME_CHAR (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values ('605', to_date('27-08-2013', 'dd-mm-yyyy'), '27', '2', '8', '3', '2013', '0');
insert into WORKB_TIME_CHAR (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values ('606', to_date('28-08-2013', 'dd-mm-yyyy'), '28', '3', '8', '3', '2013', '0');
insert into WORKB_TIME_CHAR (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values ('607', to_date('29-08-2013', 'dd-mm-yyyy'), '29', '4', '8', '3', '2013', '0');
insert into WORKB_TIME_CHAR (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values ('608', to_date('30-08-2013', 'dd-mm-yyyy'), '30', '5', '8', '3', '2013', '0');
insert into WORKB_TIME_CHAR (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values ('609', to_date('31-08-2013', 'dd-mm-yyyy'), '31', '6', '8', '3', '2013', '0');
insert into WORKB_TIME_CHAR (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values ('610', to_date('01-09-2013', 'dd-mm-yyyy'), '1', '7', '9', '3', '2013', '0');
insert into WORKB_TIME_CHAR (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values ('611', to_date('02-09-2013', 'dd-mm-yyyy'), '2', '1', '9', '3', '2013', '0');
insert into WORKB_TIME_CHAR (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values ('612', to_date('03-09-2013', 'dd-mm-yyyy'), '3', '2', '9', '3', '2013', '0');
insert into WORKB_TIME_CHAR (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values ('613', to_date('04-09-2013', 'dd-mm-yyyy'), '4', '3', '9', '3', '2013', '0');
insert into WORKB_TIME_CHAR (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values ('614', to_date('05-09-2013', 'dd-mm-yyyy'), '5', '4', '9', '3', '2013', '0');
insert into WORKB_TIME_CHAR (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values ('615', to_date('06-09-2013', 'dd-mm-yyyy'), '6', '5', '9', '3', '2013', '0');
insert into WORKB_TIME_CHAR (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values ('616', to_date('07-09-2013', 'dd-mm-yyyy'), '7', '6', '9', '3', '2013', '0');
insert into WORKB_TIME_CHAR (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values ('617', to_date('08-09-2013', 'dd-mm-yyyy'), '8', '7', '9', '3', '2013', '0');
insert into WORKB_TIME_CHAR (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values ('618', to_date('09-09-2013', 'dd-mm-yyyy'), '9', '1', '9', '3', '2013', '0');
insert into WORKB_TIME_CHAR (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values ('619', to_date('10-09-2013', 'dd-mm-yyyy'), '10', '2', '9', '3', '2013', '0');
insert into WORKB_TIME_CHAR (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values ('620', to_date('11-09-2013', 'dd-mm-yyyy'), '11', '3', '9', '3', '2013', '0');
insert into WORKB_TIME_CHAR (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values ('621', to_date('12-09-2013', 'dd-mm-yyyy'), '12', '4', '9', '3', '2013', '0');
insert into WORKB_TIME_CHAR (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values ('622', to_date('13-09-2013', 'dd-mm-yyyy'), '13', '5', '9', '3', '2013', '0');
insert into WORKB_TIME_CHAR (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values ('623', to_date('14-09-2013', 'dd-mm-yyyy'), '14', '6', '9', '3', '2013', '0');
insert into WORKB_TIME_CHAR (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values ('624', to_date('15-09-2013', 'dd-mm-yyyy'), '15', '7', '9', '3', '2013', '0');
insert into WORKB_TIME_CHAR (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values ('625', to_date('16-09-2013', 'dd-mm-yyyy'), '16', '1', '9', '3', '2013', '0');
insert into WORKB_TIME_CHAR (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values ('626', to_date('17-09-2013', 'dd-mm-yyyy'), '17', '2', '9', '3', '2013', '0');
insert into WORKB_TIME_CHAR (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values ('627', to_date('18-09-2013', 'dd-mm-yyyy'), '18', '3', '9', '3', '2013', '0');
insert into WORKB_TIME_CHAR (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values ('628', to_date('19-09-2013', 'dd-mm-yyyy'), '19', '4', '9', '3', '2013', '0');
insert into WORKB_TIME_CHAR (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values ('629', to_date('20-09-2013', 'dd-mm-yyyy'), '20', '5', '9', '3', '2013', '0');
insert into WORKB_TIME_CHAR (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values ('630', to_date('21-09-2013', 'dd-mm-yyyy'), '21', '6', '9', '3', '2013', '0');
insert into WORKB_TIME_CHAR (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values ('631', to_date('22-09-2013', 'dd-mm-yyyy'), '22', '7', '9', '3', '2013', '0');
insert into WORKB_TIME_CHAR (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values ('632', to_date('23-09-2013', 'dd-mm-yyyy'), '23', '1', '9', '3', '2013', '0');
insert into WORKB_TIME_CHAR (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values ('633', to_date('24-09-2013', 'dd-mm-yyyy'), '24', '2', '9', '3', '2013', '0');
insert into WORKB_TIME_CHAR (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values ('634', to_date('25-09-2013', 'dd-mm-yyyy'), '25', '3', '9', '3', '2013', '0');
insert into WORKB_TIME_CHAR (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values ('635', to_date('26-09-2013', 'dd-mm-yyyy'), '26', '4', '9', '3', '2013', '0');
insert into WORKB_TIME_CHAR (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values ('636', to_date('27-09-2013', 'dd-mm-yyyy'), '27', '5', '9', '3', '2013', '0');
insert into WORKB_TIME_CHAR (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values ('637', to_date('28-09-2013', 'dd-mm-yyyy'), '28', '6', '9', '3', '2013', '0');
insert into WORKB_TIME_CHAR (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values ('638', to_date('29-09-2013', 'dd-mm-yyyy'), '29', '7', '9', '3', '2013', '0');
insert into WORKB_TIME_CHAR (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values ('639', to_date('30-09-2013', 'dd-mm-yyyy'), '30', '1', '9', '3', '2013', '0');
insert into WORKB_TIME_CHAR (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values ('640', to_date('01-10-2013', 'dd-mm-yyyy'), '1', '2', '10', '4', '2013', '0');
insert into WORKB_TIME_CHAR (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values ('641', to_date('02-10-2013', 'dd-mm-yyyy'), '2', '3', '10', '4', '2013', '0');
insert into WORKB_TIME_CHAR (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values ('642', to_date('03-10-2013', 'dd-mm-yyyy'), '3', '4', '10', '4', '2013', '0');
insert into WORKB_TIME_CHAR (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values ('643', to_date('04-10-2013', 'dd-mm-yyyy'), '4', '5', '10', '4', '2013', '0');
insert into WORKB_TIME_CHAR (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values ('644', to_date('05-10-2013', 'dd-mm-yyyy'), '5', '6', '10', '4', '2013', '0');
insert into WORKB_TIME_CHAR (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values ('645', to_date('06-10-2013', 'dd-mm-yyyy'), '6', '7', '10', '4', '2013', '0');
insert into WORKB_TIME_CHAR (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values ('646', to_date('07-10-2013', 'dd-mm-yyyy'), '7', '1', '10', '4', '2013', '0');
insert into WORKB_TIME_CHAR (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values ('647', to_date('08-10-2013', 'dd-mm-yyyy'), '8', '2', '10', '4', '2013', '0');
insert into WORKB_TIME_CHAR (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values ('648', to_date('09-10-2013', 'dd-mm-yyyy'), '9', '3', '10', '4', '2013', '0');
insert into WORKB_TIME_CHAR (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values ('649', to_date('10-10-2013', 'dd-mm-yyyy'), '10', '4', '10', '4', '2013', '0');
insert into WORKB_TIME_CHAR (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values ('650', to_date('11-10-2013', 'dd-mm-yyyy'), '11', '5', '10', '4', '2013', '0');
insert into WORKB_TIME_CHAR (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values ('651', to_date('12-10-2013', 'dd-mm-yyyy'), '12', '6', '10', '4', '2013', '0');
insert into WORKB_TIME_CHAR (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values ('652', to_date('13-10-2013', 'dd-mm-yyyy'), '13', '7', '10', '4', '2013', '0');
insert into WORKB_TIME_CHAR (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values ('653', to_date('14-10-2013', 'dd-mm-yyyy'), '14', '1', '10', '4', '2013', '0');
insert into WORKB_TIME_CHAR (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values ('654', to_date('15-10-2013', 'dd-mm-yyyy'), '15', '2', '10', '4', '2013', '0');
insert into WORKB_TIME_CHAR (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values ('655', to_date('16-10-2013', 'dd-mm-yyyy'), '16', '3', '10', '4', '2013', '0');
insert into WORKB_TIME_CHAR (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values ('656', to_date('17-10-2013', 'dd-mm-yyyy'), '17', '4', '10', '4', '2013', '0');
insert into WORKB_TIME_CHAR (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values ('657', to_date('18-10-2013', 'dd-mm-yyyy'), '18', '5', '10', '4', '2013', '0');
commit;
-- 400 records committed...
insert into WORKB_TIME_CHAR (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values ('658', to_date('19-10-2013', 'dd-mm-yyyy'), '19', '6', '10', '4', '2013', '0');
insert into WORKB_TIME_CHAR (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values ('659', to_date('20-10-2013', 'dd-mm-yyyy'), '20', '7', '10', '4', '2013', '0');
insert into WORKB_TIME_CHAR (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values ('660', to_date('21-10-2013', 'dd-mm-yyyy'), '21', '1', '10', '4', '2013', '0');
insert into WORKB_TIME_CHAR (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values ('661', to_date('22-10-2013', 'dd-mm-yyyy'), '22', '2', '10', '4', '2013', '0');
insert into WORKB_TIME_CHAR (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values ('662', to_date('23-10-2013', 'dd-mm-yyyy'), '23', '3', '10', '4', '2013', '0');
insert into WORKB_TIME_CHAR (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values ('663', to_date('24-10-2013', 'dd-mm-yyyy'), '24', '4', '10', '4', '2013', '0');
insert into WORKB_TIME_CHAR (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values ('664', to_date('25-10-2013', 'dd-mm-yyyy'), '25', '5', '10', '4', '2013', '0');
insert into WORKB_TIME_CHAR (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values ('665', to_date('26-10-2013', 'dd-mm-yyyy'), '26', '6', '10', '4', '2013', '0');
insert into WORKB_TIME_CHAR (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values ('666', to_date('27-10-2013', 'dd-mm-yyyy'), '27', '7', '10', '4', '2013', '0');
insert into WORKB_TIME_CHAR (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values ('667', to_date('28-10-2013', 'dd-mm-yyyy'), '28', '1', '10', '4', '2013', '0');
insert into WORKB_TIME_CHAR (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values ('668', to_date('29-10-2013', 'dd-mm-yyyy'), '29', '2', '10', '4', '2013', '0');
insert into WORKB_TIME_CHAR (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values ('669', to_date('30-10-2013', 'dd-mm-yyyy'), '30', '3', '10', '4', '2013', '0');
insert into WORKB_TIME_CHAR (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values ('670', to_date('31-10-2013', 'dd-mm-yyyy'), '31', '4', '10', '4', '2013', '0');
insert into WORKB_TIME_CHAR (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values ('671', to_date('01-11-2013', 'dd-mm-yyyy'), '1', '5', '11', '4', '2013', '0');
insert into WORKB_TIME_CHAR (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values ('672', to_date('02-11-2013', 'dd-mm-yyyy'), '2', '6', '11', '4', '2013', '0');
insert into WORKB_TIME_CHAR (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values ('673', to_date('03-11-2013', 'dd-mm-yyyy'), '3', '7', '11', '4', '2013', '0');
insert into WORKB_TIME_CHAR (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values ('674', to_date('04-11-2013', 'dd-mm-yyyy'), '4', '1', '11', '4', '2013', '0');
insert into WORKB_TIME_CHAR (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values ('675', to_date('05-11-2013', 'dd-mm-yyyy'), '5', '2', '11', '4', '2013', '0');
insert into WORKB_TIME_CHAR (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values ('676', to_date('06-11-2013', 'dd-mm-yyyy'), '6', '3', '11', '4', '2013', '0');
insert into WORKB_TIME_CHAR (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values ('677', to_date('07-11-2013', 'dd-mm-yyyy'), '7', '4', '11', '4', '2013', '0');
insert into WORKB_TIME_CHAR (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values ('678', to_date('08-11-2013', 'dd-mm-yyyy'), '8', '5', '11', '4', '2013', '0');
insert into WORKB_TIME_CHAR (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values ('679', to_date('09-11-2013', 'dd-mm-yyyy'), '9', '6', '11', '4', '2013', '0');
insert into WORKB_TIME_CHAR (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values ('680', to_date('10-11-2013', 'dd-mm-yyyy'), '10', '7', '11', '4', '2013', '0');
insert into WORKB_TIME_CHAR (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values ('681', to_date('11-11-2013', 'dd-mm-yyyy'), '11', '1', '11', '4', '2013', '0');
insert into WORKB_TIME_CHAR (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values ('682', to_date('12-11-2013', 'dd-mm-yyyy'), '12', '2', '11', '4', '2013', '0');
insert into WORKB_TIME_CHAR (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values ('683', to_date('13-11-2013', 'dd-mm-yyyy'), '13', '3', '11', '4', '2013', '0');
insert into WORKB_TIME_CHAR (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values ('684', to_date('14-11-2013', 'dd-mm-yyyy'), '14', '4', '11', '4', '2013', '0');
insert into WORKB_TIME_CHAR (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values ('685', to_date('15-11-2013', 'dd-mm-yyyy'), '15', '5', '11', '4', '2013', '0');
insert into WORKB_TIME_CHAR (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values ('686', to_date('16-11-2013', 'dd-mm-yyyy'), '16', '6', '11', '4', '2013', '0');
insert into WORKB_TIME_CHAR (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values ('687', to_date('17-11-2013', 'dd-mm-yyyy'), '17', '7', '11', '4', '2013', '0');
insert into WORKB_TIME_CHAR (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values ('688', to_date('18-11-2013', 'dd-mm-yyyy'), '18', '1', '11', '4', '2013', '0');
insert into WORKB_TIME_CHAR (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values ('689', to_date('19-11-2013', 'dd-mm-yyyy'), '19', '2', '11', '4', '2013', '0');
insert into WORKB_TIME_CHAR (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values ('690', to_date('20-11-2013', 'dd-mm-yyyy'), '20', '3', '11', '4', '2013', '0');
insert into WORKB_TIME_CHAR (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values ('691', to_date('21-11-2013', 'dd-mm-yyyy'), '21', '4', '11', '4', '2013', '0');
insert into WORKB_TIME_CHAR (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values ('692', to_date('22-11-2013', 'dd-mm-yyyy'), '22', '5', '11', '4', '2013', '0');
insert into WORKB_TIME_CHAR (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values ('693', to_date('23-11-2013', 'dd-mm-yyyy'), '23', '6', '11', '4', '2013', '0');
insert into WORKB_TIME_CHAR (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values ('694', to_date('24-11-2013', 'dd-mm-yyyy'), '24', '7', '11', '4', '2013', '0');
insert into WORKB_TIME_CHAR (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values ('695', to_date('25-11-2013', 'dd-mm-yyyy'), '25', '1', '11', '4', '2013', '0');
insert into WORKB_TIME_CHAR (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values ('696', to_date('26-11-2013', 'dd-mm-yyyy'), '26', '2', '11', '4', '2013', '0');
insert into WORKB_TIME_CHAR (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values ('697', to_date('27-11-2013', 'dd-mm-yyyy'), '27', '3', '11', '4', '2013', '0');
insert into WORKB_TIME_CHAR (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values ('698', to_date('28-11-2013', 'dd-mm-yyyy'), '28', '4', '11', '4', '2013', '0');
insert into WORKB_TIME_CHAR (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values ('699', to_date('29-11-2013', 'dd-mm-yyyy'), '29', '5', '11', '4', '2013', '0');
insert into WORKB_TIME_CHAR (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values ('700', to_date('30-11-2013', 'dd-mm-yyyy'), '30', '6', '11', '4', '2013', '0');
insert into WORKB_TIME_CHAR (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values ('701', to_date('01-12-2013', 'dd-mm-yyyy'), '1', '7', '12', '4', '2013', '0');
insert into WORKB_TIME_CHAR (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values ('702', to_date('02-12-2013', 'dd-mm-yyyy'), '2', '1', '12', '4', '2013', '0');
insert into WORKB_TIME_CHAR (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values ('703', to_date('03-12-2013', 'dd-mm-yyyy'), '3', '2', '12', '4', '2013', '0');
insert into WORKB_TIME_CHAR (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values ('704', to_date('04-12-2013', 'dd-mm-yyyy'), '4', '3', '12', '4', '2013', '0');
insert into WORKB_TIME_CHAR (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values ('705', to_date('05-12-2013', 'dd-mm-yyyy'), '5', '4', '12', '4', '2013', '0');
insert into WORKB_TIME_CHAR (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values ('706', to_date('06-12-2013', 'dd-mm-yyyy'), '6', '5', '12', '4', '2013', '0');
insert into WORKB_TIME_CHAR (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values ('707', to_date('07-12-2013', 'dd-mm-yyyy'), '7', '6', '12', '4', '2013', '0');
insert into WORKB_TIME_CHAR (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values ('708', to_date('08-12-2013', 'dd-mm-yyyy'), '8', '7', '12', '4', '2013', '0');
insert into WORKB_TIME_CHAR (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values ('709', to_date('09-12-2013', 'dd-mm-yyyy'), '9', '1', '12', '4', '2013', '0');
insert into WORKB_TIME_CHAR (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values ('710', to_date('10-12-2013', 'dd-mm-yyyy'), '10', '2', '12', '4', '2013', '0');
insert into WORKB_TIME_CHAR (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values ('711', to_date('11-12-2013', 'dd-mm-yyyy'), '11', '3', '12', '4', '2013', '0');
insert into WORKB_TIME_CHAR (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values ('712', to_date('12-12-2013', 'dd-mm-yyyy'), '12', '4', '12', '4', '2013', '0');
insert into WORKB_TIME_CHAR (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values ('713', to_date('13-12-2013', 'dd-mm-yyyy'), '13', '5', '12', '4', '2013', '0');
insert into WORKB_TIME_CHAR (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values ('714', to_date('14-12-2013', 'dd-mm-yyyy'), '14', '6', '12', '4', '2013', '0');
insert into WORKB_TIME_CHAR (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values ('715', to_date('15-12-2013', 'dd-mm-yyyy'), '15', '7', '12', '4', '2013', '0');
insert into WORKB_TIME_CHAR (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values ('716', to_date('16-12-2013', 'dd-mm-yyyy'), '16', '1', '12', '4', '2013', '0');
insert into WORKB_TIME_CHAR (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values ('717', to_date('17-12-2013', 'dd-mm-yyyy'), '17', '2', '12', '4', '2013', '0');
insert into WORKB_TIME_CHAR (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values ('718', to_date('18-12-2013', 'dd-mm-yyyy'), '18', '3', '12', '4', '2013', '0');
insert into WORKB_TIME_CHAR (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values ('719', to_date('19-12-2013', 'dd-mm-yyyy'), '19', '4', '12', '4', '2013', '0');
insert into WORKB_TIME_CHAR (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values ('720', to_date('20-12-2013', 'dd-mm-yyyy'), '20', '5', '12', '4', '2013', '0');
insert into WORKB_TIME_CHAR (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values ('721', to_date('21-12-2013', 'dd-mm-yyyy'), '21', '6', '12', '4', '2013', '0');
insert into WORKB_TIME_CHAR (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values ('722', to_date('22-12-2013', 'dd-mm-yyyy'), '22', '7', '12', '4', '2013', '0');
insert into WORKB_TIME_CHAR (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values ('723', to_date('23-12-2013', 'dd-mm-yyyy'), '23', '1', '12', '4', '2013', '0');
insert into WORKB_TIME_CHAR (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values ('724', to_date('24-12-2013', 'dd-mm-yyyy'), '24', '2', '12', '4', '2013', '0');
insert into WORKB_TIME_CHAR (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values ('725', to_date('25-12-2013', 'dd-mm-yyyy'), '25', '3', '12', '4', '2013', '0');
insert into WORKB_TIME_CHAR (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values ('726', to_date('26-12-2013', 'dd-mm-yyyy'), '26', '4', '12', '4', '2013', '0');
insert into WORKB_TIME_CHAR (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values ('727', to_date('27-12-2013', 'dd-mm-yyyy'), '27', '5', '12', '4', '2013', '0');
insert into WORKB_TIME_CHAR (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values ('728', to_date('28-12-2013', 'dd-mm-yyyy'), '28', '6', '12', '4', '2013', '0');
insert into WORKB_TIME_CHAR (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values ('729', to_date('29-12-2013', 'dd-mm-yyyy'), '29', '7', '12', '4', '2013', '0');
insert into WORKB_TIME_CHAR (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values ('730', to_date('30-12-2013', 'dd-mm-yyyy'), '30', '1', '12', '4', '2013', '0');
insert into WORKB_TIME_CHAR (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values ('731', to_date('31-12-2013', 'dd-mm-yyyy'), '31', '2', '12', '4', '2013', '0');
insert into WORKB_TIME_CHAR (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values ('39', to_date('08-02-2012', 'dd-mm-yyyy'), '8', '3', '2', '1', '2012', '0');
insert into WORKB_TIME_CHAR (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values ('40', to_date('09-02-2012', 'dd-mm-yyyy'), '9', '4', '2', '1', '2012', '0');
insert into WORKB_TIME_CHAR (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values ('41', to_date('10-02-2012', 'dd-mm-yyyy'), '10', '5', '2', '1', '2012', '0');
insert into WORKB_TIME_CHAR (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values ('42', to_date('11-02-2012', 'dd-mm-yyyy'), '11', '6', '2', '1', '2012', '1');
insert into WORKB_TIME_CHAR (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values ('43', to_date('12-02-2012', 'dd-mm-yyyy'), '12', '7', '2', '1', '2012', '1');
insert into WORKB_TIME_CHAR (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values ('44', to_date('13-02-2012', 'dd-mm-yyyy'), '13', '1', '2', '1', '2012', '0');
insert into WORKB_TIME_CHAR (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values ('45', to_date('14-02-2012', 'dd-mm-yyyy'), '14', '2', '2', '1', '2012', '0');
insert into WORKB_TIME_CHAR (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values ('46', to_date('15-02-2012', 'dd-mm-yyyy'), '15', '3', '2', '1', '2012', '0');
insert into WORKB_TIME_CHAR (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values ('47', to_date('16-02-2012', 'dd-mm-yyyy'), '16', '4', '2', '1', '2012', '0');
insert into WORKB_TIME_CHAR (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values ('48', to_date('17-02-2012', 'dd-mm-yyyy'), '17', '5', '2', '1', '2012', '0');
insert into WORKB_TIME_CHAR (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values ('49', to_date('18-02-2012', 'dd-mm-yyyy'), '18', '6', '2', '1', '2012', '1');
insert into WORKB_TIME_CHAR (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values ('50', to_date('19-02-2012', 'dd-mm-yyyy'), '19', '7', '2', '1', '2012', '1');
insert into WORKB_TIME_CHAR (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values ('51', to_date('20-02-2012', 'dd-mm-yyyy'), '20', '1', '2', '1', '2012', '0');
insert into WORKB_TIME_CHAR (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values ('52', to_date('21-02-2012', 'dd-mm-yyyy'), '21', '2', '2', '1', '2012', '0');
insert into WORKB_TIME_CHAR (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values ('53', to_date('22-02-2012', 'dd-mm-yyyy'), '22', '3', '2', '1', '2012', '0');
insert into WORKB_TIME_CHAR (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values ('54', to_date('23-02-2012', 'dd-mm-yyyy'), '23', '4', '2', '1', '2012', '0');
insert into WORKB_TIME_CHAR (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values ('55', to_date('24-02-2012', 'dd-mm-yyyy'), '24', '5', '2', '1', '2012', '0');
insert into WORKB_TIME_CHAR (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values ('56', to_date('25-02-2012', 'dd-mm-yyyy'), '25', '6', '2', '1', '2012', '1');
insert into WORKB_TIME_CHAR (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values ('57', to_date('26-02-2012', 'dd-mm-yyyy'), '26', '7', '2', '1', '2012', '1');
insert into WORKB_TIME_CHAR (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values ('58', to_date('27-02-2012', 'dd-mm-yyyy'), '27', '1', '2', '1', '2012', '0');
insert into WORKB_TIME_CHAR (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values ('59', to_date('28-02-2012', 'dd-mm-yyyy'), '28', '2', '2', '1', '2012', '0');
insert into WORKB_TIME_CHAR (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values ('60', to_date('29-02-2012', 'dd-mm-yyyy'), '29', '3', '2', '1', '2012', '0');
insert into WORKB_TIME_CHAR (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values ('61', to_date('01-03-2012', 'dd-mm-yyyy'), '1', '4', '3', '1', '2012', '0');
insert into WORKB_TIME_CHAR (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values ('62', to_date('02-03-2012', 'dd-mm-yyyy'), '2', '5', '3', '1', '2012', '0');
insert into WORKB_TIME_CHAR (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values ('63', to_date('03-03-2012', 'dd-mm-yyyy'), '3', '6', '3', '1', '2012', '1');
insert into WORKB_TIME_CHAR (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values ('64', to_date('04-03-2012', 'dd-mm-yyyy'), '4', '7', '3', '1', '2012', '1');
commit;
-- 500 records committed...
insert into WORKB_TIME_CHAR (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values ('65', to_date('05-03-2012', 'dd-mm-yyyy'), '5', '1', '3', '1', '2012', '0');
insert into WORKB_TIME_CHAR (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values ('66', to_date('06-03-2012', 'dd-mm-yyyy'), '6', '2', '3', '1', '2012', '0');
insert into WORKB_TIME_CHAR (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values ('67', to_date('07-03-2012', 'dd-mm-yyyy'), '7', '3', '3', '1', '2012', '0');
insert into WORKB_TIME_CHAR (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values ('68', to_date('08-03-2012', 'dd-mm-yyyy'), '8', '4', '3', '1', '2012', '0');
insert into WORKB_TIME_CHAR (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values ('69', to_date('09-03-2012', 'dd-mm-yyyy'), '9', '5', '3', '1', '2012', '0');
insert into WORKB_TIME_CHAR (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values ('70', to_date('10-03-2012', 'dd-mm-yyyy'), '10', '6', '3', '1', '2012', '1');
insert into WORKB_TIME_CHAR (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values ('71', to_date('11-03-2012', 'dd-mm-yyyy'), '11', '7', '3', '1', '2012', '1');
insert into WORKB_TIME_CHAR (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values ('72', to_date('12-03-2012', 'dd-mm-yyyy'), '12', '1', '3', '1', '2012', '0');
insert into WORKB_TIME_CHAR (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values ('73', to_date('13-03-2012', 'dd-mm-yyyy'), '13', '2', '3', '1', '2012', '0');
insert into WORKB_TIME_CHAR (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values ('74', to_date('14-03-2012', 'dd-mm-yyyy'), '14', '3', '3', '1', '2012', '0');
insert into WORKB_TIME_CHAR (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values ('75', to_date('15-03-2012', 'dd-mm-yyyy'), '15', '4', '3', '1', '2012', '0');
insert into WORKB_TIME_CHAR (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values ('76', to_date('16-03-2012', 'dd-mm-yyyy'), '16', '5', '3', '1', '2012', '0');
insert into WORKB_TIME_CHAR (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values ('77', to_date('17-03-2012', 'dd-mm-yyyy'), '17', '6', '3', '1', '2012', '1');
insert into WORKB_TIME_CHAR (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values ('78', to_date('18-03-2012', 'dd-mm-yyyy'), '18', '7', '3', '1', '2012', '1');
insert into WORKB_TIME_CHAR (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values ('79', to_date('19-03-2012', 'dd-mm-yyyy'), '19', '1', '3', '1', '2012', '0');
insert into WORKB_TIME_CHAR (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values ('80', to_date('20-03-2012', 'dd-mm-yyyy'), '20', '2', '3', '1', '2012', '0');
insert into WORKB_TIME_CHAR (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values ('81', to_date('21-03-2012', 'dd-mm-yyyy'), '21', '3', '3', '1', '2012', '0');
insert into WORKB_TIME_CHAR (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values ('82', to_date('22-03-2012', 'dd-mm-yyyy'), '22', '4', '3', '1', '2012', '0');
insert into WORKB_TIME_CHAR (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values ('83', to_date('23-03-2012', 'dd-mm-yyyy'), '23', '5', '3', '1', '2012', '0');
insert into WORKB_TIME_CHAR (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values ('84', to_date('24-03-2012', 'dd-mm-yyyy'), '24', '6', '3', '1', '2012', '1');
insert into WORKB_TIME_CHAR (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values ('85', to_date('25-03-2012', 'dd-mm-yyyy'), '25', '7', '3', '1', '2012', '1');
insert into WORKB_TIME_CHAR (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values ('86', to_date('26-03-2012', 'dd-mm-yyyy'), '26', '1', '3', '1', '2012', '0');
insert into WORKB_TIME_CHAR (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values ('87', to_date('27-03-2012', 'dd-mm-yyyy'), '27', '2', '3', '1', '2012', '0');
insert into WORKB_TIME_CHAR (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values ('88', to_date('28-03-2012', 'dd-mm-yyyy'), '28', '3', '3', '1', '2012', '0');
insert into WORKB_TIME_CHAR (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values ('89', to_date('29-03-2012', 'dd-mm-yyyy'), '29', '4', '3', '1', '2012', '0');
insert into WORKB_TIME_CHAR (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values ('90', to_date('30-03-2012', 'dd-mm-yyyy'), '30', '5', '3', '1', '2012', '0');
insert into WORKB_TIME_CHAR (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values ('91', to_date('31-03-2012', 'dd-mm-yyyy'), '31', '6', '3', '1', '2012', '1');
insert into WORKB_TIME_CHAR (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values ('92', to_date('01-04-2012', 'dd-mm-yyyy'), '1', '7', '4', '2', '2012', '1');
insert into WORKB_TIME_CHAR (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values ('93', to_date('02-04-2012', 'dd-mm-yyyy'), '2', '1', '4', '2', '2012', '0');
insert into WORKB_TIME_CHAR (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values ('94', to_date('03-04-2012', 'dd-mm-yyyy'), '3', '2', '4', '2', '2012', '0');
insert into WORKB_TIME_CHAR (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values ('95', to_date('04-04-2012', 'dd-mm-yyyy'), '4', '3', '4', '2', '2012', '0');
insert into WORKB_TIME_CHAR (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values ('96', to_date('05-04-2012', 'dd-mm-yyyy'), '5', '4', '4', '2', '2012', '0');
insert into WORKB_TIME_CHAR (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values ('97', to_date('06-04-2012', 'dd-mm-yyyy'), '6', '5', '4', '2', '2012', '0');
insert into WORKB_TIME_CHAR (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values ('98', to_date('07-04-2012', 'dd-mm-yyyy'), '7', '6', '4', '2', '2012', '1');
insert into WORKB_TIME_CHAR (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values ('99', to_date('08-04-2012', 'dd-mm-yyyy'), '8', '7', '4', '2', '2012', '1');
insert into WORKB_TIME_CHAR (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values ('100', to_date('09-04-2012', 'dd-mm-yyyy'), '9', '1', '4', '2', '2012', '0');
insert into WORKB_TIME_CHAR (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values ('101', to_date('10-04-2012', 'dd-mm-yyyy'), '10', '2', '4', '2', '2012', '0');
insert into WORKB_TIME_CHAR (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values ('102', to_date('11-04-2012', 'dd-mm-yyyy'), '11', '3', '4', '2', '2012', '0');
insert into WORKB_TIME_CHAR (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values ('103', to_date('12-04-2012', 'dd-mm-yyyy'), '12', '4', '4', '2', '2012', '0');
insert into WORKB_TIME_CHAR (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values ('104', to_date('13-04-2012', 'dd-mm-yyyy'), '13', '5', '4', '2', '2012', '0');
insert into WORKB_TIME_CHAR (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values ('105', to_date('14-04-2012', 'dd-mm-yyyy'), '14', '6', '4', '2', '2012', '1');
insert into WORKB_TIME_CHAR (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values ('106', to_date('15-04-2012', 'dd-mm-yyyy'), '15', '7', '4', '2', '2012', '1');
insert into WORKB_TIME_CHAR (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values ('107', to_date('16-04-2012', 'dd-mm-yyyy'), '16', '1', '4', '2', '2012', '0');
insert into WORKB_TIME_CHAR (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values ('108', to_date('17-04-2012', 'dd-mm-yyyy'), '17', '2', '4', '2', '2012', '0');
insert into WORKB_TIME_CHAR (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values ('109', to_date('18-04-2012', 'dd-mm-yyyy'), '18', '3', '4', '2', '2012', '0');
insert into WORKB_TIME_CHAR (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values ('110', to_date('19-04-2012', 'dd-mm-yyyy'), '19', '4', '4', '2', '2012', '0');
insert into WORKB_TIME_CHAR (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values ('111', to_date('20-04-2012', 'dd-mm-yyyy'), '20', '5', '4', '2', '2012', '0');
insert into WORKB_TIME_CHAR (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values ('112', to_date('21-04-2012', 'dd-mm-yyyy'), '21', '6', '4', '2', '2012', '1');
insert into WORKB_TIME_CHAR (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values ('113', to_date('22-04-2012', 'dd-mm-yyyy'), '22', '7', '4', '2', '2012', '1');
insert into WORKB_TIME_CHAR (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values ('114', to_date('23-04-2012', 'dd-mm-yyyy'), '23', '1', '4', '2', '2012', '0');
insert into WORKB_TIME_CHAR (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values ('115', to_date('24-04-2012', 'dd-mm-yyyy'), '24', '2', '4', '2', '2012', '0');
insert into WORKB_TIME_CHAR (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values ('116', to_date('25-04-2012', 'dd-mm-yyyy'), '25', '3', '4', '2', '2012', '0');
insert into WORKB_TIME_CHAR (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values ('117', to_date('26-04-2012', 'dd-mm-yyyy'), '26', '4', '4', '2', '2012', '0');
insert into WORKB_TIME_CHAR (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values ('118', to_date('27-04-2012', 'dd-mm-yyyy'), '27', '5', '4', '2', '2012', '0');
insert into WORKB_TIME_CHAR (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values ('119', to_date('28-04-2012', 'dd-mm-yyyy'), '28', '6', '4', '2', '2012', '1');
insert into WORKB_TIME_CHAR (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values ('120', to_date('29-04-2012', 'dd-mm-yyyy'), '29', '7', '4', '2', '2012', '1');
insert into WORKB_TIME_CHAR (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values ('121', to_date('30-04-2012', 'dd-mm-yyyy'), '30', '1', '4', '2', '2012', '0');
insert into WORKB_TIME_CHAR (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values ('122', to_date('01-05-2012', 'dd-mm-yyyy'), '1', '2', '5', '2', '2012', '0');
insert into WORKB_TIME_CHAR (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values ('123', to_date('02-05-2012', 'dd-mm-yyyy'), '2', '3', '5', '2', '2012', '0');
insert into WORKB_TIME_CHAR (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values ('124', to_date('03-05-2012', 'dd-mm-yyyy'), '3', '4', '5', '2', '2012', '0');
insert into WORKB_TIME_CHAR (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values ('125', to_date('04-05-2012', 'dd-mm-yyyy'), '4', '5', '5', '2', '2012', '0');
insert into WORKB_TIME_CHAR (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values ('126', to_date('05-05-2012', 'dd-mm-yyyy'), '5', '6', '5', '2', '2012', '1');
insert into WORKB_TIME_CHAR (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values ('127', to_date('06-05-2012', 'dd-mm-yyyy'), '6', '7', '5', '2', '2012', '1');
insert into WORKB_TIME_CHAR (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values ('128', to_date('07-05-2012', 'dd-mm-yyyy'), '7', '1', '5', '2', '2012', '0');
insert into WORKB_TIME_CHAR (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values ('129', to_date('08-05-2012', 'dd-mm-yyyy'), '8', '2', '5', '2', '2012', '0');
insert into WORKB_TIME_CHAR (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values ('130', to_date('09-05-2012', 'dd-mm-yyyy'), '9', '3', '5', '2', '2012', '1');
insert into WORKB_TIME_CHAR (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values ('131', to_date('10-05-2012', 'dd-mm-yyyy'), '10', '4', '5', '2', '2012', '0');
insert into WORKB_TIME_CHAR (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values ('132', to_date('11-05-2012', 'dd-mm-yyyy'), '11', '5', '5', '2', '2012', '0');
insert into WORKB_TIME_CHAR (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values ('133', to_date('12-05-2012', 'dd-mm-yyyy'), '12', '6', '5', '2', '2012', '1');
insert into WORKB_TIME_CHAR (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values ('134', to_date('13-05-2012', 'dd-mm-yyyy'), '13', '7', '5', '2', '2012', '1');
insert into WORKB_TIME_CHAR (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values ('135', to_date('14-05-2012', 'dd-mm-yyyy'), '14', '1', '5', '2', '2012', '0');
insert into WORKB_TIME_CHAR (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values ('136', to_date('15-05-2012', 'dd-mm-yyyy'), '15', '2', '5', '2', '2012', '0');
insert into WORKB_TIME_CHAR (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values ('137', to_date('16-05-2012', 'dd-mm-yyyy'), '16', '3', '5', '2', '2012', '0');
insert into WORKB_TIME_CHAR (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values ('138', to_date('17-05-2012', 'dd-mm-yyyy'), '17', '4', '5', '2', '2012', '0');
insert into WORKB_TIME_CHAR (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values ('139', to_date('18-05-2012', 'dd-mm-yyyy'), '18', '5', '5', '2', '2012', '0');
insert into WORKB_TIME_CHAR (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values ('140', to_date('19-05-2012', 'dd-mm-yyyy'), '19', '6', '5', '2', '2012', '1');
insert into WORKB_TIME_CHAR (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values ('141', to_date('20-05-2012', 'dd-mm-yyyy'), '20', '7', '5', '2', '2012', '1');
insert into WORKB_TIME_CHAR (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values ('142', to_date('21-05-2012', 'dd-mm-yyyy'), '21', '1', '5', '2', '2012', '0');
insert into WORKB_TIME_CHAR (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values ('143', to_date('22-05-2012', 'dd-mm-yyyy'), '22', '2', '5', '2', '2012', '0');
insert into WORKB_TIME_CHAR (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values ('144', to_date('23-05-2012', 'dd-mm-yyyy'), '23', '3', '5', '2', '2012', '0');
insert into WORKB_TIME_CHAR (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values ('145', to_date('24-05-2012', 'dd-mm-yyyy'), '24', '4', '5', '2', '2012', '0');
insert into WORKB_TIME_CHAR (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values ('146', to_date('25-05-2012', 'dd-mm-yyyy'), '25', '5', '5', '2', '2012', '0');
insert into WORKB_TIME_CHAR (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values ('147', to_date('26-05-2012', 'dd-mm-yyyy'), '26', '6', '5', '2', '2012', '1');
insert into WORKB_TIME_CHAR (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values ('148', to_date('27-05-2012', 'dd-mm-yyyy'), '27', '7', '5', '2', '2012', '1');
insert into WORKB_TIME_CHAR (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values ('149', to_date('28-05-2012', 'dd-mm-yyyy'), '28', '1', '5', '2', '2012', '0');
insert into WORKB_TIME_CHAR (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values ('150', to_date('29-05-2012', 'dd-mm-yyyy'), '29', '2', '5', '2', '2012', '0');
insert into WORKB_TIME_CHAR (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values ('151', to_date('30-05-2012', 'dd-mm-yyyy'), '30', '3', '5', '2', '2012', '0');
insert into WORKB_TIME_CHAR (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values ('152', to_date('31-05-2012', 'dd-mm-yyyy'), '31', '4', '5', '2', '2012', '0');
insert into WORKB_TIME_CHAR (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values ('153', to_date('01-06-2012', 'dd-mm-yyyy'), '1', '5', '6', '2', '2012', '0');
insert into WORKB_TIME_CHAR (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values ('154', to_date('02-06-2012', 'dd-mm-yyyy'), '2', '6', '6', '2', '2012', '1');
insert into WORKB_TIME_CHAR (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values ('155', to_date('03-06-2012', 'dd-mm-yyyy'), '3', '7', '6', '2', '2012', '1');
insert into WORKB_TIME_CHAR (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values ('156', to_date('04-06-2012', 'dd-mm-yyyy'), '4', '1', '6', '2', '2012', '0');
insert into WORKB_TIME_CHAR (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values ('157', to_date('05-06-2012', 'dd-mm-yyyy'), '5', '2', '6', '2', '2012', '0');
insert into WORKB_TIME_CHAR (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values ('158', to_date('06-06-2012', 'dd-mm-yyyy'), '6', '3', '6', '2', '2012', '0');
insert into WORKB_TIME_CHAR (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values ('159', to_date('07-06-2012', 'dd-mm-yyyy'), '7', '4', '6', '2', '2012', '0');
insert into WORKB_TIME_CHAR (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values ('160', to_date('08-06-2012', 'dd-mm-yyyy'), '8', '5', '6', '2', '2012', '0');
insert into WORKB_TIME_CHAR (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values ('161', to_date('09-06-2012', 'dd-mm-yyyy'), '9', '6', '6', '2', '2012', '1');
insert into WORKB_TIME_CHAR (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values ('162', to_date('10-06-2012', 'dd-mm-yyyy'), '10', '7', '6', '2', '2012', '1');
insert into WORKB_TIME_CHAR (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values ('163', to_date('11-06-2012', 'dd-mm-yyyy'), '11', '1', '6', '2', '2012', '0');
insert into WORKB_TIME_CHAR (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values ('164', to_date('12-06-2012', 'dd-mm-yyyy'), '12', '2', '6', '2', '2012', '0');
commit;
-- 600 records committed...
insert into WORKB_TIME_CHAR (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values ('165', to_date('13-06-2012', 'dd-mm-yyyy'), '13', '3', '6', '2', '2012', '0');
insert into WORKB_TIME_CHAR (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values ('166', to_date('14-06-2012', 'dd-mm-yyyy'), '14', '4', '6', '2', '2012', '0');
insert into WORKB_TIME_CHAR (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values ('167', to_date('15-06-2012', 'dd-mm-yyyy'), '15', '5', '6', '2', '2012', '0');
insert into WORKB_TIME_CHAR (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values ('168', to_date('16-06-2012', 'dd-mm-yyyy'), '16', '6', '6', '2', '2012', '1');
insert into WORKB_TIME_CHAR (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values ('169', to_date('17-06-2012', 'dd-mm-yyyy'), '17', '7', '6', '2', '2012', '1');
insert into WORKB_TIME_CHAR (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values ('170', to_date('18-06-2012', 'dd-mm-yyyy'), '18', '1', '6', '2', '2012', '0');
insert into WORKB_TIME_CHAR (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values ('171', to_date('19-06-2012', 'dd-mm-yyyy'), '19', '2', '6', '2', '2012', '0');
insert into WORKB_TIME_CHAR (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values ('172', to_date('20-06-2012', 'dd-mm-yyyy'), '20', '3', '6', '2', '2012', '0');
insert into WORKB_TIME_CHAR (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values ('173', to_date('21-06-2012', 'dd-mm-yyyy'), '21', '4', '6', '2', '2012', '0');
insert into WORKB_TIME_CHAR (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values ('174', to_date('22-06-2012', 'dd-mm-yyyy'), '22', '5', '6', '2', '2012', '0');
insert into WORKB_TIME_CHAR (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values ('175', to_date('23-06-2012', 'dd-mm-yyyy'), '23', '6', '6', '2', '2012', '1');
insert into WORKB_TIME_CHAR (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values ('176', to_date('24-06-2012', 'dd-mm-yyyy'), '24', '7', '6', '2', '2012', '1');
insert into WORKB_TIME_CHAR (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values ('177', to_date('25-06-2012', 'dd-mm-yyyy'), '25', '1', '6', '2', '2012', '0');
insert into WORKB_TIME_CHAR (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values ('178', to_date('26-06-2012', 'dd-mm-yyyy'), '26', '2', '6', '2', '2012', '0');
insert into WORKB_TIME_CHAR (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values ('179', to_date('27-06-2012', 'dd-mm-yyyy'), '27', '3', '6', '2', '2012', '0');
insert into WORKB_TIME_CHAR (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values ('180', to_date('28-06-2012', 'dd-mm-yyyy'), '28', '4', '6', '2', '2012', '1');
insert into WORKB_TIME_CHAR (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values ('181', to_date('29-06-2012', 'dd-mm-yyyy'), '29', '5', '6', '2', '2012', '0');
insert into WORKB_TIME_CHAR (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values ('182', to_date('30-06-2012', 'dd-mm-yyyy'), '30', '6', '6', '2', '2012', '1');
insert into WORKB_TIME_CHAR (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values ('183', to_date('01-07-2012', 'dd-mm-yyyy'), '1', '7', '7', '3', '2012', '1');
insert into WORKB_TIME_CHAR (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values ('184', to_date('02-07-2012', 'dd-mm-yyyy'), '2', '1', '7', '3', '2012', '0');
insert into WORKB_TIME_CHAR (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values ('185', to_date('03-07-2012', 'dd-mm-yyyy'), '3', '2', '7', '3', '2012', '0');
insert into WORKB_TIME_CHAR (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values ('186', to_date('04-07-2012', 'dd-mm-yyyy'), '4', '3', '7', '3', '2012', '0');
insert into WORKB_TIME_CHAR (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values ('187', to_date('05-07-2012', 'dd-mm-yyyy'), '5', '4', '7', '3', '2012', '0');
insert into WORKB_TIME_CHAR (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values ('188', to_date('06-07-2012', 'dd-mm-yyyy'), '6', '5', '7', '3', '2012', '0');
insert into WORKB_TIME_CHAR (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values ('189', to_date('07-07-2012', 'dd-mm-yyyy'), '7', '6', '7', '3', '2012', '1');
insert into WORKB_TIME_CHAR (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values ('190', to_date('08-07-2012', 'dd-mm-yyyy'), '8', '7', '7', '3', '2012', '1');
insert into WORKB_TIME_CHAR (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values ('191', to_date('09-07-2012', 'dd-mm-yyyy'), '9', '1', '7', '3', '2012', '0');
insert into WORKB_TIME_CHAR (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values ('192', to_date('10-07-2012', 'dd-mm-yyyy'), '10', '2', '7', '3', '2012', '0');
insert into WORKB_TIME_CHAR (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values ('193', to_date('11-07-2012', 'dd-mm-yyyy'), '11', '3', '7', '3', '2012', '0');
insert into WORKB_TIME_CHAR (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values ('194', to_date('12-07-2012', 'dd-mm-yyyy'), '12', '4', '7', '3', '2012', '0');
insert into WORKB_TIME_CHAR (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values ('195', to_date('13-07-2012', 'dd-mm-yyyy'), '13', '5', '7', '3', '2012', '0');
insert into WORKB_TIME_CHAR (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values ('196', to_date('14-07-2012', 'dd-mm-yyyy'), '14', '6', '7', '3', '2012', '1');
insert into WORKB_TIME_CHAR (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values ('357', to_date('22-12-2012', 'dd-mm-yyyy'), '22', '6', '12', '4', '2012', '1');
insert into WORKB_TIME_CHAR (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values ('358', to_date('23-12-2012', 'dd-mm-yyyy'), '23', '7', '12', '4', '2012', '1');
insert into WORKB_TIME_CHAR (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values ('359', to_date('24-12-2012', 'dd-mm-yyyy'), '24', '1', '12', '4', '2012', '0');
insert into WORKB_TIME_CHAR (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values ('360', to_date('25-12-2012', 'dd-mm-yyyy'), '25', '2', '12', '4', '2012', '0');
insert into WORKB_TIME_CHAR (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values ('361', to_date('26-12-2012', 'dd-mm-yyyy'), '26', '3', '12', '4', '2012', '0');
insert into WORKB_TIME_CHAR (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values ('362', to_date('27-12-2012', 'dd-mm-yyyy'), '27', '4', '12', '4', '2012', '0');
insert into WORKB_TIME_CHAR (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values ('363', to_date('28-12-2012', 'dd-mm-yyyy'), '28', '5', '12', '4', '2012', '0');
insert into WORKB_TIME_CHAR (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values ('364', to_date('29-12-2012', 'dd-mm-yyyy'), '29', '6', '12', '4', '2012', '1');
insert into WORKB_TIME_CHAR (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values ('365', to_date('30-12-2012', 'dd-mm-yyyy'), '30', '7', '12', '4', '2012', '1');
insert into WORKB_TIME_CHAR (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values ('366', to_date('31-12-2012', 'dd-mm-yyyy'), '31', '1', '12', '4', '2012', '0');
insert into WORKB_TIME_CHAR (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values ('1', to_date('01-01-2012', 'dd-mm-yyyy'), '1', '7', '1', '1', '2012', '1');
insert into WORKB_TIME_CHAR (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values ('2', to_date('02-01-2012', 'dd-mm-yyyy'), '2', '1', '1', '1', '2012', '0');
insert into WORKB_TIME_CHAR (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values ('3', to_date('03-01-2012', 'dd-mm-yyyy'), '3', '2', '1', '1', '2012', '0');
insert into WORKB_TIME_CHAR (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values ('4', to_date('04-01-2012', 'dd-mm-yyyy'), '4', '3', '1', '1', '2012', '0');
insert into WORKB_TIME_CHAR (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values ('5', to_date('05-01-2012', 'dd-mm-yyyy'), '5', '4', '1', '1', '2012', '0');
insert into WORKB_TIME_CHAR (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values ('6', to_date('06-01-2012', 'dd-mm-yyyy'), '6', '5', '1', '1', '2012', '0');
insert into WORKB_TIME_CHAR (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values ('7', to_date('07-01-2012', 'dd-mm-yyyy'), '7', '6', '1', '1', '2012', '1');
insert into WORKB_TIME_CHAR (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values ('8', to_date('08-01-2012', 'dd-mm-yyyy'), '8', '7', '1', '1', '2012', '1');
insert into WORKB_TIME_CHAR (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values ('9', to_date('09-01-2012', 'dd-mm-yyyy'), '9', '1', '1', '1', '2012', '0');
insert into WORKB_TIME_CHAR (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values ('10', to_date('10-01-2012', 'dd-mm-yyyy'), '10', '2', '1', '1', '2012', '0');
insert into WORKB_TIME_CHAR (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values ('11', to_date('11-01-2012', 'dd-mm-yyyy'), '11', '3', '1', '1', '2012', '0');
insert into WORKB_TIME_CHAR (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values ('12', to_date('12-01-2012', 'dd-mm-yyyy'), '12', '4', '1', '1', '2012', '0');
insert into WORKB_TIME_CHAR (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values ('13', to_date('13-01-2012', 'dd-mm-yyyy'), '13', '5', '1', '1', '2012', '0');
insert into WORKB_TIME_CHAR (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values ('14', to_date('14-01-2012', 'dd-mm-yyyy'), '14', '6', '1', '1', '2012', '1');
insert into WORKB_TIME_CHAR (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values ('15', to_date('15-01-2012', 'dd-mm-yyyy'), '15', '7', '1', '1', '2012', '1');
insert into WORKB_TIME_CHAR (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values ('16', to_date('16-01-2012', 'dd-mm-yyyy'), '16', '1', '1', '1', '2012', '0');
insert into WORKB_TIME_CHAR (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values ('17', to_date('17-01-2012', 'dd-mm-yyyy'), '17', '2', '1', '1', '2012', '0');
insert into WORKB_TIME_CHAR (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values ('18', to_date('18-01-2012', 'dd-mm-yyyy'), '18', '3', '1', '1', '2012', '0');
insert into WORKB_TIME_CHAR (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values ('19', to_date('19-01-2012', 'dd-mm-yyyy'), '19', '4', '1', '1', '2012', '0');
insert into WORKB_TIME_CHAR (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values ('20', to_date('20-01-2012', 'dd-mm-yyyy'), '20', '5', '1', '1', '2012', '0');
insert into WORKB_TIME_CHAR (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values ('21', to_date('21-01-2012', 'dd-mm-yyyy'), '21', '6', '1', '1', '2012', '1');
insert into WORKB_TIME_CHAR (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values ('22', to_date('22-01-2012', 'dd-mm-yyyy'), '22', '7', '1', '1', '2012', '1');
insert into WORKB_TIME_CHAR (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values ('23', to_date('23-01-2012', 'dd-mm-yyyy'), '23', '1', '1', '1', '2012', '0');
insert into WORKB_TIME_CHAR (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values ('24', to_date('24-01-2012', 'dd-mm-yyyy'), '24', '2', '1', '1', '2012', '0');
insert into WORKB_TIME_CHAR (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values ('25', to_date('25-01-2012', 'dd-mm-yyyy'), '25', '3', '1', '1', '2012', '0');
insert into WORKB_TIME_CHAR (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values ('26', to_date('26-01-2012', 'dd-mm-yyyy'), '26', '4', '1', '1', '2012', '0');
insert into WORKB_TIME_CHAR (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values ('27', to_date('27-01-2012', 'dd-mm-yyyy'), '27', '5', '1', '1', '2012', '0');
insert into WORKB_TIME_CHAR (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values ('28', to_date('28-01-2012', 'dd-mm-yyyy'), '28', '6', '1', '1', '2012', '1');
insert into WORKB_TIME_CHAR (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values ('29', to_date('29-01-2012', 'dd-mm-yyyy'), '29', '7', '1', '1', '2012', '1');
insert into WORKB_TIME_CHAR (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values ('30', to_date('30-01-2012', 'dd-mm-yyyy'), '30', '1', '1', '1', '2012', '0');
insert into WORKB_TIME_CHAR (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values ('31', to_date('31-01-2012', 'dd-mm-yyyy'), '31', '2', '1', '1', '2012', '0');
insert into WORKB_TIME_CHAR (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values ('32', to_date('01-02-2012', 'dd-mm-yyyy'), '1', '3', '2', '1', '2012', '0');
insert into WORKB_TIME_CHAR (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values ('33', to_date('02-02-2012', 'dd-mm-yyyy'), '2', '4', '2', '1', '2012', '0');
insert into WORKB_TIME_CHAR (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values ('34', to_date('03-02-2012', 'dd-mm-yyyy'), '3', '5', '2', '1', '2012', '0');
insert into WORKB_TIME_CHAR (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values ('35', to_date('04-02-2012', 'dd-mm-yyyy'), '4', '6', '2', '1', '2012', '1');
insert into WORKB_TIME_CHAR (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values ('36', to_date('05-02-2012', 'dd-mm-yyyy'), '5', '7', '2', '1', '2012', '1');
insert into WORKB_TIME_CHAR (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values ('37', to_date('06-02-2012', 'dd-mm-yyyy'), '6', '1', '2', '1', '2012', '0');
insert into WORKB_TIME_CHAR (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values ('38', to_date('07-02-2012', 'dd-mm-yyyy'), '7', '2', '2', '1', '2012', '0');
insert into WORKB_TIME_CHAR (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values ('197', to_date('15-07-2012', 'dd-mm-yyyy'), '15', '7', '7', '3', '2012', '1');
insert into WORKB_TIME_CHAR (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values ('198', to_date('16-07-2012', 'dd-mm-yyyy'), '16', '1', '7', '3', '2012', '0');
insert into WORKB_TIME_CHAR (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values ('199', to_date('17-07-2012', 'dd-mm-yyyy'), '17', '2', '7', '3', '2012', '0');
insert into WORKB_TIME_CHAR (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values ('200', to_date('18-07-2012', 'dd-mm-yyyy'), '18', '3', '7', '3', '2012', '0');
insert into WORKB_TIME_CHAR (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values ('201', to_date('19-07-2012', 'dd-mm-yyyy'), '19', '4', '7', '3', '2012', '0');
insert into WORKB_TIME_CHAR (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values ('202', to_date('20-07-2012', 'dd-mm-yyyy'), '20', '5', '7', '3', '2012', '0');
insert into WORKB_TIME_CHAR (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values ('203', to_date('21-07-2012', 'dd-mm-yyyy'), '21', '6', '7', '3', '2012', '1');
insert into WORKB_TIME_CHAR (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values ('204', to_date('22-07-2012', 'dd-mm-yyyy'), '22', '7', '7', '3', '2012', '1');
insert into WORKB_TIME_CHAR (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values ('205', to_date('23-07-2012', 'dd-mm-yyyy'), '23', '1', '7', '3', '2012', '0');
insert into WORKB_TIME_CHAR (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values ('206', to_date('24-07-2012', 'dd-mm-yyyy'), '24', '2', '7', '3', '2012', '0');
insert into WORKB_TIME_CHAR (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values ('207', to_date('25-07-2012', 'dd-mm-yyyy'), '25', '3', '7', '3', '2012', '0');
insert into WORKB_TIME_CHAR (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values ('208', to_date('26-07-2012', 'dd-mm-yyyy'), '26', '4', '7', '3', '2012', '0');
insert into WORKB_TIME_CHAR (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values ('209', to_date('27-07-2012', 'dd-mm-yyyy'), '27', '5', '7', '3', '2012', '0');
insert into WORKB_TIME_CHAR (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values ('210', to_date('28-07-2012', 'dd-mm-yyyy'), '28', '6', '7', '3', '2012', '1');
insert into WORKB_TIME_CHAR (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values ('211', to_date('29-07-2012', 'dd-mm-yyyy'), '29', '7', '7', '3', '2012', '1');
insert into WORKB_TIME_CHAR (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values ('212', to_date('30-07-2012', 'dd-mm-yyyy'), '30', '1', '7', '3', '2012', '0');
insert into WORKB_TIME_CHAR (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values ('213', to_date('31-07-2012', 'dd-mm-yyyy'), '31', '2', '7', '3', '2012', '0');
insert into WORKB_TIME_CHAR (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values ('214', to_date('01-08-2012', 'dd-mm-yyyy'), '1', '3', '8', '3', '2012', '0');
insert into WORKB_TIME_CHAR (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values ('215', to_date('02-08-2012', 'dd-mm-yyyy'), '2', '4', '8', '3', '2012', '0');
insert into WORKB_TIME_CHAR (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values ('216', to_date('03-08-2012', 'dd-mm-yyyy'), '3', '5', '8', '3', '2012', '0');
commit;
-- 700 records committed...
insert into WORKB_TIME_CHAR (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values ('217', to_date('04-08-2012', 'dd-mm-yyyy'), '4', '6', '8', '3', '2012', '1');
insert into WORKB_TIME_CHAR (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values ('218', to_date('05-08-2012', 'dd-mm-yyyy'), '5', '7', '8', '3', '2012', '1');
insert into WORKB_TIME_CHAR (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values ('219', to_date('06-08-2012', 'dd-mm-yyyy'), '6', '1', '8', '3', '2012', '0');
insert into WORKB_TIME_CHAR (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values ('220', to_date('07-08-2012', 'dd-mm-yyyy'), '7', '2', '8', '3', '2012', '0');
insert into WORKB_TIME_CHAR (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values ('221', to_date('08-08-2012', 'dd-mm-yyyy'), '8', '3', '8', '3', '2012', '0');
insert into WORKB_TIME_CHAR (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values ('222', to_date('09-08-2012', 'dd-mm-yyyy'), '9', '4', '8', '3', '2012', '0');
insert into WORKB_TIME_CHAR (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values ('223', to_date('10-08-2012', 'dd-mm-yyyy'), '10', '5', '8', '3', '2012', '0');
insert into WORKB_TIME_CHAR (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values ('224', to_date('11-08-2012', 'dd-mm-yyyy'), '11', '6', '8', '3', '2012', '1');
insert into WORKB_TIME_CHAR (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values ('225', to_date('12-08-2012', 'dd-mm-yyyy'), '12', '7', '8', '3', '2012', '1');
insert into WORKB_TIME_CHAR (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values ('226', to_date('13-08-2012', 'dd-mm-yyyy'), '13', '1', '8', '3', '2012', '0');
insert into WORKB_TIME_CHAR (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values ('227', to_date('14-08-2012', 'dd-mm-yyyy'), '14', '2', '8', '3', '2012', '0');
insert into WORKB_TIME_CHAR (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values ('228', to_date('15-08-2012', 'dd-mm-yyyy'), '15', '3', '8', '3', '2012', '0');
insert into WORKB_TIME_CHAR (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values ('229', to_date('16-08-2012', 'dd-mm-yyyy'), '16', '4', '8', '3', '2012', '0');
insert into WORKB_TIME_CHAR (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values ('230', to_date('17-08-2012', 'dd-mm-yyyy'), '17', '5', '8', '3', '2012', '0');
insert into WORKB_TIME_CHAR (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values ('231', to_date('18-08-2012', 'dd-mm-yyyy'), '18', '6', '8', '3', '2012', '1');
insert into WORKB_TIME_CHAR (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values ('232', to_date('19-08-2012', 'dd-mm-yyyy'), '19', '7', '8', '3', '2012', '1');
insert into WORKB_TIME_CHAR (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values ('233', to_date('20-08-2012', 'dd-mm-yyyy'), '20', '1', '8', '3', '2012', '0');
insert into WORKB_TIME_CHAR (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values ('234', to_date('21-08-2012', 'dd-mm-yyyy'), '21', '2', '8', '3', '2012', '0');
insert into WORKB_TIME_CHAR (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values ('235', to_date('22-08-2012', 'dd-mm-yyyy'), '22', '3', '8', '3', '2012', '0');
insert into WORKB_TIME_CHAR (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values ('236', to_date('23-08-2012', 'dd-mm-yyyy'), '23', '4', '8', '3', '2012', '0');
insert into WORKB_TIME_CHAR (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values ('237', to_date('24-08-2012', 'dd-mm-yyyy'), '24', '5', '8', '3', '2012', '1');
insert into WORKB_TIME_CHAR (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values ('238', to_date('25-08-2012', 'dd-mm-yyyy'), '25', '6', '8', '3', '2012', '1');
insert into WORKB_TIME_CHAR (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values ('239', to_date('26-08-2012', 'dd-mm-yyyy'), '26', '7', '8', '3', '2012', '1');
insert into WORKB_TIME_CHAR (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values ('240', to_date('27-08-2012', 'dd-mm-yyyy'), '27', '1', '8', '3', '2012', '0');
insert into WORKB_TIME_CHAR (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values ('241', to_date('28-08-2012', 'dd-mm-yyyy'), '28', '2', '8', '3', '2012', '0');
insert into WORKB_TIME_CHAR (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values ('242', to_date('29-08-2012', 'dd-mm-yyyy'), '29', '3', '8', '3', '2012', '0');
insert into WORKB_TIME_CHAR (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values ('243', to_date('30-08-2012', 'dd-mm-yyyy'), '30', '4', '8', '3', '2012', '0');
insert into WORKB_TIME_CHAR (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values ('244', to_date('31-08-2012', 'dd-mm-yyyy'), '31', '5', '8', '3', '2012', '0');
insert into WORKB_TIME_CHAR (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values ('245', to_date('01-09-2012', 'dd-mm-yyyy'), '1', '6', '9', '3', '2012', '1');
insert into WORKB_TIME_CHAR (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values ('246', to_date('02-09-2012', 'dd-mm-yyyy'), '2', '7', '9', '3', '2012', '1');
insert into WORKB_TIME_CHAR (id_date, date_doc, id_day, day_desc, id_month, id_quart, id_year, is_holiday)
values ('247', to_date('03-09-2012', 'dd-mm-yyyy'), '3', '1', '9', '3', '2012', '0');
commit;
-- 731 records loaded
-- TODO Enable FK
-- Enabling foreign key constraints for STUFF...
-- alter table STUFF enable constraint FK_STUFF_POSITION;
-- Enabling foreign key constraints for INVOICE...
-- alter table INVOICE enable constraint FK_INVOICE_PAYMENT_TYPE;
-- alter table INVOICE enable constraint FK_INVOICE_STUFF;
-- Enabling foreign key constraints for PRODUCT...
-- alter table PRODUCT enable constraint FK_PROD_PROD_TYPE;
-- alter table PRODUCT enable constraint FK_PROD_SUPPLIER;
-- alter table PRODUCT enable constraint FK_PROD_UNIT;
-- Enabling foreign key constraints for INVOICE_DETAIL...
-- alter table INVOICE_DETAIL enable constraint FK_INVOICE_DET_INV;
-- alter table INVOICE_DETAIL enable constraint FK_INVOICE_DET_PRODUCT;
-- Enabling foreign key constraints for STORE...
-- alter table STORE enable constraint FK_STORE_FK_STORE__TYPE_OPE;
-- alter table STORE enable constraint FK_STORE_PROD;
-- Enabling triggers for PAYMENT_TYPE...
alter table PAYMENT_TYPE enable trigger all;
-- Enabling triggers for POSITION...
alter table POSITION enable trigger all;
-- Enabling triggers for STUFF...
alter table STUFF enable trigger all;
-- Enabling triggers for INVOICE...
alter table INVOICE enable trigger all;
-- Enabling triggers for PRODUCT_TYPE...
alter table PRODUCT_TYPE enable trigger all;
-- Enabling triggers for SUPPLIER...
alter table SUPPLIER enable trigger all;
-- Enabling triggers for UNIT...
alter table UNIT enable trigger all;
-- Enabling triggers for PRODUCT...
alter table PRODUCT enable trigger all;
-- Enabling triggers for INVOICE_DETAIL...
alter table INVOICE_DETAIL enable trigger all;
-- Enabling triggers for TYPE_OPER...
alter table TYPE_OPER enable trigger all;
-- Enabling triggers for STORE...
alter table STORE enable trigger all;
-- Enabling triggers for WORKB_INVOICE...
alter table WORKB_INVOICE enable trigger all;
-- Enabling triggers for WORKB_TIME...
alter table WORKB_TIME enable trigger all;
-- Enabling triggers for WORKB_TIME_CHAR...
alter table WORKB_TIME_CHAR enable trigger all;

-- Done.
