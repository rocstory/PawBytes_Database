SELECT * FROM Order_Invoice;
SELECT * FROM Orders_t;

SELECT orders.orderID, orders.orderDate,
    (SELECT SUM(lineTotal) FROM Order_Invoice WHERE orders.orderID = Order_Invoice.orderID)
FROM Orders_t AS orders;



/*
SELECT * FROM Attend_Session;
SELECT * FROM PawPal_t;
SELECT * FROM PawPal_DateGroomed;

SELECT pawID, pawName,
    (SELECT COUNT(*) FROM Attend_Session, PawPal_t WHERE Attend_Session.pawID = PawPals.pawID AND PawPal_t.pawID = PawPals.pawID) AS totalHours,
    (SELECT MAX(dateGroomed) FROM PawPal_DateGroomed WHERE PawPal_DateGroomed.pawID = PawPals.pawID) AS lastDateGroomed
FROM PawPal_t as PawPals;

*/
--SELECT * FROM Orders;
--SELECT * FROM Order_Invoice_UnitPricing;
/*
SELECT * FROM Order_Invoice_t;
SELECT * FROM Product_Price;
SELECT * FROM Order_Invoice_UnitPricing;

SELECT ordInvoice.orderID, ordInvoice.PID, ordInvoice.CID, ordInvoice.quantity, pricing.price, (ordInvoice.quantity * pricing.price) AS lineTotal
FROM Order_Invoice_t AS ordInvoice, Product_Price AS pricing, Order_Invoice_UnitPricing AS unitPricing
WHERE
    unitPricing.priceDate = pricing.EstablishedDate AND
    ordInvoice.pid = pricing.pid AND
    ordInvoice.orderID = unitPricing.orderID AND
    ordInvoice.pid = unitPricing.pid

ORDER BY ordInvoice.orderID, pricing.pid;
*/
--SELECT *
--FROM Orders, Product_Price, Order_Invoice_UnitPricing;

--SELECT * FROM Order_Invoice_UnitPricing;
--SELECT * FROM Order_Invoice_t;
--SELECT * FROM Product_Price;
--SELECT * FROM Orders;


--SELECT * FROM Order_Invoice_UnitPricing;

--SELECT * FROM Order_Invoice_UnitPricing, Order_Invoice_t,
--WHERE ;


/*

SELECT orderID, PID, CID, quantity, 
    (
        SELECT Product_Price.price
        FROM Product_Price, Order_Invoice_UnitPricing
        WHERE Order_Invoice_UnitPricing.priceDate = Product_Price.establishedDate
    )
FROM Order_Invoice_t; 
*/


/*
SELECT *
FROM Product_Price, Order_Invoice_UnitPricing
WHERE 
    Order_Invoice_UnitPricing.priceDate = Product_Price.establishedDate AND
    Product_Price.PID = Order_Invoice_UnitPricing.PID;


SELECT orderID, PID, CID, quantity,
    (
        SELECT price
        FROM Product_Price, Order_Invoice_UnitPricing
        WHERE 
            Order_Invoice_UnitPricing.priceDate = Product_Price.establishedDate AND
            Product_Price.PID = Order_Invoice_UnitPricing.PID
    )
FROM Order_Invoice_t; 
*/
/*
SELECT estprices.orderID, estprices.pid, MAX(estprices.establishedDate) AS priceDate
FROM (
    SELECT Orders.orderID, Orders.orderDate, Order_Invoice_t.PID, Product_Price.price, Product_Price.EstablishedDate
    FROM Orders, Order_Invoice_t, Product_Price
    WHERE 
        Orders.orderid = Order_Invoice_t.orderID AND
        Order_Invoice_t.PID = Product_Price.PID AND
        Product_Price.EstablishedDate <= Orders.orderDate
    ) AS estprices 
GROUP BY estprices.orderID, estprices.pid --, estprices.price
ORDER BY estprices.orderID, estprices.pid;
*/

/*
SELECT item_pricing.OrderId,item_pricing.PID, item_pricing.price, MAX(item_pricing.establishedDate) 
FROM ( 
    -- Query that retrieves the item's price at the date of the order's creation
    SELECT Orders.orderID, Orders.orderDate, Order_Invoice_t.PID, Product_Price.price, Product_Price.EstablishedDate
    FROM Orders, Order_Invoice_t, Product_Price
    WHERE
        Orders.orderid = Order_Invoice_t.orderID AND
        Order_Invoice_t.PID = Product_Price.PID AND
        Product_Price.EstablishedDate <= Orders.orderDate
    ORDER BY Orders.orderID

    ) AS item_pricing, Orders
GROUP BY item_pricing.OrderID, item_pricing.PID, item_pricing.price -- error here
ORDER BY item_pricing.OrderID;
*/

/*
SAVED QUERY
SELECT Orders.orderID, Orders.orderDate, Order_Invoice_t.PID, Product_Price.price, Product_Price.EstablishedDate
FROM Orders, Order_Invoice_t, Product_Price
WHERE
    Orders.orderid = Order_Invoice_t.orderID AND
    Order_Invoice_t.PID = Product_Price.PID AND
    Product_Price.EstablishedDate <= Orders.orderDate
ORDER BY Orders.orderID;

*/
/*
-- Query that retrieves the item's price at the date of the order's creation
SELECT Orders.orderID, Orders.orderDate, Order_Invoice_t.PID, Product_Price.price, Product_Price.EstablishedDate
FROM Orders, Order_Invoice_t, Product_Price
WHERE
    Orders.orderid = Order_Invoice_t.orderID AND
    Order_Invoice_t.PID = Product_Price.PID AND
    Product_Price.EstablishedDate <= Orders.orderDate
ORDER BY Orders.orderID;
*/