-- Data Exploration
-- Used dataset: https://ourworldindata.org/covid-deaths

-- SELECT * FROM coviddeaths ORDER BY 3, 4;
-- SELECT * FROM covidvaccinations ORDER BY 3, 4;


-- Selecting data for analysis
SELECT
    location,
    -- datum stands for date
    datum,
    population,
    total_cases,
    new_cases,
    total_deaths
FROM
    coviddeaths
WHERE
    continent IS NOT NULL
ORDER BY
    1,
    2;


-- Total Cases vs Total Deaths for Bosnia and Herzegovina
SELECT
    location,
    datum,
    total_cases,
    total_deaths,
    ( total_deaths / total_cases ) * 100 AS death_percentage
FROM
    coviddeaths
WHERE
    location LIKE '%Bosnia%'
ORDER BY
    1,
    2;


-- Total Cases vs Population for Bosnia and Herzegovina
SELECT
    location,
    datum,
    population,
    total_cases,
    ( total_cases / population ) * 100 AS infection_percentage
FROM
    coviddeaths
WHERE
    location LIKE '%Bosnia%'
ORDER BY
    1,
    2;


-- Countries with Highest Infection Percentage compared to Population
SELECT
    location,
    population,
    MAX(total_cases)                      AS highest_infection_count,
    MAX((total_cases / population)) * 100 AS infection_percentage
FROM
    coviddeaths
WHERE
    continent IS NOT NULL
GROUP BY
    location,
    population
ORDER BY
    infection_percentage DESC;


-- Countries with Highest Death Count
SELECT
    location,
    MAX(total_deaths) AS highest_death_count
FROM
    coviddeaths
WHERE
    continent IS NOT NULL
GROUP BY
    location
ORDER BY
    highest_death_count DESC;


-- Worldwide numbers
SELECT
    location,
    MAX(total_deaths) AS total_death_count
FROM
    coviddeaths
WHERE
    continent IS NULL
GROUP BY
    location
ORDER BY
    total_death_count DESC;


-- Global numbers
SELECT
    SUM(new_cases)                         AS total_cases,
    SUM(new_deaths)                        AS total_deaths,
    SUM(new_deaths) / SUM(new_cases) * 100 AS death_percentage
FROM
    coviddeaths
WHERE
    continent IS NOT NULL;



-- Population vs Vaccinations
SELECT
    dea.continent,
    dea.location,
    dea.datum,
    dea.population,
    vac.new_vaccinations,
    /*
    Partition data by location so that it runs only through one country and then
    when it gets to the next country it doesn't keep going with a summation. And 
    we do ordering by location and date because the date is what's going to separate
    data out so that we add the count of newly vaccinated to the total count.
    */
    SUM(vac.new_vaccinations)
    OVER(PARTITION BY dea.location
         ORDER BY
             dea.location, dea.datum
    ) AS vaccinated_people
FROM
         coviddeaths dea
    JOIN covidvaccinations vac ON dea.location = vac.location
                                  AND dea.datum = vac.datum
WHERE
    dea.continent IS NOT NULL
ORDER BY
    2,
    3;


/*
We want to get a percent of vaccinated people for each country, and because of that,
we need to use the column 'vaccinated_people' from the previous query. So to do it
we need to create a temp table or Common Table Expression - CTE:
*/

-- 1. Using Temp Table
-- Creating Temp Table
CREATE TABLE percent_population_vaccinated (
    continent         VARCHAR2(100 BYTE),
    location          VARCHAR2(100 BYTE),
    datum             DATE,
    population        NUMBER(38, 0),
    new_vaccinations  NUMBER(38, 0),
    vaccinated_people NUMBER(38, 0)
);

-- Inserting data to the temp table
INSERT INTO percent_population_vaccinated
    ( SELECT
        dea.continent,
        dea.location,
        dea.datum,
        dea.population,
        vac.new_vaccinations,
        SUM(vac.new_vaccinations)
        OVER(PARTITION BY dea.location
             ORDER BY
                 dea.location, dea.datum
        ) AS vaccinated_people
    FROM
             coviddeaths dea
        JOIN covidvaccinations vac ON dea.location = vac.location
                                      AND dea.datum = vac.datum
    );

SELECT
    continent,
    location,
    datum,
    population,
    new_vaccinations,
    vaccinated_people,
    ( vaccinated_people / population ) * 100 AS vaccinated_percent
FROM
    percent_population_vaccinated
WHERE
    continent IS NOT NULL
ORDER BY
    2,
    3;


-- 2. Using CTE
WITH percent_pop_vaccinated AS (
    SELECT
        dea.continent,
        dea.location,
        dea.datum,
        dea.population,
        vac.new_vaccinations,
        SUM(vac.new_vaccinations)
        OVER(PARTITION BY dea.location
             ORDER BY
                 dea.location, dea.datum
        ) AS vaccinated_people
    FROM
             coviddeaths dea
        JOIN covidvaccinations vac ON dea.location = vac.location
                                      AND dea.datum = vac.datum
    WHERE
        dea.continent IS NOT NULL
)
SELECT
    *
FROM
    percent_pop_vaccinated;



-- Creating View to store data for later visualizations in Tableau for the next mini-project
CREATE VIEW view_percent_population_vaccinated AS
    SELECT
        dea.continent,
        dea.location,
        dea.datum,
        dea.population,
        vac.new_vaccinations,
        SUM(vac.new_vaccinations)
        OVER(PARTITION BY dea.location
             ORDER BY
                 dea.location, dea.datum
        ) AS vaccinated_people
    FROM
             coviddeaths dea
        JOIN covidvaccinations vac ON dea.location = vac.location
                                      AND dea.datum = vac.datum
    WHERE
        dea.continent IS NOT NULL;

SELECT
    *
FROM
    view_percent_population_vaccinated;