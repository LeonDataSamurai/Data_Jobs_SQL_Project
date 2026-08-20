/*
Question: What are the most in-demand skills for data and business analysts in Canada and remotely?
- Join job postings to an inner join table similar to query 2
- Identify the top 5 in-demand skills for a data and business analyst.
- Why? Retrieves the top 5 skills with the highest demand in the job market, 
    providing insights into the most valuable skills for job seekers.
*/

SELECT
    skills,
    COUNT(job_postings_fact.job_id) AS demand_count
FROM
    job_postings_fact
INNER JOIN skills_job_dim ON job_postings_fact.job_id = skills_job_dim.job_id
INNER JOIN skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id
WHERE
    (job_title_short = 'Data Analyst' OR job_title_short = 'Business Analyst') AND
    (job_location LIKE '%Canada%' OR job_location = 'Anywhere')
GROUP BY
    skills
ORDER BY
    demand_count DESC
LIMIT 5;

/*
The results show that SQL is by far the most in-demand skill, appearing in 9,881 Data and Business Analyst job postings in Canada or remotely.
Excel ranks second with 6,571 postings, followed by Python (5,653) and Tableau (5,081).
Power BI, with 3,767 postings, is also highly valued, highlighting the importance of combining database, spreadsheet, 
programming, and data visualization skills for today’s analyst roles.

[
  {
    "skills": "sql",
    "demand_count": "7291"
  },
  {
    "skills": "excel",
    "demand_count": "4611"
  },
  {
    "skills": "python",
    "demand_count": "4330"
  },
  {
    "skills": "tableau",
    "demand_count": "3745"
  },
  {
    "skills": "power bi",
    "demand_count": "2609"
  }
]
*/
