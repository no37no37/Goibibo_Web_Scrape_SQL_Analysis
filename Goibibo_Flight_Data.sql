/* What is the average price of flights from Chennai to New Delhi? */

SELECT AVG(Price) AS AveragePrice
FROM Flight_Data
WHERE [From] = 'Chennai' AND [To] = 'New Delhi';

/* Which airline offers the cheapest flights for this route? */

SELECT TOP 1 Flight_Name, Price
FROM Flight_Data
WHERE [From] = 'Chennai' AND [To] = 'New Delhi'
ORDER BY Price;

/* Which airline offers the expensive flights for this route? */

SELECT TOP 1 Flight_Name, Price
FROM Flight_Data
WHERE [From] = 'Chennai' AND [To] = 'New Delhi'
ORDER BY Price DESC;

/* What is the distribution of flight durations for this route? */
SELECT Total_Duration_Hours, COUNT(*) AS Frequency
FROM Flight_Data
WHERE [From] = 'Chennai' AND [To] = 'New Delhi'
GROUP BY Total_Duration_Hours
ORDER BY Total_Duration_Hours;

/* Which airlines offer free meals during the flight? */
SELECT DISTINCT Flight_Name
FROM Flight_Data
WHERE Free_Meal = 1;

/* Top 3 airlines with longest duration */
SELECT TOP 3 Flight_Name, Total_Duration_Hours
FROM Flight_Data
WHERE [From] = 'Chennai' AND [To] = 'New Delhi'
ORDER BY Total_Duration_Hours DESC;

/* Which layover cities are the most common for flights between Chennai and New Delhi? */

SELECT Layover_City, COUNT(*) AS Layover_Count
FROM Flight_Data
WHERE Layover = 1
GROUP BY Layover_City
ORDER BY Layover_Count DESC;

/* How does the availability of free meals or layovers affect flight prices? */

SELECT 
    Free_Meal,
    Layover,
    AVG(Price) AS Avg_Price
FROM Flight_Data
GROUP BY Free_Meal, Layover;

/* How many flights have layovers, and what is the average duration of layovers? */

SELECT
	COUNT(*) AS Flights_With_Layovers,
	AVG(DATEPART(HOUR, Layover_Duration) * 60 + DATEPART(MINUTE, Layover_Duration)) AS Avg_Layover_Duration_Minutes
	FROM Flight_Data
	WHERE Layover = 1;

/* Which airlines have the highest number of flights on this route? */

SELECT 
	Flight_Name,
	COUNT(*) AS Number_of_Flights
FROM Flight_Data
WHERE [From] = 'Chennai' AND [To] = 'New Delhi'
GROUP BY Flight_Name
ORDER BY Number_of_Flights DESC;

 /* list the flights with layovers, along with their layover cities and durations, 
 for flights departing from Chennai to New Delhi? */

WITH LayoverInfo AS (
    SELECT
        Flight_Name,
        Layover_City,
        Layover_Duration
    FROM Flight_Data
    WHERE Layover = 1 AND [From] = 'Chennai' AND [To] = 'New Delhi'
)
SELECT *
FROM LayoverInfo;
