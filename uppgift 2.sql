Create DATABASE Bokhandel;
USE Bokhandel;
-- Skapa Kundertabellen
CREATE TABLE Kunder(
KundID INT AUTO_INCREMENT PRIMARY KEY,
Namn VARCHAR (100) NOT NULL,
Email VARCHAR (100) UNIQUE NOT NULL,
    Telefon VARCHAR (30) NOT NULL,
    Adress VARCHAR (200) NOT NULL
    );
    
    -- Skapa Bockertabellen
    CREATE TABLE Bocker (
    ISBN VARCHAR (30) PRIMARY key NOT NULL,
    Titel VARCHAR (200) NOT NULL,
    Forfattare VARCHAR (100) NOT NULL,
    Pris DECIMAL (10,2) NOT NULL CHECK (Pris>0),
    Lagerstatus INT NOT NULL
    );
     -- Skapa Bestallningartabellen
    CREATE TABLE Bestallningar (
    OrderID INT AUTO_INCREMENT PRIMARY KEY,
    KundID INT NOT NULL, 
    Datum DATE NOT NULL,
    Totalbelopp DECIMAL (10,2) NULL,
    FOREIGN KEY (KundID) REFERENCES Kunder (KundID)
    ON DELETE CASCADE
    );
    
    -- Skapa Orderradertabellen
    CREATE TABLE Orderrader (
    OrderradID INT AUTO_INCREMENT PRIMARY key,
    OrderID INT NOT NULL,
    ISBN VARCHAR (30) NOT NULL,
    Antal INT NOT NULL,
    Pris DECIMAL (10,2) NOT NULL ,
        FOREIGN KEY (ISBN) REFERENCES Bocker (ISBN),
        FOREIGN KEY (OrderID) REFERENCES Bestallningar (OrderID)
        ON DELETE CASCADE
    );
    
    -- Testa och kolla undertiden som vi bygger
    SHOW TABLES;
    DESCRIBE Kunder;
DESCRIBE Bocker;
DESCRIBE Bestallningar;
DESCRIBE Orderrader;
-- Inforga  data i Kunder
    
    INSERT INTO Kunder (Namn, Email, Telefon, Adress) VALUES
  ('Zahra Hadadi', 'Zahra@gmail.com', '0761547560', 'Kalmar'),
  ('Sara Gustafsson', 'sara@gmail.com', '0729856543', 'Helsingborg'),
  ('Emil Eriksson', 'Emil@gmail.com', '0768547520', 'Stockholm'),
  ('Nicklas Petersson', 'Nicklas@gmail.com', '0719856543', 'Göteborg'),
  ('Markus Arko', 'Markus@gmail.com', '0731544521', 'Malmö'),
  ('Sigrid Persson', 'Sigrid@gmail.com', '0749856541', 'Linköping');
 -- Hämtar kunder data 
   SELECT * FROM Kunder;
   
   -- Inforga  data i Bocker
   
   INSERT INTO Bocker (ISBN, Titel, Forfattare, Pris, Lagerstatus) VALUES
('9789144131234', 'Databasteknik', 'Sofia Andersson', 399.00, 10),
('9779123456789', 'SQL och Databaser', 'Maria Svensson', 249.00, 7),
('9789334501235', 'Programmering med Python', 'Karl Andersson', 329.00, 12),
('9789149129871', 'Datastrukturer', 'Emma Petersson', 459.00, 5),
('9789171799691', 'Nätverksteknik', 'Lars Johansson', 379.00, 9);
 -- Hämtar Bocker data
   SELECT * FROM Bocker; 
   
    -- Inforga  data i Bestallningar
   INSERT INTO Bestallningar (KundID, Datum) VALUES
   (1, '2025-10-22'),
   (1, '2025-11-20'),
   (2, '2025-11-22'),
   (3, '2025-11-21'),
   (5, '2025-11-23'),
   (1, '2025-11-25'),
   (4, '2025-11-26');
 -- Hämtar bestallningar data
   SELECT * FROM Bestallningar ;
   
    -- Inforga  data i Orderrader
   INSERT INTO Orderrader (OrderID, ISBN, Antal, Pris)
VALUES
(1, '9789144131234', 1, 399.00),
(1, '9779123456789', 1, 249.00),
(2, '9789149129871', 1, 459.00),
(3, '9789171799691', 1, 379.00),
(4, '9789334501235', 1, 329.00),
(4, '9789171799691', 1, 379.00),
(5, '9789144131234', 1, 399.00),
(6, '9789334501235', 2, 329.00);
 -- Hämtar Orderrader data
   SELECT * FROM Orderrader ;
SET SQL_SAFE_UPDATES = 0;

-- Räkna ut totalbelopp för varje beställning 
UPDATE Bestallningar
JOIN (
    SELECT OrderID, SUM(Pris * Antal) AS TotalSumma
    FROM Orderrader
    GROUP BY OrderID
) AS OrderSumma
ON Bestallningar.OrderID = OrderSumma.OrderID
SET Bestallningar.Totalbelopp = OrderSumma.TotalSumma;

 -- Hämtar Beställningar data

SELECT * FROM Bestallningar;

-- Filtrera på namn
SELECT * FROM Kunder
WHERE Namn LIKE '%Sara%';

-- Filtrera på e-post
SELECT * FROM Kunder
WHERE Email LIKE '%gmail.com%';

-- Sortera efter pris
SELECT * FROM Bocker
ORDER BY Pris DESC;

-- Updatera Email
UPDATE Kunder
SET Email = 'zahra.ny@gmail.com'
WHERE KundID = 1;
SELECT * FROM Kunder;

SET SQL_SAFE_UPDATES = 0;
-- Ta bort en kund
START TRANSACTION;
DELETE FROM Kunder
WHERE KundID = 3;

-- vid ånger:
ROLLBACK;

select * from kunder;
select * from bestallningar;
-- Eller om man vill spara:
-- COMMIT;

-- INNER JOIN (kunder som har lagt beställningar)
SELECT Kunder.Namn, Bestallningar.OrderID, Bestallningar.Datum
FROM Kunder 
INNER JOIN Bestallningar ON Kunder.KundID = Bestallningar.KundID;

-- LEFT JOIN (visa alla kunder)
SELECT Kunder.Namn, Bestallningar.OrderID
FROM Kunder
LEFT JOIN Bestallningar ON Kunder.KundID = Bestallningar.KundID;

select * from Bestallningar;
-- GROUP BY (räkna beställningar per kund)
SELECT Kunder.Namn, COUNT(Bestallningar.OrderID) AS AntalBestallningar
FROM Kunder 
LEFT JOIN Bestallningar ON Kunder.KundID = Bestallningar.KundID
GROUP BY Kunder.Namn;

-- HAVING (kunder med fler än 2 beställningar)
SELECT Kunder.Namn, COUNT(Bestallningar.OrderID) AS AntalBestallningar
FROM Kunder 
JOIN Bestallningar ON Kunder.KundID = Bestallningar.KundID
GROUP BY Kunder.Namn
HAVING COUNT(Bestallningar.OrderID) > 2;

-- Skapa ett index på e-post i Kunder
CREATE INDEX idx_email ON Kunder(Email);

-- constraint som säkerställer att priset på produkter alltid ̈ar över 0
ALTER TABLE Bocker
ADD CONSTRAINT check_pris CHECK (Pris > 0);

-- För att se vårt index
SHOW INDEX FROM Kunder;

-- Trigger som minska lagersaldo efter order
DELIMITER $$
CREATE TRIGGER minska_lager
AFTER INSERT ON Orderrader
FOR EACH ROW
BEGIN
    UPDATE Bocker
    SET Lagerstatus = Lagerstatus - NEW.Antal
    WHERE ISBN = NEW.ISBN;
END $$
DELIMITER ;

 -- Ny order 
INSERT INTO Orderrader (OrderID, ISBN, Antal, Pris)
VALUES (5, '9789149129871', 1, 459.00); 
SELECT * FROM Bocker WHERE ISBN = '9789149129871';

-- skapa KundLogg tabellen
CREATE TABLE KundLogg (
    LoggID INT AUTO_INCREMENT PRIMARY KEY,
    KundID INT,
    Datum TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);


-- TRIGGER som loggar med registrering av en ny kund
DELIMITER $$
CREATE TRIGGER logga_ny_kund
AFTER INSERT ON Kunder
FOR EACH ROW
BEGIN
    INSERT INTO KundLogg (KundID)
    VALUES (NEW.KundID);
END $$
DELIMITER ;
-- Registrera en ny kund
INSERT INTO Kunder (Namn, Email, Telefon, Adress) VALUES
('Adam Abrahamsson', 'Adam@gmail.com', '0768547590', 'Kalmar');

SELECT * FROM KundLogg;




    
