# PKI Guide
***

## Introduction
In this guide, we will introduce some features of CloudFlare PKI -- [cfssl](https://github.com/cloudflare/cfssl)
CFSSL is a tool developed by CloudFlare. It’s both a command line tool and an HTTP API server for signing, verifying and bundling TLS certificates. It requires GO 1.6+ to build. In this guide, we use command line tool as the example.
* [**Background**](#background)
* [**Rationale**](#rationale)
* [**Install cfssl**](#install-cfssl)
* [**CA Config**](#ca-config)
* [**Client Config**](#client-config)
* [**Key Suggestions**](#key-suggestions)
* [**Integrating the Certificates with Service**](#integrating-the-certificates-with-service)
***

### Background
Secure Channels enable confidentiality and integrity of data across network connections.  In the context of Mojaloop,  a secure channel can be made possible by the implementation of service transport security via TLS to protect data in-transit and enable mutual authentication.  The centralization of trust in a TLS implementation is provided through a Public Key Infrastructure (PKI).  Note:  While the Central KMS may serve as a PKI as the Central Services evolve, an existing internal or hosted PKI can provide the management and distribution of certificates for service endpoints.
TLS helps mitigate a number of identified threats discovered during Mojaloop Threat Modeling exercises:
* **Tampering**: Network traffic sniffing and or manipulation across DFSP, Pathfinder and Central Services
* **Spoofing**:
    1. Rogue DFSP pretends to be another DFSP at central directory
    2. False connector subscribes to notifications for transfers
    3. Notifications are sent by a party other than the central ledger
    4. Rogue KMS requests a health check or log inquiry to Forensic Logging Sidecars
    5. Data manipulation of REST calls
* **Information Disclosure**:
    1. A false connector or 3rd party connector subscribes to notifications that are not theirs
    2. Inappropriate use of Cryptography (including side-channel weaknesses)
* **Elevation of Privilege**:
    1. Credential Exposure by DFSP
    2. Credential Exposure by Customer
    3. Credential Exposure by Central Services Employee

### Rationale
The implementation of TLS is a deployment-specific consideration as the standards, configurations and reliance on a PKI are best defined by the implementor. Mojaloop team has demonstrated a PKI/TLS design which may be configured and implemented to meet the needs of a deployment scenario through the use of the CloudFlare PKI Toolkit.  This toolkit provides a central root of trust, an API for automation of certificate activities and configuration options which optimize the selection of safe choices while abstracting low-level details such as the selection and implementation of low-level cryptographic primitives.  An introduction to this toolkit with safe examples for the generation and testing of certificates is found below.


### Install cfssl
To install the cfssl tool, please follow the instructions for Cloudflare's [cfssl](https://github.com/cloudflare/cfssl)

### CA Config
#### Initialize a certificate authority
First, you need to configure the certificate signing request (csr), which we've named ```ca.json```. For the key algorithm, rsa and ecdsa are supported by cfssl, but you need to avoid using a small sized key.
```
{
  "hosts": [
    "root.com",
    "www.root.com"
  ],
  "key": {
    "algo": "rsa",
    "size": 2048
  },
  "names": [
    {
    "C": "US",
    "L": "Des Moines",
    "O": "Dwolla, Inc.",
    "OU": "Mojaloop",
    "ST": "Iowa"
    }
  ]
}
 ```
 Then you need to generate a cert and the related private key for the CA.
 ```
 cfssl gencert -initca ca.json | cfssljson -bare ca -
 ```
You will receive the following files:
```
ca-key.pem
ca.csr
ca.pem
```
* ```ca.pem``` is your cert.
* ```ca-key.pem``` is your related private key, which should be stored in a safe spot. It will allow you to sign any cert.

#### Run a CA server
To run a CA server, you need the ```ca-key.pem``` and ```ca.pem``` files from the first step, and a config file, ```config_ca.json```, for the server.
```
{
   "signing": {
     "default": {
       "auth_key": "central_ledger",
       "expiry": "8760h",
       "usages": [
          "signing",
          "key encipherment",
          "server auth",
          "client auth"
        ],
       "name_whitelist": "\\.central-ledger\\.com$"
      }
   },
   "auth_keys": {
     "central_ledger": {
       "key": "0123456789abcdef",
       "type": "standard"
     }
   }
 }
 ```
 * ```auth_key``` is the token used to authenticate the client's CSR.
 * ```expiry``` is the valid time period for the cert. A year is around 8760 hours.
 * ```name_whitelist``` is the regular expression for the domain names that can be signed by the CA.
To run the server:
```
cfssl serve -ca=ca.pem -ca-key=ca-key.pem -config=config_ca.json -port=6666
```
The default IP and port number is: 127.0.0.1:8888.

### Client Config
To generate a certificate for the client, you will need a config file -- ```config_clients.json ``` for cfssl.
```
{
    "auth_keys" : {
       "central_ledger" : {
          "type" : "standard",
          "key" : "0123456789abcdef"
       }
    },
    "signing" : {
       "default" : {
          "auth_remote" : {
             "remote" : "ca_server",
             "auth_key" : "central_ledger"
          }
       }
    },
    "remotes" : {
       "ca_server" : "localhost:6666"
    }
 }
 ```
* The authentication token in ```auth_keys``` must match the one in the server.
* The server address in ```remotes``` must match the real server address.
You will also need another config file -- ```central_ledger.json``` for the service.
```
{
    "hosts": [
         "www.central-ledger.com"
     ],
     "key": {
         "algo": "ecdsa",
         "size": 256
     },
     "names": [
         {
             "C": "US",
             "L": "Des Moines",
             "O": "Mojaloop",
             "OU": "leveloneproject-central-services",
             "ST": "Iowa"
         }
     ]
 }
 ```
 * The domain name in ```hosts``` must match the whitelist in ```config_ca.json```.
 * You should avoid using a small sized key in ```key```.
To generate a certificate for the service:
```
cfssl gencert -config=config_clients.json central_ledger.json | cfssljson -bare central_ledger
```
You will receive the following files:
```
central_ledger-key.pem
central_ledger.csr
central_ledger.pem
```
``` central_ledger.pem``` will be your service's cert, and ```central_ledger-key.pem``` will be your private key.

### Key Suggestions
During the certificate signing requests, we suggest you avoid using small keys. The minium requirement is shown in the following table:


| Signature Key | RSA | ECC |
| ------------- | --- | --- |
| AES-256 | >=2048 | PCurves >= 256 |

### Integrating the certificates with service
Once the certificates have been created, you will need to integrate them with your service. We will use central-ledger as an example here.

#### Server
On the server side, you'll want to set it up so that every incoming request is checked against the cert. In the projects so far, our team has used Hapi, but it's just as simple when using Node libraries.
Both methods are shown to make the process as straightforward as possible.

##### Setting up with Hapi
On the server side, we simply added the key and cert to a tls object. When the server connection is initialized, the tls object is added as an option.
The fs library is used to read the key and cert files.

```
var fs = require('fs') 
.
.
.
const tls = {
  key: fs.readFileSync('./src/ssl/central_ledger-key.pem'),
  cert: fs.readFileSync('./src/ssl/central_ledger.pem')
}
const server = new Hapi.Server()
server.connection({
  tls
})
```


##### Setting up with Node
This step doesn't change much. The key and cert along with the client cert are added to an options object. When the server is created, they are added as options.
The fs library is used to read the key and cert files.

```
var fs = require('fs') 
var https = require('https') 
.
.
.
var options = { 
    key: fs.readFileSync('central_ledger-key.pem'), 
    cert: fs.readFileSync('central_ledger.pem'), 
    ca: fs.readFileSync('ca.pem'), 
}

https.createServer(options, function (req, res) { 
    res.writeHead(200) 
}).listen(3000)
```    

#### Client
For client requests to the server, we use many of the same libraries. fs is used to read the client cert and https is used to make the requests. 
The cert simply needs to be added as part of the options object under the name ca.

```
var fs = require('fs') 
var https = require('https') 
var options = { 
    hostname: 'localhost', 
    port: 3000, 
    path: '/', 
    method: 'GET', 
    ca: fs.readFileSync('ca.pem') 
}

var req = https.request(options, function(res) { 
    res.on('data', function(data) { 
    }) 
}) 
req.end()
```
