docker run -v %cd%\..\..\:/work -w /work/src/ontology -e ROBOT_JAVA_ARGS='' -e JAVA_OPTS='' --rm -ti obolibrary/odkfull:v1.5.2 %*
