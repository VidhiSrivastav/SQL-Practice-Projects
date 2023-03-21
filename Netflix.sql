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

#Which Movie/shows have a rating greater than or equal to 8?

select rating, title ,type
from netflix_titles
where rating ="TV-14" or type = "TV Shows"

#How many movies were released in the year 2020?

select count(release_year) as total_movies
from netflix_titles
where type = "Movies" or release_year = 2020

#Which country has the most TV shows in the dataset?

select type as most_TV_show ,country
from netflix_titles
where type = "TV Show"
order by type
limit 1

#What is the average duration of TV shows in the dataset?

select round(avg(duration)) as Avg_TV_show
from netflix_titles
where type = "TV Show";

#Which shows /Movies were added to the dataset on September 25, 2021?

select date_added, type, title
from netflix_titles
where type = "TV Show" or date_added ="September 25, 2021"

#How many shows in the dataset have a rating of TV-MA?

select count(type) as total_TVShow
from netflix_titles
where type = "TV Show" and rating = 'TV-MA'

#Which Movie were directed by Toshiya Shinohara?

select type, title, director
from netflix_titles
where type = "Movie" and director = 'Toshiya Shinohara'

#How many Movies are there in the dataset that have a release year greater than or equal to 2010?

select count(type) as total_Movie
from netflix_titles
where type = "Movie" and release_year >= 2010

#Which shows/Movie are listed under both the 'Drama' and 'TV Dramas' genres

select type, listed_in, title
from netflix_titles
where listed_in in ("TV Dramas" , "Dramas")
or listed_in LIKE "%Dramas%"
or listed_in LIKE "%TV Dramas%"





