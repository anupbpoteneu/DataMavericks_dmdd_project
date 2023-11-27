alter session set current_schema=App_admin;

SET SERVEROUTPUT ON

----Warehouse:
EXEC add_warehouse('Amazon', 100, '789 Baker Street', '54321', 'Boston', 'Massachusetts', 'USA');
EXEC add_warehouse('Flipkart', 100, '123 Beckon St', '12345', 'Atlanta', 'Georgia', 'USA');
EXEC add_warehouse('Alibaba', 100, '789 Bolyston st', '67890', 'Newyork', 'Newyork', 'USA');
EXEC add_warehouse('Reliance', 100, '123 Harbour Street', '11223', 'Sydney', 'Sydney', 'Australia');
EXEC add_warehouse('Tata', 100, '789 Sakura Avenue', '33445', 'Tokyo', 'Tokyo', 'Japan');


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


--select * from vw_product_category;
--select * from vw_product;
--select * from vw_ware_product;
--select * from vw_warehouse;