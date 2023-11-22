alter session set current_schema=App_admin;

SET SERVEROUTPUT ON

----Product Category:
EXEC add_product_category('Phones');
EXEC add_product_category('Laptops');
EXEC add_product_category('Earphones');
EXEC add_product_category('Smartwatches');
EXEC add_product_category('Books');


----Product:
EXEC add_product(1, 'iPhone 14', 'Latest model with advanced features', 50, 1499.99);
EXEC add_product(1, 'Samsung Galaxy S21', 'High-performance Android smartphone', 30, 1299.99);
EXEC add_product(2, 'Dell XPS 13', 'Powerful and portable laptop', 20, 1499.99);
EXEC add_product(2, 'MacBook Pro', 'Premium Apple laptop', 15, 1999.99);
EXEC add_product(3, 'JBL Free X Earphones', 'Wireless in-ear headphones', 40, 99.99);
EXEC add_product(3, 'Sony WH-1000XM4', 'Noise-canceling over-ear headphones', 25, 299.99);
EXEC add_product(4, 'Fitbit Versa 3', 'Fitness and health smartwatch', 35, 199.99);
EXEC add_product(4, 'Apple Watch Series 7', 'Advanced Apple smartwatch', 30, 399.99);
EXEC add_product(5, 'Harry Potter ', 'Fantasy novel by J.K. Rowling', 100, 19.99);
EXEC add_product(5, 'The Alchemist', 'Philosophical novel by Paulo Coelho', 80, 15.99);

select * from vw_product_category;
select * from vw_product;
select * from vw_user_product;
--select * from vw_paymnet;
select * from vw_order_table;
