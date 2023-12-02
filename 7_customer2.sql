alter session set current_schema=App_admin;

SET SERVEROUTPUT ON


DECLARE
    v_latest_order_id NUMBER;
BEGIN

DBMS_OUTPUT.PUT_LINE('TEST CASE 1');

add_order(3 , 'Pending');


    -- Fetch the latest order_id for user_id = 2
    SELECT MAX(order_id) INTO v_latest_order_id
    FROM customer1_view;
    
DBMS_OUTPUT.PUT_LINE('Latest Order ID: ' || v_latest_order_id);

add_user_product(3, v_latest_order_id, 13); 
add_user_product(4, v_latest_order_id, 12); 

add_payment(v_latest_order_id, 'Credit Card', 'Failed');
add_payment(v_latest_order_id, 'Credit Card', 'Completed');


END;
/

--select * from customer1_view;
--select * from customer2_view;
-----------------------------------------------------------------
-- 2)

DECLARE
    v_latest_order_id NUMBER;

BEGIN
    DBMS_OUTPUT.PUT_LINE('TEST 2');

    add_order(3 , 'Pending');

    -- Fetch the latest order_id for user_id = 2
    SELECT MAX(order_id) INTO v_latest_order_id
    FROM customer1_view;

    DBMS_OUTPUT.PUT_LINE('Latest Order ID: ' || v_latest_order_id);

    add_user_product(3, v_latest_order_id, 13); 
    add_user_product(4, v_latest_order_id, 14);

    add_payment(v_latest_order_id, 'Credit Card', 'Failed');
    add_payment(v_latest_order_id, 'Credit Card', 'Completed');
END;
/

-- 3)

DECLARE
    v_latest_order_id NUMBER;

BEGIN
    DBMS_OUTPUT.PUT_LINE('TEST 3');

    add_order(3 , 'Pending');

    -- Fetch the latest order_id for user_id = 2
    SELECT MAX(order_id) INTO v_latest_order_id
    FROM customer1_view;

    DBMS_OUTPUT.PUT_LINE('Latest Order ID: ' || v_latest_order_id);

    add_user_product(3, v_latest_order_id, 18); 
    add_user_product(4, v_latest_order_id, 19);

    add_payment(v_latest_order_id, 'Credit Card', 'Failed');
    add_payment(v_latest_order_id, 'Credit Card', 'Completed');
END;
/

-- 4)

DECLARE
    v_latest_order_id NUMBER;

BEGIN
    DBMS_OUTPUT.PUT_LINE('TEST 4');

    add_order(3 , 'Pending');

    -- Fetch the latest order_id for user_id = 2
    SELECT MAX(order_id) INTO v_latest_order_id
    FROM customer1_view;

    DBMS_OUTPUT.PUT_LINE('Latest Order ID: ' || v_latest_order_id);

    add_user_product(3, v_latest_order_id, 18); 
    add_user_product(4, v_latest_order_id, 19);

    add_payment(v_latest_order_id, 'Credit Card', 'Failed');
    add_payment(v_latest_order_id, 'Credit Card', 'Completed');
END;
/

-- 5)

DECLARE
    v_latest_order_id NUMBER;
BEGIN
    DBMS_OUTPUT.PUT_LINE('TEST 5');

    add_order(2 , 'Pending');

    -- Fetch the latest order_id for user_id = 2
    SELECT MAX(order_id) INTO v_latest_order_id
    FROM customer1_view;

    DBMS_OUTPUT.PUT_LINE('Latest Order ID: ' || v_latest_order_id);

    add_user_product(1, v_latest_order_id, 9); 
    add_user_product(2, v_latest_order_id, 10);

    add_payment(v_latest_order_id, 'Credit Card', 'Failed');
    add_payment(v_latest_order_id, 'Credit Card', 'Completed');
END;
/

-- 6)


DECLARE
    v_latest_order_id NUMBER;
BEGIN
    DBMS_OUTPUT.PUT_LINE('TEST 6');

    add_order(3 , 'Pending');

    -- Fetch the latest order_id for user_id = 2
    SELECT MAX(order_id) INTO v_latest_order_id
    FROM customer1_view;

    DBMS_OUTPUT.PUT_LINE('Latest Order ID: ' || v_latest_order_id);

    add_user_product(3, v_latest_order_id, 9); 
    add_user_product(4, v_latest_order_id, 10);

    add_payment(v_latest_order_id, 'Credit Card', 'Failed');
    add_payment(v_latest_order_id, 'Credit Card', 'Completed');
END;
/