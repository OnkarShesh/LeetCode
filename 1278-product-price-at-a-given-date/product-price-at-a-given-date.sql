# Write your MySQL query statement below
SELECT p.product_id,
COALESCE(x.new_price ,10) AS price
FROM (
    SELECT DISTINCT product_id #to include evry ids
    FROM products 
) p
LEFT JOIN (
    SELECT p1.product_id , p1.new_price
    FROM Products p1
    JOIN(
        SELECT product_id, MAX(change_date) AS latest_date #this does not include all products ids
        FROM products
        WHERE change_date <= '2019-08-16'
        GROUP BY product_id
    ) p2
    ON p1.product_id = p2.product_id
    AND p1.change_date = p2.latest_date
) x 
ON p.product_id = x.product_id ;