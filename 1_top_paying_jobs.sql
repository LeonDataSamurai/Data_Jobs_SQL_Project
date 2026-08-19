/*
Question: What are the top-paying data or business analyst jobs?
- Identify the top 10 highest-paying Data Analyst roles that are available remotely or in Canada
- Focus on job postings with specified salaries (remove nulls)
- BONUS: Include company names of top 10 roles
- Why? Highlight the top-paying opportunities for Data and Business Analysts, offering insights into employment options and location flexibility.
*/

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
LIMIT 10;


/*
Here's the breakdown of the top data and business analyst jobs:
Wide Salary Range: Top 10 paying data and business analyst roles span from $200,000 to $650,000, indicating significant salary potential in the field.
Diverse Employers: Companies like Mantys, Meta, and AT&T are among those offering high salaries, showing a broad interest across different industries.

RESULTS
=======
[
  {
    "job_id": 226942,
    "job_title": "Data Analyst",
    "job_location": "Anywhere",
    "job_schedule_type": "Full-time",
    "salary_year_avg": "650000.0",
    "job_posted_date": "2023-02-20 15:13:33",
    "company_name": "Mantys"
  },
  {
    "job_id": 547382,
    "job_title": "Director of Analytics",
    "job_location": "Anywhere",
    "job_schedule_type": "Full-time",
    "salary_year_avg": "336500.0",
    "job_posted_date": "2023-08-23 12:04:42",
    "company_name": "Meta"
  },
  {
    "job_id": 552322,
    "job_title": "Associate Director- Data Insights",
    "job_location": "Anywhere",
    "job_schedule_type": "Full-time",
    "salary_year_avg": "255829.5",
    "job_posted_date": "2023-06-18 16:03:12",
    "company_name": "AT&T"
  },
  {
    "job_id": 99305,
    "job_title": "Data Analyst, Marketing",
    "job_location": "Anywhere",
    "job_schedule_type": "Full-time",
    "salary_year_avg": "232423.0",
    "job_posted_date": "2023-12-05 20:00:40",
    "company_name": "Pinterest Job Advertisements"
  },
  {
    "job_id": 502610,
    "job_title": "Lead Business Intelligence Engineer",
    "job_location": "Anywhere",
    "job_schedule_type": "Full-time",
    "salary_year_avg": "220000.0",
    "job_posted_date": "2023-08-29 18:26:36",
    "company_name": "Noom"
  },
  {
    "job_id": 1021647,
    "job_title": "Data Analyst (Hybrid/Remote)",
    "job_location": "Anywhere",
    "job_schedule_type": "Full-time",
    "salary_year_avg": "217000.0",
    "job_posted_date": "2023-01-17 00:17:23",
    "company_name": "Uclahealthcareers"
  },
  {
    "job_id": 112859,
    "job_title": "Manager II, Applied Science - Marketplace Dynamics",
    "job_location": "Anywhere",
    "job_schedule_type": "Full-time",
    "salary_year_avg": "214500.0",
    "job_posted_date": "2023-12-18 08:02:37",
    "company_name": "Uber"
  },
  {
    "job_id": 168310,
    "job_title": "Principal Data Analyst (Remote)",
    "job_location": "Anywhere",
    "job_schedule_type": "Full-time",
    "salary_year_avg": "205000.0",
    "job_posted_date": "2023-08-09 11:00:01",
    "company_name": "SmartAsset"
  },
  {
    "job_id": 998056,
    "job_title": "Analyst",
    "job_location": "Anywhere",
    "job_schedule_type": "Full-time",
    "salary_year_avg": "200000.0",
    "job_posted_date": "2023-10-04 11:01:48",
    "company_name": "Multicoin Capital"
  },
  {
    "job_id": 1069582,
    "job_title": "Analyst",
    "job_location": "Anywhere",
    "job_schedule_type": "Full-time",
    "salary_year_avg": "200000.0",
    "job_posted_date": "2023-12-21 13:01:17",
    "company_name": "Multicoin Capital"
  }
]
*/