import ballerina/test;

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
    string subject = "exampleSubject";
    string body = "this is a sample body";

    // io:println("I'm in test function!");
    error? sendEmailResult = sendEmail(subject, body);
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
