use campusx;
select * from playstore;

load data infile "E:/SQL FILES/playstore.csv"
into table playstore
fields terminated by ','
optionally enclosed by '"'
lines terminated by '\r\n'
ignore 1 rows;

select * from playstore;

-- 1. You're working as a market analyst for a mobile app development company. Your task is to identify the most promising categories (TOP 5) for launching new free apps based on their average ratings.

select Category,round(avg(Rating), 2) as 'avg_rating' from playstore
where type = 'Free'
group by Category
order by avg_rating Desc limit 5;

/*2. As a business strategist for a mobile app company, your objective is to pinpoint the three categories that generate the most revenue from paid apps. 
This calculation is based on the product of the app price and its number of installations.*/

select Category , avg(revenue) as 'rev' from
(
select Category, Price * Installs as 'revenue' from playstore where Type = 'Paid'
)t group by category
order by rev desc limit 3;

/*3. As a data analyst for a gaming company, you're tasked with calculating the percentage of app within each category. 
This information will help the company understand the distribution of gaming apps across different categories.*/

select *, (cnt / (select count(*) from playstore))*100 as 'percentage' from 
(
select category, count(app) as 'cnt' from playstore group by category 
)t;

-- 4. As a data analyst at a mobile app-focused market research firm you’ll recommend whether the company should develop paid or free apps for each category based on the ratings of that category.

with t1 as 
(
select Category, round(avg(Rating),2) as 'paid' from playstore where Type = 'Paid' group by Category
),
t2 as
(
select Category, round(avg(Rating),2) as 'free' from playstore where Type = 'Free' group by Category
)

select *, if (paid>free, 'Develop Paid apps', 'Develop Unpaid apps') as 'Decision' from
(
select a.category, paid, free from t1 as a inner join t2 as b on a.category = b.category
)k

/*4. Suppose you're a database administrator your databases have been hacked and hackers are changing price of certain apps on the database, it is taking long for IT team to neutralize the hack,
 however you as a responsible manager don’t want your data to be changed, do some measure where the changes in price can be recorded as you can’t stop hackers from making changes.*/
 














-- Your IT team have neutralized the threat; however, hackers have made some changes in the prices, but because of your measure you have noted the changes, now you want correct data to be inserted into the database again.
-- As a data person you are assigned the task of investigating the correlation between two numeric factors: app ratings and the quantity of reviews.
-- Your boss noticed  that some rows in genres columns have multiple genres in them, which was creating issue when developing the  recommender system from the data he/she assigned you the task to clean the genres column and make two genres out of it, rows that have only one genre will have other column as blank.
-- Your senior manager wants to know which apps are not performing as par in their particular category, however he is not interested in handling too many files or list for every  category and he/she assigned  you with a task of creating a dynamic tool where he/she  can input a category of apps he/she  interested in  and your tool then provides real-time feedback by displaying apps within that category that have ratings lower than the average rating for that specific category.
-- 10.What is the difference between “Duration Time” and “Fetch Time.
