CPATH='.:lib/hamcrest-core-1.3.jar:lib/junit-4.13.2.jar'

rm -rf student-submission
git clone $1 student-submission
echo 'Finished cloning'
cd student-submission

# Recursively search for ListExamples.java
if [[ $(find . -type f -name "ListExamples.java") ]]; then
    echo "File with correct name was submitted (ListExamples.java)"
    # Compile ListExamples.java
    javac $(find . -type f -name "ListExamples.java")
    # Check if the compilation was successful
    if [ $? -eq 0 ]; then
      echo "Compilation successful!"
    else
      echo "Compilation failed. Here are the errors:"
      javac $(find . -type f -name "ListExamples.java") 2>&1 | grep -v "^Note: "
    fi
else
    echo "File with incorrect name was submitted. Rename to ListExamples.java"
    exit
fi


cd ../

cp student-submission/ListExamples.java ./
javac -cp $CPATH *.java

if [[ $? -ne 0 ]]
then
    echo "There was an error compling the file"
    cat error-trace.txt
    exit
else 
    echo "The java code was compiled successfully"
fi

java -cp .:lib/hamcrest-core-1.3.jar:lib/junit-4.13.2.jar org.junit.runner.JUnitCore TestListExamples > test-output.txt

echo "--------"
last_line=$(tail -n 2 test-output.txt)
echo $last_line
echo "--------"
echo "Execution ended"

java -cp $CPATH org.junit.runner.JUnitCore TestListExamples
