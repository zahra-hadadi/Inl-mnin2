README.md – Bokhandel Databas 

## Beskrivning av databasen 

Denna databas är skapad för en bokhandel och används för att hantera kunder, böcker och beställningar. Databasen består av tabellerna Kunder, Böcker, Beställningar, Orderrader och KundLogg. 

## Relationer i databasen: 

En kund kan ha många beställningar.  

En beställning kan ha många orderrader.  

En bok kan finnas i många orderrader.  

En kund kan ha många loggar i KundLogg.  

Beställningar och Böcker har en många-till-många relation via Orderrader.  

Databasen innehåller även index, constraints, triggers och transaktioner för att säkerställa dataintegritet och förbättra prestanda. 

## Reflektion och analys av databaslösningen 

Databasen designades som en relationsdatabas för att undvika duplicerad data och göra databasen strukturerad. Tabellerna delades upp så att kundinformation, beställningar och böcker lagras separat. Orderrader används som kopplingstabell mellan beställningar och böcker eftersom en beställning kan innehålla flera böcker. 

## Om databasen skulle hantera 100 000 kunder 

Om databasen skulle hantera mycket mer data skulle fler index behövas, till exempel på KundID, OrderID och ISBN. Man skulle även kunna använda stored procedures och fler triggers för att automatisera beräkningar och förbättra prestandan. 

## Optimeringar 

Prestandan kan förbättras genom: 

Index på Email, KundID, OrderID och ISBN.  

Använda primärnycklar som INT.  

Använda triggers för att uppdatera lagerstatus automatiskt.  

Normaliserad databasstruktur som minskar duplicerad data.  

 

## Sammanfattning 

Databasen är normaliserad och har tydliga relationer mellan tabellerna. Index, triggers och constraints används för att säkerställa att databasen fungerar effektivt och att data är korrekt. 
