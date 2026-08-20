/*
Answer: What are the most optimal skills to learn (aka it’s in high demand and a high-paying skill)?
- Identify skills in high demand and associated with high average salaries for Data and Business Analyst roles
- Concentrates on Canada or remote positions with specified salaries
- Why? Targets skills that offer job security (high demand) and financial benefits (high salaries), 
    offering strategic insights for career development in data or business analysis
*/

WITH skills_demand AS (
    SELECT
        skills_dim.skills,
        skills_dim.skill_id,
        COUNT(job_postings_fact.job_id) AS demand_count
    FROM
        job_postings_fact
    INNER JOIN skills_job_dim ON job_postings_fact.job_id = skills_job_dim.job_id
    INNER JOIN skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id
    WHERE
        (job_title_short = 'Data Analyst' OR job_title_short = 'Business Analyst') AND
        (job_location LIKE '%Canada%' OR job_location = 'Anywhere') AND
        salary_year_avg IS NOT NULL
    GROUP BY
        skills_dim.skill_id
),
average_salary AS (
    SELECT
        skills_job_dim.skill_id,
        ROUND(AVG(salary_year_avg), 0) AS avg_salary
    FROM
        job_postings_fact
    INNER JOIN skills_job_dim ON job_postings_fact.job_id = skills_job_dim.job_id
    INNER JOIN skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id
    WHERE
        (job_title_short = 'Data Analyst' OR job_title_short = 'Business Analyst') AND
        (job_location LIKE '%Canada%' OR job_location = 'Anywhere') AND
        salary_year_avg IS NOT NULL
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
INNER JOIN average_salary ON skills_demand.skill_id = average_salary.skill_id
WHERE
    demand_count > 10
ORDER BY
    avg_salary DESC,
    demand_count DESC
LIMIT 25;

/*
The data shows that Python, Tableau, and R are the most in-demand skills, with hundreds of job postings and average salaries around $100K+. 
Cloud and modern data-platform skills such as Snowflake, Azure, AWS, and Databricks have lower demand but generally higher salaries. 
Databricks stands out with the highest average salary at $135.8K, while Python offers the strongest balance between demand and compensation. 
Combining Python + SQL + BI tools + cloud/data platforms would be a strong strategy for Canadian and remote analyst positions.

[
  {
    "skill_id": 75,
    "skills": "databricks",
    "demand_count": "12",
    "avg_salary": "135840"
  },
  {
    "skill_id": 80,
    "skills": "snowflake",
    "demand_count": "39",
    "avg_salary": "112399"
  },
  {
    "skill_id": 97,
    "skills": "hadoop",
    "demand_count": "28",
    "avg_salary": "111347"
  },
  {
    "skill_id": 8,
    "skills": "go",
    "demand_count": "30",
    "avg_salary": "111121"
  },
  {
    "skill_id": 74,
    "skills": "azure",
    "demand_count": "37",
    "avg_salary": "109978"
  },
  {
    "skill_id": 77,
    "skills": "bigquery",
    "demand_count": "18",
    "avg_salary": "109806"
  },
  {
    "skill_id": 234,
    "skills": "confluence",
    "demand_count": "14",
    "avg_salary": "108415"
  },
  {
    "skill_id": 76,
    "skills": "aws",
    "demand_count": "33",
    "avg_salary": "107762"
  },
  {
    "skill_id": 194,
    "skills": "ssis",
    "demand_count": "12",
    "avg_salary": "106683"
  },
  {
    "skill_id": 185,
    "skills": "looker",
    "demand_count": "55",
    "avg_salary": "106154"
  },
  {
    "skill_id": 79,
    "skills": "oracle",
    "demand_count": "43",
    "avg_salary": "103877"
  },
  {
    "skill_id": 233,
    "skills": "jira",
    "demand_count": "23",
    "avg_salary": "103276"
  },
  {
    "skill_id": 2,
    "skills": "nosql",
    "demand_count": "15",
    "avg_salary": "102624"
  },
  {
    "skill_id": 184,
    "skills": "dax",
    "demand_count": "11",
    "avg_salary": "102500"
  },
  {
    "skill_id": 1,
    "skills": "python",
    "demand_count": "271",
    "avg_salary": "102011"
  },
  {
    "skill_id": 4,
    "skills": "java",
    "demand_count": "22",
    "avg_salary": "101700"
  },
  {
    "skill_id": 5,
    "skills": "r",
    "demand_count": "157",
    "avg_salary": "101206"
  },
  {
    "skill_id": 187,
    "skills": "qlik",
    "demand_count": "15",
    "avg_salary": "101037"
  },
  {
    "skill_id": 197,
    "skills": "ssrs",
    "demand_count": "15",
    "avg_salary": "99993"
  },
  {
    "skill_id": 182,
    "skills": "tableau",
    "demand_count": "266",
    "avg_salary": "99562"
  },
  {
    "skill_id": 78,
    "skills": "redshift",
    "demand_count": "17",
    "avg_salary": "99558"
  },
  {
    "skill_id": 7,
    "skills": "sas",
    "demand_count": "74",
    "avg_salary": "98359"
  },
  {
    "skill_id": 186,
    "skills": "sas",
    "demand_count": "74",
    "avg_salary": "98359"
  },
  {
    "skill_id": 204,
    "skills": "visio",
    "demand_count": "13",
    "avg_salary": "97801"
  },
  {
    "skill_id": 13,
    "skills": "c++",
    "demand_count": "12",
    "avg_salary": "97795"
  }
]
*/
