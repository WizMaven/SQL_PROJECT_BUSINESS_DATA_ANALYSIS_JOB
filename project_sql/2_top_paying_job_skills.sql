       /* Question: 

1. What are the top paying jobs for my role (Bussiness Analyst/ Business Data Analytics)?
2. Identify the top 10 highest-paying (Bussiness Analyst/ Business Data Analytics) roles that are available remotely.
3. Focuses on job posting with specified salaries (remove null).
Why? Highlight the top-paying opportunities for (Bussiness Analyst/ Business Data Analytics) offering insight into ..........?
*/
 

WITH top_paying_jobs AS (
    SELECT
        job_id,
        job_title,
        salary_year_avg,
        name AS company_name
    FROM
        job_postings_fact
    LEFT JOIN company_dim ON job_postings_fact.company_id = company_dim.company_id
    WHERE
        job_title_short = 'Business Analyst' AND
        job_location = 'Anywhere' AND
        salary_year_avg IS NOT NULL
    ORDER BY
        salary_year_avg DESC
    LIMIT 
        10
)

SELECT 
    top_paying_jobs.*,
    skills
FROM 
    top_paying_jobs
INNER JOIN skills_job_dim ON top_paying_jobs.job_id = skills_job_dim.job_id
INNER JOIN skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id
ORDER BY
    salary_year_avg DESC