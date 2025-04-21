create database olympics_db;
use olympics_db;
SELECT * FROM olympics_db.athlete_events;

-- 1. Descriptive Statistics & Overview
-- Total number of rows (events)
select count(*) from athlete_events;

-- Total number of unique athletes
select count(distinct name) as total_athlete from athlete_events;

-- Total number of Olympic Games years
select distinct year 
from athlete_events 
order by year;

-- Total countries represented
select count(distinct team) as total_countries
from athlete_events;

-- 2. Medal Analysis
-- -- Total medal count by country
select team, count(*) as total_medals
from athlete_events
where medal != "None"
group by team
order by total_medals desc;

-- Gold medal winners by country
select team, count(*) as gold_medals
from athlete_events
where medal = "Gold"
group by team
order by gold_medals desc;

-- Top 10 athletes by total medals
select name, count(*) as medal_counts
from athlete_events
where medal != "None"
group by name
order by medal_counts desc
limit 10;

-- Medals by sport
select sport, medal, count(*) as count
from athlete_events
where medal != "None"
group by sport, medal
order by sport desc;

-- 3. Demographics Analysis
-- Average age of athletes
select avg(age) from athlete_events;

-- Average height and weight by gender
select sex, avg(height) as avg_height, avg(weight) as avg_weight
from athlete_events
group by sex;

-- Gender distribution
select sex, count(*) as total
from athlete_events
group by sex;

-- 4. Sport & Event Performance
-- Most popular sports (by number of athletes)
select sport, count(distinct name) as total_athlete
from athlete_events
group by sport
order by total_athlete desc;

-- Events with most gold medals
select event, count(*) as gold_counts
from athlete_events
where medal = "Gold"
group by event
order by gold_counts desc;

-- Athlete's event participation over time
select name, year, event
from athlete_events
where name = "Sayed Abdel Gadir"
order by year;

-- 5. Geography & Team Analysis
-- Teams that participated in the most events
select team, count(*) as total_events
from athlete_events
group by team
order by total_events desc;

-- Top countries by medals in a specific year
select team, count(*) as medal_counts
from athlete_events
where year = 2016 and medal != "None"
group by team
order by medal_counts desc;

-- 6. Time Series Analysis
-- Number of athletes per Olympic year

select year, count(distinct name) as total_athlete
from athlete_events
group by year
order by year;

-- Medals won per year

select year, count(*) as total_medals
from athlete_events
where medal != "None"
group by year
order by year;

-- Custom/Advanced Analytics
-- Age distribution of medal winners
select age, count(*) as total
from athlete_events
where medal != "None"
group by age
order by age;

-- Youngest and oldest medal winners
select name, age, medal
from athlete_events
where medal != "None"
order by age asc
limit 1;

select name, age, medal
from athlete_events
where medal != "None"
order by age desc
limit 1;