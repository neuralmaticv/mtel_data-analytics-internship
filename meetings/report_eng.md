# Data Analytics Internship at mtel company

> Online version of this page (**in Bosnian only**) is at [this link](https://neuralmaticv.github.io/data-analytics-internship/).   
> [Link to GitHub repository](https://github.com/neuralmaticv/data-analytics-internship). 

 > **Theme:** Data analysis and Introduction to Data Warehousing and Business Intelligence  
 **Mentor:** B.Sc.E.E. Siniša Roljić, main engineer for Business Analytics

During the internship, it is planned to do four mini-projects:  
* Project 1 - exploratory data analysis and introduction to SQL  
* Project 2 - data visualization in Tableau  
* Project 3 - exploratory analysis and data cleaning with SQL  
* Project 4 - comparison of correlation between data using Python and libraries: NumPy, Pandas and Matplotlib
---

## Meeting notes | Week 1
#### Day 1
> Date: Aug. 16, 2021
- mentor introduced us to work methods and the role of the Management Information Systems department within the company
- we discussed the structure of the internship and our future tasks
- we went through the skills and experiences
---
#### Day 2
> Date: Aug. 17, 2021
- introduction to data science and data analysis
- presentation of a theory
- Domain Expertise
- DWH - Data Warehousing
- BI - Business Intelligence
- ETL - Extract Transform Load
- OLTP - Online transaction processing 
- OLAP - Online analytical processing
- we discussed tech stack that we gonna use 
---
#### Day 3
> Date: Aug. 18, 2021
- we started learning by following [Database Management Essentials course](https://www.coursera.org/learn/database-management)
- DBMS - Database Management System
- Enterprise DBMSs
- Desktop DBMSs
- Embedded DBMSs
- Non-procedural and procedural access
- Transaction processing overview
- DWH processing
---
#### Day 4
> Date: Aug. 19, 2021
- installed and setted up Oracle Database and Oracle SQL Developer
- fixed several bugs occurred during the installation process
- practicing SQL queries
- searching for data sets
---
#### Day 5
> Date: Aug. 20, 2021
- went through the [dataset](https://ourworldindata.org/covid-deaths)
- split about who will analyze which part of a dataset
- went through the dataset, exploratory analysis
- created some SQL views and tables for visualizations in Tableau
- plan the next steps
---
<br>

## Meeting notes | Week 2
#### Day 1
> Date: Aug. 23, 2021
- data visualization was done in Tableau
- we went through the [dataset](https://www.kaggle.com/tmthyjames/nashville-housing-data) for the third project
- we did exploratory analysis and data formatting
- we left data cleaning for the next day
---
#### Day 2
> Date: Aug. 24, 2021
- cleaned the data and finished the third project
- several bugs occurred during this project:
- *ORA-00928: missing SELECT keyword using WITH clause*, because we was trying to use DELETE keyword after WITH clause which is not allowed in Oracle SQL Developer
- *ORA-01427: single-row subquery returns more than one row*, while trying to join the same table to itself
- started to work on the fourth project and finished it
- [dataset](https://www.kaggle.com/danielgrijalvas/movies) used for fourth project
- we used a Python to find correlations between informations from dataset
---
#### Day 3
> Date: Aug. 25, 2021
- started to work on the fifth project and finished it - the project is about web scraping from Amazon
- we are pulling data from Amazons site for specific products and checking their prices, if the price is lower than the acceptable price then we gonna send a notification email to user using Simple Mail Transfer Protocol
- we discussed our future projects
- plan the next steps and think about what to include in the report
- **TODO**: 
	 - [x] do some formatting in the code;
	 - [x] add some markdown in notebooks;
	 - [ ] change some things in Tableau visualizationl;
	 - [ ] write the final report and prepare for it;
---
#### Day 4
> Date: Aug. 26, 2021
- from the previous day we transfer the following tasks:
	- [x] change some things in Tableau visualizationl;
	- [x] write the final report and prepare for it;

---
#### Day 5
> Date: Aug. 27, 2021
- submitting progress and final reports
- 
---
<br/>

## GitHub links:
- **Source code:**  
	[Project 1 - exploratory data analysis](https://github.com/neuralmaticv/data-analytics-internship/tree/main/project01)  
	[Project 2 - data visualization](https://github.com/neuralmaticv/data-analytics-internship/tree/main/project02)  
	[Project 3 - exploratory analysis and data cleaning](https://github.com/neuralmaticv/data-analytics-internship/tree/main/project03)  
	[Project 4 - correlation between data](https://github.com/neuralmaticv/data-analytics-internship/tree/main/project04)  
	[Project 5 - web scraping](https://github.com/neuralmaticv/data-analytics-internship/tree/main/project05)  

- **Extra:**  
	[Datasets](https://github.com/neuralmaticv/data-analytics-internship/tree/main/datasets)  
	[Notes](https://github.com/neuralmaticv/data-analytics-internship/tree/main/meetings)  
	[Presentations](https://github.com/neuralmaticv/data-analytics-internship/tree/main/presentation)  

---
<br/>

## Technology stack:

<p>
<a href="https://www.oracle.com/index.html"><img src="https://img.shields.io/badge/Made%20with-Oracle-ff0000?style=for-the-badge&amp;logo=Oracle"></a>&nbsp;&nbsp;
<a href="https://www.tableau.com/"><img src="https://img.shields.io/badge/Made%20with-Tableau-1c4481?style=for-the-badge&amp;logo=Tableau"></a>&nbsp;&nbsp; 
<a href="https://jupyter.org/"><img src="https://img.shields.io/badge/Made%20with-Jupyter-orange?style=for-the-badge&amp;logo=Jupyter"></a> <br><br>
<a href="https://www.python.org/"><img src="https://img.shields.io/badge/Made%20with-Python-1f425f?style=for-the-badge&amp;logo=Python"></a>&nbsp;&nbsp;
<a href="https://numpy.org/"><img src="https://img.shields.io/badge/Made%20with-NumPy-4dabcf?style=for-the-badge&amp;logo=numpy"></a>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
<a href="https://pandas.pydata.org/"><img src="https://img.shields.io/badge/Made%20with-Pandas-130654?style=for-the-badge&amp;logo=pandas"></a>
</p>
