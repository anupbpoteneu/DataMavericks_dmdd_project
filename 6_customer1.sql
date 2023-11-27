alter session set current_schema=App_admin;

SET SERVEROUTPUT ON

----Order Table
-- Procedure for adding a new Order

EXEC add_order(1, 5, 'Pending');
EXEC add_order(1, 4, 'Pending');
EXEC add_order(1, 2, 'Completed');
EXEC add_order(1, 5, 'Pending');


----User_Product table1:

EXEC add_user_product(1, 1, 5);
EXEC add_user_product(1, 2, 4);
EXEC add_user_product(1, 3, 2);
EXEC add_user_product(1, 4, 5);


----Payment1
-- Procedure for adding a new Payment

EXEC add_payment(1, 'Credit Card', 'Completed');
EXEC add_payment(2, 'Cash', 'Completed');
EXEC add_payment(3, 'Credit Card', 'Completed');
EXEC add_payment(4, 'Credit Card', 'Completed');

------------------------------------------------------------
--Testing customer 1 data (updated)

EXEC add_order(2 , 'Pending');
EXEC add_user_product(1, 1, 3);
EXEC add_user_product(2, 1, 5);
EXEC add_payment(1, 'Credit Card', 'Failed');

--------------------------------------------------------------

--select * from vw_product_category;
--select * from vw_product;