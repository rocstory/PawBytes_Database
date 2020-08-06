-- Malik Roc
-- Paw Bytes
-- populate.sql
-- Creates all PawBytes schema objects

DELETE FROM Conduct_Session;
DELETE FROM Attend_Session;

DELETE FROM Tweet_Treat_Owner;

DELETE FROM Training_Session;

DELETE FROM Order_Invoice_t;

DELETE FROM Customer_Address;
DELETE FROM Customer;

DELETE FROM Product_Price;
DELETE FROM Product;

DELETE FROM Employee_Address;
DELETE FROM Employee;

DELETE FROM PawPal_DateGroomed;
DELETE FROM PawPal_t;

DELETE FROM Orders;

DELETE FROM Tweet_Treat;

INSERT INTO Customer(CID, FirstName)
VALUES
    (1, 'Naomi'),
    (2, 'Hazel'),
    (3, 'Jr'),
    (4, 'Mya');


INSERT INTO Customer_Address(CID, Street, City, cState, ZipCode)
VALUES
    (1, '475 5th Ave', 'New York', 'NY', '100017'),
    (2, '475 5th Ave', 'New York', 'NY', '100017'),
    (3, '475 5th Ave', 'New York', 'NY', '100017'),
    (4, '475 5th Ave', 'New York', 'NY', '100017');

INSERT INTO Product(PID,productName, productType)
VALUES
    -- Services
    (0,'Stay-in', 'Service'),

    -- Beverages
    (1,'Lemonade', 'Beverage'),
    (2,'Apple Juice', 'Beverage'),
    (3,'Mango Juice', 'Beverage'),
    (4,'Cranberry Juice', 'Beverage'),

    -- Meal
    (5,'Soup', 'Meal'),
    (6,'Rice', 'Meal'),
    (7,'Steak', 'Meal'),
    (8,'Chicken', 'Meal');

INSERT INTO Product_Price(PID, Price)
VALUES
    -- Beverages
    (0, 1.10),

    (1, 1.50),
    (2, 1.50),
    (3, 1.50),
    (4, 1.50),

    (5, 3.50),
    (6, 5.00),
    (7, 4.00),
    (8, 3.00);

INSERT INTO Employee(EID, FirstName, LastName, Email, PhoneNumber)
VALUES
    (0, 'Malik'  , 'Story'  , 'mstory@pawpals.com'    , '(203)333-7433'),
    (1, 'Anusha' , 'Canines', 'acanines@pawpals.com'  , '(203)333-7432'),
    (2, 'Matheus', 'Game'   , 'mgame@pawpals.com'     , '(203)333-7431'),
    (3, 'Elly'   , 'Toile'  , 'etoile@pawpals.com'    , '(203)333-7430'),
    (4, 'Niki'   , 'Psy'    , 'npsy@pawpals.com'      , '(203)333-7433');


INSERT INTO Employee_Address(EID, Street, City, cState, ZipCode)
VALUES
    (1, '1051 Long Ridge Rd', 'Stamford', 'CT', '06903'),
    (2, '1051 Long Ridge Rd', 'Stamford', 'CT', '06903'),
    (3, '1051 Long Ridge Rd', 'Stamford', 'CT', '06903'),
    (4, '1051 Long Ridge Rd', 'Stamford', 'CT', '06903');

INSERT INTO PawPal_t(pawID, pawName, species, tagName)
VALUES
    (0, 'Misty', 'dog', 'misty'),
    (1, 'Blue', 'dog', 'blue'),
    (2, 'Carson', 'dog', 'barson'),
    (3, 'Sammy', 'cat', 'thammy'),
    (4, 'Zoey', 'cat', 'zoey');


INSERT INTO PawPal_DateGroomed(pawID)
VALUES
    (0),
    (1),
    (2),
    (3),
    (4); 
-- end here
INSERT INTO Orders_t(orderID)
VALUES
    (100),
    (101),
    (102); 

INSERT INTO Order_Invoice_t(orderID, PID, CID, quantity)
VALUES
    (100, 0, 1, 1), 
    (100, 1, 1, 1),
    (100, 2, 1, 1),
    (100, 5, 1, 1),

    (101, 0, 2, 1),
    (101, 6, 2, 4),
    (101, 3, 2, 1),

    (102, 0, 3, 1), 
    (102, 3, 3, 1),
    (102, 4, 3, 3);

INSERT INTO Training_Session(SessionID)
VALUES
    (901),
    (902),
    (903),
    (904),
    (905);

INSERT INTO Attend_Session(SessionID, pawID)
VALUES
    (901, 0),
    (902, 0),
    (903, 0),
    (904, 0),
    (905, 0),

    (901, 1),
    (902, 1),
    (903, 1),
    (904, 1),
    (905, 1),

    (901, 2),
    (902, 2),
    (903, 2),
    (904, 2),
    (905, 2),

    (901, 3),
    (902, 3),
    (903, 3),
    (904, 3),
    (905, 3),

    (901, 4),
    (902, 4),
    (903, 4),
    (904, 4),
    (905, 4);

INSERT INTO Conduct_Session(SessionID, EID)
VALUES
    (901, 0),
    (902, 1),
    (903, 2),
    (904, 3),
    (905, 4);
 