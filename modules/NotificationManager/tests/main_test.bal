import ballerina/test;
import ballerina/io;

# Before Suite Function
@test:BeforeSuite
function beforeSuiteFunc() {
    // io:println("I'm the before suite function!");
}

# Before test function
function beforeFunc() {
    // io:println("I'm the before function!");
}

# Test function
@test:Config {
    before: beforeFunc,
    after: afterFunc
}
function testFunction() {
   var time = currentCivil(); 
   io:println("time : ", time);
}

# After test function
function afterFunc() {
    // io:println("I'm the after function!");
}

# After Suite Function
@test:AfterSuite {}
function afterSuiteFunc() {
    // io:println("I'm the after suite function!");
}
