select distinct p.position_name, avg(p.salary) over (partition by p.id_position) over  
from stuff s, position p 
where s.id_position = p.id_position;


select   p_t.product_type_name,  u.unit_name,  avg (p.price) over (partition by p.id_product_type, p.id_unit ) avg
from product p, product_type p_t, unit u
where p_t.id_product_type = p.id_product_type and
p.id_unit = u.id_unit;

-- прибыль по товару если наценка 30%
select distinct p.product_name "Товар",
       sum( 0.3*p.price*ID.QUANTITY) 
            over(partition by id.id_product) "Сумма прибыли" 
from INVOICE_DETAIL id, product p
where p.id_product = id.id_product
order by "Сумма прибыли" desc;




-------------------------------------------------
-- выдать поставщика что поставляют 
-- наибольшее количество по каждой группе товаров
--------------------------------------------------
select product_type_name, supplier_name, amount
  from (select cnt.supplier_name,
               cnt.product_type_name,
               cnt.id_product_type,
               cnt.amount,
               row_number() over(partition by cnt.id_product_type order by cnt.amount desc) nmb
          from (select s.supplier_name,
                       pt.product_type_name,
                       pt.id_product_type,
                       count(*) over(partition by p.id_supplier, p.id_product_type) as AMOUNT
                  from supplier s, product p, product_type pt
                 where p.id_supplier = s.id_supplier
                   and p.id_product_type = pt.id_product_type
                 order by p.id_product_type, amount) cnt)
 where nmb = 1;

------------------------------------------------------

SELECT REGEXP_SUBSTR('String 1,String 2,String 3', '[^,]+', 1, level) str
                        FROM (SELECT 'String 1,String 2,String 3' str FROM dual)
                      CONNECT BY INSTR('String 1,String 2,String 3', ',', 1, level - 1) > 0
                      
                      
    select wi.id_invoice, wi.id_type, tpo.name_oper from workb_invoice wi, workb_time wt, type_oper tpo, stuff st
    where wi.id_type = tpo.id_oper_type ;

-- отображает предыдущую дату операции по полкам склада
select st.id_product, st.shelf,  top.name_oper,  date_oper, 
LAG (st.date_oper,1) over (partition by st.shelf order by st.shelf) PREVIOUS_OPER
from store st, type_oper top 
where st.id_oper_type = top.id_oper_type;


-- отображает следующую дату операции по полкам склада
select st.id_product, st.shelf,  top.name_oper,  date_oper, 
LEAD (st.date_oper,1) over (partition by st.shelf order by st.shelf) PREVIOUS_OPER
from store st, type_oper top 
where st.id_oper_type = top.id_oper_type;

-- Номер операции по текущей полке
select st.id_product, st.shelf,  top.name_oper,  date_oper, 
rank() over (partition by st.shelf order by date_oper) NUMB_OPER
from store st, type_oper top 
where st.id_oper_type = top.id_oper_type
and st.shelf = 15;

-- Номер операции по текущей полке
select st.id_product, st.shelf,  top.name_oper,  date_oper, 
DENSE_RANK() over (partition by st.shelf order by date_oper) NUMB_OPER
from store st, type_oper top 
where st.id_oper_type = top.id_oper_type;
--and st.shelf = 15;
-- самая высокая и наизкая цена в группе
SELECT 
pt.product_type_name,
   min (p.price)   keep (DENSE_RANK  first  ORDER BY p.id_supplier) hie ,
  
   max (p.price) keep (DENSE_RANK  first ORDER BY p.id_supplier) highest_price  

  FROM product p, product_type pt
  where pt.id_product_type = p.id_product_type
 GROUP BY pt.product_type_name

-----
SELECT p.id_product_type,
       p.id_supplier,
       p.price,
       
       min (p.price) keep(DENSE_RANK first ORDER BY p.id_supplier) over(partition by p.id_product_type) first_min,
       min (p.price) keep(DENSE_RANK last ORDER BY p.id_supplier) over(partition by p.id_product_type) last_min,       
       max (p.price) keep(DENSE_RANK last ORDER BY p.id_supplier) over(partition by p.id_product_type) first_max,       
       max (p.price) keep(DENSE_RANK first ORDER BY p.id_supplier) over(partition by p.id_product_type) first_max
  FROM product p, product_type pt
 where pt.id_product_type = p.id_product_type
 order by p.id_product_type, p.id_supplier;
----
-- создание 5 групп
select s.supplier_name, ntile(5) over (order by s.supplier_name)
from supplier s; 


-- значение  зп по отношение ко всему фонду зп
select s.surname, p.salary, to_char(ratio_to_report (p.salary) over() , '9.99')as rr
from position p, stuff s
where s.id_position = p.id_position;

select s.surname, p.salary, to_char(ratio_to_report (p.salary) over(partition by p.id_position) , '9.99')as rr
from position p, stuff s
where s.id_position = p.id_position;



