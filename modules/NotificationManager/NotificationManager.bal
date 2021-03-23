// import ballerina/lang.runtime;
import ballerina/task;
import ballerina/time;
import rukshanp/Y_uji_nAlarm.model as model;

configurable string timeAbbrev = ?;
configurable int zoneOffsetHours = ?;
configurable int zoneOffsetMinutes = ?;
configurable int zoneOffsetSeconds = ?;

class Notification {
    *task:Job;

    int i = 1;
    model:EmailRecord emailRecord;

    public function execute() {
        self.i += 1;
        
    }

    isolated function init(int i, model:EmailRecord emailRecord) {
        self.i = i;
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

public function sendNotificationAfter(int seconds, model:EmailRecord emailRecord) returns error? {
    time:Utc currentUtc = time:utcNow();
    time:Utc newTime = time:utcAddSeconds(currentUtc, 3);
    time:Civil time = time:utcToCivil(newTime);
    task:JobId result = check task:scheduleOneTimeJob(new Notification(0, emailRecord), time);
}


public function getAllJobIds() returns int[] {
    int[] ids = [];
    task:JobId[] jobIds =  task:getRunningJobs();
    foreach task:JobId jobId in jobIds {
        ids.push(jobId.id);
    }
    return ids;
}
