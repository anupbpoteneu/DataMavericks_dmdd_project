--Drop Tables
 
 
SET SERVEROUTPUT ON
 
BEGIN
    FOR I IN (
        WITH MYTABLES AS (
            SELECT 'USER_PRODUCT' AS TNAME FROM DUAL
            UNION ALL SELECT 'PAYMENT' FROM DUAL
            UNION ALL SELECT 'ORDER_TABLE' FROM DUAL
            UNION ALL SELECT 'USER_TABLE' FROM DUAL
            UNION ALL SELECT 'WARE_PRODUCT' FROM DUAL
            UNION ALL SELECT 'PRODUCT' FROM DUAL
            UNION ALL SELECT 'PRODUCT_CATEGORY' FROM DUAL
            UNION ALL SELECT 'ROLES' FROM DUAL
            UNION ALL SELECT 'WAREHOUSE' FROM DUAL
        )
        SELECT M.TNAME
        FROM MYTABLES M INNER JOIN USER_TABLES O ON M.TNAME = O.TABLE_NAME
    )
    LOOP
        BEGIN
            DBMS_OUTPUT.PUT_LINE('TABLE NAME TO BE DROPPED: ' || I.TNAME);
            EXECUTE IMMEDIATE 'DROP TABLE ' || I.TNAME;
        EXCEPTION
            WHEN OTHERS THEN
                DBMS_OUTPUT.PUT_LINE(SQLERRM);
        END;
    END LOOP;
EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE(SQLERRM);
END;
/
-------------------------------------------
 
--Drop sequences
 
 
--select * from user_sequences;
 
 
SET SERVEROUTPUT ON
 
BEGIN
    FOR I IN (
        WITH MYSEQUENCES AS (
            SELECT 'PAYMENT_ID_SEQ' AS SEQ_NAME FROM DUAL
            UNION ALL SELECT 'PRODUCT_ID_SEQ' FROM DUAL
            UNION ALL SELECT 'USER_ID_SEQ' FROM DUAL
            UNION ALL SELECT 'ROLE_ID_SEQ' FROM DUAL
            UNION ALL SELECT 'ORDER_ID_SEQ' FROM DUAL
            UNION ALL SELECT 'WAREHOUSE_ID_SEQ' FROM DUAL
            UNION ALL SELECT 'CATEGORY_ID_SEQ' FROM DUAL
            UNION ALL SELECT 'USER_PRODUCT_ID_SEQ' FROM DUAL
            UNION ALL SELECT 'WARE_PRODUCT_ID_SEQ' FROM DUAL
        )
        SELECT M.SEQ_NAME
        FROM MYSEQUENCES M INNER JOIN USER_SEQUENCES O ON M.SEQ_NAME = O.SEQUENCE_NAME
    )
    LOOP
        BEGIN
            DBMS_OUTPUT.PUT_LINE('SEQUENCE TO BE DROPPED: ' || I.SEQ_NAME);
            EXECUTE IMMEDIATE 'DROP SEQUENCE ' || I.SEQ_NAME;
        EXCEPTION
            WHEN OTHERS THEN
                DBMS_OUTPUT.PUT_LINE(SQLERRM);
        END;
    END LOOP;
EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE(SQLERRM);
END;
/
 
------------------------------------------------------
 
-- Create Sequences
CREATE SEQUENCE ROLE_ID_SEQ START WITH 1;
CREATE SEQUENCE CATEGORY_ID_SEQ START WITH 1;
CREATE SEQUENCE WAREHOUSE_ID_SEQ START WITH 1;
CREATE SEQUENCE PRODUCT_ID_SEQ START WITH 1;
CREATE SEQUENCE WARE_PRODUCT_ID_SEQ START WITH 1;
CREATE SEQUENCE USER_ID_SEQ START WITH 1;
CREATE SEQUENCE ORDER_ID_SEQ START WITH 1;
CREATE SEQUENCE USER_PRODUCT_ID_SEQ START WITH 1;
CREATE SEQUENCE PAYMENT_ID_SEQ START WITH 1;

----------------------------------------------------
 
-- Create Tables
CREATE TABLE ROLES (
    ROLE_ID NUMBER(6) DEFAULT ROLE_ID_SEQ.NEXTVAL NOT NULL,
    ROLE_NAME VARCHAR2(50) NOT NULL,
    PRIMARY KEY (ROLE_ID),
    CONSTRAINT UK_ROLES_ROLE_NAME UNIQUE (ROLE_NAME)
);
 
CREATE TABLE PRODUCT_CATEGORY (
    CATEGORY_ID NUMBER(6) DEFAULT CATEGORY_ID_SEQ.NEXTVAL NOT NULL,
    CATEGORY_NAME VARCHAR2(100) NOT NULL,
    PRIMARY KEY (CATEGORY_ID),
    CONSTRAINT UK_PRODUCT_CATEGORY_NAME UNIQUE (CATEGORY_NAME)
);
 
CREATE TABLE WAREHOUSE (
    WAREHOUSE_ID NUMBER(6) DEFAULT WAREHOUSE_ID_SEQ.NEXTVAL NOT NULL,
    WAREHOUSE_NAME VARCHAR2(100) NOT NULL,
    TOTAL_CAPACITY NUMBER,
    STREET_ADDRESS VARCHAR2(255),
    ZIP_CODE VARCHAR2(20),
    CITY VARCHAR2(100),
    STATE VARCHAR2(100),
    COUNTRY VARCHAR2(100),
    PRIMARY KEY (WAREHOUSE_ID),
   CONSTRAINT UK_WAREHOUSE_NAME UNIQUE (WAREHOUSE_NAME)
);
 
CREATE TABLE PRODUCT (
    PRODUCT_ID NUMBER(6) DEFAULT PRODUCT_ID_SEQ.NEXTVAL NOT NULL,
    CATEGORY_ID NUMBER(6) NOT NULL,
    PRODUCT_NAME VARCHAR2(100) NOT NULL,
    DESCRIPTION VARCHAR2(255),
    PRODUCT_QUANTITY NUMBER,
    PRODUCT_COST NUMBER,
    PRIMARY KEY (PRODUCT_ID),
    CONSTRAINT PRODUCT_CATEGORY_FK FOREIGN KEY (CATEGORY_ID) REFERENCES PRODUCT_CATEGORY(CATEGORY_ID) ON DELETE CASCADE,
    CONSTRAINT UK_PRODUCT_NAME UNIQUE (PRODUCT_NAME)
);

CREATE TABLE WARE_PRODUCT (
    WARE_PRODUCT_ID NUMBER(20) DEFAULT WARE_PRODUCT_ID_SEQ.NEXTVAL NOT NULL,
    WAREHOUSE_ID NUMBER(6) NOT NULL,
    PRODUCT_ID NUMBER(6) NOT NULL,
    STOCK_QUANTITY NUMBER,
    PRIMARY KEY (WARE_PRODUCT_ID),
    CONSTRAINT WARE_PRODUCT_WAREHOUSE_FK FOREIGN KEY (WAREHOUSE_ID) REFERENCES WAREHOUSE(WAREHOUSE_ID) ON DELETE CASCADE,
    CONSTRAINT WARE_PRODUCT_PRODUCT_FK FOREIGN KEY (PRODUCT_ID) REFERENCES PRODUCT(PRODUCT_ID) ON DELETE CASCADE,
    CONSTRAINT UK_WARE_PRODUCT_UNIQUE_COMBINATION UNIQUE (WAREHOUSE_ID, PRODUCT_ID)
);
 
CREATE TABLE USER_TABLE (
    USER_ID NUMBER(16) DEFAULT USER_ID_SEQ.NEXTVAL NOT NULL,
    ROLE_ID NUMBER(6) NOT NULL,
    USER_NAME VARCHAR2(100) NOT NULL,
    EMAIL_ADDRESS VARCHAR2(255) NOT NULL,
    STREET_ADDRESS VARCHAR2(255),
    CITY VARCHAR2(100),
    ZIPCODE VARCHAR2(20),
    COUNTRY VARCHAR2(100),
    STATE VARCHAR2(100),
    PHONE_NUMBER VARCHAR2(20),
    PRIMARY KEY (USER_ID),
    CONSTRAINT UK_USER_NAME UNIQUE (USER_NAME),
    CONSTRAINT UK_EMAIL_ADDRESS UNIQUE (EMAIL_ADDRESS),
    CONSTRAINT USER_ROLE_FK FOREIGN KEY (ROLE_ID) REFERENCES ROLES(ROLE_ID) ON DELETE CASCADE
    
);
 
CREATE TABLE ORDER_TABLE (
    ORDER_ID NUMBER(10) DEFAULT ORDER_ID_SEQ.NEXTVAL NOT NULL,
    USER_ID NUMBER(16) NOT NULL,
    ORDER_QTY NUMBER,
    ORDER_STATUS VARCHAR2(50),
    ORDER_DATE DATE,
    PRIMARY KEY (ORDER_ID),
    CONSTRAINT ORDER_USER_FK FOREIGN KEY (USER_ID) REFERENCES USER_TABLE(USER_ID) ON DELETE CASCADE
);
 
CREATE TABLE USER_PRODUCT (
    USER_PRODUCT_ID NUMBER(20) DEFAULT USER_PRODUCT_ID_SEQ.NEXTVAL NOT NULL,
    PRODUCT_ID NUMBER(6) NOT NULL,
    ORDER_ID NUMBER(10) NOT NULL,
    UP_QUANTITY NUMBER,
    UP_PRICE NUMBER,
    PRIMARY KEY (USER_PRODUCT_ID),
    CONSTRAINT USER_PRODUCT_PRODUCT_FK FOREIGN KEY (PRODUCT_ID) REFERENCES PRODUCT(PRODUCT_ID) ON DELETE CASCADE,
    CONSTRAINT USER_PRODUCT_ORDER_FK FOREIGN KEY (ORDER_ID) REFERENCES ORDER_TABLE(ORDER_ID) ON DELETE CASCADE
);
 
CREATE TABLE PAYMENT (
    PAYMENT_ID NUMBER(10) DEFAULT PAYMENT_ID_SEQ.NEXTVAL NOT NULL,
    ORDER_ID NUMBER(10) NOT NULL,
    PAYMENT_MODE VARCHAR2(50),    
    PAYMENT_DATE DATE,   
    PAYMENT_STATUS VARCHAR2(50),  
    PRIMARY KEY (PAYMENT_ID),
    CONSTRAINT PAYMENT_ORDER_FK FOREIGN KEY (ORDER_ID) REFERENCES ORDER_TABLE(ORDER_ID) ON DELETE CASCADE
);
 
------------------------------------------------------------------------------------------
 
 
--select * from user_views;
 
 
---------------------------------------------------------------------------------------------
 
 
-- Drop Views
 
SET SERVEROUTPUT ON
 
BEGIN
    FOR I IN (
        WITH MYVIEWS AS (
                SELECT 'VW_USER_PRODUCT' AS VNAME FROM DUAL
                UNION ALL SELECT 'VW_PAYMENT' FROM DUAL
                UNION ALL SELECT 'VW_ORDER_TABLE' FROM DUAL
                UNION ALL SELECT 'VW_USER_TABLE' FROM DUAL
                UNION ALL SELECT 'VW_WARE_PRODUCT' FROM DUAL
                UNION ALL SELECT 'VW_PRODUCT' FROM DUAL
                UNION ALL SELECT 'VW_PRODUCT_CATEGORY' FROM DUAL
                UNION ALL SELECT 'VW_ROLES' FROM DUAL
                UNION ALL SELECT 'VW_WAREHOUSE' FROM DUAL
        )
        SELECT M.VNAME
        FROM MYVIEWS M
        INNER JOIN USER_VIEWS O ON M.VNAME = O.VIEW_NAME
    )
    LOOP
        BEGIN
            DBMS_OUTPUT.PUT_LINE('VIEW NAME TO BE DROPPED: ' || I.VNAME);
            EXECUTE IMMEDIATE 'DROP VIEW ' || I.VNAME;
        EXCEPTION
            WHEN OTHERS THEN
                DBMS_OUTPUT.PUT_LINE(SQLERRM);
        END;
    END LOOP;
EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE(SQLERRM);
END;
/
---------------------------------------------------------------------------------------

--create views
 
 
CREATE OR REPLACE VIEW VW_USER_PRODUCT AS
SELECT * FROM USER_PRODUCT;
 
CREATE OR REPLACE VIEW VW_PAYMENT AS
SELECT * FROM PAYMENT;
 
CREATE OR REPLACE VIEW VW_ORDER_TABLE AS
SELECT * FROM ORDER_TABLE;
 
CREATE OR REPLACE VIEW VW_USER_TABLE AS
SELECT * FROM USER_TABLE;
 
CREATE OR REPLACE VIEW VW_WARE_PRODUCT AS
SELECT * FROM WARE_PRODUCT;
 
CREATE OR REPLACE VIEW VW_PRODUCT AS
SELECT * FROM PRODUCT;
 
CREATE OR REPLACE VIEW VW_PRODUCT_CATEGORY AS
SELECT * FROM PRODUCT_CATEGORY;
 
CREATE OR REPLACE VIEW VW_ROLES AS
SELECT * FROM ROLES;
 
CREATE OR REPLACE VIEW VW_WAREHOUSE AS
SELECT * FROM WAREHOUSE;

---------------------------------------------------------------------------------------
--Procedures Creation

CREATE OR REPLACE PROCEDURE add_role (
    in_role_name VARCHAR2
) AS
    v_exists VARCHAR(5);
    e_exists EXCEPTION;
BEGIN
    SELECT
        'Y'
    INTO v_exists
    FROM
        roles
    WHERE
        role_name = in_role_name;

    IF ( v_exists = 'Y' ) THEN
        RAISE e_exists;
    END IF;
EXCEPTION
    WHEN no_data_found THEN
        INSERT INTO roles VALUES (
            role_id_seq.NEXTVAL,
            in_role_name
        );

        dbms_output.put_line('Role Added');
        COMMIT;
    WHEN e_exists THEN
        dbms_output.put_line('Role already exists');
END add_role;
/

-- Procedure for adding a new Product Category
CREATE OR REPLACE PROCEDURE add_product_category(in_category_name VARCHAR2) AS
V_EXISTS VARCHAR(5);
E_EXISTS EXCEPTION;
BEGIN
	SELECT 'Y' INTO V_EXISTS FROM product_category WHERE category_name=in_category_name;
	IF(V_EXISTS='Y')
	THEN RAISE E_EXISTS;
	END IF;

EXCEPTION
WHEN NO_DATA_FOUND THEN
	INSERT INTO product_category VALUES (category_id_seq.NEXTVAL, in_category_name);
    DBMS_OUTPUT.PUT_LINE('Product Category Added');
    COMMIT;
WHEN E_EXISTS THEN
    DBMS_OUTPUT.PUT_LINE('Category already exists');
	
END add_product_category;
/
-- Procedure for adding a new Warehouse

CREATE OR REPLACE PROCEDURE add_warehouse (
    in_warehouse_name VARCHAR2,
    in_total_capacity NUMBER,
    in_street_address VARCHAR2,
    in_zip_code       VARCHAR2,
    in_city           VARCHAR2,
    in_state          VARCHAR2,
    in_country        VARCHAR2
) AS
    v_exists VARCHAR(5);
    e_exists EXCEPTION;
BEGIN
    SELECT
        'Y'
    INTO v_exists
    FROM
        warehouse
    WHERE
        warehouse_name = in_warehouse_name;

    IF ( v_exists = 'Y' ) THEN
        RAISE e_exists;
    END IF;
EXCEPTION
    WHEN no_data_found THEN
        INSERT INTO warehouse VALUES (
            warehouse_id_seq.NEXTVAL,
            in_warehouse_name,
            in_total_capacity,
            in_street_address,
            in_zip_code,
            in_city,
            in_state,
            in_country
        );

        dbms_output.put_line('Warehouse Added');
        COMMIT;
    WHEN e_exists THEN
        dbms_output.put_line('Warehouse already exists');
END add_warehouse;
/


-- Procedure for adding a new Product
CREATE OR REPLACE PROCEDURE add_product(
    in_category_id NUMBER,
    in_product_name VARCHAR2,
    in_description VARCHAR2,
    in_product_quantity NUMBER,
    in_product_cost NUMBER
) AS
V_EXISTS VARCHAR(5);
E_EXISTS EXCEPTION;
BEGIN
	SELECT 'Y' INTO V_EXISTS FROM product WHERE product_name=in_product_name;
	IF(V_EXISTS='Y')
	THEN RAISE E_EXISTS;
	END IF;
    
	
EXCEPTION
WHEN NO_DATA_FOUND THEN
	INSERT INTO product VALUES (
        product_id_seq.NEXTVAL,
        in_category_id,
        in_product_name,
        in_description,
        in_product_quantity,
        in_product_cost
    );
    DBMS_OUTPUT.PUT_LINE('Product Added');
    COMMIT;
WHEN E_EXISTS THEN
    DBMS_OUTPUT.PUT_LINE('Product already exists');
	
END add_product;
/

-- Procedure for adding a new Ware Product
CREATE OR REPLACE PROCEDURE add_ware_product(
    in_warehouse_id NUMBER,
    in_product_id NUMBER,
    in_stock_quantity NUMBER
) AS
V_EXISTS VARCHAR(10):='N';
V_WAREHOUSE_EXISTS VARCHAR(10):='N';
V_PRODUCT_EXISTS VARCHAR(10):='N';
V_WARE_CAPACITY NUMBER;
E_INVALID_STOCK EXCEPTION;
BEGIN
	
	SELECT 'Y' INTO V_WAREHOUSE_EXISTS 
	FROM WAREHOUSE
	WHERE WAREHOUSE_ID=in_warehouse_id;
	
	SELECT 'Y' INTO V_PRODUCT_EXISTS 
	FROM PRODUCT
	WHERE PRODUCT_ID=in_product_id;
	
	SELECT TOTAL_CAPACITY INTO V_WARE_CAPACITY
	FROM WAREHOUSE
	WHERE WAREHOUSE_ID=in_warehouse_id;
	
	IF(in_stock_quantity<0 OR in_stock_quantity>V_WARE_CAPACITY)
	THEN RAISE E_INVALID_STOCK;
    END IF;
	
	SELECT 'Y' INTO V_EXISTS 
	FROM WARE_PRODUCT
	WHERE WAREHOUSE_ID=in_warehouse_id
	AND PRODUCT_ID=in_product_id;
    
    IF(V_EXISTS='Y') THEN
    DBMS_OUTPUT.PUT_LINE('The product you are trying to add into this warehouse already exists');
	END IF;

EXCEPTION
WHEN NO_DATA_FOUND THEN	

	IF (V_WAREHOUSE_EXISTS='N') THEN
	    DBMS_OUTPUT.PUT_LINE('Warehouse does not exist. Therefore you cannot add product into this warehouse');
		
	ELSIF (V_PRODUCT_EXISTS='N') THEN
	    DBMS_OUTPUT.PUT_LINE('Product is invalid. Try to add another product that exists.');

	ELSIF (V_EXISTS='N') THEN
    DBMS_OUTPUT.PUT_LINE('Ware Product does not exist. You can add product into this warehouse');
	
	INSERT INTO ware_product VALUES (
        ware_product_id_seq.NEXTVAL,
        in_warehouse_id,
        in_product_id,
        in_stock_quantity
    );
    DBMS_OUTPUT.PUT_LINE('Ware Product Added');
    COMMIT;
	END IF;
	
WHEN E_INVALID_STOCK THEN
	DBMS_OUTPUT.PUT_LINE('Quantity must be greater than 0 and less than or equal to warehouse capacity');

END add_ware_product;
/

-- Procedure for adding a new user

CREATE OR REPLACE PROCEDURE add_user (
    in_role_id        NUMBER,
    in_user_name      VARCHAR2,
    in_email_address  VARCHAR2,
    in_street_address VARCHAR2,
    in_city           VARCHAR2,
    in_zipcode        VARCHAR2,
    in_country        VARCHAR2,
    in_state          VARCHAR2,
    in_phone_number   VARCHAR2
) AS
    v_exists VARCHAR(5);
    e_exists EXCEPTION;
BEGIN
    SELECT
        'Y'
    INTO v_exists
    FROM
        user_table
    WHERE
        user_name = in_user_name
        OR email_address = in_email_address;

    IF ( v_exists = 'Y' ) THEN
        RAISE e_exists;
    END IF;
EXCEPTION
    WHEN no_data_found THEN
        INSERT INTO user_table VALUES (
            user_id_seq.NEXTVAL,
            in_role_id,
            in_user_name,
            in_email_address,
            in_street_address,
            in_city,
            in_zipcode,
            in_country,
            in_state,
            in_phone_number
        );

        dbms_output.put_line('User Added');
        COMMIT;
    WHEN e_exists THEN
        dbms_output.put_line('User already exists with same user name or email address');
END add_user;
/

-- Procedure for adding a new Order

CREATE OR REPLACE PROCEDURE add_order (
    in_user_id      NUMBER,
    in_order_status VARCHAR2
) AS
BEGIN
    IF ( in_order_status != 'Pending' ) THEN
        dbms_output.put_line('Order status is invalid.');
    ELSE
        INSERT INTO order_table (
            order_id,
            user_id,
            order_status
        ) VALUES (
            order_id_seq.NEXTVAL,
            in_user_id,
            in_order_status
        );

        dbms_output.put_line('Order Added');
        COMMIT;
    END IF;
END add_order;
/

-- Procedure for adding a new User Product

CREATE OR REPLACE PROCEDURE add_user_product (
    in_product_id  NUMBER,
    in_order_id    NUMBER,
    in_up_quantity NUMBER
) AS

    v_product_cost  NUMBER;
    v_order_exist   VARCHAR(10) := 'N';
    v_product_exist VARCHAR(10) := 'N';
    v_product_qty   NUMBER;
BEGIN

    --Check if Order exists
    SELECT
        'Y'
    INTO v_order_exist
    FROM
        order_table
    WHERE
            order_id = in_order_id
        AND order_status = 'Pending';

    SELECT
        'Y'
    INTO v_product_exist
    FROM
        product
    WHERE
        product_id = in_product_id;

    SELECT
        product_quantity
    INTO v_product_qty
    FROM
        product
    WHERE
        product_id = in_product_id;

    IF ( in_up_quantity <= 0 ) THEN
        dbms_output.put_line('Quantity must be greater than 0');
        
    ELSIF ( v_product_qty = 0 ) THEN
        dbms_output.put_line('Product currently unavialable.');
                                 
    ELSIF ( in_up_quantity > v_product_qty ) THEN
        dbms_output.put_line('The available quantity of this product is: '
                             || v_product_qty
                             || '.Please try to order equal or lesser than the available quantity');
                                                 
    ELSE
        -- Retrieve the product cost
        SELECT
            product_cost
        INTO v_product_cost
        FROM
            product
        WHERE
            product_id = in_product_id;
                
        -- Insert into user_product with calculated up_price
        INSERT INTO user_product VALUES (
            user_product_id_seq.NEXTVAL,
            in_product_id,
            in_order_id,
            in_up_quantity,
            in_up_quantity * v_product_cost -- Calculate up_price
        );

        dbms_output.put_line('User Product Added');
        COMMIT;
    END IF;

EXCEPTION
    WHEN no_data_found THEN
        IF ( v_order_exist = 'N' ) THEN
            dbms_output.put_line('You cannot add products against an order which is already completed or does not exist. Please place a new order and add products to it!'
            );
        ELSIF ( v_product_exist = 'N' ) THEN
            dbms_output.put_line('Unfortunately, the product you have chosen does not exist in our catalog.');
        END IF;
END add_user_product;
/

-- Procedure for adding a new Payment
CREATE OR REPLACE PROCEDURE add_payment(
    in_order_id NUMBER,
    in_payment_mode VARCHAR2,
    in_payment_status VARCHAR2
) AS
V_EXISTS VARCHAR(5);
E_EXISTS EXCEPTION;
BEGIN

    SELECT 'Y' INTO V_EXISTS FROM PAYMENT WHERE order_id=in_order_id
    AND payment_status='Completed' ;
	
	IF(V_EXISTS='Y')
	THEN RAISE E_EXISTS;
	END IF;
EXCEPTION
    WHEN NO_DATA_FOUND THEN
    IF (in_payment_status NOT IN ('Failed', 'Completed')) THEN
    DBMS_OUTPUT.PUT_LINE('Payment status is invalid.');
    
    ELSE
    INSERT INTO payment VALUES (
    payment_id_seq.NEXTVAL,
        in_order_id,
        in_payment_mode,
        SYSDATE,
        in_payment_status
    );
    COMMIT;

    END IF;
    
    IF(in_payment_status='Failed') THEN
    DBMS_OUTPUT.PUT_LINE('Payment failed');
    
    ELSIF(in_payment_status='Completed') THEN
    DBMS_OUTPUT.PUT_LINE('Payment is successfully completed');
    END IF;
    
    WHEN E_EXISTS THEN
    DBMS_OUTPUT.PUT_LINE('Payment for this order is already completed');

END add_payment;
/


------------------------------------------------------------

--Inserting records
 
--Roles table:
EXEC add_role('Admin');
EXEC add_role('Customer');
EXEC add_role('Product Manager');
EXEC add_role('Inventory Manager');

---User table data:
EXEC add_user(1, 'App_admin', 'admin@example.com', '789 Baker Street', 'Boston', '02120', 'USA', 'Massachusetts', '123-456-7890');
EXEC add_user(2, 'customer1', 'customer1@example.com', '123 Beckon St', 'Atlanta', '05150', 'USA', 'Georgia', '987-654-3210');
EXEC add_user(2, 'customer2', 'customer2@example.com', '789 Bolyston st', 'Newyork', '0666','USA', 'Newyork', '555-555-5555');
EXEC add_user(3, 'product_manager', 'productmanager@example.com', '123 Harbour Street','Sydney', '0780', 'Australia', 'Sydney', '555-555-5556');
EXEC add_user(4, 'inventory_manager', 'inventorymanager@example.com', '789 Sakura Avenue', 'Tokyo', '0888', 'Japan', 'Tokyo', '123-456-7891');

---------------------------------------------------------------------------
--Views for customers

CREATE OR REPLACE VIEW customer1_view AS
SELECT *
FROM order_table
WHERE user_id = 2;

CREATE OR REPLACE VIEW customer2_view AS
SELECT *
FROM order_table
WHERE user_id = 3;

-----------------------------------------------------------------------------
--Trigger for orders

CREATE OR REPLACE TRIGGER trg_order_completed AFTER
    UPDATE OR INSERT ON order_table
    FOR EACH ROW
DECLARE
    v_up_quantity NUMBER;
BEGIN
    IF :new.order_status = 'Completed' THEN
        -- For each product in the order
        FOR product_rec IN (
            SELECT
                product_id,
                up_quantity
            FROM
                user_product
            WHERE
                order_id = :new.order_id
        ) LOOP
            -- Assign up_quantity to the variable
            v_up_quantity := product_rec.up_quantity;
 
            -- Update product table for the specific product
            UPDATE product
            SET
                product_quantity = product_quantity - v_up_quantity
            WHERE
                product_id = product_rec.product_id;

        END LOOP;

    END IF;
END;
/
