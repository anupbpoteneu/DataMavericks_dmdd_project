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
    PRIMARY KEY (ROLE_ID)
);
 
CREATE TABLE PRODUCT_CATEGORY (
    CATEGORY_ID NUMBER(6) DEFAULT CATEGORY_ID_SEQ.NEXTVAL NOT NULL,
    CATEGORY_NAME VARCHAR2(100) NOT NULL,
    PRIMARY KEY (CATEGORY_ID)
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
    PRIMARY KEY (WAREHOUSE_ID)
);
 
CREATE TABLE PRODUCT (
    PRODUCT_ID NUMBER(6) DEFAULT PRODUCT_ID_SEQ.NEXTVAL NOT NULL,
    CATEGORY_ID NUMBER(6) NOT NULL,
    PRODUCT_NAME VARCHAR2(100) NOT NULL,
    DESCRIPTION VARCHAR2(255),
    PRODUCT_QUANTITY NUMBER,
    PRODUCT_COST NUMBER,
    PRIMARY KEY (PRODUCT_ID),
    CONSTRAINT PRODUCT_CATEGORY_FK FOREIGN KEY (CATEGORY_ID) REFERENCES PRODUCT_CATEGORY(CATEGORY_ID) ON DELETE CASCADE
);

CREATE TABLE WARE_PRODUCT (
    SURROGATE_KEY NUMBER(20) DEFAULT WARE_PRODUCT_ID_SEQ.NEXTVAL NOT NULL,
    WAREHOUSE_ID NUMBER(6) NOT NULL,
    PRODUCT_ID NUMBER(6) NOT NULL,
    STOCK_QUANTITY NUMBER,
    PRIMARY KEY (SURROGATE_KEY),
    CONSTRAINT WARE_PRODUCT_WAREHOUSE_FK FOREIGN KEY (WAREHOUSE_ID) REFERENCES WAREHOUSE(WAREHOUSE_ID) ON DELETE CASCADE,
    CONSTRAINT WARE_PRODUCT_PRODUCT_FK FOREIGN KEY (PRODUCT_ID) REFERENCES PRODUCT(PRODUCT_ID) ON DELETE CASCADE
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
    SURROGATE_KEY NUMBER(20) DEFAULT USER_PRODUCT_ID_SEQ.NEXTVAL NOT NULL,
    PRODUCT_ID NUMBER(6) NOT NULL,
    ORDER_ID NUMBER(10) NOT NULL,
    UP_QUANTITY NUMBER,
    UP_PRICE NUMBER,
    PRIMARY KEY (SURROGATE_KEY),
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

-- Procedure for adding a new Role
CREATE OR REPLACE PROCEDURE add_role(in_role_name VARCHAR2) AS
BEGIN
    INSERT INTO roles VALUES (role_id_seq.NEXTVAL, in_role_name);
    DBMS_OUTPUT.PUT_LINE('Role Added');
    COMMIT;
END add_role;
/
-- Procedure for adding a new Product Category
CREATE OR REPLACE PROCEDURE add_product_category(in_category_name VARCHAR2) AS
BEGIN
    INSERT INTO product_category VALUES (category_id_seq.NEXTVAL, in_category_name);
    DBMS_OUTPUT.PUT_LINE('Product Category Added');
    COMMIT;
END add_product_category;
/
-- Procedure for adding a new Warehouse
CREATE OR REPLACE PROCEDURE add_warehouse(
    in_warehouse_name VARCHAR2,
    in_total_capacity NUMBER,
    in_street_address VARCHAR2,
    in_zip_code VARCHAR2,
    in_city VARCHAR2,
    in_state VARCHAR2,
    in_country VARCHAR2
) AS
BEGIN
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
    DBMS_OUTPUT.PUT_LINE('Warehouse Added');
    COMMIT;
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
BEGIN
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
END add_product;
/
-- Procedure for adding a new Ware Product
CREATE OR REPLACE PROCEDURE add_ware_product(
    in_warehouse_id NUMBER,
    in_product_id NUMBER,
    in_stock_quantity NUMBER
) AS
BEGIN
    INSERT INTO ware_product VALUES (
        ware_product_id_seq.NEXTVAL,
        in_warehouse_id,
        in_product_id,
        in_stock_quantity
    );
    DBMS_OUTPUT.PUT_LINE('Ware Product Added');
    COMMIT;
END add_ware_product;
/
-- Procedure for adding a new user
CREATE OR REPLACE PROCEDURE add_user(
    in_role_id NUMBER,
    in_user_name VARCHAR2,
    in_email_address VARCHAR2,
    in_street_address VARCHAR2,
    in_city VARCHAR2,
    in_zipcode VARCHAR2,
    in_country VARCHAR2,
    in_state VARCHAR2,
    in_phone_number VARCHAR2
) AS
BEGIN
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
    DBMS_OUTPUT.PUT_LINE('User Added');
    COMMIT;
END add_user;
/

-- Procedure for adding a new Order
CREATE OR REPLACE PROCEDURE add_order(
    in_user_id NUMBER,
    in_order_qty NUMBER,
    in_order_status VARCHAR2
) AS
BEGIN
    INSERT INTO order_table VALUES (
        order_id_seq.NEXTVAL,
        in_user_id,
        in_order_qty,
        in_order_status,
        SYSDATE
    );
    DBMS_OUTPUT.PUT_LINE('Order Added');
    COMMIT;
END add_order;
/
-- Procedure for adding a new User Product
CREATE OR REPLACE PROCEDURE add_user_product(
    in_product_id NUMBER,
    in_order_id NUMBER,
    in_up_quantity NUMBER
) AS
    v_product_cost NUMBER;
BEGIN
    -- Retrieve the product cost
    SELECT product_cost INTO v_product_cost
    FROM product
    WHERE product_id = in_product_id;
    -- Insert into user_product with calculated up_price
    INSERT INTO user_product VALUES (
        user_product_id_seq.NEXTVAL,
        in_product_id,
        in_order_id,
        in_up_quantity,
        in_up_quantity * v_product_cost -- Calculate up_price
    );
    DBMS_OUTPUT.PUT_LINE('User Product Added');
    COMMIT;
END add_user_product;
/
-- Procedure for adding a new Payment
CREATE OR REPLACE PROCEDURE add_payment(
    in_order_id NUMBER,
    in_payment_mode VARCHAR2,
    in_payment_status VARCHAR2
) AS
BEGIN
    INSERT INTO payment VALUES (
    payment_id_seq.NEXTVAL,
        in_order_id,
        in_payment_mode,
        SYSDATE,
        in_payment_status
    );
    DBMS_OUTPUT.PUT_LINE('Payment Added');
    COMMIT;
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
EXEC add_user(1, 'App_admin', 'admin@example.com', '456 Admin St', 'AdminCity', 'Admin12345', 'AdminLand', 'AdminState', '123-456-7890');
EXEC add_user(2, 'customer1', 'customer1@example.com', '123 Customer St', 'CustomerCity', 'Customer12345', 'CustomerLand', 'CustomerState', '987-654-3210');
EXEC add_user(2, 'customer2', 'customer2@example.com', '789 Customer St', 'CustomerCity', 'Customer54321', 'CustomerLand', 'CustomerState', '555-555-5555');
EXEC add_user(3, 'product_manager', 'productmanager@example.com', '789 Prod Manager St', 'ProdManagerCity', 'ProdManager54321', 'ProdManagerLand', 'ProdManagerState', '555-555-5556');
EXEC add_user(4, 'inventory_manager', 'inventorymanager@example.com', '456 Inv Manager St', 'InvManagerCity', 'InvManager12345', 'InvManagerLand', 'InvManagerState', '123-456-7891');
