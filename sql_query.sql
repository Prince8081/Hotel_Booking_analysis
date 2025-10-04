create database hotel_booking_db ;
use hotel_booking_db;

select * from hotel_bookings;

-- Total Bookings (overall & by hotel) --

SELECT 
    hotel, COUNT(*) AS total_bookings
FROM
    hotel_bookings
GROUP BY 1;


-- Cancellation Rate (overall & by hotel) --

SELECT 
    hotel,
    COUNT(*) AS total_bookings,
    SUM(CASE
        WHEN is_canceled = 'Yes' THEN 1
        ELSE 0
    END) AS canceled_bookings,
    (SUM(CASE
        WHEN is_canceled = 'Yes' THEN 1
        ELSE 0
    END) * 100 / COUNT(*)) AS Cancellation_Rate
FROM
    hotel_bookings
GROUP BY 1;


-- Average Stay Duration (by hotel) -- 

SELECT 
    hotel, ROUND(AVG(total_stays), 2) AS avg_stay_duration
FROM
    hotel_bookings
GROUP BY 1;

-- Revenue by Hotel -- 

SELECT 
    hotel, ROUND(SUM(revenue), 2) AS total_revenue
FROM
    hotel_bookings
GROUP BY 1
ORDER BY 2 DESC;

 -- Top 10 Guest Countries --
 
SELECT 
    country, COUNT(*) AS total_bookings
FROM
    hotel_bookings
GROUP BY 1
ORDER BY 2 DESC
LIMIT 10;

 -- Booking Trends by Month -- 
 
 SELECT 
    arrival_date_month, COUNT(*) AS monthly_bookings
FROM
    hotel_bookings
GROUP BY 1
ORDER BY 2 DESC;


 -- Impact of Parking Requests --
 
SELECT 
    required_car_parking_spaces,
    COUNT(*) AS total_bookings,
    ROUND(AVG(revenue), 2) AS avg_revenue
FROM
    hotel_bookings
GROUP BY 1
ORDER BY 2 DESC;

-- Special Requests vs Cancellations --

SELECT 
    total_of_special_requests,
    COUNT(*) AS total_bookings,
    SUM(CASE
        WHEN is_canceled = 'Yes' THEN 1
        ELSE 0
    END) AS canceled_bookings,
    ROUND(SUM(CASE
                WHEN is_canceled = 'Yes' THEN 1
                ELSE 0
            END) * 100 / COUNT(*),
            2) AS cancellation_rate
FROM
    hotel_bookings
GROUP BY 1;

 -- Repeated Guest Insights --
 
SELECT 
    is_repeated_guest,
    COUNT(*) AS total_bookings,
    ROUND(AVG(revenue), 2) AS avg_revenue
FROM
    hotel_bookings
GROUP BY 1;

 -- Booking Channels Performance --
 
SELECT 
    distribution_channel,
    COUNT(*) AS total_bookings,
    ROUND(SUM(revenue), 2) AS total_revenue
FROM
    hotel_bookings
GROUP BY 1;




