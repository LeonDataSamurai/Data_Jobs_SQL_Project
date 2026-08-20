# Introduction
📊 Dive into the data job market! Focusing on data and business analyst roles available in Canada and remotely, this project explores 💰 top-paying jobs, 🔥 in-demand skills, and 📈 where high demand meets high salary in data analytics.

🔍 SQL queries? Check them out here: [project_sql folder](/project_sql/)
# Background
Driven by a quest to navigate the data analyst job market more effectively, this project was born from a desire to pinpoint top-paid and in-demand skills, streamlining others work to find optimal jobs.

Data hails from [SQL Course](https://www.lukebarousse.com/sql) By Luke Barousse. It's packed with insights on job titles, salaries, locations, and essential skills.

### The questions I wanted to answer through my SQL queries were:
1. What are the top-paying data analyst jobs?
2. What skills are required for these top-paying jobs?
3. What skills are most in demand for data analysts?
4. Which skills are associated with higher salaries?
5. What are the most optimal skills to learn?

# Tools I Used
For my deep dive into the data analyst job market, I harnessed the power of several key tools:

- **SQL:** The backbone of my analysis, allowing me to query the database and unearth critical insights.
- **PostgreSQL:** The chosen database management system, ideal for handling the job posting data.
- **Visual Studio Code:** My go-to for database management and executing SQL queries.
- **Git & GitHub:** Essential for version control and sharing my SQL scripts and analysis, ensuring collaboration and project tracking.

# The Analysis
Each query for this project aimed at investigating specific aspects of the data analyst job market. Here’s how I approached each question:


### 1. Top Paying Data and Business Analyst Jobs 
To identify the highest-paying roles, I filtered data analyst positions by average yearly salary and location, focusing on Canada and remote jobs. This query highlights the high-paying opportunities in the field.

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
    (job_title_short = 'Data Analyst' OR job_title_short = 'Business Analyst') AND 
    (job_location LIKE '%Canada%' OR job_location = 'Anywhere') AND 
    salary_year_avg IS NOT NULL
ORDER BY
    salary_year_avg DESC
LIMIT 10
```

</br>

### Insights

- The highest-paying roles exceed **$200K annually**, with the top Data Analyst position reaching an exceptional **$650K**.

- **Leadership and advanced analytics roles** such as Director of Analytics and Associate Director of Data Insights command some of the highest salaries.

- Companies like **Meta, AT&T, Pinterest, Uber, and SmartAsset** demonstrate strong compensation for professionals with advanced data and business intelligence expertise.
</br>
<img src="Assets/Highest Paying Jobs.jpg" alt="Highest Paying Jobs Bar Graph">
<i>Bar graph visualizing the salary for the top 10 salaries for data analysts; Canva AI generated this graph from my SQL query results</i>

</br>

### 2. Skills for Top Paying Jobs


To understand what skills are required for the top-paying jobs, I joined the job postings with the skills data, providing insights into what employers value for high-compensation roles.

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
        (job_title_short = 'Data Analyst' OR job_title_short = 'Business Analyst') AND 
        (job_location LIKE '%Canada%' OR job_location = 'Anywhere') AND 
        salary_year_avg IS NOT NULL
    ORDER BY
        salary_year_avg DESC
    LIMIT 10
)

SELECT
    top_paying_jobs.*,
    skills
FROM
    top_paying_jobs
INNER JOIN skills_job_dim ON top_paying_jobs.job_id = skills_job_dim.job_id
INNER JOIN skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id
ORDER BY
    top_paying_jobs.salary_year_avg DESC
```

Here's the breakdown of the most demanded skills for data and business analysts in Canada and remote, based on job postings </br>
(Includes only 6 out of 10 initial postings as the other 4 postings did not have any skills listed):

1. **Python, SQL and Tableau** are leading with a count of 5.

2. **Excel** follows closely with a count of 3.

3. Other skills like **R, Pandas, AWS and Snowflake** show varying degrees of demand.
</br>
<img src='Assets/Most In-Demand Skills.jpg' alt='Top In-Demand Skills'>
<i>Bar graph visualizing the count of skills for selected jobs for data and business analysts; Canva AI generated this graph from my SQL query results</i>



### 3. In-Demand Skills for Data and Business Analysts (In Canada and Remote Options)

This query helped identify the skills most frequently requested in job postings, directing focus to areas with high demand.

```sql
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
```

</br>

**The breakdown of most in-demand skills:**

- The results show that **SQL** is by far the most in-demand skill, appearing in **9,881** Data and Business Analyst job postings in Canada or remotely.

- **Excel** ranks second with **6,571** postings, followed by Python **5,653** and Tableau **5,081**.

- **Power BI**, with **3,767** postings, is also highly valued, highlighting the importance of combining database, spreadsheet, </br>
programming, and data visualization skills for today’s analyst roles.

</br>

<table>
  <thead>
    <tr>
      <th>Skill</th>
      <th>Demand Count</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <td>SQL</td>
      <td>9,881</td>
    </tr>
    <tr>
      <td>Excel</td>
      <td>6,571</td>
    </tr>
    <tr>
      <td>Python</td>
      <td>5,653</td>
    </tr>
    <tr>
      <td>Tableau</td>
      <td>5,081</td>
    </tr>
    <tr>
      <td>Power BI</td>
      <td>3,767</td>
    </tr>
  </tbody>
</table>

<i>Table of the demand for the top 5 skills in data analyst job postings</i>

</br>

### 4. Skills Based on Salary

Exploring the average salaries associated with different skills revealed which skills are the highest paying.

```sql
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
```

</br>

**Here's a breakdown of the results for top-paying skills for Data Analysts:**

- **PySpark** leads by a significant margin, with an average salary of **$208,172**,
suggesting that **big-data** processing skills are associated with some of the highest-paying analyst roles.

- The list is heavily concentrated around **data engineering, machine learning, and modern data platforms.**
Skills such as **DataRobot, Pandas, NumPy, Databricks, Airflow, and scikit-learn** appear among the highest-paying skills.

- **DevOps and cloud technologies** also stand out: **Bitbucket, GitLab, Chef, Jenkins, Kubernetes, and GCP** are all represented, 
showing that technical infrastructure skills can complement traditional analytics skills.

- An interesting takeaway is that specialized technical skills appear to command higher salaries than basic analyst tools in this dataset. 
The highest-paying skills are not primarily Excel or visualization tools; 
Instead, they **lean toward big data, machine learning, programming, cloud computing, and DevOps**.

<table>
  <thead>
    <tr>
      <th>Skill</th>
      <th>Average Salary</th>
    </tr>
  </thead>
  <tbody>
    <tr><td>PySpark</td><td>$208,172</td></tr>
    <tr><td>Bitbucket</td><td>$189,155</td></tr>
    <tr><td>Watson</td><td>$160,515</td></tr>
    <tr><td>Couchbase</td><td>$160,515</td></tr>
    <tr><td>DataRobot</td><td>$155,486</td></tr>
    <tr><td>GitLab</td><td>$154,500</td></tr>
    <tr><td>Swift</td><td>$153,750</td></tr>
    <tr><td>Jupyter</td><td>$152,777</td></tr>
    <tr><td>Chef</td><td>$152,500</td></tr>
    <tr><td>Pandas</td><td>$151,821</td></tr>
    <tr><td>Golang</td><td>$145,000</td></tr>
    <tr><td>NumPy</td><td>$143,513</td></tr>
    <tr><td>Databricks</td><td>$135,840</td></tr>
    <tr><td>Atlassian</td><td>$131,162</td></tr>
    <tr><td>Elasticsearch</td><td>$127,500</td></tr>
    <tr><td>Twilio</td><td>$127,000</td></tr>
    <tr><td>Airflow</td><td>$126,103</td></tr>
    <tr><td>Scikit-learn</td><td>$125,781</td></tr>
    <tr><td>Jenkins</td><td>$125,436</td></tr>
    <tr><td>Scala</td><td>$124,903</td></tr>
    <tr><td>Crystal</td><td>$120,100</td></tr>
    <tr><td>Linux</td><td>$119,338</td></tr>
    <tr><td>Kubernetes</td><td>$116,667</td></tr>
    <tr><td>GCP</td><td>$115,000</td></tr>
    <tr><td>DB2</td><td>$114,158</td></tr>
  </tbody>
</table>

<i>Table of the average salary for the top 10 paying skills for data and business analysts</i>

### 5. Most Optimal Skills to Learn

Combining insights from demand and salary data, this query aimed to pinpoint skills that are both in high demand and have high salaries, offering a strategic focus for skill development.

```sql
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
```

<table>
  <thead>
    <tr>
      <th>Skill ID</th>
      <th>Skill</th>
      <th>Demand Count</th>
      <th>Average Salary</th>
    </tr>
  </thead>
  <tbody>
    <tr><td>75</td><td>Databricks</td><td>12</td><td>$135,840</td></tr>
    <tr><td>80</td><td>Snowflake</td><td>39</td><td>$112,399</td></tr>
    <tr><td>97</td><td>Hadoop</td><td>28</td><td>$111,347</td></tr>
    <tr><td>8</td><td>Go</td><td>30</td><td>$111,121</td></tr>
    <tr><td>74</td><td>Azure</td><td>37</td><td>$109,978</td></tr>
    <tr><td>77</td><td>BigQuery</td><td>18</td><td>$109,806</td></tr>
    <tr><td>234</td><td>Confluence</td><td>14</td><td>$108,415</td></tr>
    <tr><td>76</td><td>AWS</td><td>33</td><td>$107,762</td></tr>
    <tr><td>194</td><td>SSIS</td><td>12</td><td>$106,683</td></tr>
    <tr><td>185</td><td>Looker</td><td>55</td><td>$106,154</td></tr>
    <tr><td>79</td><td>Oracle</td><td>43</td><td>$103,877</td></tr>
    <tr><td>233</td><td>Jira</td><td>23</td><td>$103,276</td></tr>
    <tr><td>2</td><td>NoSQL</td><td>15</td><td>$102,624</td></tr>
    <tr><td>184</td><td>DAX</td><td>11</td><td>$102,500</td></tr>
    <tr><td>1</td><td>Python</td><td>271</td><td>$102,011</td></tr>
    <tr><td>4</td><td>Java</td><td>22</td><td>$101,700</td></tr>
    <tr><td>5</td><td>R</td><td>157</td><td>$101,206</td></tr>
    <tr><td>187</td><td>Qlik</td><td>15</td><td>$101,037</td></tr>
    <tr><td>197</td><td>SSRS</td><td>15</td><td>$99,993</td></tr>
    <tr><td>182</td><td>Tableau</td><td>266</td><td>$99,562</td></tr>
    <tr><td>78</td><td>Redshift</td><td>17</td><td>$99,558</td></tr>
    <tr><td>7</td><td>SAS</td><td>74</td><td>$98,359</td></tr>
    <tr><td>186</td><td>SAS</td><td>74</td><td>$98,359</td></tr>
    <tr><td>204</td><td>Visio</td><td>13</td><td>$97,801</td></tr>
    <tr><td>13</td><td>C++</td><td>12</td><td>$97,795</td></tr>
  </tbody>
</table>

<i>Table of the most optimal skills for data and business analysts sorted by salary</i>

**Here's a breakdown of the most optimal skills for Data and Business Analysts in Canada or remotely:**

The data shows that **Python, Tableau, and R** are the most in-demand skills, with hundreds of job postings and average salaries around **$100K+**. 
Cloud and modern data-platform skills such as **Snowflake, Azure, AWS, and Databricks** have lower demand but generally higher salaries. 
**Databricks** stands out with the highest average salary at **$135.8K**, while **Python** offers the strongest balance between demand and compensation. 
**Conclusion:** Combining Python + SQL + BI tools + cloud/data platforms would be a strong strategy for Canadian and remote analyst positions.

# What I Learned

Throughout this project, I strengthened my SQL skills and gained more practical experience working with real-world data:

- 🧩 **Complex Query Crafting:** Improved my ability to build complex SQL queries, join multiple tables, and use CTEs (```WITH``` clauses) to organize and simplify analysis.
- 📊 **Data Aggregation:** Developed a stronger understanding of ```GROUP BY``` and aggregate functions such as ```COUNT()``` and ```AVG()``` to summarize and compare large datasets.
- 💡 **Analytical Problem-Solving:** Learned how to translate real-world questions into structured SQL queries and use the results to identify meaningful trends and insights.

# Conclusion


From the analysis, several general insights emerged:

1. **High-paying analyst roles can exceed $200K annually.**
The highest-paying Data and Business Analyst positions in Canada and remote roles offer exceptional compensation, with some positions reaching **$650K**. Leadership and advanced analytics roles tend to command the highest salaries.
2. **Python, SQL, and Tableau are core skills for top-paying positions.**
Among the highest-paying jobs analyzed, **Python, SQL, and Tableau** appeared most frequently. Excel was also common, showing that employers continue to value a combination of programming, database, spreadsheet, and visualization skills.
3. **SQL, Excel, Python, Tableau, and Power BI dominate overall demand.**
SQL leads with 9,881 postings, followed by Excel (6,571), Python (5,653), Tableau (5,081), and Power BI (3,767). This demonstrates that strong fundamentals in databases, spreadsheets, programming, and visualization are highly valuable across the analyst job market.
4. **Specialized technical skills are associated with higher salaries.**
The highest-paying skills are concentrated around **big data, machine learning, cloud computing, and DevOps.** PySpark leads the salary rankings at approximately **$208K**, while skills such as Databricks, Pandas, Airflow, Kubernetes, and GCP also appear among the higher-paying technologies.
5. **The best strategy combines high demand with specialized skills.**
**Python** provides one of the strongest combinations of demand and compensation, while **Databricks, Snowflake, Azure, AWS, and BigQuery** offer higher salary potential with lower demand. Overall, combining **Python + SQL + BI tools + cloud/data** platforms would provide a strong foundation for pursuing Canadian and remote Data Analyst and Business Analyst opportunities.

# Closing Thoughts

This project enhanced my SQL skills and provided valuable insights into the data analyst job market. The findings from the analysis serve as a guide to prioritizing skill development and job search efforts. Aspiring data analysts can better position themselves in a competitive job market by focusing on high-demand, high-salary skills. This exploration highlights the importance of continuous learning and adaptation to emerging trends in the field of data analytics.


