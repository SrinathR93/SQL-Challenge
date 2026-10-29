use sql7challenge;

/* total Sales*/
select sum(oi.quantity*oi.unit_price) as total_sales 
from orders o 
join order_items oi 
on o.order_id=oi.order_id
where status<> 'cancelled';

/*Revenue by product Category*/
select p.category,sum(oi.quantity*oi.unit_price)as revenue
from orders o
join order_items oi
on o.order_id=oi.order_id
join products p
on oi.product_id=p.product_id
where o.status<>'cancelled'
group by p.category
order by revenue;

/*Count Payment method*/
select payment_method ,count(*) AS total_payments
from payments
group by payment_method
order by total_payments desc;

/*count payments by their status*/
select payment_status,
count(*) AS total_payments
from payments
group by payment_status;

/*calculate the average recorded payment amount*/
select avg(amount) AS average_payment_amount
from payments;

/*calculate the total recorded payment amount for each payment method*/
select payment_method,
sum(amount) as total_payment_amount
from payments
group by payment_method;


