import ballerina/io;
// import ballerina/lang.runtime;
import ballerina/task;
import ballerina/time;

configurable string timeAbbrev = ?;
configurable int zoneOffsetHours = ?;
configurable int zoneOffsetMinutes = ?;
configurable int zoneOffsetSeconds = ?;

class Notification {
    *task:Job;

    int i = 1;
    string message;

    public function execute() {
        self.i += 1;
        io:println("MyCounter: ", self.i);
    }

    isolated function init(int i, string message) {
        self.i = i;
        self.message = message;
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
