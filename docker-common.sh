docker network create my_shared_network
pwd
cd dbt;             docker compose up -d 
cd ../dbt-spark;    docker compose up -d 

docker exec dbt-dbt-1 bash -c "cd /usr/app/demo/dbt_spark_demo_prj && . ./setup.sh"

# jupyter nbconvert --to notebook --execute --inplace a.ipynb
docker exec -it dbt-dbt-1 bash -c "cd /usr/app/ && jupyter notebook --NotebookApp.token='' --NotebookApp.password='' --NotebookApp.disable_check_xsrf=True --allow-root --ip=0.0.0.0 --port=8888 --no-browser"
