--Botox vs Liposuction campaigns - Analysis of sales in the last 3 months

SELECT *
FROM PortfolioProject..Botox_the_medical
Order by 3,4

SELECT *
FROM PortfolioProject..Liposuction_The_Medical
Order by 3,4

--Looking at Botox Won cases = 81 from 2,011 leads = 6.7% closing rate
--Looking at Liposuction cases = 20 from 1,204 leads = 1.66% closing rate

SELECT opportunity_name, lead_value, source, status
FROM PortfolioProject..Botox_the_medical
WHERE status like 'won'
AND Lead_Value > 0
Order by 4,2 desc

SELECT opportunity_name, lead_value, source, status
FROM PortfolioProject..Liposuction_The_Medical
WHERE status like 'won'
AND Lead_Value > 0
Order by 4,2 desc

--Looking at Botox Open cases = 794 from 2,011 leads, and 132 out of 1,204 liposuction leads, there is a high opportunity cost here, 
--there are still a considerably high number of leads that have not advanced and are still with their service open. 
--The following is recommended: 
--1.Create a customer reactivation campaign with some incentive
--2.Follow up on leads through calls, human interaction increases the number of leads showing up for an appointment. 

SELECT opportunity_name, lead_value, source, status
FROM PortfolioProject..Botox_the_medical
WHERE status like 'open'
Order by 4,2 desc

SELECT opportunity_name, lead_value, source, status
FROM PortfolioProject..Liposuction_The_Medical
WHERE status like 'open'
Order by 4,2 desc

--Looking at the revenue of each lead (New patient) and its source
--Clearly, we can see that the majority of new patients for Botox come from Facebook paid ads, this makes it the winning source.
--For the case of Liposuction, we notice that the winning source is Google ads, where people are searching for such services themselves.
--This is an example that the leads coming in from Facebook are looking to see real results in the ads through graphics, as opposed to the results generated on Google for Liposuction, 
--where people are searching more for these services.

SELECT status, opportunity_name, MAX(lead_value) AS Sales, source
FROM PortfolioProject..Botox_the_medical
WHERE lead_value > 0  
Group by opportunity_name, lead_value, source, status
Order by sales desc

SELECT status, opportunity_name, MAX(lead_value) AS Sales, source
FROM PortfolioProject..Liposuction_The_Medical
WHERE lead_value > 0  
Group by opportunity_name, lead_value, source, status
Order by sales desc


--- Looking at the total number of leads in each pipeline, along with the monetary value of each lead.

SELECT source, COUNT(opportunity_name) as TotalLeadsbySource, SUM(cast(Lead_Value as int)) as TotaPipelineValue
FROM PortfolioProject..Botox_the_medical
WHERE source is not NULL
Group by source
Order by TotalLeadsbySource desc

SELECT source, COUNT(opportunity_name) as TotalLeadsbySource, SUM(cast(Lead_Value as int)) as TotaPipelineValue
FROM PortfolioProject..Liposuction_The_Medical
WHERE source is not NULL
and lead_value > 0
Group by source
Order by TotalLeadsbySource desc


---Looking at the total number of leads in each stage of the funnel, along with the monetary value of the pipeline.

SELECT status, COUNT(opportunity_name) as TotalofLeadsbyStage, SUM(cast(lead_value as int)) as TotalBotoxPipelineValue
FROM PortfolioProject..Botox_the_medical
Group by status
Order by TotalBotoxPipelineValue desc

SELECT status, COUNT(opportunity_name) as TotalofLeadsbyStage, SUM(cast(lead_value as int)) as TotalLipoPipelineValue
FROM PortfolioProject..Liposuction_The_Medical
Group by status
Order by TotalLipoPipelineValue desc

-- Looking at the total number of leads coming from each source, and the monetary value of each one of them, with each status of the funnel

SELECT source, COUNT(opportunity_name) as TotalLeadsbySource, SUM(cast(Lead_Value as int)) as TotaValuePipeline, status
FROM PortfolioProject..Botox_the_medical
WHERE source is not NULL
Group by source, status
Order by TotalLeadsbySource desc

SELECT source, COUNT(opportunity_name) as TotalLeadsbySource, SUM(cast(Lead_Value as int)) as TotaValuePipeline, status
FROM PortfolioProject..Liposuction_The_Medical
WHERE source is not NULL
and lead_value > 0
Group by source, status
Order by TotalLeadsbySource desc

-- Looking at the number of WON cases of Botox and Liposuction, of every campaign

SELECT source, COUNT(opportunity_name) as TotalLeadsbySource, SUM(cast(Lead_Value as int)) as TotaValuePipeline, status
FROM PortfolioProject..Botox_the_medical
WHERE source is not NULL
AND status like 'won'
and lead_value > 0
Group by source, status
Order by TotalLeadsbySource desc

SELECT source, COUNT(opportunity_name) as TotalLeadsbySource, SUM(cast(Lead_Value as int)) as TotaValuePipeline, status
FROM PortfolioProject..Liposuction_The_Medical
WHERE source is not NULL
AND status like 'won'
and lead_value > 0
Group by source, status
Order by TotalLeadsbySource desc

--Total Monetary Case Winnings for Botox and Liposuction

SELECT COUNT(cast(Lead_Value as int)) as NewBotoxCases, SUM(CAST(lead_value as int)) as TotalBotoxRevenue 
FROM PortfolioProject..Botox_the_medical
WHERE status like 'won'
and lead_value > 0
Order by TotalBotoxRevenue desc

SELECT COUNT(cast(Lead_Value as int)) as NewLipoCases, SUM(CAST(lead_value as int)) as TotalLipoRevenue 
FROM PortfolioProject..Liposuction_The_Medical
WHERE status like 'won'
and lead_value > 0
Order by TotalLipoRevenue desc


------------

SELECT COUNT(cast(Lead_Value as int))as NumberofBotoxLeads, SUM(CAST(lead_value as int)) AS BotoxtotalValue
FROM PortfolioProject..Botox_the_medical
WHERE status like 'won'
AND dbo.Botox_the_medical.lead_value > 0
    UNION
SELECT COUNT(cast(Lead_Value as int)) as NumberofLipoLeads, SUM(CAST(lead_value as int)) AS LipototalValue
FROM PortfolioProject..Liposuction_The_Medical
WHERE status like 'won'
AND dbo.Liposuction_The_Medical.Lead_Value > 0
    UNION
	SELECT COUNT(cast(Lead_Value as int)), SUM(CAST(lead_value as int)) AS BotoxtotalValue
FROM PortfolioProject..Botox_the_medical
    UNION
SELECT COUNT(cast(Lead_Value as int)), SUM(CAST(lead_value as int)) AS LipototalValue
FROM PortfolioProject..Liposuction_The_Medical


  -------------------------------------------------------------*******************************************************
-- Here we see the cumulative and per new patient total for both Botox and Liposuction services.
-- We can analyze that although Botox is a low ticket service, the total of what we have generated, in the same time, 
-- shows that it has been higher than Liposuction, besides, Botox patients are usually first time clients and you can upsell them 
-- to other higher ticket services.

Liposuction leads are more expensive to generate.
SELECT btx.status,btx.opportunity_name AS BotoxTotalLeads,
SUM(CAST(btx.lead_value as int)) AS BotoxtotalValue,
lipo.status,lipo.opportunity_name as NumberofLipoLeads, 
SUM(CAST(lipo.lead_value as int)) AS LipototalValue, SUM(lipo.lead_value) OVER (ORDER BY lipo.lead_value) AS TotalRevenueLipo, 
SUM(btx.lead_value) OVER (ORDER BY btx.lead_value) AS TotalRevenueBotox
FROM PortfolioProject..Botox_the_medical AS btx
FULL JOIN PortfolioProject..Liposuction_The_Medical AS lipo
   ON btx.Lead_Value = lipo.Lead_Value
   AND btx.opportunity_name = lipo.opportunity_name
   AND btx.status = lipo.status
   WHERE lipo.status like 'won'
   OR btx.status like 'won'
   AND btx.Lead_Value > 0
     GROUP BY lipo.opportunity_name, btx.opportunity_name, lipo.status, btx.status, lipo.Lead_Value, btx.Lead_Value 
ORDER BY LipototalValue desc, BotoxtotalValue desc;

 --Looking at every lead that spent and got converted into a patient for Botox or Liposuction in just one column.

 
 SELECT opportunity_name, lead_value, status 
 FROM Liposuction_The_Medical
 WHERE status like 'won'
 and lead_value > 0 
UNION
 SELECT opportunity_name, lead_value, status 
 FROM Botox_the_medical 
 WHERE status like 'won'
 and lead_value > 0 
ORDER BY Lead_Value desc
 

  
 



 





  
  




 

 













