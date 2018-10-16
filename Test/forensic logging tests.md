# Forensic Logging tests

## Stop service when not logging
If the forensic logging service stops the service(s) connected to it immeditately detect this and also stop. 

When the forensic log service is started it logs a restart to the log.

## Show complete data for a single transfer
A forensic log can be built across the entire path of the transfer that shows passage of a single transfer (by Transfer ID) and it's state at each time, including retries and down services.

## Show complete data by time period and customer
A forensic log can be built across the entire path of the transfer that shows the passage of the all the transfers for a give user during a time period. The time period is defined from the point of view of one service, such as the center and the transfers are shown that are valid for that service in the time period. 

## Show when a log has been tampered with
In each case show that part of the log (the line or a section) has been tampered with and the parts that are not tampered with
- Change a row
- Change order of rows
- Drop a row
- Add a row