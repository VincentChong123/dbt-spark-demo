#!/bin/bash
docker network create --attachable my_shared_network

COMPOSE_BAKE=true # This variable isn't used in the commands, assume it's for context

# --- Step 1: Build and start the dbt project ---
echo "Building and starting dbt project..."
# cd dbt && docker compose build --no-cache && docker compose up -d
pushd dbt && docker compose build && docker compose up -d
if [ $? -ne 0 ]; then echo "Error starting dbt project"; exit 1; fi
popd 

# --- Step 2: Build and start the dbt-spark project ---
echo "Building and starting dbt-spark project..."
# cd dbt-spark && docker compose build --no-cache && docker compose up -d
pushd dbt-spark && ls ./docker-compose.yml && docker compose build && docker compose up -d
if [ $? -ne 0 ]; then echo "Error starting dbt-spark project"; exit 1; fi
cd ..
popd

        # # --- Step 3: Wait for dbt-spark3-thrift to be ready ---
        # echo "Waiting for dbt-spark3-thrift service to be ready..."
        # # Use docker compose wait (recommended if available, Docker Compose v2.20.0+)
        # # Make sure your dbt-spark/docker-compose.yml has a healthcheck for spark3-thrift!
        # cd dbt-spark && docker compose wait dbt-spark3-thrift
        # if [ $? -ne 0 ]; then echo "dbt-spark3-thrift service failed health check"; exit 1; fi
        # cd ..

# OR, a more manual wait with retry (if docker compose wait isn't an option or reliable enough)
# MAX_RETRIES=20
# RETRY_COUNT=0
# until docker inspect --format='{{.State.Health.Status}}' dbt-spark3-thrift | grep -q "healthy"; do
#   if [ $RETRY_COUNT -ge $MAX_RETRIES ]; then
#     echo "dbt-spark3-thrift service did not become healthy after $MAX_RETRIES retries. Exiting."
#     exit 1
#   fi
#   echo "Waiting for dbt-spark3-thrift service to be healthy... (Attempt $((RETRY_COUNT+1))/$MAX_RETRIES)"
#   sleep 10 # Wait 10 seconds between checks
#   RETRY_COUNT=$((RETRY_COUNT+1))
# done
# echo "dbt-spark3-thrift service is healthy!"


# --- Clean up old data (execute after services are up if they depend on it) ---
# echo "Cleaning up data..."
# rm -r dbt/dbt_spark_demo_prj/* || true # Use '|| true' to prevent script from failing if dir doesn't exist
# rm demo/results/*.txt || true # Use '|| true' to prevent script from failing if file doesn't exist

# --- Verify running containers (optional) ---
echo "Currently running Docker containers:"
docker ps

# --- Step 4: Execute the dbt command ---
echo "Executing dbt command inside dbt-dbt-1 container..."
docker exec dbt-dbt-1 bash -c "cd /usr/app/demo/dbt_spark_demo_prj && . ./setup.sh"
if [ $? -ne 0 ]; then echo "Error executing dbt command"; exit 1; fi

echo "Workflow completed successfully!"

# pwd
# COMPOSE_BAKE=true
# cd dbt;             docker compose build --no-cache; docker compose up -d
# cd ../dbt-spark;    docker compose build --no-cache; docker compose up -d

# rm -r dbt/dbt_spark_demo_prj/*
# rm demo/results/*.txt

# docker ps 
# docker exec dbt-dbt-1 bash -c "cd /usr/app/demo/dbt_spark_demo_prj && . ./setup.sh"

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
