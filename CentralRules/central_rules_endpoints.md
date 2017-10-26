# Central Rules Endpoints

The Central Rules API determines whether a transfer to an End User is permitted.

## Endpoints

### Check transfer eligibility

This endpoint is used to find out if a transfer to an End User is permitted.

#### Allowed
``` http
GET https://central-rules/transfer?sender_user_number=11144455555555&receiver_user_number=11122233333333&amount=125
```

``` http
HTTP/1.1 200 OK
Content-Type: application/json
{
  "allowed": true
}
```

#### Not allowed
``` http
GET https://central-rules/transfer?sender_user_number=11144455555555&receiver_user_number=11122233333333&amount=100001
```

``` http
HTTP/1.1 200 OK
Content-Type: application/json
{
  "allowed": false,
  "reason": {
  	"code": "transfer_limit_exceeded",
  	"message": "Not allowed to send more than 100,000"
  }
}
