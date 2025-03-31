select * from athlete_events;
select * from noc_regions;
select count(1) from athlete_events;

SELECT column_name
FROM information_schema.columns
WHERE table_name = 'athlete_events';

1. Write a SQL query to find the total no of Olympic Games held as per the dataset.

SELECT COUNT(DISTINCT "Games") AS total_olympic_games
FROM athlete_events;

2. Mention the total no of nations who participated in each olympics game?

Select "Games", count(distinct "NOC") as total_nations
from athlete_events
group by "Games"
order by "Games";

3. Write a SQL query to list down all the Olympic Games held so far.

Select distinct "Games"
from athlete_events
order by "Games";

4. Which year saw the highest and lowest no of countries participating in olympics.

select "Games", count(distinct "NOC") as total_countries
from athlete_events
group by "Games"
order by "total_countries" desc;

5. Write a SQL query to return the list of countries who have been part of every Olympics games.

select "NOC"
from athlete_events
group by "NOC"
having COUNT(distinct "Games") = (select COUNT(distinct "Games") from athlete_events);

6. Write a SQL query to fetch the list of all sports which have been part of every olympics.

select "Sport", count(distinct "Games") as total_games
from athlete_events
group by "Sport"
order by total_games desc
limit 10;

7. Using SQL query, Identify the sport which were just played once in all of olympics.

select "Sport", count(distinct "Games") as total_games_played
from athlete_events
group by "Sport"
having count(distinct "Games")=1;

8. Write SQL query to fetch the total no of sports played in each olympics.

Select "Games", count(distinct "Sport") as total_sport
from athlete_events
group by "Games"
order by "Games";

9. SQL Query to fetch the details of the oldest athletes to win a gold medal at the olympics.

-- Replace "NA" with NULL (Optional)
-- If you want to permanently clean your data, update all "NA" values to NULL:

UPDATE athlete_events
SET "Age" = NULL
WHERE "Age" = 'NA';

SELECT * FROM athlete_events
WHERE "Medal" = 'Gold' 
AND "Age" IS NOT NULL
ORDER BY CAST("Age" AS INTEGER) DESC
LIMIT 2;

10. Write a SQL query to get the ratio of male and female participants

select 
count(case when "Sex" = 'M' then 1 end) as male_participants,
count(case when "Sex" = 'F' then 1 end) as female_participants,
round(
count(case when "Sex" = 'M' then 1 end)*1.0 / count(case when "Sex" = 'F' then 1 end), 2
) as male_female_ratio
from athlete_events;

11. SQL query to fetch the top 5 athletes who have won the most gold medals.

select "Name", count(*) as gold_medals
from athlete_events
where "Medal" = 'Gold'
group by "Name"
order by gold_medals desc
limit 5;

12. SQL Query to fetch the top 5 athletes who have won the most medals (Medals include gold, silver and bronze).

select "Name", count(*) as total_medals
from athlete_events
where "Medal" in ('Gold', 'Bronze', 'Silver')
group by "Name"
order by total_medals desc
limit 5;

13. Write a SQL query to fetch the top 5 most successful countries in olympics. (Success is defined by no of medals won).

select "NOC", count(*) as total_medals
from athlete_events
where "Medal" in ('Gold','Bronze','Silver')
group by "NOC"
order by total_medals desc
limit 5;

14. Write a SQL query to list down the  total gold, silver and bronze medals won by each country.

select "NOC", 
count(case when "Medal" = 'Gold' then 1 end) as gold_medals,
count(case when "Medal" = 'Silver' then 1 end) as silver_medals,
count(case when "Medal" = 'Bronze' then 1 end) as bronze_medals,
count(case when "Medal" in ('Gold','Bronze','Silver') then 1 end) as total_medals
from athlete_events
group by "NOC"
order by total_medals desc;

15. Write a SQL query to list down the  total gold, silver and bronze medals won by each country corresponding to each olympic games.

select "Games","NOC",
count(case when "Medal" = 'Gold' then 1 end) as gold_medals,
count(case when "Medal" = 'Silver' then 1 end) as silver_medals,
count(case when "Medal" = 'Bronze' then 1 end) as bronze_medals,
count(case when "Medal" in ('Gold','Bronze','Silver') then 1 end) as total_medals
from athlete_events
group by "Games", "NOC"
order by "Games" asc, total_medals desc;

16. Write SQL query to display for each Olympic Games, which country won the highest gold, silver and bronze medals.

with medal_count as(
select "Games", "NOC",
count(case when "Medal" = 'Gold' then 1 end) as gold_medals,
count(case when "Medal" = 'Silver' then 1 end) as silver_medals,
count(case when "Medal" = 'Bronze' then 1 end) as bronze_medals,
count(case when "Medal" in ('Gold','Silver','Bronze') then 1 end) as total_medals
from athlete_events
group by "Games", "NOC"
)
select distinct
mc."Games",
first_value(mc."NOC") over (partition by mc."Games" order by mc.gold_medals DESC) as most_gold,
first_value(mc."NOC") over (partition by mc."Games" order by mc.silver_medals desc) as most_silver,
first_value(mc."NOC") over (partition by mc."Games" order by mc.bronze_medals desc) as most_bronze
from medal_count mc
order by mc."Games";

17. Write a SQL Query to fetch details of countries which have won silver or bronze medal but never won a gold medal.

with Medal_Count as(
select "NOC",
COUNT(*) FILTER (WHERE "Medal" = 'Gold') AS gold_medals,
COUNT(*) FILTER (WHERE "Medal" = 'Silver') AS silver_medals,
COUNT(*) FILTER (WHERE "Medal" = 'Bronze') AS bronze_medals
from athlete_events
group by "NOC"
)
select "NOC", silver_medals, bronze_medals
from Medal_Count
where gold_medals = 0
and (silver_medals > 0 or bronze_medals > 0)
order by silver_medals desc, bronze_medals desc;

18. identify during each Olympic Games, which country won the highest gold, silver and bronze medals. Along with this, identify also the country with the most medals in each olympic games.

with Medal_Count as (
select "Games", "NOC",
count(*) filter (where "Medal" = 'Gold') as gold_medals,
count(*) filter (where "Medal" = 'Silver') as silver_medals,
count(*) filter (where "Medal" = 'Bronze') as bronze_medals,
count(*) as total_medals
from athlete_events
where "Medal" is not null
group by "Games","NOC"
),
Ranked_Countries as (
select "Games","NOC",
gold_medals,
silver_medals,
bronze_medals,
total_medals,
rank() over (partition by "Games" order by gold_medals desc) as gold_rank,
rank() over (partition by "Games" order by silver_medals desc) as silver_rank,
rank() over (partition by "Games" order by bronze_medals desc) as bronze_rank,
rank() over (partition by "Games" order by total_medals desc) as total_rank
from Medal_Count
)
select "Games",
max(case when gold_rank =1 then "NOC" end) as most_gold,
max(case when silver_rank = 1 then "NOC" end) as most_silver,
max(case when bronze_rank = 1 then "NOC" end) as most_bronze,
max(case when total_rank = 1 then "NOC" end) as most_total_medals
from Ranked_Countries
group by "Games"
order by "Games";

19. Write SQL Query to return the sport which has won India the highest no of medals.

select "Sport",
count(*) as total_medals
from athlete_events
where "NOC" = 'IND'
and "Medal" is not null
group by "Sport"
order by total_medals desc
limit 3

-- Breakdown medals by type (Gold, Silver, Bronze)

select "Sport",
count(*) filter (where "Medal" = 'Gold') as gold_medals,
count(*) filter (where "Medal" = 'Silver') as silver_medals,
count(*) filter (where "Medal" = 'Bronze') as bronze_medals,
count(*) as total_medals
from athlete_events
where "NOC" = 'IND'
and "Medal" is not null
group by "Sport"
order by total_medals desc
limit 1;

20. Write an SQL Query to fetch details of all Olympic Games where India won medal(s) in hockey. 

select distinct "Games","Year","Season","City"
from athlete_events
where "NOC" = 'IND'
and "Sport" = 'Hockey'
and "Medal" is not null
order by "Year" asc;