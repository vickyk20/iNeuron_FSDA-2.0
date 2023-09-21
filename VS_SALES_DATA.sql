use database demo_database;
create or replace table VS_sales_data
(
order_id varchar (40) ,
order_date DATE primary key,
ship_date DATE,
ship_mode varchar (30),
customer_name varchar  (40),
segment varchar (30),
state varchar (40),
country varchar (40),
market varchar (20),
region varchar (40),
product_id varchar (40),
category varchar (30),
sub_category varchar (30),
product_name varchar (150),
sales NUMBER (10,0),
quantity number (10),
discount varchar (10),
profit varchar (30),
shipping_cost varchar (20),
order_priority char (8),
Year number (10,0)
);

Describe Table  VS_sales_data;    
Select * from VS_sales_data

-- I create a table structure like previously create table with no data

create or replace table VS_sales_data_copy like VS_sales_data
Describe Table  VS_sales_data_copy;
select * from  VS_sales_data_copy


-- I create a table structure like previously create table with  data

create or replace table VS_sales_data_copy_data as 
Select * from VS_sales_data;
Select * from VS_sales_data_copy_data;

---Assignment Snowflake

--1. Load the given dataset into snowflake with a primary key to Order Date column.

Alter table VS_sales_data_copy
Add primary key (order_date);

Alter table VS_sales_data_copy
drop primary key;

describe table VS_sales_data_copy;

---2. Change the Primary key to Order Id Column.

Alter table VS_sales_data_copy
Add primary key (order_id);

describe table VS_sales_data_copy;

---3. Check the data type for Order date and Ship date and mention in what data type 
---it should be?

 Already changes the format through data cleaning.
 

--4. Create a new column called order_extract and extract the number after the last 
--‘–‘from Order ID column.

    alter table VS_sales_data_copy_data
    add column order_extract varchar (30);
  

    select order_id ,substring (order_id,9 ,8 )
     from  VS_sales_data_copy_data;

    update VS_sales_data_copy_data
    set order_extract = substring (order_id,9 ,8 );
    
    select * from VS_sales_data_copy_data;

    -----5. Create a new column called Discount Flag and categorize it based on discount. 
---Use ‘Yes’ if the discount is greater than zero else ‘No’.


           alter table VS_sales_data_copy_data
            add column discount_flag  varchar(20);
         
            
           update VS_sales_data_copy_data
           set  discount_flag = 'yes' where discount > 0;

           update VS_sales_data_copy_data
           set  discount_flag = 'false' where discount > 0;

             select * from VS_sales_data_copy_data;
             

    ---- OR WE CAN DO WITH ANOTHER METHOD WHERE CONDITIONS SHOW YES OR FALSE AT THE SAME TIME

                          SELECT *,
                                   CASE
                                       WHEN discount > 0 THEN 'yes'
                                       ELSE 'false'
                                       END AS  discount_flag
                                      FROM VS_sales_data_copy_data;


----6. Create a new column called process days and calculate how many days it takes 
---for each order id to process from the order to its shipment

                alter table VS_sales_data_copy_data
                add column process_days varchar(30);

                select order_date,ship_date, datediff( day, order_date, ship_date) as diff_in_order_ship
                FROM VS_sales_data_copy_data;

                UPDATE VS_sales_data_copy_data
                set process_days =  datediff( day, order_date, ship_date) ; 
                                      
                 select * from VS_sales_data_copy_data;

                 

--7. Create a new column called Rating and then based on the Process days give 
--rating like given below.
--a. If process days less than or equal to 3days then rating should be 5
--b. If process days are greater than 3 and less than or equal to 6 then rating 
--should be 4
--c. If process days are greater than 6 and less than or equal to 10 then rating 
--should be 3
--d. If process days are greater than 10 then the rating should be 2


alter table VS_sales_data_copy_data
add column rating varchar (20);

update VS_sales_data_copy_data
set rating = '5' where process_days <=3;


update VS_sales_data_copy_data
set rating = '4' where process_days > 3 and process_days <=6;


update VS_sales_data_copy_data
set rating = '3' where process_days > 6 and process_days <=10;

update VS_sales_data_copy_data
set rating = '2' where process_days >10;

select * from VS_sales_data_copy_data;

                 
        







