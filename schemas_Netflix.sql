--Schema_Netflix_project


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


          