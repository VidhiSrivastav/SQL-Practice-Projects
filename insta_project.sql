#Write a query to get the total number of comments for each photo.

SELECT photo_id, COUNT(*) AS comment_count
FROM comments
GROUP BY photo_id;

#Write a query to get the username of the user who posted the photo with the most likes.

SELECT u.username
FROM users u
JOIN (
    SELECT p.user_id, p.id
    FROM photos p
    JOIN likes l ON p.id = l.photo_id
    GROUP BY p.id
    ORDER BY COUNT(*) DESC
    LIMIT 1
) t ON u.id = t.user_id;



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

#Write a query to get the top 5 most tagged photos, along with the number of tags for each photo.

SELECT p.id, COUNT(*) AS tag_count
FROM photos p
JOIN photo_tags pt ON p.id = pt.photo_id
GROUP BY p.id
ORDER BY tag_count DESC
LIMIT 5;


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

#total numbers of users who have posted at least one time *

SELECT COUNT(DISTINCT(users.id)) AS total_users_posted
FROM users
join photos ON users.id = photos.user_id;

#A brand wants to know which hashtags to use in a post
#What are the top 5 most commonly used hashtags?

SELECT tag_name, COUNT(tag_name) AS total
FROM tags
JOIN photo_tags ON tags.id = photo_tags.tag_id
GROUP BY tags.id
ORDER BY total DESC;

#We have a small problem with bots on our site...
#Find users who have liked every single photo on the site

SELECT users.id, username, COUNT(users.id)AS total_likes 
FROM users
JOIN likes ON users.id = likes.user_id
GROUP BY users.id
HAVING total_likes = (SELECT COUNT(*) FROM photos);

#We also have a problem with celebrities
#Find users who have never commented on a photo

SELECT count(*) 
FROM
(SELECT username, comment_text
FROM users
LEFT JOIN comments ON users.id = comments.user_id
GROUP BY users.id
HAVING comment_text IS NULL) AS total_number_of_users_without_comments;


#Find the percentage of our users who have either never commented on a photo or have commented on every photo*

SELECT 
tableA.total_A AS number_of_users_never_commented,
(tableA.total_A/(SELECT COUNT(*) FROM users))*100 AS "%",
tableB.total_B AS number_of_users_liked_every_photo,
(tableB.total_B/(SELECT COUNT(*) FROM users))*100 AS "%"

FROM 
(
SELECT COUNT(*) AS total_A 
FROM
(SELECT username, comment_text
FROM users
LEFT JOIN comments ON users.id = comments.user_id
GROUP BY users.id
HAVING comment_text IS NULL ) AS total_numbers_without_comments
) 
AS tableA

JOIN
(
SELECT COUNT(*) AS total_B
FROM 
(
SELECT users.id, username,COUNT(users.id) AS total_likes_by_user
FROM users
JOIN likes ON users.id  = likes.user_id
GROUP BY users.id
HAVING total_likes_by_user = (SELECT COUNT(*) FROM photos)) AS total_nuber_users_likes_every_photo
)
AS tableB;
