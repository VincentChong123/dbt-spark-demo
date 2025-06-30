docker network create my_shared_network
pwd
cd dbt;             docker compose up -d 
cd ../dbt-spark;    docker compose up -d 

docker exec dbt-dbt-1 bash -c "cd /usr/app/demo/dbt_spark_demo_prj && . ./setup.sh"

rm -r dbt/dbt_spark_demo_prj/*
rm demo/results/*.txt

# to show progress of notebook "run all" cell execution status in terminal, 
# without opening notebook session in web browswer
docker exec -it dbt-dbt-1 bash -c "hv pip install papermill" 
docker exec -it dbt-dbt-1 bash -c "papermill /usr/app/demo/dbt-spark-demo.ipynb /usr/app/demo/dbt-spark-demo.ipynb"

# jupyter nbconvert --to notebook --execute --inplace a.ipynb
# docker exec -it dbt-dbt-1 bash -c "cd /usr/app/ && jupyter notebook --NotebookApp.token='' --NotebookApp.password='' --NotebookApp.disable_check_xsrf=True --allow-root --ip=0.0.0.0 --port=8888 --no-browser"
