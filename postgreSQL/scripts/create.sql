-- Malik Roc
-- Paw Bytes
-- create.sql
-- Creates all PawBytes schema objects

BEGIN TRANSACTION;

CREATE TABLE IF NOT EXISTS Customer
(
    CID SERIAL NOT NULL UNIQUE PRIMARY KEY,
    FirstName VARCHAR(50) DEFAULT NULL
        CHECK(CHAR_LENGTH(TRIM(FirstName)) > 0),
    LastName VARCHAR(50) DEFAULT NULL
        CHECK(CHAR_LENGTH(TRIM(LastName)) > 0),
    Email VARCHAR(345) UNIQUE DEFAULT NULL
        CHECK (Email LIKE '_%@_%._%'),
    PhoneNumber VARCHAR(14) UNIQUE DEFAULT NULL
);

CREATE TABLE IF NOT EXISTS Customer_Address
(
    CID SERIAL NOT NULL REFERENCES Customer,
    Street VARCHAR(50) DEFAULT NULL,
    City VARCHAR(50) DEFAULT NULL,
    cState CHAR(2) DEFAULT NULL,
    ZipCode VARCHAR(8) DEFAULT NULL   
);

CREATE TABLE IF NOT EXISTS Product
(
    PID SERIAL NOT NULL PRIMARY KEY,
    productName VARCHAR(50) NOT NULL,
    productType VARCHAR(50) NOT NULL,
        CHECK(CHAR_LENGTH(TRIM(productType)) > 0)
);

CREATE TABLE IF NOT EXISTS Product_Price 
(
    PID SERIAL NOT NULL REFERENCES Product,
    Price NUMERIC(10,2) NOT NULL,
    EstablishedDate DATE NOT NULL DEFAULT CURRENT_DATE,
    PRIMARY KEY(PID, EstablishedDate)
);

CREATE TABLE IF NOT EXISTS Employee
(
    EID SERIAL NOT NULL PRIMARY KEY,
    FirstName VARCHAR(50) 
        CHECK(CHAR_LENGTH(TRIM(FirstName)) > 0),
    LastName VARCHAR(50) 
        CHECK(CHAR_LENGTH(TRIM(LastName)) > 0),
    Email VARCHAR(345) UNIQUE
        CHECK (Email LIKE '_%@_%._%'),
    PhoneNumber VARCHAR(14)
);

CREATE TABLE IF NOT EXISTS Employee_Address
(
    EID SERIAL NOT NULL REFERENCES Employee,
    Street VARCHAR(50),
    City VARCHAR(50),
    cState CHAR(2),
    ZipCode VARCHAR(8),
    PRIMARY KEY(EID)
);

CREATE TABLE IF NOT EXISTS PawPal_t
(
    pawID SERIAL NOT NULL PRIMARY KEY,
    pawName VARCHAR(50)
        CHECK(CHAR_LENGTH(TRIM(pawName)) > 0),
    species VARCHAR(16)
        CHECK(CHAR_LENGTH(TRIM(species)) > 0),
    tagName VARCHAR(16)
        CHECK(CHAR_LENGTH(TRIM(tagName)) > 0)
);

CREATE TABLE IF NOT EXISTS PawPal_DateGroomed
(
    pawID SERIAL NOT NULL REFERENCES PawPal_t,
    dateGroomed DATE NOT NULL DEFAULT CURRENT_DATE,
    PRIMARY KEY(pawID, dateGroomed)
);


CREATE TABLE IF NOT EXISTS Orders_t
(
    orderID SERIAL NOT NULL PRIMARY KEY,
    orderDate DATE NOT NULL DEFAULT CURRENT_DATE
);

CREATE TABLE IF NOT EXISTS Order_Invoice_t
(
    orderID SERIAL NOT NULL REFERENCES Orders_t,
    PID SERIAL NOT NULL REFERENCES Product,
    CID SERIAL NOT NULL REFERENCES Customer,
    quantity INTEGER NOT NULL
        CHECK(quantity > 0)
);

CREATE TABLE IF NOT EXISTS Training_Session
(
    SessionID SERIAL NOT NULL PRIMARY KEY,
    SessionDate DATE NOT NULL DEFAULT CURRENT_DATE
);

CREATE TABLE IF NOT EXISTS Attend_Session
(
    SessionID SERIAL NOT NULL REFERENCES Training_Session,
    pawID SERIAL NOT NULL REFERENCES PawPal_t,
    PRIMARY KEY(SessionID, pawID)
);

CREATE TABLE IF NOT EXISTS Conduct_Session
(
    SessionID SERIAL NOT NULL REFERENCES Training_Session,
    EID SERIAL NOT NULL REFERENCES Employee,
    PRIMARY KEY(SessionID, EID)
);

CREATE TABLE IF NOT EXISTS Tweet_Treat
(
    tweetID BIGINT NOT NULL PRIMARY KEY,
    tweet_owner CHAR(20) NOT NULL,
    tweet_text TEXT NOT NULL,
    dateSaved TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE IF NOT EXISTS Tweet_Treat_Owner
(
    tweetID BIGINT REFERENCES Tweet_Treat,
    pawID SERIAL REFERENCES PawPal_t,
    PRIMARy KEY(tweetID, pawID)
);

-- VIEWS

CREATE VIEW PawPal AS
SELECT pawID, pawName,
    (SELECT COUNT(*) FROM Attend_Session, PawPal_t WHERE Attend_Session.pawID = PawPals.pawID AND PawPal_t.pawID = PawPals.pawID) AS total_sessions_attended,
    (SELECT MAX(dateGroomed) FROM PawPal_DateGroomed WHERE PawPal_DateGroomed.pawID = PawPals.pawID) AS last_Date_Groomed
FROM PawPal_t as PawPals;

CREATE VIEW Order_Invoice_UnitPricing AS
SELECT estprices.orderID, estprices.pid, MAX(estprices.establishedDate) AS priceDate
FROM (
    SELECT Orders_t.orderID, Orders_t.orderDate, Order_Invoice_t.PID, Product_Price.price, Product_Price.EstablishedDate
    FROM Orders_t, Order_Invoice_t, Product_Price
    WHERE 
        Orders_t.orderid = Order_Invoice_t.orderID AND
        Order_Invoice_t.PID = Product_Price.PID AND
        Product_Price.EstablishedDate <= Orders_t.orderDate
    ) AS estprices 
GROUP BY estprices.orderID, estprices.pid 
ORDER BY estprices.orderID, estprices.pid;

CREATE VIEW Order_Invoice AS
SELECT ordInvoice.orderID, ordInvoice.PID, ordInvoice.CID, ordInvoice.quantity, pricing.price, (ordInvoice.quantity * pricing.price) AS lineTotal
FROM Order_Invoice_t AS ordInvoice, Product_Price AS pricing, Order_Invoice_UnitPricing AS unitPricing
WHERE
    unitPricing.priceDate = pricing.EstablishedDate AND
    ordInvoice.pid = pricing.pid AND
    ordInvoice.orderID = unitPricing.orderID AND
    ordInvoice.pid = unitPricing.pid
ORDER BY ordInvoice.orderID, pricing.pid;

CREATE VIEW Orders AS 
SELECT orders_t.orderID, orders_t.orderDate,
    (SELECT SUM(lineTotal) FROM Order_Invoice WHERE orders_t.orderID = Order_Invoice.orderID)
FROM Orders_t;

CREATE VIEW Tweet_Treat_Total AS
SELECT pawid, COUNT(pawid) FROM Tweet_Treat_Owner
GROUP BY pawid;




COMMIT;