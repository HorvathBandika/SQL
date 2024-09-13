-- STEP 1: SELECT all pageviews for relevant seessions
-- STEP 2: identify each pageview as the specific funnel step
-- STEP 3: create the session-level conversation funnel VIEW

USE mavenfuzzyfactory;

-- let1s look at this first, then we will use it as a subquery to do a session summary around it

SELECT
	website_sessions.website_session_id,
	website_pageviews.pageview_url,
	-- website_pageviews.created_at AS pageview_created_at,
	CASE WHEN pageview_url = '/products' THEN 1 ELSE 0 END AS product_page,
	CASE WHEN pageview_url = '/the-original-mr-fuzzy' THEN 1 ELSE 0 END AS mrfuzzy_page,
	CASE WHEN pageview_url = '/cart' THEN 1 ELSE 0 END AS cart_page,
	CASE WHEN pageview_url = '/shipping' THEN 1 ELSE 0 END AS shipping_page,
	CASE WHEN pageview_url = '/billing' THEN 1 ELSE 0 END AS billing_page,
	CASE WHEN pageview_url = '/thank_you_for_your_order' THEN 1 ELSE 0 END AS thankyou_page
FROM website_sessions
	LEFT JOIN website_pageviews
		ON website_sessions.website_session_id = website_pageviews.website_session_id
WHERE website_sessions.utm_source = 'gsearch'
	AND website_sessions.utm_campaign = 'nonbrand'
	AND website_sessions.created_at > '2012-08-05'
	AND website_sessions.created_at < '2012-09-05'
ORDER BY
	website_sessions.website_session_id,
	website_pageviews.created_at;