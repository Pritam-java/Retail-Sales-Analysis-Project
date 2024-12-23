## **SQL Queries and insights**

### **Q1. Total revenue generated by each product category**
select category, sum(total_sale) as revenue from retail_analysis.retail_data group by category order by revenue desc;

### **Q2. Top 5 customers contributing the most to sales**
select customer_id, sum(total_sale) as rev from retail_analysis.retail_data group by customer_id order by rev desc limit 5;

### **Q3. Top customers in each category
select category, customer_id, sum(total_sale) , rank() over(partition by category order by sum(total_sale) desc) as rn from retail_analysis.retail_data group by category, customer_id;

### **Q4. Which gender contributes the most to sales revenue**
select gender, sum(total_sale) as rev from retail_analysis.retail_data group by gender order by rev desc;

## **Q5. Age distribution of customers purchasing products**
select age, count(distinct customer_id) as unique_customers, sum(total_sale - cogs) as rev from retail_analysis.retail_data group by age order by rev, unique_customers desc;
## revenue = total_sales - cogs

### **Q6. Most profitable product category in terms of revenue and COGS**
select distinct category, round(sum(total_sale - cogs), 2) as rev from retail_analysis.retail_data group by category order by rev desc;

## **Q7. Write a SQL query to calculate the average sale for each month.Find out best selling month in each year**
select year, month, avg_sale
from
( 
select year(sale_date) as year, 
month(sale_date) as month, 
avg(total_sale) as avg_sale,
rank() over(partition by year(sale_date) order by avg(total_sale) desc) as rn
from retail_analysis.retail_data
group by year, month
) as t1
where rn = 1;

## **Q8. Create shifts and calculate the number of orders of each shift**

select
case
when hour(sale_time) < 12 then 'morning'
when hour(sale_time) between 12 and 17 then 'afternoon'
else 'evening'
end as shifts,
count(*) as tot_orders
from retail_analysis.retail_data
group by shifts;