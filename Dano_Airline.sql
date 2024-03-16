-- Creating the AIRLINE database
CREATE DATABASE airline;

-- Switching to the AIRLINE database
USE airline;

-- Creating the Dano_airline table to store airline passenger data
CREATE TABLE Dano_airline (
    ID INT NOT NULL,
    Gender VARCHAR(6),
    Age INT NOT NULL,
    Customer_type VARCHAR(30),
    Type_of_travel VARCHAR(30),
    Class VARCHAR(30),
    Flight_distance INT,
    Departure_delay INT,
    Arrival_delay INT,
    Departure_and_arrival_time_convenience INT,
    Ease_of_online_booking INT,
    Check_in_service INT,
    Online_boarding INT,
    Gate_location INT,
    On_board_service INT,
    Seat_comfort INT,
    Leg_room_service INT,
    Cleanliness INT,
    Food_and_drink INT,
    In_flight_service INT,
    In_flight_wifi_service INT,
    In_flight_entertainment INT,
    Baggage_handling INT,
    Satisfaction VARCHAR(30)
);

-- Correcting a typo in the column name "Bggage_handling" to "Baggage_handling"
ALTER TABLE Dano_airline
CHANGE COLUMN Bggage_handling Baggage_handling INT;


-- SUMMARY METRICS
-- Total passengers/surveys
SELECT 
    COUNT(*)
FROM
    Dano_airline;
 
-- Satisfaction rate
SELECT 
    satisfaction,
    COUNT(satisfaction),
    COUNT(satisfaction) / (SELECT 
            COUNT(*)
        FROM
            dano_airline) * 100 AS percentage
FROM
    dano_airline
GROUP BY satisfaction;
 
-- Percentage of on-time departure times
SELECT 
    DepartureDelayCategory,
    COUNT(DepartureDelayCategory) AS count_in_category,
    ROUND((COUNT(DepartureDelayCategory) / (SELECT 
                    COUNT(*)
                FROM
                    Dano_airline)) * 100,
            2) AS Percentage
FROM
    (SELECT 
        CASE
                WHEN departure_delay <= 0 THEN 'On Time'
                WHEN departure_delay <= 15 THEN 'Minor Delay'
                WHEN departure_delay <= 30 THEN 'Moderate Delay'
                ELSE 'Significant Delay'
            END AS DepartureDelayCategory
    FROM
        Dano_airline) AS Delay_categories
GROUP BY DepartureDelayCategory
ORDER BY Percentage ASC;
    
-- Percentage of on-time arrival times
SELECT 
    ArrivalDelayCategory,
    COUNT(ArrivalDelayCategory) AS count_in_category,
    ROUND((COUNT(ArrivalDelayCategory) / (SELECT 
                    COUNT(*)
                FROM
                    Dano_airline)) * 100,
            2) AS Percentage
FROM
    (SELECT 
        CASE
                WHEN arrival_delay <= 0 THEN 'On Time'
                WHEN arrival_delay <= 15 THEN 'Minor Delay'
                WHEN arrival_delay <= 30 THEN 'Moderate Delay'
                ELSE 'Significant Delay'
            END AS ArrivalDelayCategory
    FROM
        Dano_airline) AS Arrival_categories
GROUP BY ArrivalDelayCategory
ORDER BY Percentage ASC;


-- RESPONDENT CATEGORIES
-- Percentage and count of gender
SELECT 
    Gender,
    COUNT(Gender) AS Gender_count,
    ROUND((COUNT(Gender) / (SELECT 
                    COUNT(Gender)
                FROM
                    Dano_airline)) * 100,
            2) AS Percentage
FROM
    Dano_airline
GROUP BY Gender;
 
-- Percentage and count of Travel type
SELECT 
    type_of_travel,
    COUNT(type_of_travel) AS TT_count,
    ROUND((COUNT(type_of_travel) / (SELECT 
                    COUNT(*)
                FROM
                    Dano_airline)) * 100,
            2) AS Percentage
FROM
    Dano_airline
GROUP BY type_of_travel;

-- Percentage and count of customer type
SELECT 
    customer_type,
    COUNT(customer_type) AS CT_count,
    ROUND((COUNT(customer_type) / (SELECT 
                    COUNT(*)
                FROM
                    Dano_airline)) * 100,
            2) AS Percentage
FROM
    Dano_airline
GROUP BY customer_type;

-- Percentage and count of class
SELECT 
    class,
    COUNT(class) AS class_count,
    ROUND((COUNT(class) / (SELECT 
                    COUNT(*)
                FROM
                    Dano_airline)) * 100,
            2) AS percentage
FROM
    Dano_airline
GROUP BY class;

-- Age distribution
SELECT 
    Age_Category,
    COUNT(Age) AS Age_Count,
    ROUND((COUNT(Age) / (SELECT 
                    COUNT(*)
                FROM
                    Dano_airline)) * 100,
            2) AS Percentage
FROM
    Dano_airline
GROUP BY Age_Category
ORDER BY Percentage;


-- DISSATISFACTION RATE BY CUSTOMER SEGMENT
-- Gender
SELECT 
    Gender,
    COUNT(CASE WHEN Satisfaction = 'satisfied' THEN 1 END) AS Satisfied_Count,
    COUNT(CASE WHEN Satisfaction = 'neutral or dissatisfied' THEN 1 END) AS Unsatisfied_Count,
    COUNT(*) AS Total_Count,
    ROUND((COUNT(CASE WHEN Satisfaction = 'satisfied' THEN 1 END) / COUNT(*)) * 100, 2) AS Satisfied_Percentage,
    ROUND((COUNT(CASE WHEN Satisfaction = 'neutral or dissatisfied' THEN 1 END) / COUNT(*)) * 100, 2) AS Unsatisfied_Percentage
FROM 
    Dano_airline
GROUP BY 
    Gender;

-- Travel type
SELECT
    type_of_travel,
    COUNT(CASE WHEN Satisfaction = 'satisfied' THEN 1 END) AS Satisfied_Count,
    COUNT(CASE WHEN Satisfaction = 'neutral or dissatisfied' THEN 1 END) AS Unsatisfied_Count,
    COUNT(*) AS Total_Count,
    ROUND((COUNT(CASE WHEN Satisfaction = 'satisfied' THEN 1 END) / COUNT(*)) * 100, 2) AS Satisfied_Percentage,
    ROUND((COUNT(CASE WHEN Satisfaction = 'neutral or dissatisfied' THEN 1 END) / COUNT(*)) * 100, 2) AS Unsatisfied_Percentage
FROM 
    Dano_airline
GROUP BY 
    type_of_travel;

-- Class
SELECT
    Class,
    COUNT(CASE WHEN Satisfaction = 'satisfied' THEN 1 END) AS Satisfied_Count,
    COUNT(CASE WHEN Satisfaction = 'neutral or dissatisfied' THEN 1 END) AS Unsatisfied_Count,
    COUNT(*) AS Total_Count,
    ROUND((COUNT(CASE WHEN Satisfaction = 'satisfied' THEN 1 END) / COUNT(*)) * 100, 2) AS Satisfied_Percentage,
    ROUND((COUNT(CASE WHEN Satisfaction = 'neutral or dissatisfied' THEN 1 END) / COUNT(*)) * 100, 2) AS Unsatisfied_Percentage
FROM 
    Dano_airline
GROUP BY 
    Class;

-- Customer type
SELECT 
    customer_type,
    COUNT(CASE WHEN Satisfaction = 'satisfied' THEN 1 END) AS Satisfied_Count,
    COUNT(CASE WHEN Satisfaction = 'neutral or dissatisfied' THEN 1 END) AS Unsatisfied_Count,
    COUNT(*) AS Total_Count,
    ROUND((COUNT(CASE WHEN Satisfaction = 'satisfied' THEN 1 END) / COUNT(*)) * 100, 2) AS Satisfied_Percentage,
    ROUND((COUNT(CASE WHEN Satisfaction = 'neutral or dissatisfied' THEN 1 END) / COUNT(*)) * 100, 2) AS Unsatisfied_Percentage
FROM 
    Dano_airline
GROUP BY 
    customer_type;


-- Age
-- Disable safe updates to allow altering the table
SET Sql_safe_updates = 0;

-- Add a new column to categorize age ranges
ALTER TABLE Dano_airline
ADD COLUMN Age_category VARCHAR(10);

-- Update the Age_category column based on age ranges
UPDATE Dano_airline
SET Age_category =
    CASE
        WHEN Age BETWEEN 7 AND 17 THEN 'Under 18'
        WHEN Age BETWEEN 18 AND 30 THEN '18-30'
        WHEN Age BETWEEN 31 AND 50 THEN '31-50'
        WHEN Age BETWEEN 51 AND 65 THEN '51-65'
        ELSE '65+'
    END;

-- Retrieve dissatisfaction metrics based on age categories
SELECT
    Age_category,
    COUNT(CASE WHEN Satisfaction = 'satisfied' THEN 1 END) AS Satisfied_Count,
    COUNT(CASE WHEN Satisfaction = 'neutral or dissatisfied' THEN 1 END) AS Unsatisfied_Count,
    COUNT(*) AS Total_Count,
    ROUND((COUNT(CASE WHEN Satisfaction = 'satisfied' THEN 1 END) / COUNT(*)) * 100, 2) AS Satisfied_Percentage,
    ROUND((COUNT(CASE WHEN Satisfaction = 'neutral or dissatisfied' THEN 1 END) / COUNT(*)) * 100, 2) AS Unsatisfied_Percentage
FROM 
    Dano_airline
GROUP BY 
    Age_category;


-- AVERAGE RATING FOR EACH SERVICE 

-- Calculate the average rating for each service
SELECT 
    AVG(Departure_and_arrival_time_convenience) AS Avg_Departure_and_arrival_time_convenience,
    AVG(Ease_of_online_booking) AS Avg_Ease_of_online_booking,
    AVG(Check_in_service) AS Avg_Check_in_service,
    AVG(Online_boarding) AS Avg_Online_boarding,
    AVG(Gate_location) AS Avg_Gate_location,
    AVG(On_board_service) AS Avg_On_board_service,
    AVG(Seat_comfort) AS Avg_Seat_comfort,
    AVG(Leg_room_service) AS Avg_Leg_room_service,
    AVG(Cleanliness) AS Avg_Cleanliness,
    AVG(Food_and_drink) AS Avg_Food_and_drink,
    AVG(In_flight_service) AS Avg_In_flight_service,
    AVG(In_flight_wifi_service) AS Avg_In_flight_wifi_service,
    AVG(In_flight_entertainment) AS Avg_In_flight_entertainment,
    AVG(Baggage_handling) AS Avg_Baggage_handling
FROM 
    Dano_airline;

-- OR

-- Calculate the average rating for each service individually and combine the results (this makes the output easy to understand)
SELECT 
    'Departure_and_arrival_time_convenience' AS Service,
    AVG(Departure_and_arrival_time_convenience) AS Avg_Service_Value
FROM 
    Dano_airline
UNION ALL
SELECT 
    'Ease_of_online_booking' AS Service,
    AVG(Ease_of_online_booking) AS Avg_Service_Value
FROM 
    Dano_airline
UNION ALL
SELECT 
    'Check_in_service' AS Service,
    AVG(Check_in_service) AS Avg_Service_Value
FROM 
    Dano_airline
UNION ALL
SELECT 
    'Online_boarding' AS Service,
    AVG(Online_boarding) AS Avg_Service_Value
FROM 
    Dano_airline
UNION ALL
SELECT 
    'Gate_location' AS Service,
    AVG(Gate_location) AS Avg_Service_Value
FROM 
    Dano_airline
UNION ALL
SELECT 
    'On_board_service' AS Service,
    AVG(On_board_service) AS Avg_Service_Value
FROM 
    Dano_airline
UNION ALL
SELECT 
    'Seat_comfort' AS Service,
    AVG(Seat_comfort) AS Avg_Service_Value
FROM 
    Dano_airline
UNION ALL
SELECT 
    'Leg_room_service' AS Service,
    AVG(Leg_room_service) AS Avg_Service_Value
FROM 
    Dano_airline
UNION ALL
SELECT 
    'Cleanliness' AS Service,
    AVG(Cleanliness) AS Avg_Service_Value
FROM 
    Dano_airline
UNION ALL
SELECT 
    'Food_and_drink' AS Service,
    AVG(Food_and_drink) AS Avg_Service_Value
FROM 
    Dano_airline
UNION ALL
SELECT 
    'In_flight_service' AS Service,
    AVG(In_flight_service) AS Avg_Service_Value
FROM 
    Dano_airline
UNION ALL
SELECT 
    'In_flight_wifi_service' AS Service,
    AVG(In_flight_wifi_service) AS Avg_Service_Value
FROM 
    Dano_airline
UNION ALL
SELECT 
    'In_flight_entertainment' AS Service,
    AVG(In_flight_entertainment) AS Avg_Service_Value
FROM 
    Dano_airline
UNION ALL
SELECT 
    'Baggage_handling' AS Service,
    AVG(Baggage_handling) AS Avg_Service_Value
FROM 
    Dano_airline
ORDER BY 
    Avg_Service_Value ASC;
    

-- DISTRIBUTION OF EACH FACTOR ON A LIKERT SCALE

-- Create a temporary table to store the aggregated data for Likert scale ratings of various services
CREATE TEMPORARY TABLE temp_services AS
(
    -- Select each service and its corresponding rating from the main table
    SELECT 
        'Departure_and_arrival_time_convenience' AS service,
       Departure_and_arrival_time_convenience AS rating
    FROM 
        Dano_airline
    UNION ALL
    SELECT 
        'Ease_of_online_booking' AS service,
        Ease_of_online_booking AS rating
    FROM 
        Dano_airline
    UNION ALL
    SELECT 
        'Check_in_service' AS service,
        Check_in_service AS rating
    FROM 
        Dano_airline
    UNION ALL
    SELECT 
        'Online_boarding' AS service,
        Online_boarding AS rating
    FROM 
        Dano_airline
    UNION ALL
    SELECT 
        'Gate_location' AS service,
        Gate_location AS rating
    FROM 
        Dano_airline
    UNION ALL
    SELECT 
        'On_board_service' AS service,
        On_board_service AS rating
    FROM 
        Dano_airline
    UNION ALL
    SELECT 
        'Seat_comfort' AS service,
        Seat_comfort AS rating
    FROM 
        Dano_airline
    UNION ALL
    SELECT 
        'Leg_room_service' AS service,
        Leg_room_service AS rating
    FROM 
        Dano_airline
    UNION ALL
    SELECT 
        'Cleanliness' AS service,
        Cleanliness AS rating
    FROM 
        Dano_airline
    UNION ALL
    SELECT 
        'Food_and_drink' AS service,
        Food_and_drink AS rating
    FROM 
        Dano_airline
    UNION ALL
    SELECT 
        'In_flight_service' AS service,
        In_flight_service AS rating
    FROM 
        Dano_airline
    UNION ALL
    SELECT 
        'In_flight_wifi_service' AS service,
        In_flight_wifi_service AS rating
    FROM 
        Dano_airline
    UNION ALL
    SELECT 
        'In_flight_entertainment' AS service,
        In_flight_entertainment AS rating
    FROM 
        Dano_airline
    UNION ALL
    SELECT 
        'Baggage_handling' AS service,
        Baggage_handling AS rating
    FROM 
        Dano_airline
);

-- Show the aggregated data
SELECT *
FROM temp_services;

-- Calculate the occurrence (count) of each Likert scale value (0-5) for each service
SELECT 
    service,
    SUM(CASE WHEN rating = 0 THEN 1 ELSE 0 END) AS Not_applicable,
    SUM(CASE WHEN rating = 1 THEN 1 ELSE 0 END) AS Strong_disagree,
    SUM(CASE WHEN rating = 2 THEN 1 ELSE 0 END) AS Disagree,
    SUM(CASE WHEN rating = 3 THEN 1 ELSE 0 END) AS Neutral,
    SUM(CASE WHEN rating = 4 THEN 1 ELSE 0 END) AS Agree,
    SUM(CASE WHEN rating = 5 THEN 1 ELSE 0 END) AS Strongly_agree
FROM 
    temp_services
GROUP BY 
    service;

-- Calculate the percentage distribution of each Likert scale value (0-5) for each service
SELECT 
    service,
    ROUND((SUM(CASE WHEN rating = 0 THEN 1 ELSE 0 END) / COUNT(*)) * 100, 2) AS Not_applicable,
    ROUND((SUM(CASE WHEN rating = 1 THEN 1 ELSE 0 END) / COUNT(*)) * 100, 2) AS Strong_disagree,
    ROUND((SUM(CASE WHEN rating = 2 THEN 1 ELSE 0 END) / COUNT(*)) * 100, 2) AS Disagree,
    ROUND((SUM(CASE WHEN rating = 3 THEN 1 ELSE 0 END) / COUNT(*)) * 100, 2) AS Neutral,
    ROUND((SUM(CASE WHEN rating = 4 THEN 1 ELSE 0 END) / COUNT(*)) * 100, 2) AS Agree,
    ROUND((SUM(CASE WHEN rating = 5 THEN 1 ELSE 0 END) / COUNT(*)) * 100, 2) AS Strongly_agree
FROM 
    temp_services
GROUP BY 
    service;


-- FIND OUT THE CONTRIBUTION OF EACH CUSTOMER SEGMENT TO ALL SERVICES REPRESENTED ON THE LIKERT SCALE

-- Create a temporary table to store the aggregated data for Likert scale ratings of various services by customer type
CREATE TEMPORARY TABLE CT_temp_services AS
(
    -- Select each service, its corresponding rating, and customer type from the main table
    SELECT 
        Customer_type,
        'Departure_and_arrival_time_convenience' AS service,
        Departure_and_arrival_time_convenience AS rating
    FROM 
        Dano_airline
    UNION ALL
    SELECT 
        Customer_type,
        'Ease_of_online_booking' AS service,
        Ease_of_online_booking AS rating
    FROM 
        Dano_airline
    UNION ALL
    SELECT 
        Customer_type,
        'Check_in_service' AS service,
        Check_in_service AS rating
    FROM 
        Dano_airline
    UNION ALL
    SELECT 
        Customer_type,
        'Online_boarding' AS service,
        Online_boarding AS rating
    FROM 
        Dano_airline
    UNION ALL
    SELECT 
        Customer_type,
        'Gate_location' AS service,
        Gate_location AS rating
    FROM 
        Dano_airline
    UNION ALL
    SELECT 
        Customer_type,
        'On_board_service' AS service,
        On_board_service AS rating
    FROM 
        Dano_airline
    UNION ALL
    SELECT 
        Customer_type,
        'Seat_comfort' AS service,
        Seat_comfort AS rating
    FROM 
        Dano_airline
    UNION ALL
    SELECT 
        Customer_type,
        'Leg_room_service' AS service,
        Leg_room_service AS rating
    FROM 
        Dano_airline
    UNION ALL
    SELECT 
        Customer_type,
        'Cleanliness' AS service,
        Cleanliness AS rating
    FROM 
        Dano_airline
    UNION ALL
    SELECT 
        Customer_type,
        'Food_and_drink' AS service,
        Food_and_drink AS rating
    FROM 
        Dano_airline
    UNION ALL
    SELECT 
        Customer_type,
        'In_flight_service' AS service,
        In_flight_service AS rating
    FROM 
        Dano_airline
    UNION ALL
    SELECT 
        Customer_type,
        'In_flight_wifi_service' AS service,
        In_flight_wifi_service AS rating
    FROM 
        Dano_airline
    UNION ALL
    SELECT 
        Customer_type,
        'In_flight_entertainment' AS service,
        In_flight_entertainment AS rating
    FROM 
        Dano_airline
    UNION ALL
    SELECT 
        Customer_type,
        'Baggage_handling' AS service,
        Baggage_handling AS rating
    FROM 
        Dano_airline
);

-- Show the aggregated data with customer type
SELECT *
FROM CT_temp_services;

-- Calculate the contribution of each customer segment to each service represented on the Likert scale
SELECT 
    service,
    customer_type,
    ROUND((SUM(CASE WHEN rating = 0 THEN 1 ELSE 0 END) / COUNT(*)) * 100, 2) AS Not_applicable,
    ROUND((SUM(CASE WHEN rating IN (1,2,3) THEN 1 ELSE 0 END) / COUNT(*)) * 100, 2) AS Dissatisfied_Neutral,
    ROUND((SUM(CASE WHEN rating IN (4,5) THEN 1 ELSE 0 END) / COUNT(*)) * 100, 2) AS Satisfied
FROM 
    CT_temp_services
GROUP BY 
    service, customer_type;
    

-- Find out the contribution of each customer segment to all services represented on the Likert scale based on the type of travel

-- Create a temporary table to store the aggregated data for Likert scale ratings of various services by type of travel
CREATE TEMPORARY TABLE ToT_temp_services AS
(
    -- Select each service, its corresponding rating, and type of travel from the main table
    SELECT 
        Type_of_travel,
        'Departure_and_arrival_time_convenience' AS service,
        Departure_and_arrival_time_convenience AS rating
    FROM 
        Dano_airline
    UNION ALL
    SELECT 
        Type_of_travel,
        'Ease_of_online_booking' AS service,
        Ease_of_online_booking AS rating
    FROM 
        Dano_airline
    UNION ALL
    SELECT 
        Type_of_travel,
        'Check_in_service' AS service,
        Check_in_service AS rating
    FROM 
        Dano_airline
    UNION ALL
    SELECT 
        Type_of_travel,
        'Online_boarding' AS service,
        Online_boarding AS rating
    FROM 
        Dano_airline
    UNION ALL
    SELECT 
        Type_of_travel,
        'Gate_location' AS service,
        Gate_location AS rating
    FROM 
        Dano_airline
    UNION ALL
    SELECT 
        Type_of_travel,
        'On_board_service' AS service,
        On_board_service AS rating
    FROM 
        Dano_airline
    UNION ALL
    SELECT 
        Type_of_travel,
        'Seat_comfort' AS service,
        Seat_comfort AS rating
    FROM 
        Dano_airline
    UNION ALL
    SELECT 
        Type_of_travel,
        'Leg_room_service' AS service,
        Leg_room_service AS rating
    FROM 
        Dano_airline
    UNION ALL
    SELECT 
        Type_of_travel,
        'Cleanliness' AS service,
        Cleanliness AS rating
    FROM 
        Dano_airline
    UNION ALL
    SELECT 
        Type_of_travel,
        'Food_and_drink' AS service,
        Food_and_drink AS rating
    FROM 
        Dano_airline
    UNION ALL
    SELECT 
        Type_of_travel,
        'In_flight_service' AS service,
        In_flight_service AS rating
    FROM 
        Dano_airline
    UNION ALL
    SELECT 
        Type_of_travel,
        'In_flight_wifi_service' AS service,
        In_flight_wifi_service AS rating
    FROM 
        Dano_airline
    UNION ALL
    SELECT 
        Type_of_travel,
        'In_flight_entertainment' AS service,
        In_flight_entertainment AS rating
    FROM 
        Dano_airline
    UNION ALL
    SELECT 
        Type_of_travel,
        'Baggage_handling' AS service,
        Baggage_handling AS rating
    FROM 
        Dano_airline
);

-- Show the aggregated data with type of travel
SELECT *
FROM ToT_temp_services;

-- Calculate the contribution of each type of travel to each service represented on the Likert scale
SELECT 
    service, 
    Type_of_travel,
    ROUND((SUM(CASE WHEN rating = 0 THEN 1 ELSE 0 END) / COUNT(*)) * 100, 2) AS Not_applicable,
    ROUND((SUM(CASE WHEN rating IN (1,2,3) THEN 1 ELSE 0 END) / COUNT(*)) * 100, 2) AS Dissatisfied_Neutral,
    ROUND((SUM(CASE WHEN rating IN (4,5) THEN 1 ELSE 0 END) / COUNT(*)) * 100, 2) AS Satisfied
FROM 
    ToT_temp_services
GROUP BY 
    service, Type_of_travel;


-- Determine the contribution of each customer class to all services represented on the Likert scale

-- Create a temporary table to store the aggregated data for Likert scale ratings of various services by customer class
CREATE TEMPORARY TABLE Class_temp_services AS
(
    -- Select each service, its corresponding rating, and customer class from the main table
    SELECT 
        Class,
        'Departure_and_arrival_time_convenience' AS service,
        Departure_and_arrival_time_convenience AS rating
    FROM 
        Dano_airline
    UNION ALL
    SELECT 
        Class,
        'Ease_of_online_booking' AS service,
        Ease_of_online_booking AS rating
    FROM 
        Dano_airline
    UNION ALL
    SELECT 
        Class,
        'Check_in_service' AS service,
        Check_in_service AS rating
    FROM 
        Dano_airline
    UNION ALL
    SELECT 
        Class,
        'Online_boarding' AS service,
        Online_boarding AS rating
    FROM 
        Dano_airline
    UNION ALL
    SELECT 
        Class,
        'Gate_location' AS service,
        Gate_location AS rating
    FROM 
        Dano_airline
    UNION ALL
    SELECT 
        Class,
        'On_board_service' AS service,
        On_board_service AS rating
    FROM 
        Dano_airline
    UNION ALL
    SELECT 
        Class,
        'Seat_comfort' AS service,
        Seat_comfort AS rating
    FROM 
        Dano_airline
    UNION ALL
    SELECT 
        Class,
        'Leg_room_service' AS service,
        Leg_room_service AS rating
    FROM 
        Dano_airline
    UNION ALL
    SELECT 
        Class,
        'Cleanliness' AS service,
        Cleanliness AS rating
    FROM 
        Dano_airline
    UNION ALL
    SELECT 
        Class,
        'Food_and_drink' AS service,
        Food_and_drink AS rating
    FROM 
        Dano_airline
    UNION ALL
    SELECT 
        Class,
        'In_flight_service' AS service,
        In_flight_service AS rating
    FROM 
        Dano_airline
    UNION ALL
    SELECT 
        Class,
        'In_flight_wifi_service' AS service,
        In_flight_wifi_service AS rating
    FROM 
        Dano_airline
    UNION ALL
    SELECT 
        Class,
        'In_flight_entertainment' AS service,
        In_flight_entertainment AS rating
    FROM 
        Dano_airline
    UNION ALL
    SELECT 
        Class,
        'Baggage_handling' AS service,
        Baggage_handling AS rating
    FROM 
        Dano_airline
);

-- Show the aggregated data with customer class
SELECT *
FROM Class_temp_services;

-- Calculate the contribution of each customer class to each service represented on the Likert scale
SELECT 
    service, 
    Class,
    ROUND((SUM(CASE WHEN rating = 0 THEN 1 ELSE 0 END) / COUNT(*)) * 100, 2) AS Not_applicable,
    ROUND((SUM(CASE WHEN rating IN (1,2,3) THEN 1 ELSE 0 END) / COUNT(*)) * 100, 2) AS Dissatisfied_Neutral,
    ROUND((SUM(CASE WHEN rating IN (4,5) THEN 1 ELSE 0 END) / COUNT(*)) * 100, 2) AS Satisfied
FROM 
    Class_temp_services
GROUP BY 
    service, Class;


-- Gender Analysis for Likert Scale Ratings of Different Services

-- Create a temporary table to store the aggregated data for Likert scale ratings of various services by gender
CREATE TEMPORARY TABLE Gender_temp_services AS
(
    -- Select each service, its corresponding rating, and gender from the main table
    SELECT 
        Gender,
        'Departure_and_arrival_time_convenience' AS service,
        Departure_and_arrival_time_convenience AS rating
    FROM 
        Dano_airline
    UNION ALL
    SELECT 
        Gender,
        'Ease_of_online_booking' AS service,
        Ease_of_online_booking AS rating
    FROM 
        Dano_airline
    UNION ALL
    SELECT 
        Gender,
        'Check_in_service' AS service,
        Check_in_service AS rating
    FROM 
        Dano_airline
    UNION ALL
    SELECT 
        Gender,
        'Online_boarding' AS service,
        Online_boarding AS rating
    FROM 
        Dano_airline
    UNION ALL
    SELECT 
        Gender,
        'Gate_location' AS service,
        Gate_location AS rating
    FROM 
        Dano_airline
    UNION ALL
    SELECT 
        Gender,
        'On_board_service' AS service,
        On_board_service AS rating
    FROM 
        Dano_airline
    UNION ALL
    SELECT 
        Gender,
        'Seat_comfort' AS service,
        Seat_comfort AS rating
    FROM 
        Dano_airline
    UNION ALL
    SELECT 
        Gender,
        'Leg_room_service' AS service,
        Leg_room_service AS rating
    FROM 
        Dano_airline
    UNION ALL
    SELECT 
        Gender,
        'Cleanliness' AS service,
        Cleanliness AS rating
    FROM 
        Dano_airline
    UNION ALL
    SELECT 
        Gender,
        'Food_and_drink' AS service,
        Food_and_drink AS rating
    FROM 
        Dano_airline
    UNION ALL
    SELECT 
        Gender,
        'In_flight_service' AS service,
        In_flight_service AS rating
    FROM 
        Dano_airline
    UNION ALL
    SELECT 
        Gender,
        'In_flight_wifi_service' AS service,
        In_flight_wifi_service AS rating
    FROM 
        Dano_airline
    UNION ALL
    SELECT 
        Gender,
        'In_flight_entertainment' AS service,
        In_flight_entertainment AS rating
    FROM 
        Dano_airline
    UNION ALL
    SELECT 
        Gender,
        'Baggage_handling' AS service,
        Baggage_handling AS rating
    FROM 
        Dano_airline
);

-- Show the aggregated data with gender
SELECT *
FROM Gender_temp_services;

-- Calculate the contribution of each gender to each service represented on the Likert scale
SELECT 
    service, 
    Gender,
    ROUND((SUM(CASE WHEN rating = 0 THEN 1 ELSE 0 END) / COUNT(*)) * 100, 2) AS Not_applicable,
    ROUND((SUM(CASE WHEN rating IN (1,2,3) THEN 1 ELSE 0 END) / COUNT(*)) * 100, 2) AS Dissatisfied_Neutral,
    ROUND((SUM(CASE WHEN rating IN (4,5) THEN 1 ELSE 0 END) / COUNT(*)) * 100, 2) AS Satisfied
FROM 
    Gender_temp_services
GROUP BY 
    service, Gender;


-- Age Analysis for Likert Scale Ratings of Different Services

-- Create a temporary table to store the aggregated data for Likert scale ratings of various services by age category
CREATE TEMPORARY TABLE Age_temp_services AS
(
    -- Select each service, its corresponding rating, and age category from the main table
    SELECT 
        Age_category,
        'Departure_and_arrival_time_convenience' AS service,
        Departure_and_arrival_time_convenience AS rating
    FROM 
        Dano_airline
    UNION ALL
    SELECT 
        Age_category,
        'Ease_of_online_booking' AS service,
        Ease_of_online_booking AS rating
    FROM 
        Dano_airline
    UNION ALL
    SELECT 
        Age_category,
        'Check_in_service' AS service,
        Check_in_service AS rating
    FROM 
        Dano_airline
    UNION ALL
    SELECT 
        Age_category,
        'Online_boarding' AS service,
        Online_boarding AS rating
    FROM 
        Dano_airline
    UNION ALL
    SELECT 
        Age_category,
        'Gate_location' AS service,
        Gate_location AS rating
    FROM 
        Dano_airline
    UNION ALL
    SELECT 
        Age_category,
        'On_board_service' AS service,
        On_board_service AS rating
    FROM 
        Dano_airline
    UNION ALL
    SELECT 
        Age_category,
        'Seat_comfort' AS service,
        Seat_comfort AS rating
    FROM 
        Dano_airline
    UNION ALL
    SELECT 
        Age_category,
        'Leg_room_service' AS service,
        Leg_room_service AS rating
    FROM 
        Dano_airline
    UNION ALL
    SELECT 
        Age_category,
        'Cleanliness' AS service,
        Cleanliness AS rating
    FROM 
        Dano_airline
    UNION ALL
    SELECT 
        Age_category,
        'Food_and_drink' AS service,
        Food_and_drink AS rating
    FROM 
        Dano_airline
    UNION ALL
    SELECT 
        Age_category,
        'In_flight_service' AS service,
        In_flight_service AS rating
    FROM 
        Dano_airline
    UNION ALL
    SELECT 
        Age_category,
        'In_flight_wifi_service' AS service,
        In_flight_wifi_service AS rating
    FROM 
        Dano_airline
    UNION ALL
    SELECT 
        Age_category,
        'In_flight_entertainment' AS service,
        In_flight_entertainment AS rating
    FROM 
        Dano_airline
    UNION ALL
    SELECT 
        Age_category,
        'Baggage_handling' AS service,
        Baggage_handling AS rating
    FROM 
        Dano_airline
);

-- Show the aggregated data with age categories
SELECT *
FROM Age_temp_services;

-- Calculate the contribution of each age category to each service represented on the Likert scale
SELECT 
    service, 
    Age_category,
    ROUND((SUM(CASE WHEN rating = 0 THEN 1 ELSE 0 END) / COUNT(*)) * 100, 2) AS Not_applicable,
    ROUND((SUM(CASE WHEN rating IN (1,2,3) THEN 1 ELSE 0 END) / COUNT(*)) * 100, 2) AS Dissatisfied_Neutral,
    ROUND((SUM(CASE WHEN rating IN (4,5) THEN 1 ELSE 0 END) / COUNT(*)) * 100, 2) AS Satisfied
FROM 
    Age_temp_services
GROUP BY 
    service, Age_category;








