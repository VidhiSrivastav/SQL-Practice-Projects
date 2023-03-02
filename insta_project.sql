#What day of the week do most users register on?
#We need to figure out when to schedule an ad campgain*

select date_format(created_at, "%W") AS "day_of_week",
count(*) AS "total_registrations"
from users
group by day_of_week
order by total_registrations desc;

#version 2
select date_format(created_at, "%W") AS "day_of_week",
count(*) AS "total_registrations"
from users
group by 1
order by 2 desc;


#We want to target our inactive users with an email campaign.
#Find the users who have never posted a photo*/

select username
from users
LEFT JOIN photos 
ON users.id = photos.user_id
where photos.id IS NULL;



#Our Investors want to know...
#How many times does the average user post?
#total number of photos/total number of users

SELECT ROUND((select count(*) from photos)/(select count(*) from users),2);

#user ranking by postings higher to lower

SELECT users.username,COUNT(photos.image_url)
FROM users
JOIN photos ON users.id = photos.user_id
GROUP BY users.id
ORDER BY 2 DESC;

#Total Posts by users (longer version of SELECT COUNT(*)FROM photos) 

SELECT SUM(user_posts.total_posts_per_user)
FROM (SELECT users.username,COUNT(photos.image_url)AS  total_posts_per_user
FROM users
JOIN photos ON users.id = photos.user_id
GROUP BY users.id) AS user_posts;
