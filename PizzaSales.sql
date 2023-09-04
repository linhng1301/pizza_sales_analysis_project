SELECT *
FROM dbo.pizza_sales

-- Total revenue
SELECT
	SUM(total_price) AS Total_Revenue
FROM dbo.pizza_sales

-- Average Order Value
SELECT
	SUM(total_price)/COUNT(DISTINCT order_id) AS Average_Order_Value
FROM dbo.pizza_sales

-- Total Pizzas Sold
SELECT
	SUM(quantity) AS Total_Pizzas_Sold
FROM dbo.pizza_sales
 
-- Total Orders
SELECT
	COUNT(DISTINCT order_id) AS Total_Orders
FROM dbo.pizza_sales
-- Average Pizzas Per Order
SELECT
	CAST(CAST(SUM(quantity) AS decimal)/CAST(COUNT(DISTINCT order_id) AS decimal) AS decimal(10,2)) AS Avg_Pizzas_Per_Order
FROM dbo.pizza_sales

-- Daily Trend for Total Orders (on a daily basis) -> we should return total order per weekday
SELECT
	DATENAME(DW,order_date) AS Weekday,
	COUNT(Distinct order_id) AS Total_orders
FROM dbo.pizza_sales
GROUP BY DATENAME(DW,order_date)

-- Monthly Trend for Total Orders -> return total order by month
SELECT
	DATENAME(MONTH,order_date) AS Month,
	COUNT(Distinct order_id) AS Total_orders
FROM dbo.pizza_sales
GROUP BY DATENAME(MONTH,order_date)
ORDER BY Total_orders

-- Percentage of Sales by Pizza Category
SELECT
	pizza_category,
	SUM(total_price) AS Total_price,
	ROUND(SUM(total_price)/(SELECT SUM(total_price) FROM dbo.pizza_sales) * 100,2) AS Percentage_sales_by_category
FROM dbo.pizza_sales
GROUP BY pizza_category
ORDER BY Percentage_sales_by_category DESC

-- Percentage of Sales by Pizza Size
SELECT
	pizza_size,
	SUM(total_price) AS Total_price,
	ROUND(SUM(total_price)/(SELECT SUM(total_price) FROM dbo.pizza_sales) * 100,2) AS Percentage_sales_by_size
FROM dbo.pizza_sales
GROUP BY pizza_size
ORDER BY Percentage_sales_by_size DESC

-- Total Pizzas Sold by Pizza Category
SELECT
	pizza_category,
	SUM(quantity) AS Quantity
FROM dbo.pizza_sales
GROUP BY pizza_category

-- Top 5 Best Sellers by Revenue
SELECT
	pizza_name,
	SUM(total_price) AS Total_Revenue
FROM dbo.pizza_sales
GROUP BY pizza_name
ORDER BY Total_Revenue DESC

-- Top 5 Best Sellers by Quantity
SELECT
	pizza_name,
	SUM(quantity) AS Total_quantity
FROM dbo.pizza_sales
GROUP BY pizza_name
ORDER BY Total_quantity DESC

-- Top 5 Best Sellers by Order
SELECT
	pizza_name,
	COUNT(DISTINCT order_id) AS Total_order
FROM dbo.pizza_sales
GROUP BY pizza_name
ORDER BY Total_order DESC

