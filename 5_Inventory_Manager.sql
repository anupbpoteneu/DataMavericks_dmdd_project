alter session set current_schema=App_admin;

SET SERVEROUTPUT ON

----Warehouse:
EXEC add_warehouse('Amazon', 10000, '123 Amazon St', '54321', 'Amazon City', 'Amazon State', 'Amazon Land');
EXEC add_warehouse('Flipkart', 8000, '456 Flipkart St', '12345', 'Flipkart Town', 'Flipkart State', 'Flipkart Land');
EXEC add_warehouse('Alibaba', 12000, '789 Alibaba St', '67890', 'Alibaba Village', 'Alibaba State', 'Alibaba Land');
EXEC add_warehouse('Reliance', 9000, '101 Reliance St', '11223', 'Reliance Metropolis', 'Reliance State', 'Reliance Land');
EXEC add_warehouse('Tata', 15000, '202 Tata St', '33445', 'Tata City', 'Tata State', 'Tata Land');


----Ware Product:
EXEC add_ware_product(1, 1, 30);
EXEC add_ware_product(1, 2, 20);
EXEC add_ware_product(2, 3, 15);
EXEC add_ware_product(2, 4, 10);
EXEC add_ware_product(3, 5, 25);
EXEC add_ware_product(3, 6, 15);
EXEC add_ware_product(4, 7, 20);
EXEC add_ware_product(4, 8, 18);
EXEC add_ware_product(5, 9, 50);
EXEC add_ware_product(5, 10, 40);


select * from vw_product_category;
select * from vw_product;
select * from vw_ware_product;
select * from vw_warehouse;