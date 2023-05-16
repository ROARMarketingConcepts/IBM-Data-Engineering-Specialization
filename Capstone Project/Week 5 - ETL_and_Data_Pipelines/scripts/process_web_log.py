#Import the libraries
from datetime import timedelta
from airflow import DAG 
from airflow.operators.bash_operator import BashOperator
from airflow.utils.dates import days_ago

# Task 1 - Define DAG arguments
default_args = {
    'owner':'Ken Wood',
    'start_date':days_ago(0),
    'email':['ken@roarmarketingconcepts.com'],
    'email_on_failure':True,
    'email_on_retry':True,
    'retries':1,
    'retry_delay':timedelta(minutes = 5)
}

# Task 2 - Define the DAG
dag = DAG(
    'process_web_log',
    default_args=default_args,
    description='Process web log data',
    schedule_interval=timedelta(days=1),
)

# Task 3 - Create a task to extract data
extract_data = BashOperator(
    task_id = 'extract_data',
    bash_command = 'cut -d"," -f1 /home/project/airflow/dags/capstone/accesslog.txt > /home/project/airflow/dags/capstone/extracted_data.txt',
    dag = dag,
)

# Task 4 - Create a task to transform the data
transform_data= BashOperator(
    task_id = 'transform_data',
    bash_command = 'grep 198.46.149.143 /home/project/airflow/dags/capstone/extracted_data.txt > /home/project/airflow/dags/capstone/transformed_data.txt',
    dag = dag,
)

# Task 5 - Create a task to load the data into a .tar file
load_data = BashOperator(
    task_id = 'load_data',
    bash_command = 'tar -cvf /home/project/airflow/dags/capstone/weblog.tar /home/project/airflow/dags/capstone/transformed_data.txt',
    dag = dag,
)

# Task 6 - Define the task pipeline
extract_data >> transform_data >> load_data