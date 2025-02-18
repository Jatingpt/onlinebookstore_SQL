---- LOADING THE DATASET ----

SELECT * FROM onlinebookstore.books;

SELECT * FROM onlinebookstore.customers;

SELECT * FROM onlinebookstore.orders_table;

---- Finding the valuable insights from the dataset.

--  What is the costlier book that have been sold.

SELECT MAX(Price) from onlinebookstore.books;


--  Which books are short in stock.

SELECT * FROM onlinebookstore.books WHERE Stock < 50;


--  Total  number of books which we need to keep in our stock. 

SELECT COUNT(*) FROM onlinebookstore.books WHERE Stock  < 50;


--  All the genre present in out stock.

SELECT Genre , Count(Genre) FROM onlinebookstore.books GROUP BY Genre; 


--  Finding the top 5 genre.

SELECT Genre, Count(Genre) FROM onlinebookstore.books 
GROUP BY Genre ORDER BY Genre DESC LIMIT 5;


--  Retrieving the total number of books that are available in the stock.

SELECT SUM(Stock) AS Total_Stock FROM onlinebookstore.books;


--  Select customers who ordered more than 5 book.

SELECT * FROM onlinebookstore.Orders_table
WHERE Quantity > 5 ORDER BY Quantity DESC;


--  Retrieve all orders where the total amount exceeds $20.

SELECT *  FROM onlinebookstore.books WHERE Price > 20 ORDER BY Price DESC;


--  Calculate the total revenue generated by all orders.alter

SELECT SUM(Total_Amount) as total_revenue FROM onlinebookstore.orders_table;


--  On the basis of months how many books are ordered.

SELECT DATE_FORMAT(order_date, '%Y-%m')
AS order_month, COUNT(*) as total_orders
FROM onlinebookstore.orders_table
GROUP BY order_month 
ORDER BY order_month;


--  Retrieve the total number of books sold for each genre. 

SELECT onlinebookstore.books.Genre, SUM(onlinebookstore.orders_table.Quantity) AS total_books_sold
FROM onlinebookstore.books
INNER JOIN onlinebookstore.orders_table
ON onlinebookstore.books.Book_ID = onlinebookstore.orders_table.Book_ID
GROUP BY onlinebookstore.books.Genre;


--  Find the average price of book in each genre. 

SELECT onlinebookstore.books.Genre, avg(onlinebookstore.orders_table.Total_Amount) AS Avg_Amount
FROM onlinebookstore.books RIGHT JOIN onlinebookstore.orders_table 
ON onlinebookstore.books.Book_ID = onlinebookstore.orders_table.Book_ID
GROUP BY onlinebookstore.books.Genre;


--  List customers who have placed more than 2 orders.alter.

SELECT Customer_ID, COUNT(Customer_ID) FROM onlinebookstore.orders_table
GROUP BY Customer_ID HAVING COUNT(Customer_ID) >= 2;


--  Lists the most frequently ordered books ordered by the customers.

SELECT onlinebookstore.books.Book_ID, onlinebookstore.books.Title, onlinebookstore.orders_table.Quantity
AS Quantity_Ordered FROM onlinebookstore.books
INNER JOIN onlinebookstore.orders_table
ON onlinebookstore.books.Book_ID = onlinebookstore.orders_table.Book_ID
ORDER BY onlinebookstore.orders_table.Quantity DESC;


--  Lists the cities where the customers who spent over $30.

SELECT  DISTINCT onlinebookstore.customers.City, Total_Amount 
FROM onlinebookstore.customers INNER JOIN onlinebookstore.orders_table
ON onlinebookstore.customers.Customer_ID = onlinebookstore.orders_table.Customer_ID
WHERE onlinebookstore.orders_table.Total_Amount > 30;


--  Lisy top 3 books in fantasy genre.

SELECT * FROM onlinebookstore.books WHERE Genre = "Fantasy" 
ORDER BY Price DESC LIMIT 3;


--  Which authors have their books ordered, 
-- along with the total quantity of books ordered and the count of books they have written?


SELECT 
    onlinebookstore.books.Author, 
    SUM(onlinebookstore.orders_table.Quantity) AS Total_Quantity, 
    COUNT(onlinebookstore.books.Author) AS Books_Count
FROM onlinebookstore.books
INNER JOIN onlinebookstore.orders_table 
ON onlinebookstore.books.Book_ID = onlinebookstore.orders_table.Book_ID
GROUP BY onlinebookstore.books.Author;


--  Which authors have their books sold, along with the total quantity sold, 
--    including those who haven't sold any books?

select onlinebookstore.books.Author, sum(onlinebookstore.orders_table.Quantity) as total_book_sold
from  onlinebookstore.orders_table left join onlinebookstore.books
on onlinebookstore.books.Book_ID = onlinebookstore.orders_table.Book_ID
group by onlinebookstore.books.Author;


--  Calculate the total remaining stock after fullfilling all the orders.

SELECT 
    onlinebookstore.books.Book_ID, 
    onlinebookstore.books.Title, 
    (onlinebookstore.books.Stock - IFNULL(SUM(onlinebookstore.orders_table.Quantity), 0)) 
    AS remaining_stock
FROM onlinebookstore.books
LEFT JOIN onlinebookstore.orders_table 
ON onlinebookstore.books.Book_ID = onlinebookstore.orders_table.Book_ID
GROUP BY onlinebookstore.books.Book_ID, onlinebookstore.books.Title,onlinebookstore.books.Stock;













