#!/bin/bash
CPATH='.:lib/hamcrest-core-1.3.jar:lib/junit-4.13.2.jar'

# Changes working directory of script to directory where the script is located
cd "$(dirname "$0")"

# Clone the repository of the student submission to a well-known directory name (provided in starter code)
rm -rf student-submission
git clone "$1" student-submission

# Check that the student code has the correct file submitted. If they didn’t, detect and give helpful feedback about it.
if [ ! -f student-submission/ListExamples.java ]; then
  echo "Error: 'ListExamples.java' file not found in submission. Please check the file name and try again."
  exit 1
fi

# Copy the test file into the same directory as the student code
cp TestListExamples.java student-submission/

# Compile your tests and the student’s code from the appropriate directory with the appropriate classpath commands. If the compilation fails, detect and give helpful feedback about it.
cd student-submission
if ! javac -cp .:/usr/share/java/junit4.jar ListExamples.java TestListExamples.java; then
  echo "Error: Compilation failed. Please check your code and try again."
  exit 1
fi

# Run the tests and report the grade based on the JUnit output.
java -cp .:/usr/share/java/junit4.jar org.junit.runner.JUnitCore TestListExamples > test_output.txt 2>&1
if grep -q "FAILURES!!!" test_output.txt; then
  echo "Fail"
else
  echo "Pass"
fi
