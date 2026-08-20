/*
Answer: What are the top skills based on salary?
- Look at the average salary associated with each skill for Data and Business Analyst positions in Canada or remotely
- Focuses on roles with specified salaries
- Why? It reveals how different skills impact salary levels for Data and Business Analysts and 
    helps identify the most financially rewarding skills to acquire or improve
*/

SELECT
    skills,
    ROUND(AVG(salary_year_avg), 0) AS average_salary
FROM
    job_postings_fact
INNER JOIN skills_job_dim ON job_postings_fact.job_id = skills_job_dim.job_id
INNER JOIN skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id
WHERE
    (job_title_short = 'Data Analyst' OR job_title_short = 'Business Analyst') AND
    (job_location LIKE '%Canada%' OR job_location = 'Anywhere') AND
    salary_year_avg IS NOT NULL
GROUP BY
    skills
ORDER BY
    average_salary DESC
LIMIT 25;


/*
-PySpark leads by a significant margin, with an average salary of $208,172,
suggesting that big-data processing skills are associated with some of the highest-paying analyst roles.

-The list is heavily concentrated around data engineering, machine learning, and modern data platforms. 
Skills such as DataRobot, Pandas, NumPy, Databricks, Airflow, and scikit-learn appear among the highest-paying skills.

-DevOps and cloud technologies also stand out: Bitbucket, GitLab, Chef, Jenkins, Kubernetes, and GCP are all represented, 
showing that technical infrastructure skills can complement traditional analytics skills.

-An interesting takeaway is that specialized technical skills appear to command higher salaries than basic analyst tools in this dataset. 
The highest-paying skills are not primarily Excel or visualization tools; 
Instead, they lean toward big data, machine learning, programming, cloud computing, and DevOps.

[
  {
    "skills": "pyspark",
    "average_salary": "208172"
  },
  {
    "skills": "bitbucket",
    "average_salary": "189155"
  },
  {
    "skills": "watson",
    "average_salary": "160515"
  },
  {
    "skills": "couchbase",
    "average_salary": "160515"
  },
  {
    "skills": "datarobot",
    "average_salary": "155486"
  },
  {
    "skills": "gitlab",
    "average_salary": "154500"
  },
  {
    "skills": "swift",
    "average_salary": "153750"
  },
  {
    "skills": "jupyter",
    "average_salary": "152777"
  },
  {
    "skills": "chef",
    "average_salary": "152500"
  },
  {
    "skills": "pandas",
    "average_salary": "151821"
  },
  {
    "skills": "golang",
    "average_salary": "145000"
  },
  {
    "skills": "numpy",
    "average_salary": "143513"
  },
  {
    "skills": "databricks",
    "average_salary": "135840"
  },
  {
    "skills": "atlassian",
    "average_salary": "131162"
  },
  {
    "skills": "elasticsearch",
    "average_salary": "127500"
  },
  {
    "skills": "twilio",
    "average_salary": "127000"
  },
  {
    "skills": "airflow",
    "average_salary": "126103"
  },
  {
    "skills": "scikit-learn",
    "average_salary": "125781"
  },
  {
    "skills": "jenkins",
    "average_salary": "125436"
  },
  {
    "skills": "scala",
    "average_salary": "124903"
  },
  {
    "skills": "crystal",
    "average_salary": "120100"
  },
  {
    "skills": "linux",
    "average_salary": "119338"
  },
  {
    "skills": "kubernetes",
    "average_salary": "116667"
  },
  {
    "skills": "gcp",
    "average_salary": "115000"
  },
  {
    "skills": "db2",
    "average_salary": "114158"
  }
]
*/
