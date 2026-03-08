DROP TABLE IF EXISTS blinkit_sales_data;

CREATE TABLE blinkit_sales_data(
    Item_Fat TEXT,
    Item_Identifier text,
    Item_Type TEXT,
    Outlet_Establishment_Year INT,
    Outlet_Identifier text,
    Outlet_Location_Type TEXT,
    Outlet_Size TEXT,
    Outlet_Type TEXT,
    Item_Visibility FLOAT,
    Item_Weight FLOAT,
    Sales FLOAT,
    Rating float
);
select * from blinkit_sales_data;

select count(*) from blinkit_sales_data;
update blinkit_sales_data
set item_fat=
case 
when item_fat in('LF','low fat') then 'Low Fat'
when item_fat='reg' then 'Regular'
else item_fat
end

select distinct(item_fat) from blinkit_sales_data;
--KPIs
select cast(sum(sales)/1000000 as decimal(10,2)) as Total_Sales_Millions from blinkit_sales_data;
 
select cast(avg(sales) as decimal(4,0)) as Avg_Sales from blinkit_sales_data;

select count(*) as No_of_items from blinkit_sales_data;

select cast(sum(sales)/1000000 as decimal(10,2)) as Total_Sales_Low_Fat from blinkit_sales_data
where item_fat='Low Fat';

select cast(avg(rating) as decimal(4,2)) as Avg_Rating from blinkit_sales_data;


select item_fat,concat(cast(sum(sales)/1000 as decimal(10,0)),'k') as Total_Sales_Thousands,
cast(avg(sales) as decimal(4,1)) as Avg_Sales,
count(*) as No_of_items,
cast(avg(rating) as decimal(4,2)) as Avg_Rating
from blinkit_sales_data
group by item_fat
order by Total_Sales_Thousands desc;


select item_type,cast(sum(sales) as decimal(10,2)) as Total_Sales,
cast(avg(sales) as decimal(4,1)) as Avg_Sales,
count(*) as No_of_items,
cast(avg(rating) as decimal(4,2)) as Avg_Rating
from blinkit_sales_data
group by item_type
order by Total_Sales desc
limit 5;


select item_fat,outlet_location_type,cast(sum(sales) as decimal(10,2)) as Total_Sales,
cast(avg(sales) as decimal(4,1)) as Avg_Sales,
count(*) as No_of_items,
cast(avg(rating) as decimal(4,2)) as Avg_Rating
from blinkit_sales_data
group by item_fat,outlet_location_type
order by Total_Sales desc;


select item_fat,outlet_location_type,
cast(sum(sales) as decimal(10,2)) as Total_Sales
from blinkit_sales_data
group by item_fat,outlet_location_type
order by Total_Sales desc

SELECT 
    Outlet_Location_Type,
    CAST(SUM(CASE WHEN Item_Fat = 'Low Fat' THEN Sales ELSE 0 END) AS DECIMAL(10,2)) AS Low_Fat,
    CAST(SUM(CASE WHEN Item_Fat = 'Regular' THEN Sales ELSE 0 END) AS DECIMAL(10,2)) AS Regular
FROM blinkit_sales_data
GROUP BY Outlet_Location_Type
ORDER BY Outlet_Location_Type;




select outlet_establishment_year,cast(sum(sales) as decimal(10,2)) as Total_Sales,
cast(avg(sales) as decimal(4,1)) as Avg_Sales,
count(*) as No_of_items,
cast(avg(rating) as decimal(4,2)) as Avg_Rating
from blinkit_sales_data
group by outlet_establishment_year
order by Total_Sales desc;

select distinct outlet_establishment_year from blinkit_sales_data
order by outlet_establishment_year;


select outlet_size,
cast(sum(sales) as decimal(10,2)) as Total_Sales,
cast((sum(sales)*100.0 / sum(sum(sales)) over()) as decimal(10,2)) as Total_Sales_percenatge
from blinkit_sales_data
group by outlet_size
order by Total_Sales desc;


select * from blinkit_sales_data;


select outlet_location_type,
cast(sum(sales) as decimal(10,2)) as Total_Sales,
cast((sum(sales)*100.0 / sum(sum(sales)) over()) as decimal(10,2)) as Sales_percenatge,
cast(avg(sales) as decimal(4,1)) as Avg_Sales,
count(*) as No_of_items,
cast(avg(rating) as decimal(4,2)) as Avg_Rating
from blinkit_sales_data
group by outlet_location_type
order by Total_Sales desc



select outlet_type,
cast(sum(sales) as decimal(10,2)) as Total_Sales,
cast((sum(sales)*100.0 / sum(sum(sales)) over()) as decimal(10,2)) as Sales_percenatge,
cast(avg(sales) as decimal(4,1)) as Avg_Sales,
count(*) as No_of_items,
cast(avg(rating) as decimal(4,2)) as Avg_Rating
from blinkit_sales_data
group by outlet_type
order by Total_Sales desc


