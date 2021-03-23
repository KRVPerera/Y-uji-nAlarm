# YóujiànAlarm

## Setup

add your smtp server details to `Config.toml`. For gmail you may want to create an application password.

## Running

On vs code `Ballerina: Run` or `Ballerina: build` and then `bal run target/bin/Y_uji_nAlarm.jar`.

## Support simple one time notification e-mail

Below request will send an e-mail with following details after 60 seconds.
```
http://localhost:9090/notifications/schedule
{
	"seconds": 60,
	"subject": "simple notificatifon",
	"body": "give Iron suplement and vitamin to baby"
}
```

## Current JOB Ids

Returns a integer array with job ids currenlty scheduled.

http://localhost:9090/notifications/all
