# Web Scraping - COVID-19 Data
Web scraping is the (generally automatic) process of collecting semi-structured data from the web, filtering and storing it, and then using it in another process.

## Table of Contents
* [Motivation](#Motivation)
* [Process](#Process)
* [Data](#Data)
* [Dependencies](#Dependencies)
* [Run Bot](#Run-Bot)
* [DataViz](#DataViz)
* [Documentation](#Documentation)
* [Contributing and Feedback](#Contributing-and-Feedback)
* [Author](#Author)
* [License](#License)

## Motivation
Create a web scraper bot to obtain data on confirmed cases and deaths of COVID-19, in order to analyze them.

## Process
1. Run the Web Scraper with Selenium to obtain the historical data. It only runs 1 time.
2. Run the Web Scraper with BeautifulSoup to obtain daily data (every day every x hours).
3. Export the historical daily data in a CSV file, to feed the dashboard in Power BI.
4. Use the COVID-19 dashboard (built in Power BI) to analyze data and find insights.

## Data
The data obtained through web scraping are:

| Variable | Description |
| --- | --- |
| country | Country name |
| total_cases | Total number of cases |
| total_deaths | Total number of deaths |
| total_recovered | Total number of people recovered |
| active_cases | Number of active cases |
| serious_critical | Number of critical cases |
| total_tests | Total number of tests |
| tot_cases_1m_pop | Number of cases per one million population |
| deaths_1m_pop | Number of deaths per one million population |
| tests_1m_pop | Number of tests per one million population |
| datestamp | Data timestamp with UTC-5 time zone |

Furthermore, to carry out the complete data analysis and its respective visualization, other variables had to be derived, such as:

| Variable | Description | Definition |
| --- | --- | --- |
| perc_deaths | Percentage of deaths | total_deaths * 100 / total_cases |
| perc_infection | Percentage of infections or contagions | total_cases * 100 / total_tests |
| new_total_cases | New daily cases | total_cases_today - total_cases_yest |
| new_total_deaths | New daily deaths | total_deaths_today - total_deaths_yest |
| new_active_cases | New daily active cases | active_cases_today - active_cases_yest |

You can find the scripts with which the tables were created in SQL Server <a href="https://github.com/ansegura7/WebScraping_Covid19/blob/master/sql/DDL" target="_blank" >here</a>.

World COVID-19 data was collected over 253 days. The latest data reported by country can be seen at the following <a href="https://github.com/ansegura7/WebScraping_Covid19/blob/master/data/current_data.csv" target="_blank" >link</a>

Below, some final statistics of the data updated until September 30 UTC+0:

| Variable           | Value       |
| ---                | --:         |
| Final Date         | 9/30/2020   |
| Countries infected | 213         |
| Total Cases        | 34,134,840  |
| Total Deaths       | 1,018,033   |
| Active Cases       | 6,587,728   |
| Total Tests        | 648,926,831 |

## Analysis
1. <a href="https://ansegura7.github.io/WebScraping_Covid19/analysis/pca_data_analysis_c19.html" >PCA Data Analysis</a>
2. <a href="https://ansegura7.github.io/WebScraping_Covid19/analysis/curve_similarity_c19_cases.html" >Curve Similarity Analysis - Cases</a>
3. <a href="https://ansegura7.github.io/WebScraping_Covid19/analysis/curve_similarity_c19_deaths.html" >Curve Similarity Analysis - Deaths</a>
4. <a href="https://ansegura7.github.io/WebScraping_Covid19/analysis/sim_curve_slope_c19.html" >Similarity of the Curve Slopes</a>

## Dependencies
The project was carried out with the latest version of <a href="https://www.anaconda.com/distribution/" target="_blank" >Anaconda</a> on Windows.

If the main Web Scraping libraries do not come with the selected Anaconda distribution, you can install them with the following commands:

``` console
conda install -c anaconda pyodbc
conda install -c anaconda beautifulsoup4
conda install -c conda-forge selenium
```

The specific Python 3.7.x libraries used are:

``` python
# Import custom libraries
import util_lib as ul

# Import util libraries
import logging
import pytz
from pytz import timezone
from datetime import datetime

# Email libraries
import smtplib
import ssl
from email.mime.multipart import MIMEMultipart
from email.mime.text import MIMEText

# Database libraries
import pyodbc

# Import Web Scraping libraries
from urllib.request import urlopen
from urllib.request import Request
from urllib.error import HTTPError
from urllib.error import URLError
from bs4 import BeautifulSoup

# Import Web Scraping 2 libraries
from selenium import webdriver
from selenium.webdriver.chrome.options import Options
```

**Note:**  In order to use the *web scraper* that fetches historical data, you may need to download the <a href="https://chromedriver.chromium.org/downloads" target="_blank" >Chrome driver</a> that uses the Selenium library and put it in the *driver* folder.

## Run Bot
There are several ways to run this web scraper bot on Windows:

1. Type the following commands (below) at the **Anaconda Prompt**.

``` console
  cd "WebScraping_Covid19\code\"
  python web_scraper.py
```

2. Type the following commands (below) at the **Windows Command Prompt**. Previously, Anaconda Python paths must be added to: Environment Variables -> User Variables.

``` console
  cd "WebScraping_Covid19\code\"
  conda activate base
  python web_scraper.py
```

3. Directly run the batch file **run-win.bat** (found in the run/ folder).

### Automate Execution
In order to automate the process, a Task can be created in the **Windows Task Scheduler**, to configure the execution of the web scraper bot every x hours.

![task-sch-0-img](https://github.com/ansegura7/WebScraping_Covid19/blob/master/img/task-sch-0.PNG?raw=true)

1. Create a new **Task** in Windows Task Scheduler.

![task-sch-1-img](https://github.com/ansegura7/WebScraping_Covid19/blob/master/img/task-sch-1.PNG?raw=true)

2. Set up a **Trigger** that runs the task every day every x hours.

![task-sch-2-img](https://github.com/ansegura7/WebScraping_Covid19/blob/master/img/task-sch-2.PNG?raw=true)

3. In the **Action** tab, select the .bat file and the folder from where the Task will be executed.

![task-sch-3-img](https://github.com/ansegura7/WebScraping_Covid19/blob/master/img/task-sch-3.PNG?raw=true)

## DataViz
Next, the COVID-19 dashboard that was created to visually analyze the collected data.

![dataviz-img](https://github.com/ansegura7/WebScraping_Covid19/blob/master/img/data-viz.gif?raw=true)

## Documentation
Below, some useful and relevant links to this project:

- <a href="https://www.codeproject.com/Articles/647950/Create-and-Populate-Date-Dimension-for-Data-Wareho" target="_blank" >Create and Populate Date Dimension</a>
- <a href="https://realpython.com/tutorials/web-scraping/" target="_blank" >Python Web Scraping Tutorials</a>
- <a href="https://papelesdeinteligencia.com/herramientas-de-web-scraping/" target="_blank" >10 Web Scraping Tools (Spanish)</a>
- <a href="https://www.quora.com/Why-can-t-I-run-Python-in-CMD-but-can-in-Anaconda-Prompt/" target="_blank" >Run Anaconda Python in CMD</a>
- <a href="https://www.thewindowsclub.com/how-to-schedule-batch-file-run-automatically-windows-7/" target="_blank" >Schedule a Batch file to run Automatically</a>
- <a href="https://restcountries.eu/" target="_blank" >Get information about countries via a RESTful API</a>
- <a href="https://realpython.com/python-send-email/" target="_blank" >Sending Emails With Python</a>

## Contributing and Feedback
Any kind of feedback/criticism would be greatly appreciated (algorithm design, documentation, improvement ideas, spelling mistakes, etc...).

## Author
- Created by Andrés Segura Tinoco
- Created on Apr 10, 2020

## License
This project is licensed under the terms of the MIT license.
