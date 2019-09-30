select s.shelf, top.name_oper, sum(s.quantity) from store s, type_oper top
where  
s.id_oper_type = top.id_oper_type 
group by cube(s.shelf, top.name_oper) ;


select  pt.product_type_name, p.product_name,sum(p.price) from product p, product_type pt
where p.id_product_type = pt.id_product_type
group by cube (pt.product_type_name, p.product_name );


select i.id_stuff, nvl(to_char(idl.id_product),'ИТОГО:'), sum(idl.quantity) from invoice i, invoice_detail idl
where i.id_invoice = idl.id_invoice
group by rollup(i.id_stuff, idl.id_product);

select i.id_stuff, nvl(to_char(idl.id_product),'ИТОГО:'), sum(idl.quantity) from invoice i, invoice_detail idl
where i.id_invoice = idl.id_invoice
group by CUBE(i.id_stuff, idl.id_product);


select i.id_stuff,i.id_type, nvl(to_char(idl.id_product),'ИТОГО:'), sum(idl.quantity) from invoice i, invoice_detail idl
where i.id_invoice = idl.id_invoice
group by rollup(i.id_stuff,i.id_type, idl.id_product);

select i.id_stuff,i.id_type, nvl(to_char(idl.id_product),'ИТОГО:'), sum(idl.quantity) from invoice i, invoice_detail idl
where i.id_invoice = idl.id_invoice
group by cube(i.id_stuff,i.id_type, idl.id_product);
