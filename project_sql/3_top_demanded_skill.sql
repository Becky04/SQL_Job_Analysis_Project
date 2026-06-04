/*
Question: What are the most in-demand skills for data analysts?
- Join job postings to inner join table similar to query 2
- Identify the top 5 in-demand skills for a data analyst.
- Focus on all job postings.
- Why? Retrieves the top 5 skills with the highest demand in the job market, 
    providing insights into the most valuable skills for job seekers.
*/


WITH top_paying_jobs AS (
	SELECT	
		job_id,
		job_title,
		job_location,
		job_schedule_type,
		salary_year_avg,
		job_posted_date,
		name AS company_name
	FROM job_postings_fact
	LEFT JOIN company_dim ON job_postings_fact.company_id = company_dim.company_id
	WHERE job_title_short = 'Data Analyst' AND job_location = 'Anywhere' AND salary_year_avg IS NOT NULL
	ORDER BY salary_year_avg DESC
	
)


SELECT 
	skills,
	COUNT(top_paying_jobs.job_id) AS in_demand
FROM top_paying_jobs
INNER JOIN skills_job_dim ON top_paying_jobs.job_id = skills_job_dim.job_id
INNER JOIN skills_dim ON skills_dim.skill_id = skills_job_dim.skill_id
GROUP BY skills
ORDER BY in_demand DESC;


SELECT 
	skills,
	COUNT(job_postings_fact.job_id) AS in_demand
FROM job_postings_fact
INNER JOIN skills_job_dim ON job_postings_fact.job_id = skills_job_dim.job_id
INNER JOIN skills_dim ON skills_dim.skill_id = skills_job_dim.skill_id
WHERE job_title_short = 'Data Analyst' AND job_location = 'Anywhere' 
GROUP BY skills
ORDER BY in_demand DESC
LIMIT 10;