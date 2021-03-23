# Call this script as `test1-install Grammar` where `Grammar.cf` is the name of the grammar, which must be in the working directory
# The system needs to be able to run:  bnfc, alex, happy, ghc and needs to be connected to the internet

# download the testsuite from the internet if not installed locally
echo -e "\033[35m----download the testsuite from the internet if not installed locally\033[0m"

# if [ ! -d ./lab1-testsuite-larger ]
# then
#    wget http://www.grammaticalframework.org/ipl-book/assignments/assignment1/testscript/lab1-testsuite-larger.tar.gz
 #   tar -zxf lab1-testsuite-larger.tar.gz
  #  rm  lab1-testsuite-larger.tar.gz
# fi

# compile the test progs-test-lab1.hs
echo "\033[35m----compile the test progs-test-lab1.hs\033[0m"
cd lab1-testsuite-larger
ghc --make -o progs-test-lab1 progs-test-lab1.hs | grep error

# execute the tests 
echo "\033[35m----execute the tests (... can take a while ...)\033[0m"
./progs-test-lab1 ../$1.cf | grep 'program\|failed\|rules\|conflicts' 
cd ..

# run bnfc and show the number of conflicts in the grammar
# echo "\033[35m----run bnfc and show the number of rules and of conflicts in the grammar\033[0m"
bnfc -m --haskell $1.cf | grep rules
make | grep conflicts
pwd
echo "\33[32m ----parse hello.cc \33[0m"
./TestCpp lab1-testsuite-larger/good/hello.cc | grep Parse
echo "\33[32m ----parse greet.cc \33[0m"
./TestCpp lab1-testsuite-larger/good/greet.cc | grep Parse
echo "\33[32m ----parse med.cc \33[0m"
./TestCpp lab1-testsuite-larger/good/med.cc | grep Parse
echo "\33[32m ----parse grade.cc \33[0m"
./TestCpp lab1-testsuite-larger/good/grade.cc | grep Parse
echo "\33[32m ----parse palin.cc \33[0m"
./TestCpp lab1-testsuite-larger/good/palin.cc | grep Parse
echo "\33[32m ----parse grammar.cc \33[0m"
./TestCpp lab1-testsuite-larger/good/grammar.cc | grep Parse

# clean up 
# echo "\033[35m----clean up\033[0m"
# rm  lab1-testsuite-larger.tar.gz*
