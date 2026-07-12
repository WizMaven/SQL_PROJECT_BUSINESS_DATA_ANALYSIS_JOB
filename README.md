# Introduction
Dive into the business analysis job market! focusing on business analysis roles,this project explores top paying jobs, in-demand skills, and where high demand meets high salary in budiness analytics.

SQL queries? Check them out here: [project_sql folder](/project_sql/).

# Background
Driven by the quest to navigate the utilisation of data in business ananlysis market more effectively, this project was born from a sedire to pinpoint top-paid and in-demand skills, streamlining others work to find optimal jobs. Therefore, this is packed with insights on job titles, salaries, locations, and essential skills.

###  The questions I want to answer through my SQL queries were:

1. What are the top-paying bussiness analysis job?
2. What skills are required for these top-paying jobs?
3. What skills are most in demand for business analysts?
4. Which skills are assosciated with higher salaries?
5. What are the top optimal skills to learn?

# Tools I used

For my deep dive into the business analyst job market, I harnessed the power of several key tools:

- **SQL:** The backbone of my analysis, allowing me to query the database and unearth critical insights.
- **PostgreSQL:** The chosen database management system, ideal for handling the job posting data.
- **Visual Studio Code:** My go-to for database management and executing SQL queries. 
- **Git & GitHub:** Essential for version control and sharing my SQL scriptd and analysis, ensuring collaboration and project tracking.

# The Analysis
Each query in this project aim at investing specific aspects of the data analyst job market. Here is how I approacjed each question. 

### 1. Top Paying Busiess Analyst Jobs
To identify the highest paying roles, I filtered data analyst positions by average yearly salary and location, focusing on remote jobs. This query highlights the high paying opportuniies in the field. 

```sql
SELECT
    job_id,
    job_title,
    job_location,
    job_schedule_type,
    salary_year_avg,
    job_posted_date,
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
    10;
``` 
Here's the break down of the top payig jobs in 2023:
- **Wide Salary Range:** Top 10 paying business analyst roles span from $134 550 to $220 000, indicating significant salary potential in the field.
- **Diverse Employers:** Compnaies like Get It Recruit - Market, Uber, and Noom are among those offering high salaries, showing a board interest across diiferent industries. 
- **Job Title Variety:** There is a high diversity in job titles, from Data Analyst to Director of Analysics, reflecting varied roles and specializations within daa analytics. 

![Top Paying Roles](assest\1_top_paying_roles.png)
*Bar Graph visualising the salary for the top 10 salaries for data analysis; This was derived from my SQL query results*


### 2. Skills for Top Paying Jobs
To understand what skills are required for top paying jobs, I joined the job postings with the skills data, providing the lists of skills employer value for high-compensation roles.

```sql
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
```
Here is the breakdown of the most demanded skills for top paying business analyst job in 2023:

- **SQL** is leading with bold count of 5.
- **Python** follows closely with a bold count of 4.
- **Excel** is also highly sought after, with bold count of 4. Other skills like **Tableau,** **R,** **Looker,** and **SAS** show varying degrees of demand.

![Skills](assest\4_analytics_skills.png)
*Bar Graph visualising the count of skills for the top 10 paying jobs or business analysis; This was derived from my SQL query results*

### 3. In-Demand Skills for Business Analysts
This query helped to identify the skills most frequently requested in job postings, directing focus to areas with high demand.

```SQL
SELECT
    skills,
    COUNT(skills_job_dim.job_id) AS demand_count
    FROM
    job_postings_fact
INNER JOIN skills_job_dim ON job_postings_fact.job_id = skills_job_dim.job_id
INNER JOIN skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id
WHERE
    job_title_short = 'Business Analyst'
    AND job_work_from_home = TRUE
GROUP BY
    skills
ORDER BY
    demand_count DESC
LIMIT
    5;
```
Here is the breakdown of the most demanded skills for data analysts in 2023.

- **SQL** and **Excel** remain fundamental, emphasizing the need for strong foundational skills in business analysis; ranging from data processing and spreadsheet manipulation.

- **Programming** and **Visualization Tools** like **Python,** **Tableau,** and **PowerBI** are essential, pointing towards the increasing importance of technical skills in data storytelling and decision support. 

| Skills                |        Demand Count |
| --------------------- | -----------: |
|SQL |            7291 |
| Excel    |        4611 |
| Python   |  4330 |
| Python  |  3746 |

*Table of the demand for the top 5 skills in data analyst job postings*

### 4. Skills Based on Salary

Exploring the average salaries associated with different skills revealed which skills are the highest paying.

```SQL
SELECT
    skills,
    ROUND(AVG(salary_year_avg), 0) AS avg_salary
FROM
    job_postings_fact
INNER JOIN skills_job_dim ON job_postings_fact.job_id = skills_job_dim.job_id
INNER JOIN skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id
WHERE
    job_title_short = 'Business Analyst'
    AND salary_year_avg IS NOT NULL
    AND job_work_from_home = TRUE
GROUP BY
    skills
ORDER BY
    avg_salary DESC
LIMIT 5;
```
- **High Demand for Big Data & ML Skills:** Top salaries are commanded by analysts skilled in big data technololgies (Power BI, SharePoint), reflecting the industry's high valuation of dsts processing and predictive modeling capabilities.
- **Software Development & Deploment Proficiency:** Knowledge in development and deployment of tools like (Github, Confluence, Outlook) indicates a lucrative crossover between data analysis and engineering, with a premium on skills that facilitate automation and eficient data pipeline management.
- **Cloud Computing Expertise:** Familiarity with cloud and business analization tools ( Sheets, Java, Flow) underscores the growing importance of cloud-based analytics environments, suggesting that cloud proficiency significantly boosts earning potential in data analytics.

| Skill      | Average Salary |
| ---------- | -------------: |
| Power BI   |        $90,448 |
| SharePoint |        $91,667 |
| Confluence |        $87,167 |
| Outlook    |        $86,667 |
| Sheets     |        $84,500 |
| Java       |        $82,500 |
| Flow       |        $79,042 |
| Go         |        $73,333 |
| JavaScript |        $71,721 |
| Spark      |        $62,467 |

*Tables of the aversge salary for the top 10 paying skills for data analysts.*

### 5. Most Optimal Skills to Learn

Combining insights from demand and salary data, this query aimed to pinpoint skills that are both in hihg demand and have high salaries, offering a stargic focus for skill development.

```
SELECT
        skills_dim.skill_id,
        skills_dim.skills,
        COUNT(skills_job_dim.job_id) AS demand_count
        FROM
        job_postings_fact
    INNER JOIN skills_job_dim ON job_postings_fact.job_id = skills_job_dim.job_id
    INNER JOIN skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id
    WHERE
        job_title_short = 'Business Analyst'
         AND salary_year_avg IS NOT NULL
        AND job_work_from_home = TRUE
    GROUP BY
        skills_dim.skill_id
), avg_salary AS (
    SELECT
        skills_job_dim.skill_id,
        ROUND(AVG(salary_year_avg), 0) AS avg_salary
    FROM
        job_postings_fact
    INNER JOIN skills_job_dim ON job_postings_fact.job_id = skills_job_dim.job_id
    INNER JOIN skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id
    WHERE
        job_title_short = 'Business Analyst'
        AND salary_year_avg IS NOT NULL
        AND job_work_from_home = TRUE
    GROUP BY
        skills_job_dim.skill_id
)

SELECT
    skills_demand.skill_id,
    skills_demand.skills,
    demand_count,
    avg_salary
FROM
    skills_demand
INNER JOIN avg_salary ON skills_demand.skill_id = avg_salary.skill_id
ORDER BY
    demand_count DESC,
    avg_salary DESC
LIMIT
    5;
```

| Rank | Skill   | Average Salary |
| ---: | ------- | -------------: |
|    1 | Chef    |   **$220,000** |
|    2 | Phoenix |   **$135,990** |
| 3 | Tableau    |   **$134,000** |
|    3 | Looker  |   **$130,400** |
|    4 | MongoDB |   **$120,000** |
|    5 | Python  |   **$116,516** |
*Table of the most optimal skills for data analyst sorted by salary*

Here's a breakdown of the most optimal skills for Data Analysts in 2023:

- **Business Intelligence and Visualization Tools:** Tableau and Looker, highlights the critical rol of data visualization and business intelligence in driving actionable insights from data.
- **Database Tecnologies:** The demand for skills in tradional  and NoSQL database (Oracle, SQL Server, NoSQL) reflects the enduring need for data storage, retrival, and management expertise.


 # What I've Learnt

 Throughtout this adventure, I've mastered the art of advance SQL, merging tables like a pro and wielding WITH clauses for ninja-level temp table maneuvers. 

 I also get cozy with data aggregation, using GROUP BY and turing aggregate functions like COUNT() and AVG() into my data-summarizing sidekicks.

 To crown it all, I have levelled up my real-world puzzle-solving skills, turing questions into actionable, insightful SQL queries.

 # Conclusion

 This project enhanced my SQL skills and provided valuable insights into the data analyst job market. The findings from the analysis serve as guide to prioritizing skill development and job search efforts. Aspiring data analysts can bette position themselves in a competitive job market focusing on high-demand, high-salary skills. Thi exploration highlights the importance of continuous learning and adaptation to emerging trends in the field of data analytics!


