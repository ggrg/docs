# Using Logging

## Introduction
This document provides Mojaloop services logging guidelines in order to provide end-end traceability of interactions, aid in troubleshooting and publish metrics to the backend


### Desired Goals
* End-to-end Traceability of a particular transaction
* Understand service behavior
* Debuggging
* Metrics for a particular transaction

#### General:
All logs statement must begin with **ISO8601 compliant timestamp**.  The timestamp must have millisecond resolution.  It should be follwed by a log level.  Available logs levels are 
**ERROR, WARN, INFO, DEBUG**  For example
```
2017-04-28T17:16:20.561Z INFO ilp-routing:routing-tables debug bumping route ledgerA: mojaloop.dfsp1.  ledgerB:   nextHop: mojaloop.ist.dfsp2
```
#### 1. End-to-end Traceability:  
To provide end-to-end traceability of Level One payment related interactions, L1P components shall include **L1p-Trace-Id** in all log statements where available.  The following
snippet must be included in all of the log lines: `L1p-Trace-Id=<current_trace_id>` For a given unit of work, related interactions between services,
the L1p-Trace-Id is required to be unique.  It is recommended that UUID be used for uniqueness requirement.  This would allow to quickly retrieve
all logging for a given L1p-Trace-Id.    
 
#### 2. Rest Service Calls:  
All Rest Service calls must include **L1p-Trace-Id** as a header HTTP Header.  The value of this header must be set to *Payment ID* for all payment interactions.
For all non-payment interaction the originating DFSP must generate and use an UUID for the value of the header.  In the case where the **L1p-Trace-Id** is not present
as a header, an error needs to be logged with context about the call with the missing header.  The service must set the **L1p-Trace-Id** header with appropriate value 
whether the current interaction is during the course of processing a payment or not.

#### 3. Web Socket Notifications:  
[To Be Filled in]

#### 4. Addtional Context in Logs
It is recommended to log other identifiers that can help retrieve logs statement across multiple layers in the Mojaloop stack. 
Some examples are Transfer Id, User ID (USSD id, email, login name), AppName, and AccountId etc.  `Relevant-Id=<id_value>`
  
#### 5. Metrics Logging
Logs can be used to publish metrics to metrics service.  There are 2 types of metrics that are supported.  The details about supported
metrics are available [here](https://github.com/mojaloop/interop-metrics-ui/blob/master/available-metrics.md).  The snippet below shows the systax for publishing metrics:
  
  1. Counter
    ```
    ... L1P_METRIC_COUNTER:[counter-namespace.name] ...
    ```
    where L1P_METRIC_COUNTER is a keyword followed by a colon and the desired metric name* is within [ ].  This would increment the 
    counter identified by metric name by 1.
  1. Timer
    ```
    ... L1P_METRIC_TIMER:[timer-namespace.name][50] ...
    ```
    where L1P_METRIC_TIMER is a keyword followed by a colon, the desired metric name* is within [ ] and timed value in millisenconds with [ ].  
    This would add the time value in milliseconds to timer identified by metric name*.

  \* metric name is composed of 3 elements that separated by a period.  
  1. environment which captures where the application is runnning e.g. _dfsp1-test, dfsp2-qa_ etc.
  1. application instance id which should identify the process
  1. metric name which could contain alpahnumeric characters and could have java package name style prefix
