#!/bin/sh
if [ ! -f TP1.jar ]; then
   cd ./project
   ./gradlew build
   cp ./app/build/libs/app.jar ../TP1.jar
   cd ..
fi
java -jar TP1.jar
