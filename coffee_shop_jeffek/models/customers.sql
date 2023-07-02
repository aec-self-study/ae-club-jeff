{{ config(materialized='table') }}

select 
distinct(o.customer_id), 
c.name, 
c.email, 
first_value(created_at) over (partition by customer_id order by created_at asc) as first_order_at, 
count(total) as number_of_orders from `analytics-engineers-club.coffee_shop.orders` o
join `analytics-engineers-club.coffee_shop.customers` c on c.id = o.customer_id
group by 1,2,3, created_at
order by first_order_at limit 5