begin
    execute immediate 'drop user product_manager cascade';
    execute immediate 'drop user inventory_manager cascade';
    execute immediate 'drop user customer1 cascade';
    execute immediate 'drop user customer2 cascade';
exception
    when others then
        if sqlcode != -1918 then
            raise;
        end if;    
end;
/


--product_manager
create user product_manager identified by PasswordMaverick2;
grant create session to product_manager;
grant execute on add_product_category to product_manager;
grant execute on add_product to product_manager;
--grant execute on add_user_product to product_manager;
--grant execute on add_payment to product_manager;
--grant execute on add_order to product_manager;
grant select on vw_product_category to product_manager;
grant select on vw_product to product_manager;
grant select on vw_user_product to product_manager;
grant select on vw_payment to product_manager;
grant select on vw_order_table to product_manager;

--revoke select on product from product_manager;
--revoke select on product_category from product_manager;
--revoke select on user_product from product_manager;
--revoke select on payment from product_manager;
--revoke select on order_table from product_manager;

--select * from PRODUCT;
----
----
----
--inventory_manager
create user inventory_manager identified by PasswordMaverick3;
grant create session to inventory_manager;
grant execute on add_warehouse to inventory_manager;
grant execute on add_ware_product to inventory_manager;
grant select on vw_product to inventory_manager;
grant select on vw_product_category to inventory_manager;
grant select on vw_ware_product to inventory_manager;
grant select on vw_warehouse to inventory_manager;
grant select on vw_inventory_out_of_stock to inventory_manager;

--revoke select on product from inventory_manager;
--revoke select on product_category from inventory_manager;
--revoke select on ware_product from inventory_manager;
--revoke select on warehouse from inventory_manager;
-----
-----
-----
--customer1
create user customer1 identified by PasswordMaverick4;
grant create session to customer1;
grant execute on add_user_product to customer1;
grant execute on add_payment to customer1;
grant execute on add_order to customer1;
grant select on customer1_view to customer1;
grant select on vw_product to customer1;
grant select on vw_product_category to customer1;
----

--customer2
create user customer2 identified by PasswordMaverick5;
grant create session to customer2;
grant execute on add_user_product to customer2;
grant execute on add_payment to customer2;
grant execute on add_order to customer2;
grant select on customer2_view to customer2;
grant select on vw_product to customer2;
grant select on vw_product_category to customer2;