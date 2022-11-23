from pyspark.sql import SparkSession


def main():
    spark = SparkSession.builder.appName("SimpleApp").getOrCreate()
    parsed = spark.read.option("header", "true")\
        .option("nullValue", "?")\
        .option("inferSchema", "true")\
        .csv("linkage/block*.csv")
    parsed.show()
    parsed.printSchema()


if __name__ == '__main__':
    main()
