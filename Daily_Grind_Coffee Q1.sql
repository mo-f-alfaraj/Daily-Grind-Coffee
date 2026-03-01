-- Combining The Orders by Years
with [All Orders] as (
select OrderID,
CustomerID,
ProductID,
OrderDate,
Quantity,
Revenue,
COGS
from Orders_2023

union all

select OrderID,
CustomerID,
ProductID,
OrderDate,
Quantity,
Revenue,
COGS
from Orders_2024

union all

select OrderID,
CustomerID,
ProductID,
OrderDate,
Quantity,
Revenue,
COGS
from Orders_2025)

-- Building The Main DataSet Query
select 
a.OrderID,
a.CustomerID,
c.Region,
a.ProductID,
c.CustomerJoinDate,
a.OrderDate,
a.Quantity,
a.Revenue,
case when a.Revenue is null then p.Price * a.Quantity else a.Revenue end as [Cleaned Revenue],   
a.Revenue - a.COGS as [Profit],
a.COGS,
p.ProductName,
p.ProductCategory,
p.Price,
p.Base_Cost
from [All Orders] as a
left join Customers as c
on a.CustomerID = c.CustomerID
left join Products as p
on a.ProductID = p.ProductID
where a.CustomerID is not null -- Dropping Null Customer IDs 
