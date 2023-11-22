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