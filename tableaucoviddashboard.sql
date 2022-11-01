-- The purpose of this file is to push the following queries to the data visualization platform Tableau 
-- The link to the final product in Tableu --> https://public.tableau.com/views/CovidDashboard_16673297017400/Dashboard1?:language=en-US&:display_count=n&:origin=viz_share_link



-- 1. Global Death Percentage 

-- To copy entire query result (to include data and column titles, click on the white square in the top left of the table, then click ctrl+shift+c

Select SUM(new_cases) as total_cases, SUM(cast(new_deaths as int)) as total_deaths, SUM(cast(new_deaths as int))/SUM(New_Cases)*100 as DeathPercentage
From PortfolioProject..CovidDeaths
--Where location like '%states%'
where continent is not null 
--Group By date
order by 1,2

--2. Total Death Count Per Continent 

-- We take these out as they are not inluded in the above queries and want to stay consistent
-- European Union is part of Europe

Select location, SUM(cast(new_deaths as int)) as TotalDeathCount
From PortfolioProject..CovidDeaths
--Where location like '%states%'
Where continent is null 
and location not in ('World', 'European Union', 'International', 'High income', 'Upper middle income', 'Lower middle income', 'Low income')
Group by location
order by TotalDeathCount desc

--3. Percent Population Infected Per Country 

Select Location, Population, MAX(total_cases) as HighestInfectionCount,  Max((total_cases/population))*100 as PercentPopulationInfected
From PortfolioProject..CovidDeaths
--Where location like '%states%'
Group by Location, Population
order by PercentPopulationInfected desc

--When transferring data to Excel, there can be no NULL values or else the data in tableau will be visualized incorrectly. In Excel, press ctrl + h, and for every Null value make it a zero, replace all

-- 4. Percent Population Infected

Select Location, Population,date, MAX(total_cases) as HighestInfectionCount,  Max((total_cases/population))*100 as PercentPopulationInfected
From PortfolioProject..CovidDeaths
--Where location like '%states%'
Group by Location, Population, date
order by PercentPopulationInfected desc

-- Again, you will need to convert all NULL values to 0s in Excel. 
-- Also need to convert the date to a short date. In Excel, highlight date column, in home tab, in Number box, click the General drop down, click short date

-- https://public.tableau.com/views/CovidDashboard_16673297017400/Dashboard1?:language=en-US&:display_count=n&:origin=viz_share_link