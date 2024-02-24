# DANO AIRLINE CUSTOMER SATISFACTION REPORT
![airline](https://github.com/NEENYEE/Dano-Airline-/assets/101926233/03eeecde-5ff8-4212-80ab-d55c4c969d65)

## Table of Contents

- [Overview](#overview)
- [Problem Statement](problem-statement)
- [Data Source](#data-source)
- [Schema Diagram](#schema-diagram)
- [Tools](#tools)
- [Data Cleaning and Transformation](#data-cleaning-and-transformation)
- [Data Analysis](#data-analysis)
- [Visualization](#visualization)
- [Key Insights](#key-insights)
- [Recommendations](#recommendations)


## Overview

Welcome to the Dano Airlines customer satisfaction documentation. This project aims to address the challenge of declining passenger satisfaction rates at Dano Airlines, a UK-based airline with headquarters in London, United Kingdom. The latest passenger survey results indicate that the satisfaction rate has dipped below 50% for the first time ever, creating an urgent need for immediate action from the leadership team.


## Problem Statement

The task at hand involves analyzing the passenger survey data to identify the key factors contributing to the decline in satisfaction rates and recommending data-driven strategies for improvement.



## Data Source

The dataset was provided by Digitaley drive as an integral part of my capstone project           
[data source](https://docs.google.com/spreadsheets/d/15Kp-2yfQFNRGJPNOkpMwG-OMX8xVZOJ5VL7f35v7sRQ/edit#gid=1647986900) . The dataset is made up of one table comprising of 129,880 rows and 24 columns. It contains satisfaction scores provided by over 129,880 airline passengers, encompassing various details such as individual passenger information, flight details, type of travel, and assessments of factors including cleanliness, comfort, service, and overall experience. 



## Schema Diagram

![Screenshot 2024-02-24 at 8 29 26 PM](https://github.com/NEENYEE/Dano-Airline-/assets/101926233/4bc4986e-c602-4b13-be88-e2493b182b7a)



## Tools 

- SQL: Used for data extraction, transformation, and querying.
- Power Query: Employed for data transformation and manipulation.
- PowerBI: Utilized for creating interactive dashboards and visualizations, including buttons, tooltips, filters, page navigation, and quick measures.



## Data Cleaning and Transformation

In the data cleaning process, missing values were identified in the "arrival delay" column. To address this issue, the "Replace Values" function in Power Query was utilized. The missing values were replaced with '0' using the mode as the replacement value. By ensuring the integrity of the dataset, it was prepared for subsequent analysis, contributing to the reliability and accuracy of the insights derived from the data.



## Data Analysis


A thorough analysis of the dataset was carried out using SQL queries to uncover insights and propose recommendations for Dano Airlines.The goal was to identify key factors impacting satisfaction rates and provide actionable strategies for improvement. Let's dive into the details of our analysis.

Below are some examples of the SQL queries:

1.  **Categorizing the passenger ages into categories**
```Sql
 UPDATE Dano_airline
  SET Age_category =
        CASE
            WHEN Age BETWEEN 7 AND 17 THEN 'Under 18'
            WHEN Age BETWEEN 18 AND 30 THEN '18-30'
            WHEN Age BETWEEN 31 AND 50 THEN '31-50'
            WHEN Age BETWEEN 51 AND 65 THEN '51-65'
            ELSE '65+'
        END;



```

2.  **Average Rating For Each Service**
```sql
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

```
## visualization

Visualizations have been created to represent the findings and provide insights into various aspects of the dataset. Below is a visualization of one of the main insights derived from the analysis:

- **Satisfaction Rate of Airline Services By Passengers**
  
![image](https://github.com/NEENYEE/Dano-Airline-/assets/101926233/e19f55ec-4b8b-48eb-88b6-9daf90f5dc0f)




## Key Insights 
- The survey showed a satisfaction rate of 43%.
- The most dissatisfied customer segments were 90% of personal purpose travellers, 76% of first-time passengers, 81% and 75% of economy and economy-plus passengers, 83% of under 18 and 81% of those above 65.
- The major dissatisfactory services were:
   - **In-flight Wi-Fi service** (personal purpose and economy passengers were most dissatisfied with this service)
   - **Gate location** (passengers above 65 and first time travellers were most dissatisfied)
   - **Ease of online booking** (personal, first-time and economy were most dissatisfied)
   - It is also important to note that the customer segments most diissatisfied with the major dissatisfactory services were the key dissatisfied segments.



## Recommendations
- To address dissatisfaction with in-flight WiFi at Dano Airlines, it's essential to assess technical infrastructure and expand coverage area to ensure consistent wi-fi connectivity throughout flight duration. Offer transparent real-time status updates and flexible pricing options, and provide customer support for trouble shooting technical issues promptly.

- To Improve passenger experience, implement digital signage and mobile apps to provide real-time updates on gate locations, offer clear and concise signage throughout the terminal. Staff can also be employed to assist passengers with directions, ensuring smooth navigation and reducing passenger stress and confusion.

- Combining flexible booking options like date and time adjustments with comprehensive FAQs and customer support enhances a user friendly and efficient booking experience. Additionally, implementing guest checkout for quicker transactions, integrating autofill features, and utilizing predictive search functionalities further streamline the booking process, resulting in a seamless and user-friendly experience for customers.





  
