
   --DROP TABLE IF EXISTS NETFLIX;
   
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

	   SELECT 
	   COUNT(*) AS TOTAL_CONTENT
	   FROM NETFLIX;

		SELECT 
		DISTINCT type
		from NETFLIX;

		SELECT
		DISTINCT title
		from netflix;    



 1.Count the number of Movies vs TV Shows 

     SELECT  
	 TYPE,
	 COUNT(*) AS total_content
     FROM NETFLIX
	 GROUP BY type;
	 

2.Find the most common rating for movies and TV shows

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


3. List all movies released in a specific year (e.g., 2020)

	  select* FROM  netflix
	  where
	  type = 'Movie'
	  and
	   release_year = 2020;
      
	  
4. Find the top 5 countries with the most content on Netflix

    SELECT 
	country,
	count(show_id) as total_content
	from netflix
	GROUP by 1
	ORDER BY 2 DESC
	LIMIT 5;

	
  5.Identify the longest movie


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


SELECT 
    *
FROM netflix
WHERE type = 'Movie'
ORDER BY SPLIT_PART(duration, ' ', 1)::INT DESC;

6. Find Content Added in the Last 5 Years

SELECT *
FROM netflix
WHERE TO_DATE(date_added, 'Month DD, YYYY') >= CURRENT_DATE - INTERVAL '5 years';



7. Find all the movies/TV shows by director 'Rajiv Chilaka'!

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
 

8. List all TV shows with more than 5 seSSIONS

      
	  SELECT *
      FROM netflix
      WHERE type = 'TV Show'
  AND SPLIT_PART(duration, ' ', 1)::INT > 5;

 
9.Count the number of content items in each genre

       SELECT 
	   listed_in,
	   
       UNNEST (STRING_TO_ARRAY (listed_in,' '))
	   FROM NETFLIX;

	   
10.Find each year and the average numbers of content release in India on netflix. 
return top 5 year with highest avg content release!

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
        (SELECT COUNT(*) FROM netflix WHERE country = 'India')::numeric * 100, 2
    ) AS avg_release
FROM netflix
WHERE country = 'India'
GROUP BY  country, release_year;


 11. List all movies that are documentaries 

	      SELECT *FROM NETFLIX
	      where 
		  listed_in ILIKE '%documentaries%' -- FOR MULTIPL ADDING

        SELECT *FROM NETFLIX
		WHERE 
		listed_in = 'Documentaries';
 
12. Find all content without a director	

      SELECT * FROM NETFLIX
	   WHERE 
	   Director is  null; 

  
13. Find How Many Movies Actor 'Salman Khan' Appeared in the Last 10 Years

       SELECT *FROM NETFLIX
	   WHERE 
	    casts ILIKE '%salman khan%'
		AND 
		release_year>extract(year from current_date)-10

14. Find the top 10 actors who have appeared in the highest number of movies produced in India.

      SELECT  
	
	  UNNEST (STRING_TO_ARRAY(casts, ',')) as actors,
	  count(*) as total_no
	  from netflix
	  where 
	  country ILIKE '%india%'
	  group by 1
	  order by 2 desc
	  LIMIT 10;

   15.Categorize the content based on the presence of the keywords 'kill' and 'violence' in 
   the description field. Label content containing these keywords as 'Bad' and all other 
   content as 'Good'. Count how many items fall into each category. 

          SELECT*FROM NETFLIX
		  WHERE description ILIKE '%kill%';


          SELECT
		  *,
		  case
		  WHEN description ILIKE '%KILL%'
		  OR
		  description ILIKE '%VIOLENCE%'
		  THEN 'bad_content'
		  else 'good_content'
		  END category
		   
          FROM NETFLIX;

        --count

	   
		 SELECT 
        category,
        COUNT(*) AS content_count
	    FROM
		(
        SELECT 
        CASE 
	    WHEN description ILIKE '%kill%' 
	    OR description 
	    ILIKE '%violence%' 
	    THEN 'Bad'
        ELSE 'Good'
        END AS category
        FROM netflix
       )
	   group  by 1
	   order by 2 desc;



	   --END PROJECT
       


		
-- 15 Business Problems & Solutions

1. Count the number of Movies vs TV Shows
2. Find the most common rating for movies and TV shows
3. List all movies released in a specific year (e.g., 2020)
4. Find the top 5 countries with the most content on Netflix
5. Identify the longest movie
6. Find content added in the last 5 years
7. Find all the movies/TV shows by director 'Rajiv Chilaka'!
8. List all TV shows with more than 5 seasons
9. Count the number of content items in each genre
10.Find each year and the average numbers of content release in India on netflix. 
return top 5 year with highest avg content release!
11. List all movies that are documentaries
12. Find all content without a director
13. Find How Many Movies Actor 'Salman Khan' Appeared in the Last 10 Years
14. Find the top 10 actors who have appeared in the highest number of movies produced in India.
15.Categorize the content based on the presence of the keywords 'kill' and 'violence' in 
the description field. Label content containing these keywords as 'Bad' and all other 
content as 'Good'. Count how many items fall into each category.



        
		

	   
