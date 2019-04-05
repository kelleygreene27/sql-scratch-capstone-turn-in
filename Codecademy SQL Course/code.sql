{\rtf1\ansi\ansicpg1252\cocoartf1671\cocoasubrtf400
{\fonttbl\f0\fswiss\fcharset0 Helvetica;}
{\colortbl;\red255\green255\blue255;}
{\*\expandedcolortbl;;}
\margl1440\margr1440\vieww10800\viewh8400\viewkind0
\pard\tx720\tx1440\tx2160\tx2880\tx3600\tx4320\tx5040\tx5760\tx6480\tx7200\tx7920\tx8640\pardirnatural\partightenfactor0

\f0\fs24 \cf0 SELECT COUNT(DISTINCT utm_campaign)\
FROM page_visits;\
\
SELECT COUNT(DISTINCT utm_source)\
FROM page_visits;\
\
SELECT DISTINCT utm_campaign, utm_source\
FROM page_visits;\
\
SELECT DISTINCT page_name\
FROM page_visits;\
\
WITH first_touch AS (\
    SELECT user_id,\
        MIN(timestamp) as first_touch_at\
    FROM page_visits\
    GROUP BY user_id)\
SELECT ft.user_id,\
    ft.first_touch_at,\
    pv.utm_source,\
		pv.utm_campaign,\
    COUNT(utm_campaign)\
FROM first_touch ft\
JOIN page_visits pv\
    ON ft.user_id = pv.user_id\
    AND ft.first_touch_at = pv.timestamp\
GROUP BY utm_campaign\
ORDER BY 5 DESC;\
\
WITH last_touch AS (\
    SELECT user_id,\
        MAX(timestamp) AS last_touch_at\
    FROM page_visits\
    GROUP BY user_id)\
SELECT lt.user_id,\
    lt.last_touch_at,\
    pv.utm_source,\
    pv.utm_campaign,\
    COUNT(utm_campaign)\
FROM last_touch lt\
JOIN page_visits pv\
    ON lt.user_id = pv.user_id\
    AND lt.last_touch_at = pv.timestamp\
GROUP BY utm_campaign\
ORDER BY 5 DESC;\
\
SELECT COUNT(DISTINCT user_id)\
FROM page_visits\
WHERE page_name = '4 - purchase';\
\
WITH last_touch AS (\
    SELECT user_id,\
         MAX(timestamp) AS last_touch_at\
    FROM page_visits\
    WHERE page_name = '4 - purchase'\
    GROUP BY user_id)\
SELECT lt.user_id,\
    lt.last_touch_at,\
    pv.utm_source,\
    pv.utm_campaign,\
    COUNT(utm_campaign)\
FROM last_touch lt\
JOIN page_visits pv\
    ON lt.user_id = pv.user_id\
    AND lt.last_touch_at = pv.timestamp\
GROUP BY utm_campaign\
ORDER BY 5 DESC;}