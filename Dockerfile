ARG IMAGE_VARIANT=slim-buster
ARG OPENJDK_VERSION=17
ARG PYTHON_VERSION=3.10.6

FROM python:${PYTHON_VERSION}-${IMAGE_VARIANT} AS py3
FROM apache/spark-py:3.3.1

USER root

RUN  apt-get update \
  && apt-get install -y wget make

RUN rm -rf /var/lib/apt/lists/*

ENV APP_HOME /pyspark_home
WORKDIR $APP_HOME

COPY --from=py3 / /

RUN groupadd -r default && useradd -r -g default default

ENV PYTHONUNBUFFERED True

COPY requirements.txt ./

RUN python -m pip install --upgrade pip
RUN python -m pip install -r requirements.txt
ARG PYSPARK_VERSION=3.3.1

RUN pip --no-cache-dir install pyspark==${PYSPARK_VERSION}

COPY main.py ./

RUN chmod -R 755 $APP_HOME
RUN chown default:default $APP_HOME

USER default

CMD ["bash"]