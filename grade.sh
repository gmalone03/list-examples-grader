CPATH='.:lib/hamcrest-core-1.3.jar:lib/junit-4.13.2.jar'

# Clone the repository of the student submission to a well-known directory name
rm -rf student-submission
git clone $1 student-submission
echo 'Finished cloning'

# Check that the student code has the correct file submitted. If they didn’t, detect and give helpful feedback about it.
if [ ! -f student-submission/ListExamples.java ]; then
  echo "Error: 'ListExamples.java' file not found in submission. Please check the file name and try again."
  exit 1
fi

# Copy the test file into the same directory as the student code
cp student-submission/ListExamples.java ./

# Compile your tests and the student’s code from the appropriate directory with the appropriate classpath commands. If the compilation fails, detect and give helpful feedback about it.
javac -cp $CPATH *.java
java -cp $CPATH org.junit.runner.JUnitCore TestListExamples
# Run the tests and report the grade based on the JUnit output.

