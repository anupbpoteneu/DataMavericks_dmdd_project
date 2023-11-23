alter session set current_schema=App_admin;

SET SERVEROUTPUT ON

----Order Table
-- Procedure for adding a new Order
EXEC add_order(1, 5, 'Pending');
--EXEC add_order(2, 3, 'Completed');
--EXEC add_order(2, 2, 'Completed');
EXEC add_order(1, 4, 'Pending');
--EXEC add_order(2, 1, 'Pending');
--EXEC add_order(2, 3, 'Pending');
EXEC add_order(1, 2, 'Completed');
--EXEC add_order(2, 3, 'Completed');
EXEC add_order(1, 5, 'Pending');
--EXEC add_order(2, 3, 'Completed');





----User_Product table1:
EXEC add_user_product(1, 1, 5);
--EXEC add_user_product(2, 2, 3);
--EXEC add_user_product(2, 3, 2);
EXEC add_user_product(1, 4, 4);
--EXEC add_user_product(2, 5, 1);
--EXEC add_user_product(2, 6, 3);
EXEC add_user_product(1, 7, 2);
--EXEC add_user_product(2, 8, 3);
EXEC add_user_product(1, 9, 5);
--EXEC add_user_product(2, 10, 3);






----Payment1
-- Procedure for adding a new Payment
EXEC add_payment(1, 'Credit Card', 'Completed');
--EXEC add_payment(2, 'Cash', 'Completed');
--EXEC add_payment(3, 'Credit Card', 'Completed');
EXEC add_payment(4, 'Cash', 'Failed');
--EXEC add_payment(5, 'Credit Card', 'Completed');
--EXEC add_payment(6, 'Cash', 'Failed');
EXEC add_payment(7, 'Credit Card', 'Failed');
--EXEC add_payment(8, 'Cash', 'Completed');
EXEC add_payment(9, 'Credit Card', 'Completed');
--EXEC add_payment(10, 'Cash', 'Failed');




select * from vw_product_category;
select * from vw_product;