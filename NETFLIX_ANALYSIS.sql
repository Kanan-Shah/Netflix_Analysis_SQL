--CREATING TABLE
CREATE TABLE NETFLIX(
     show_id varchar(10),
	 type varchar(10),
	 title varchar(150),
	 director varchar(210),
	 casts varchar(1000),
	 country varchar(150),
	 date_added varchar(50),
	 release_year int,
	 rating varchar(10),
	 duration varchar(15),
	 listed_in varchar(100),
	 description varchar(250)
);
SELECT * FROM NETFLIX;

--Q1.Count the number of Movies vs TV Shows
SELECT type ,COUNT(show_id) as total_number 
FROM NETFLIX
GROUP BY type;

--Q2.Find the most common rating for movies and TV shows
SELECT type, rating
FROM 
(SELECT TYPE,RATING , COUNT(*) ,
    RANK() OVER(PARTITION BY type ORDER BY COUNT(*) DESC) as Ranking
FROM NETFLIX
GROUP BY type,rating) as t1
WHERE Ranking =1;

--Q3.List all movies released in a specific year (e.g., 2020)
SELECT release_year, COUNT(*)as total_movies , STRING_AGG(title ,',') as movie_title
FROM NETFLIX
WHERE type ='Movie'
GROUP BY release_year
ORDER BY release_year;
--only for a particular year like 2020
SELECT title as movies_released_in_2020
FROM NETFLIX
WHERE type ='Movie' AND release_year =2020;

--Q4.Find the top 5 countries with the most content on Netflix
SELECT country , COUNT(show_id) as number_of_content
FROM NETFLIX
WHERE country IS NOT NULL
GROUP BY country
ORDER BY COUNT(show_id) DESC
LIMIT 5;

--Q5. Identify the longest movie
SELECT title ,duration
FROM NETFLIX
WHERE type = 'Movie' and duration = (select max(duration) from NETFLIX);

--Q6. Find content added in the last 5 years
SELECT  
      TO_DATE(date_added , 'DD-Month- YYYY')
from NETFLIX

--Q7.  Find all the movies/TV shows by director 'Rajiv Chilaka'!
SELECT title
FROM NETFLIX
WHERE type ='Movie' AND director = 'Rajiv Chilaka';

--Q8.List all TV shows with more than 5 seasons
SELECT title , duration as total_seasons
FROM NETFLIX
WHERE type = 'TV Show' and duration > '5 Seasons'
ORDER BY duration desc;

--Q9.Count the number of content items in each genre
SELECT listed_in , COUNT(show_id)
FROM NETFLIX
GROUP BY listed_in
ORDER BY COUNT(show_id) DESC ;

--Q10.Find each year and the average numbers of content release in India on netflix. return top 5 year with highest avg content release!
SELECT release_year , COUNT(*)
FROM NETFLIX
WHERE country ='India'
GROUP BY release_year
ORDER BY release_year DESC;

--Q11. List all movies that are documentaries
SELECT title
FROM NETFLIX
WHERE type='Movie' AND listed_in ='Documentaries';

--Q12.Find all content without a director
SELECT * FROM NETFLIX
WHERE director IS NULL;

--Q13.Find how many movies actor 'Salman Khan' appeared in last 10 years!
SELECT release_year , COUNT(show_id)
FROM NETFLIX
WHERE type = 'Movie' AND casts = 'Salman Khan'
GROUP BY release_year;

--Q14.Find the top 10 actors who have appeared in the highest number of movies produced in India.
SELECT casts , count(show_id)
FROM NETFLIX
WHERE type = 'Movie' AND country ='India'
GROUP BY casts;

