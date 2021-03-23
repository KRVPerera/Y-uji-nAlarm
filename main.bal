// import ballerina/io;
import ballerina/http;
import ballerina/log;
// import rukshanp/Y_uji_nAlarm.Mailman as mm;
import rukshanp/Y_uji_nAlarm.NotificationManager as nm;

configurable int servicePort = ?;

public function main() {
// string subject = "exampleSubject";
// string body = "this is a sample body";

// // io:println("I'm in test function!");
// error? sendEmailResult = mm:sendEmail(subject, body);
// io:println("Hello World!");
}

service /notifications on new http:Listener(servicePort) {

    resource function get all(http:Caller caller, http:Request req) {
        log:printDebug("request called all");
        int[] ids = nm:getAllJobIds();
        http:Response res = new;
        res.statusCode = 200;
        res.setPayload(ids.toString());
        var x = caller->respond(res);
    }

}
