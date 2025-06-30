docker network create my_shared_network
pwd
COMPOSE_UP=true
cd dbt;             docker compose build --no-cache; docker compose up -d
cd ../dbt-spark;    docker compose build --no-cache; docker compose up -d

rm -r dbt/dbt_spark_demo_prj/*
rm demo/results/*.txt

docker ps 
docker exec dbt-dbt-1 bash -c "cd /usr/app/demo/dbt_spark_demo_prj && . ./setup.sh"

# to show progress of notebook "run all" cell execution status in terminal, 
# without opening notebook session in web browswer
echo -------- start docker exec
# docker exec -it dbt-dbt-1 bash -c "uv pip install --system papermill" 
# docker exec -it dbt-dbt-1 bash -c "papermill /usr/app/demo/dbt-spark-demo.ipynb /usr/app/demo/dbt-spark-demo.ipynb"

docker exec dbt-dbt-1 bash -c "uv pip install --system papermill" 
docker exec dbt-dbt-1 bash -c "papermill /usr/app/demo/dbt-spark-demo.ipynb /usr/app/demo/dbt-spark-demo.ipynb"
echo -------- end docker exec

# jupyter nbconvert --to notebook --execute /usr/app/demo/dbt-spark-demo.ipynb
# docker exec -it dbt-dbt-1 bash -c "cd /usr/app/ && jupyter notebook --NotebookApp.token='' --NotebookApp.password='' --NotebookApp.disable_check_xsrf=True --allow-root --ip=0.0.0.0 --port=8888 --no-browser"
