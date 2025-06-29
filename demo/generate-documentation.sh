quarto render ./demo/dbt-spark-demo.ipynb
cp ./demo/dbt-spark-demo.html ./index.html

dbt docs generate --project-dir=/home/vin/01-prj/stripe/dbt-spark-demo/dbt/dbt_spark_demo_prj --profiles-dir=/home/vin/01-prj/stripe/dbt-spark-demo/demo

dbt docs serve --project-dir=/home/vin/01-prj/stripe/dbt-spark-demo/dbt/dbt_spark_demo_prj --profiles-dir=/home/vin/01-prj/stripe/dbt-spark-demo/demo --port 8089