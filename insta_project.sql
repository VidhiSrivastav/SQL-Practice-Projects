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

