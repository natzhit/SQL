/*
Identifying 10 highest paying data analyst jobs based on job postings with specified salaries 
to show the best job opportunities for data analysts in Canada.
*/

SELECT
    job_id,
    job_title,
    job_location,
    job_schedule_type,
    salary_year_avg,
    job_posted_date::DATE,
    name AS company_name
FROM 
    job_postings_fact
LEFT JOIN company_dim ON company_dim.company_id = job_postings_fact.company_id
WHERE
    job_title_short = 'Data Analyst'
    AND salary_year_avg IS NOT NULL
    AND job_country = 'Canada'
ORDER BY
    salary_year_avg DESC
LIMIT 10;
