select * from region;
select * from sales_reps;
select * from web_events;
select * from accounts;
select* from orders;

------- AN SQL CASE STUDY ON A COMPANY'S DATABASE WHICH INCLUDES
------- DATASET ON THEIR ORDERS, ACCOUNTS, SALES REPS,
------- WEB EVENTS AND REGIONS

----- USE OF JOINS AND OTHER ADVANCED 
----- SQL QUERIES WILL BE USED



--- Q1. TOP 10 ACCOUNTS WITH THE HIGHEST ORDERS

select * from accounts;
select * from orders;

select a.name "account", sum(o.total_amt_usd) "total_worth",
sum(o.total) "total"
from 
accounts a
join 
orders o
on
a.id = o.account_id
group by 1
order by 2 desc
limit 10;

-- "EOG Resources" had the highest amount of orders 
-- with a total of USD 382,873.30



-- Q2. REPS MANAGING "EOG Resources" AND THEIR REGIONS

select s.name "sales_reps", r.name "region"
from
sales_reps s
join
accounts a
on
s.id = a.sales_rep_id
join
region r
on
r.id = s.region_id
where 
a.name = 'EOG Resources'
group by 2, 1;

-- JUST ONE SALES REP IS ASSIGNED TO EOG Resources IN THE PERSON OF
-- "Arica Stoltzfus" IN THE WESTERN REGION.
-- WHO WAS ALSO THE SALES REP WITH THE 5TH HIGHEST ORDERS



-- Q3. ARE THERE OTHER ACCOUNTS THAT "Arica Stoltzfus" IS MANAGING?

select a.name "accounts"
from 
accounts a
join
sales_reps s
on
a.sales_rep_id = s.id
where
s.name = 'Arica Stoltzfus';

-- Arica Stoltzfus manages 9 other accounts aside "EOG Resources"



-- Q4. CHANNEL THAT GENERATED THE HIGHEST AMOUNT 
-- OF ORDERS AND THE WORTH OF THE ORDERS

select w.channel "channel", sum(o.total) "total_qty", 
sum(o.total_amt_usd) "total_worth"
from
orders o
join 
web_events w
on
o.account_id = w.account_id
group by 1
order by 2 desc;

-- MOST OF THEIR ORDERS WHERE DIRECT WITH 
-- OVER 100 MILLION ORDERS BEING MADE THEROUGH
-- THE DIRECT CHANNEL. VERY FEW ORDERS WERE MADE THROUGH
-- BANNERS



-- Q5. ACCOUNTS THAT USED THE DIRECT CHANNEL THE MOST

select a.name "account", count(a.name) "counts"
from
accounts a
join
web_events w
on 
a.id = w.account_id
where
w.channel = 'direct'
group by 1
order by 2 desc;

-- "Leucadia National" (52 times), 
-- "New York Life Insurance" (51 times) and
-- "Colgate-Palmolive" (51 times) were most active on the direct channel



-- Q6. SALES REP WHO THE HIGHEST AMOUNT OF ORDERS WERE MADE THROUGH

select s.name "sales_rep", sum(o.total) "total"
from
sales_reps s
join
accounts a
on
s.id = a.sales_rep_id
join
orders o
on
a.id = o.account_id
group by 1
order by 2 desc;

-- "Earlie Schleusner" recorded the highest amount of 
-- orders (174430) 



-- Q7. ACCOUNTS THAT GENERATED THE TOTAL AMOUNT OF ORDERS
-- GOTTEN BY Earlie Schleusner

select a.name, sum(o.total) "total_orders"
from
accounts a
join
orders o
on
a.id = o.account_id
join
sales_reps s
on
a.sales_rep_id = s.id
where
s.name = 'Earlie Schleusner'
group by 1
order by 2 desc;

-- A total of 11 accounts were managed by Earlie Schleusner
-- and "Fluor" generated the highest amount of orders (36887)
