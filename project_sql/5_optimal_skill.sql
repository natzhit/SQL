/*
Identifying the ideal skill set for a data analyst in Canada, i.e., the most desirable and well-paid skills to learn 
that ensure employment opportunities and financial rewards; thus, providing valuable insights for career advancement in the field of data analysis.
*/

WITH skills_demand AS (
    SELECT 
        skills_dim.skill_id,
        skills_dim.skills,
        COUNT (skills_job_dim.job_id) AS skill_count
    FROM job_postings_fact
    INNER JOIN skills_job_dim ON job_postings_fact.job_id = skills_job_dim.job_id
    INNER JOIN skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id
    WHERE
        job_title_short ='Data Analyst'
        AND salary_year_avg IS NOT NULL
        AND job_country = 'Canada'
    GROUP BY skills_dim.skill_id
), average_salary AS (  
    SELECT 
        skills_job_dim.skill_id,
        ROUND(AVG(job_postings_fact.salary_year_avg),0) as avg_salary
    FROM job_postings_fact
    INNER JOIN skills_job_dim ON job_postings_fact.job_id = skills_job_dim.job_id
    INNER JOIN skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id
    WHERE
        job_title_short ='Data Analyst' 
        AND salary_year_avg IS NOT NULL
        AND job_country = 'Canada'
    GROUP BY skills_job_dim.skill_id
)
SELECT
    skills_demand.skills,
    skill_count,
    avg_salary
FROM skills_demand
INNER JOIN average_salary ON skills_demand.skill_id = average_salary.skill_id
WHERE skill_count >=5
ORDER BY 
    skill_count DESC
LIMIT 25;

--OR 

SELECT
    skills_dim.skills,
    COUNT(skills_job_dim.job_id) AS skill_count,
    ROUND(AVG(job_postings_fact.salary_year_avg),0) AS avg_salary
FROM job_postings_fact
INNER JOIN skills_job_dim ON job_postings_fact.job_id = skills_job_dim.job_id
INNER JOIN skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id
WHERE
    job_title_short ='Data Analyst'
    AND salary_year_avg IS NOT NULL
    AND job_country = 'Canada'
GROUP BY skills_dim.skill_id
HAVING COUNT(skills_job_dim.job_id) >=5
ORDER BY
    skill_count DESC
LIMIT 25;