// import ballerina/lang.runtime;
import ballerina/task;
import ballerina/time;
import ballerina/log;

import rukshanp/Y_uji_nAlarm.model as model;
import rukshanp/Y_uji_nAlarm.Mailman as mm;

configurable string timeAbbrev = ?;
configurable int zoneOffsetHours = ?;
configurable int zoneOffsetMinutes = ?;
configurable int zoneOffsetSeconds = ?;

class Notification {
    *task:Job;

    model:EmailRecord emailRecord;

    public function execute() {
        error? sendEmail = mm:sendEmail(self.emailRecord.subject, self.emailRecord.body);
        if sendEmail is error {
            log:printError("Could not send email", 'error=sendEmail);
        }
    }

    isolated function init(model:EmailRecord emailRecord) {
        self.emailRecord = emailRecord;
    }
}

time:ZoneOffset zoneOffset = {
    hours: zoneOffsetHours,
    minutes: zoneOffsetMinutes,
    seconds: <decimal>zoneOffsetSeconds
};

public function currentCivil() returns time:Civil {
    time:Utc currentUtc = time:utcNow();
    time:Civil currentCivil = time:utcToCivil(currentUtc);
    return currentCivil;
}

public function sendNotificationAfter(decimal seconds, model:EmailRecord emailRecord) returns error? {
    time:Utc currentUtc = time:utcNow();
    time:Utc newTime = time:utcAddSeconds(currentUtc, seconds);
    time:Civil time = time:utcToCivil(newTime);
    task:JobId result = check task:scheduleOneTimeJob(new Notification(emailRecord), time);
}

public function getAllJobIds() returns int[] {
    int[] ids = [];
    task:JobId[] jobIds = task:getRunningJobs();
    foreach task:JobId jobId in jobIds {
        ids.push(jobId.id);
    }
    return ids;
}
