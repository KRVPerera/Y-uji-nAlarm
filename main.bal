// import ballerina/io;
import ballerina/http;
import ballerina/log;
// import rukshanp/Y_uji_nAlarm.Mailman as mm;
import Y_uji_nAlarm.model;
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

    @http:ResourceConfig {consumes: ["application/json"]}
    resource function post schedule(http:Caller caller, http:Request req) returns error? {
        json jsonMsg = check req.getJsonPayload();
        log:printDebug(jsonMsg.toString());
        json subjectJson = check jsonMsg.subject;
        json bodyJson = check jsonMsg.body;
        decimal seconds = check jsonMsg.seconds;

        model:EmailRecord emailRec = {
            subject: subjectJson.toString(),
            body: bodyJson.toString()
        };
    
        check nm:sendNotificationAfter(seconds, emailRec);

        http:Response res = new;
        res.statusCode = 200;
        res.setPayload("notification added");
        var x = caller->respond(res);
    }
}
