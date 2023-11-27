alter session set current_schema=App_admin;

SET SERVEROUTPUT ON

----Order Table2
-- Procedure for adding a new Order

EXEC add_order(2, 3, 'Completed');
EXEC add_order(2, 2, 'Completed');
EXEC add_order(2, 1, 'Pending');
EXEC add_order(2, 3, 'Pending');
EXEC add_order(2, 3, 'Completed');
EXEC add_order(2, 3, 'Completed');


----User_Product table2:

EXEC add_user_product(2, 5, 3);
EXEC add_user_product(2, 6, 2);
EXEC add_user_product(2, 7, 1);
EXEC add_user_product(2, 8, 3);
EXEC add_user_product(2, 9, 3);
EXEC add_user_product(2, 10, 3);


----Payment2

EXEC add_payment(5, 'Cash', 'Completed');
EXEC add_payment(6, 'Credit Card', 'Completed');
EXEC add_payment(7, 'Credit Card', 'Completed');
EXEC add_payment(8, 'Cash', 'Failed');
EXEC add_payment(9, 'Cash', 'Completed');
EXEC add_payment(10, 'Cash', 'Failed');



-----------------------------------------------------------------
--Testing customer 2 data (updated)

EXEC add_order(3 , 'Completed');
EXEC add_user_product(3, 2, 3);
EXEC add_user_product(4, 2, 5);
EXEC add_payment(2, 'Pay Pal', 'Completed');


------------------------------------------------------------------

--select * from vw_product_category;
--select * from vw_product;