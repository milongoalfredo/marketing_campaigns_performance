-- ========================================
-- 1. PERFORMANCE GERAL
-- ========================================

SELECT 
	COUNT(*) AS total_campaigns,
	SUM(impressions) AS total_impressions,
	SUM(clicks) AS total_clicks,
	SUM(conversions) AS total_conversions,
	SUM(revenue) AS total_revenue,
	SUM(cost) AS total_cost
FROM marketing_campaigns;

-- ========================================
-- 2. CTR, Conversion Rate e ROI globais
-- ========================================

SELECT
	SUM(clicks) * 1.0 / SUM(impressions) AS overall_ctr,
	SUM(conversions) * 1.0 / SUM(clicks) AS overall_conversion_rate,
	(SUM(revenue) - SUM(cost)) * 1.0 / SUM(cost) AS overall_roi
FROM marketing_campaigns
WHERE cost > 0;

-- ========================================
-- 3. TOP MELHORES CAMPANHAS
-- ========================================

SELECT 
	campaign_name,
	SUM(revenue) AS revenue,
	SUM(conversions) AS conversions,
	SUM(cost) AS cost,
	(SUM(revenue) - SUM(cost)) * 1.0 / SUM(cost) AS roi
FROM marketing_campaigns
WHERE cost > 1
GROUP BY campaign_name
ORDER BY roi DESC
LIMIT 10;

-- ========================================
-- 4. TOP PIORES CAMPANHAS
-- ========================================

SELECT
    campaign_name,
    SUM(revenue) AS revenue,
    SUM(cost) AS cost,
    (SUM(revenue) - SUM(cost)) * 1.0 / SUM(cost) AS roi
FROM marketing_campaigns
WHERE cost > 1
GROUP BY campaign_name
ORDER BY roi ASC
LIMIT 10;

-- ========================================
-- 5. PAID VS ORGANIC
-- ========================================

SELECT 
	channel_type,
	COUNT(*) AS campaigns,
	SUM(conversions) AS conversions,
	SUM(revenue) AS revenue,
	SUM(cost) AS cost
FROM marketing_campaigns
GROUP BY channel_type;

-- ========================================
-- 6. PERFORMANCE POR CANAL
-- ========================================

SELECT 
	campaign_name,
	channel_type,
	SUM(revenue) AS revenue,
	SUM(conversions) AS conversions,
	AVG(ctr) AS avg_ctr
FROM marketing_campaigns
GROUP BY campaign_name, channel_type
ORDER BY revenue DESC;

-- ========================================
-- 7. RELAÇÃO ENTRE CLICKS E CONVERSÕES
-- ========================================

SELECT 
	clicks,
	conversions
FROM marketing_campaigns
WHERE clicks > 1
ORDER BY clicks DESC
LIMIT 15;

-- ========================================
-- 8. CPA POR CAMPANHA
-- ========================================

SELECT 
	campaign_name,
	SUM(cost) * 1.0 / SUM(conversions) AS cpa
FROM marketing_campaigns
WHERE cost > 0
GROUP BY campaign_name
ORDER BY cpa ASC;
