#How many unique shows are there in the dataset?

select distinct(show_id) from netflix_titles;

#How many movies are in the dataset?

select count(type) AS type_Movie from netflix_titles
where type = "Movie"

#hw many TV shows are in the dataset?

select count(type) AS type_TVShow from netflix_titles
where type = "TV Show"

#What is the title of the longest movie in the dataset?

select  title,duration,director
from netflix_titles
where type = "Movie"
order by duration
limit 1

#Who directed the movie with the longest duration?

select  title,duration,director
from netflix_titles
where type = "Movie"
order by duration
limit 1

#Which show has the highest rating?

select type, rating
from netflix_titles
where type = "TV Show"
order by rating
limit 1

#How many shows are added in the dataset in the year 2021?

select count(type) as type_tv_show ,release_year
from netflix_titles
where release_year = 2021

#What is the total duration of all shows in the dataset?

select sum(duration) as total_season ,title, release_year
from netflix_titles
where type = "TV Show"
group by title, release_year
order by total_season desc
limit 5;

#Which country produced the most number of shows in the dataset?

select type as most_TV_show ,country
from netflix_titles
where type = "TV Show"
order by type
limit 1

#Who are the top 5 Movies with actors/actresses in the dataset?

select type, title, cast, rating
from netflix_titles
order by rating
limit 5

#Which shows have the word 'The' in their title?

select *
from netflix_titles
where title like "THE%"
