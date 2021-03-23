import ballerina/io;

import rukshanp/Y_uji_nAlarm.Mailman as mm;

public function main() {
    string subject = "exampleSubject";
    string body = "this is a sample body";

    // io:println("I'm in test function!");
    error? sendEmailResult = mm:sendEmail(subject, body);
    io:println("Hello World!");
}
