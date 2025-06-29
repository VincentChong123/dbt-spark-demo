ARG py_version=3.11.2
FROM python:$py_version-slim-bullseye

ARG commit_ref=main
ARG dbt_third_party="dbt-pyspark[PyHive]"

RUN apt-get update \
  && apt-get dist-upgrade -y \
  && apt-get install -y --no-install-recommends \
    build-essential=12.9 \
    ca-certificates=20210119 \
    git=1:2.30.2-1+deb11u2 \
    libpq-dev=13.21-0+deb11u1 \
    make=4.3-4.1 \
    openssh-client=1:8.4p1-5+deb11u3 \
    software-properties-common=0.96.20.2-2.1 \
    coreutils \ 
    tree \
  && apt-get clean \
  && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

ENV PYTHONIOENCODING=utf-8
ENV LANG=C.UTF-8
WORKDIR /usr/app/dbt
ENTRYPOINT ["dbt"]
HEALTHCHECK CMD dbt --version || exit 1

RUN python -m pip install --no-cache-dir "uv>=0.1.30,<0.2"

RUN uv pip install --system --upgrade "pip==24.0" "setuptools==69.2.0" "wheel==0.43.0" --no-cache-dir \
#   && uv pip install --system --no-cache-dir "dbt-core @ git+https://github.com/dbt-labs/dbt-core@${commit_ref}#subdirectory=core" \
  && uv pip install --system --no-cache-dir dbt-core==1.10.2 \
  && if [ "$dbt_third_party" ]; then \
        uv pip install --system install --no-cache-dir "${dbt_third_party}"; \
     else \
        echo "No third party adapter provided"; \
     fi

COPY requirements.txt ./
RUN uv pip install -r requirements.txt --system --no-cache-dir
