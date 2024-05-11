/*
Identifying the most demanded skills that job seekers should focus on 
to land a job as a data analyst in the job market in Canada.
*/

WITH da_job_skills AS (
    SELECT
        skill_id,
        COUNT(*) AS skill_count
    FROM skills_job_dim
    INNER JOIN job_postings_fact ON job_postings_fact.job_id = skills_job_dim.job_id
    WHERE
        job_postings_fact.job_title_short ='Data Analyst'
        AND job_postings_fact.job_country ='Canada'
GROUP BY skill_id
)
SELECT
    skills AS skills_name,
    skill_count
FROM da_job_skills
INNER JOIN skills_dim ON skills_dim.skill_id = da_job_skills.skill_id
ORDER BY skill_count DESC
LIMIT 10;

--OR

SELECT 
    skills,
    COUNT (skills_job_dim.job_id) AS skill_count
FROM job_postings_fact
INNER JOIN skills_job_dim ON job_postings_fact.job_id = skills_job_dim.job_id
INNER JOIN skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id
WHERE
    job_title_short = 'Data Analyst'
    AND job_country = 'Canada'
GROUP BY skills
ORDER BY skill_count DESC
LIMIT 10;