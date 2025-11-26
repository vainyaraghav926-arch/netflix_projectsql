
#  Netflix Movies and Shows Data Analysis using SQL


# Overview
This project involves a comprehensive analysis of Netflix's movies and TV shows data using SQL. The goal is to extract valuable insights and answer various business questions based on the dataset. The following README provides a detailed account of the project's objectives, business problems, solutions, findings, and conclusions.
 # Objectives
* Analyze the distribution of content types (movies vs TV shows).
* Identify the most common ratings for movies and TV shows.
* List and analyze content based on release years, countries, and durations.
* Explore and categorize content based on specific criteria and keywords.
# dataset
The data for this project is sourced from the Kaggle dataset:

 * Datasetlink:https://www.kaggle.com/datasets/shivamb/netflix-shows

# Schema 
```SQL 
CREATE TABLE NETFLIX  (
       show_id VARCHAR(10),
	   
       type VARCHAR(10),
	   title VARCHAR(120),
       director VARCHAR(210),
       casts VARCHAR(1000),
       country VARCHAR(150),
       date_added VARCHAR(50),
       release_year INT,
       rating VARCHAR(20),	
       duration VARCHAR(20),
       listed_in VARCHAR(100),
       description VARCHAR(250)
 
             );

	   SELECT *FROM NETFLIX;
```

 # Business Problems and Solutions
1. Count the Number of Movies vs TV Shows
```
SELECT  
	 TYPE,
	 COUNT(*) AS total_content
     FROM NETFLIX
	 GROUP BY type;
```
Objective: Determine the distribution of content types on Netflix.

2. Find the Most Common Rating for Movies and TV Shows
```
select 
	  type,
	  rating
	  FROM
	  
(
	 SELECT 
	 type,
	 rating,
	 COUNT(*),
	 RANK() OVER(PARTITION BY type ORDER BY COUNT(*)) as ranking
	 from netflix
     GROUP BY 1,2

)as t1
where 
ranking=1;
```
Objective: Identify the most frequently occurring rating for each type of content.

3. List all movies released in a specific year (e.g., 2020)

```
	  select* FROM  netflix
	  where
	  type = 'Movie'
	  and
	   release_year = 2020;
 ```
Objective: Retrieve all movies released in a specific year.

 4. Find the top 5 countries with the most content on Netflix

```
     SELECT 
	country,
	count(show_id) as total_content
	from netflix
	GROUP by 1
	ORDER BY 2 DESC
	LIMIT 5;     
```
Objective: Identify the top 5 countries with the highest number of content items.

 5.Identify the longest movie

```
     SELECT *FROM NETFLIX
	WHERE
	type = 'Movie'
	AND
	duration = (select MAX(duration)from netflix); 

    SELECT 
    *
FROM netflix
WHERE type = 'Movie'
ORDER BY SPLIT_PART(duration, ' ', 1)::INT DESC;

```
Objective: Find the movie with the longest duration.


6. Find Content Added in the Last 5 Years
```
SELECT *
FROM netflix
WHERE TO_DATE(date_added, 'Month DD, YYYY') >= CURRENT_DATE - INTERVAL '5 years';
```
Objective: Retrieve content added to Netflix in the last 5 years.
 
 7. Find all the movies/TV shows by director 'Rajiv Chilaka'!

```
 SELECT
 *
 FROM  NETFLIX
		WHERE 
		Director = 'Rajiv Chilaka';

        -- FOR MULTIPLE  DIRECTORS

 SELECT
		*
		FROM  NETFLIX
		WHERE 
		Director LIKE '%Rajiv Chilaka%';
```

Objective: List all content directed by 'Rajiv Chilaka'.

8. List all TV shows with more than 5 sessions.

``` 
	  SELECT *
      FROM netflix
      WHERE type = 'TV Show'
  AND SPLIT_PART(duration, ' ', 1)::INT > 5;
  ```
Objective: Identify TV shows with more than 5 seasons.

9.Count the number of content items in each genre.

```
 SELECT 
	   listed_in,
	   
       UNNEST (STRING_TO_ARRAY (listed_in,' '))
	   FROM NETFLIX;
```
Objective:Count the number of content items in each genre

10.Find each year and the average numbers of content release in India on netflix. 
return top 5 year with highest avg content release!
```
      SELECT 
	  TO_DATE(date_added,'month DD,YYYY') AS date,
	  *
	  FROM NETFLIX
	  WHERE
	  country= 'India'
	   

    SELECT 
    country,
    release_year,
    COUNT(*) AS total_release,
    ROUND(
        COUNT(*)::numeric /
        (SELECT COUNT(*) FROM netflix WHERE country = 'India')  ::numeric * 100, 2
    ) AS avg_release
FROM netflix
WHERE country = 'India'
GROUP BY  country, release_year;
```
Objective: Calculate and rank years by the average number of content releases by India.

11. List all movies that are documentaries 

```
SELECT *FROM NETFLIX
	      where 
		  listed_in ILIKE '%documentaries%' -- FOR MULTIPL ADDING

SELECT *FROM NETFLIX
		WHERE 
		listed_in = 'Documentaries';
```
Objective: Retrieve all movies classified as documentaries.

12. Find all content without a director.

  ```
 SELECT * FROM NETFLIX
	   WHERE 
	   Director is  null; 
```
Objective: List content that does not have a director.

13. Find How Many Movies Actor 'Salman Khan' Appeared in the Last 10 Years.
```
SELECT *FROM NETFLIX
	   WHERE 
	    casts ILIKE '%salman khan%'
		AND 
		release_year>extract(year from current_date)-10
```
Objective: Count the number of movies featuring 'Salman Khan' in the last 10 years.

14. Find the top 10 actors who have appeared in the highest number of movies produced in India.
```
SELECT  
	
	  UNNEST (STRING_TO_ARRAY(casts, ',')) as actors,
	  count(*) as total_no
	  from netflix
	  where 
	  country ILIKE '%india%'
	  group by 1
	  order by 2 desc
	  LIMIT 10;
```
Objective: Categorize content as 'Bad' if it contains 'kill' or 'violence' and 'Good' otherwise. Count the number of items in each category.

# Author - Ananya(Poonam) Raghav
This project is part of my portfolio, showcasing the SQL skills essential for data analyst roles. If you have any questions, feedback, or would like to collaborate, feel free to get in touch!
# Findings and Conclusion

Overall Findings & Insights

•	Balanced Content Strategy:
Netflix hosts a wide range of Movies and TV Shows, indicating a diversified content library designed to appeal to multiple audience segments.

•Audience Targeting Through Ratings:
The most common ratings such as TV-MA and TV-14 show that Netflix focuses heavily on mature content and young-adult audiences.
This suggests Netflix’s strategy aligns with global streaming preferences.

•Country-Wise Content Strength:
The analysis highlights strong content representation from countries like United States, India, United Kingdom, showing Netflix’s reliance on these markets for consistent production and licensing.
India appears as a major contributor, reflecting Netflix’s growing focus on regional markets.

•Duration Patterns Reveal Content Style:
Movies mostly fall into the 90–120 minute range, while TV Shows predominantly have 1–2 seasons, suggesting shorter, binge-friendly content—ideal for modern streaming behavior.

•
Keyword-Based Categorization Helps Identify Themes:
Categorizing content as “Good” vs “Bad” using keywords like kill, violence, etc., shows how metadata can reveal hidden patterns about content tone and theme.



