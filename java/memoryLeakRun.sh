#!/bin/bash


VALGRIND_OPS="--tool=memcheck  --smc-check=all --error-limit=no --leak-check=full --track-origins=yes"
#VALGRIND_OPS="--tool=memcheck --leak-check=full --smc-check=all"
cd "$(dirname "$BASH_SOURCE")"
WD=$(pwd)
# tempfile for JNI binaries
TMPDIR=$(mktemp -d)
# delete after exit using trap
trap "rm -fR $TMPDIR" EXIT

CP_LIBS="tensorflow-core-api-0.5.0-SNAPSHOT.jar
tensorflow-core-platform-0.5.0-SNAPSHOT.jar
javacpp-1.5.7.jar
ndarray-0.4.0-SNAPSHOT.jar
protobuf-java-3.19.4.jar"

JNI_LIBS="javacpp-1.5.7-linux-x86_64.jar
tensorflow-core-api-0.5.0-SNAPSHOT-linux-x86_64.jar"
# build jar of project (and resolve all dependencies)
./gradlew jar
# collect all dependency jars
for LIB in $CP_LIBS; do
  LIBS="$(find ~/.gradle -name "${LIB}" -exec echo -n "{}" \;):${LIBS}"
done
# unpack all JNI libs to a temp location
cd $TMPDIR
for LIB in $JNI_LIBS; do
  unzip -o $(find ~/.gradle -name "${LIB}" -exec echo -n "{}" \;)
done
JNIS=$(find $TMPDIR -name linux-x86_64 -type d -exec echo -n "{}:" \;)


cd "$WD"
echo "Run the following command:"
cd src/main/java;
echo "RUNNIND: "valgrind $VALGRIND_OPS java -cp ${LIBS}${WD}/build/libs/java.jar -Djava.library.path=${JNIS::length-1}  tftest.App
valgrind $VALGRIND_OPS java -cp ${LIBS}${WD}/build/libs/java.jar -Djava.library.path=${JNIS::length-1}  tftest.App
