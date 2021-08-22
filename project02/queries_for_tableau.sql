-- Queries used for visualization

SELECT
    SUM(new_cases)                         AS total_cases,
    SUM(new_deaths)                        AS total_deaths,
    SUM(new_deaths) / SUM(new_cases) * 100 AS death_percentage
FROM
    coviddeaths
WHERE
    continent IS NOT NULL;



SELECT
    location,
    SUM(new_deaths) AS total_death_count
FROM
    coviddeaths
WHERE
    continent IS NULL
    AND location NOT IN ( 'World', 'European Union', 'International' )
GROUP BY
    location
ORDER BY
    total_death_count DESC;



SELECT
    location,
    population,
    MAX(total_cases)                      AS highest_infection_count,
    MAX((total_cases / population)) * 100 AS percent_population_infected
FROM
    coviddeaths
GROUP BY
    location,
    population
ORDER BY
    percent_population_infected DESC;



SELECT
    location,
    population,
    date,
    MAX(total_cases)                      AS highest_infection_count,
    MAX((total_cases / population)) * 100 AS percent_population_infected
FROM
    coviddeaths
GROUP BY
    location,
    population,
    date
ORDER BY
    percent_population_infected DESC;
