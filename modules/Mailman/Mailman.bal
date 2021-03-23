import ballerina/email;
import ballerina/log;

configurable string alarmLabel = ?;
configurable int smtpPort = ?;
configurable string smtpServer = ?;
configurable string smtpServerLogin = ?;
configurable string smtpServerPassword = ?;

type UsersRecord record {|
    readonly string username;
    string email;
|};

type Users table<UsersRecord> key(username);

configurable Users & readonly ccusers = ?;
configurable Users & readonly tousers = ?;

email:SmtpConfiguration smtpConfig = {port: smtpPort};
email:SmtpClient smtpClient = check new(smtpServer, smtpServerLogin, smtpServerPassword, smtpConfig);

# Send a simple e-mail
#
# + subject - Subject of the email   
# + body - Body of the email  
# + return - Return Value Description
public function sendEmail(string subject, string body) returns error? {

    string[] tofields = [];
    foreach UsersRecord touser in tousers {
        tofields.push(touser.email);
    }

    email:Message email = {
        to: tofields,
        cc: ["receiver3@email.com", "receiver4@email.com"],
        subject: subject,
        body: body
    };
    
    check smtpClient->sendMessage(email);
    log:printDebug("e-mail sent");
}
