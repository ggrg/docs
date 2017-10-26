# Central Directory API

The central directory is a system that allows DFSPs to retrieve a URI that will return customer information by supplying an identifier and identifier type.

- Data Structures
	- [Resource Object](#resource_object)
	- [DFSP Object](#dfsp_object)
	- [Identifier Type Object](#identifier_type_object)
	- [Metadata Object](#metadata_object)
- Endpoints
	- [Lookup resource by identifier](#lookup_resource)
	- [Register a DFSP](#register_dfsp)
	- [Get identifier types](#get_identifier_types)
	- [Get directory metadata](#get_metadata)
- [Error Information](#error_information)

### Resource Object<a name="resource_object"></a>

A resource represents the information returned about an identifier and identifier type.

A resource object can have the following fields:

| Name | Type | Description |
| ---- | ---- | ----------- |
| spspReceiver | URI | A URI that can be called to get more information about the customer |

### DFSP Object<a name="dfsp_object"></a>

Represents a DFSP that has registered with the central directory.

Some fields are Read-only, meaning they are set by the API and cannot be modified by clients. A DFSP object can have the following fields:

| Name | Type | Description |
| ---- | ---- | ----------- |
| name | String | Unique name of the DFSP |
| key | String | *Optional, Read-only* Key to use when authenticating, currently the same value as the name field |
| secret | String | *Optional, Read-only* Secret to use when authenticating, currently the same value as the name field |

### Identifier Type Object<a name="identifier_type_object"></a>

Represents an identifier type that is supported by the central directory.

An identifier type object can have the following fields:

| Name | Type | Description |
| ---- | ---- | ----------- |
| identifierType | String | Unique name of the identifier type |
| description | String | Description of the identifier type |

### Metadata Object<a name="metadata_object"></a>

The central directory will return a metadata object about itself allowing client's to configure themselves properly.

A metadata object can have the following fields:

| Name | Type | Description |
| ---- | ---- | ----------- |
| directory | URI | The directory that generated the metadata |
| urls | Object | Paths to other methods exposed by this directory. Each field name is short name for a method and the value is the path to that method. |

### Lookup resource by identifier<a name="lookup_resource"></a>
This endpoint allows retrieval of a URI that will return customer information by supplying and identifier and identifier type.

```
http://central-directory/resources?identifierType=:type&identifier=:identifier
```

```http
GET http://central-directory/resources/?identifierType=test&identifier=1 HTTP/1.1
```

#### Authentication
| Type | Description |
| ---- | ----------- |
| HTTP Basic | The username and password are the key and secret of a registered DFSP; for example, dfsp1:dfsp1 |

#### Query Params
| Field | Type | Description |
| ----- | ---- | ----------- |
| identifierType | String | Valid identifier type |
| identifier | String | Identifier for the user |

#### Response 200 OK
| Field | Type | Description |
| ----- | ---- | ----------- |
| Object | Resource | The [Resource object](#resource_object) retrieved |

``` http
HTTP/1.1 200 OK
{
  "spspReceiver": "http://dfsp/users/2"
}
```

#### Errors (4xx)
| Field | Description |
| ----- | ----------- |
| NotFoundError | The requested resource could not be found |

### Register a DFSP<a name="register_dfsp"></a>
This endpoint allows a DFSP to be registered to use the central directory.

```
http://central-directory/commands/register
```

``` http
POST http://central-directory/commands/register HTTP/1.1
Content-Type: application/json
{
  "name": "dfsp1"
}
```

#### Authentication
| Type | Description |
| ---- | ----------- |
| HTTP Basic | The username and password are admin:admin |

#### Headers
| Field | Type | Description |
| ----- | ---- | ----------- |
| Content-Type | String | Must be set to `application/json` |

#### Request body
| Field | Type | Description |
| ----- | ---- | ----------- |
| Object | DFSP | A [DFSP object](#dfsp_object) to be created |

#### Response 201 Created
| Field | Type | Description |
| ----- | ---- | ----------- |
| Object | DFSP | The newly-created [DFSP object](#dfsp_object) as saved |

``` http
HTTP/1.1 201 CREATED
Content-Type: application/json
{
  "name": "dfsp1",
  "key": "dfsp1",
  "secret": "dfsp1"
}
```

##### Errors (4xx)
| Field | Description |
| ----- | ----------- |
| AlreadyExistsError | The DFSP already exists (determined by name) |

### Get identifier types<a name="get_identifier_types"></a>
This endpoint allows retrieval of the identifier types supported by the central directory.

```
http://central-directory/identifier-types
```

```http
GET http://central-directory/identifier-types HTTP/1.1
```

#### Authentication
| Type | Description |
| ---- | ----------- |
| HTTP Basic | The username and password are the key and secret of a registered DFSP, for example, dfsp1:dfsp1 |

#### Response 200 OK
| Field | Type | Description |
| ----- | ---- | ----------- |
| Object | Array | List of supported [Identifier Type objects](#identifier_type_object) |

``` http
HTTP/1.1 200 OK
[
  {
    "identifierType": "test",
    "description": "test"
  }
]
```

### Get directory metadata<a name="get_directory_metadata"></a>

Returns metadata associated with the directory

``` http
http://central-directory
```

``` http
GET http://central-directory HTTP/1.1
```

##### Response 200 OK
| Field | Type | Description |
| ----- | ---- | ----------- |
| Metadata | Object | The [Metadata object](#metadata_object) for the directory |

``` http
HTTP/1.1 200 OK
{
  "directory": "http://central-directory-dev.us-west-2.elasticbeanstalk.com",
  "urls": {
    "health": "http://central-directory-dev.us-west-2.elasticbeanstalk.com/health",
    "identifier_types": "http://central-directory-dev.us-west-2.elasticbeanstalk.com/identifier-types",
    "resources": "http://central-directory-dev.us-west-2.elasticbeanstalk.com/resources"
  }
}
```

### Error information<a name="error_information"></a>

This section identifies the potential errors returned and the structure of the response.

An error object can have the following fields:

| Name | Type | Description |
| ---- | ---- | ----------- |
| id | String | An identifier for the type of error |
| message | String | A message describing the error that occurred |
| validationErrors | Array | *Optional* An array of validation errors |
| validationErrors[].message | String | A message describing the validation error |
| validationErrors[].params | Object | An object containing the field that caused the validation error |
| validationErrors[].params.key | String | The name of the field that caused the validation error |
| validationErrors[].params.value | String | The value that caused the validation error |
| validationErrors[].params.child | String | The name of the child field |

``` http
HTTP/1.1 404 Not Found
Content-Type: application/json
{
  "id": "InvalidQueryParameterError",
  "message": "Error validating one or more query parameters",
  "validationErrors": [
    {
      "message": "'0' is not a registered identifierType",
      "params": {
        "key": "identifierType",
        "value": "0"
      }
    }
  ]
}
```
