Docker zone :
- `docker build -t pyspark_trainning:latest .`
- `docker run -it -v ${PWD}:/pyspark_home -p 0.0.0.0:4040:4040 pyspark_trainning:latest --rm`
