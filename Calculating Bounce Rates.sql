-- CALCULATING_BOUNCE_RATES

-- STEP 1: finding the first website_pageview_id for relevant sesions
-- STEP 2: identifying the landing page of each session
-- STEP 3: counting pageviews for each session, to identify "bounces"
-- STEP 4: summarizing by counting total sessions and bounced sessions

USE mavenfuzzyfactory;

CREATE TEMPORARY TABLE first_pageviews
SELECT
	website_pageview_id,
	MIN(website_pageview_id) AS min_pageview_id
FROM website_pageviews
WHERE created_at < '2012-06-14'
GROUP BY
	website_session_id;
	
-- next, we'll bring in the landing page, but restrict to home only
-- this is redundant in this case, since all is to the homepage

CREATE TEMPORARY TABLE sessions_w_home_landing_page
SELECT
	first_pageviews.website_session_id,
	website_pageviews.pageview_url AS landing_page
FROM first_pageviews
	LEFT JOIN website_pageviews
		ON website_pageviews.website_pageview_id = first_pageviews.min_pageview_id
WHERE website_pageviews.pageview_url = '/home';

-- SELECT * FROM sessions_w_home_landing_page;

-- then a table to have count of pageviews per session
-- then limit it to just bounced_sessions

CREATE TEMPORARY TABLE bounced_sessions
SELECT 
	sessions_w_home_landing_page.website_session_id,
	sessions_w_home_landing_page.landing_page,
	COUNT (website_pageviews.website_pageview_id) AS count_of_pages_viewed
	
FROM sessions_w_home_landing_page
LEFT JOIN website_pageviews
	ON website_pageviews.website_session_id = sessions_w_home_landing_page.website_session_id
	
GROUP BY
	website_pageviews.website_session_id,
	sessions_w_home_landing_page.landing_page
	
HAVING
	COUNT(website_pageviews.website_pageview_id) = 1;
	
-- we'll do this first just to show what's in this query, then we will count them after;

SELECT
	sessions_w_home_landing_page.website_session_id,
	