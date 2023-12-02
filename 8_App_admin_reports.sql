---REPORTS 

--1) Product Sales Report: 
--Lists products within the specified category along with the total number of sales for each product.

SET SERVEROUTPUT ON;
CREATE OR REPLACE PROCEDURE get_product_sales_report(in_category_id NUMBER)
IS
BEGIN
    DBMS_OUTPUT.PUT_LINE('Product Sales Report:');
    DBMS_OUTPUT.PUT_LINE('-------------------------------------');
    FOR product_sale IN (SELECT p.product_id,
                                  p.product_name,
                                  COUNT(o.order_id) AS total_sales
                           FROM vw_order_table o
                                JOIN vw_user_product up ON o.order_id = up.order_id
                                JOIN vw_product p ON up.product_id = p.product_id
                           WHERE p.category_id = in_category_id
                           AND o.order_status='Completed'
                           GROUP BY p.product_id, p.product_name
                           ORDER BY total_sales DESC)

    LOOP
        DBMS_OUTPUT.PUT_LINE('Product: ' || product_sale.product_name || ', Total Sales: ' || product_sale.total_sales);
    END LOOP;
END get_product_sales_report;
/

--select * from order_table;
--select * from user_product;

exec get_product_sales_report(1);
-------------------------------------------------------------------------------
--2) Payment Status Report: 
--Displays payment details for a specific order, including payment ID, mode, status, and order date.

CREATE OR REPLACE PROCEDURE get_payment_status_report(in_order_id NUMBER)
IS
BEGIN
    DBMS_OUTPUT.PUT_LINE('Payment Status Report:');
    DBMS_OUTPUT.PUT_LINE('-------------------------------------');
    FOR payment_status IN (SELECT p.payment_id,
                                     p.payment_mode,
                                     p.payment_status,
                                     o.order_date,
                                     p.payment_date                                    
                              FROM vw_payment p
                                   JOIN vw_order_table o ON p.order_id = o.order_id
                              WHERE o.order_id = in_order_id
                              ORDER BY p.payment_id)
    LOOP
        DBMS_OUTPUT.PUT_LINE('Payment ID: ' || payment_status.payment_id ||
                             ', Payment Mode: ' || payment_status.payment_mode ||
                             ', Status: ' || payment_status.payment_status ||
                             ', Order Date: ' || TO_CHAR(payment_status.order_date, 'YYYY-MM-DD HH24:MI:SS') ||
                             ', Payment Date: ' || TO_CHAR(payment_status.payment_date, 'YYYY-MM-DD HH24:MI:SS'));
    END LOOP;
END get_payment_status_report;
/

exec get_payment_status_report(1);

--------------------------------------------------------------------------------------------------