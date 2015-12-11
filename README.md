# radio
An intuitive CLI Rest Client for interacting with CRUD APIs

# Usage

The command line usage is pretty simple

```
USAGE: radio [host] [action] [service...] [[key]:[value]...]
```

## host

The host is just any valid DNS entry or IP address.  We need to know who to talk to.  If 
your API lives in a context path like `/api` you can append that to the host argument too

## action

Actions will determine the HTTP method to use, in addition to the standard HTTP methods
there are also some aliases you can use

- `show` translates to `GET`
- `new` translates to `POST`
- `update` translates to `PUT`

Any action that matches an HTTP method name will be converted to uppercase, so you don't 
have to type `DELETE` on the CLI, `delete` will work just fine

## endpoint

The service is the API service you want to perform your action on.  You can specify the 
service either `/` delimited or space delimited.  I like space delimited becayse 
it looks nicer.  For example if I have an endpoint `GET /jobs/23/status` would 
run 

````bash
$ radio api.ht.gs get jobs/23/status
{
  "percent": 23,
  "status": "running"
}

# or just replace the slashes with spaces  

$ radio api.ht.gs get jobs 23 status
{
  "percent": 23,
  "status": "running"
}
```

# Examples

## Simple HTTP GET

```bash
$ radio api.hurtigtechnoloiges.com show user 1
{
  "email": "bar@example.com",
  "name": "Bar"
}
```

This command translates to the following HTTP Request

```
HTTP/1.1 /user POST
Host: api.hurtigtechnologies.com
Contetn-Type: application/json
Accept: application/json

{
  "email": "fo@example.com",
  "name": "foo"
}
```


## Simple HTTP POST

Note that key:value pairs representing the JSON Body which contain spaces just need to be quoted or `\ ` escaped

```bash
$ radio api.hurtigtechnoloiges.com new user email:foo@example.com "name:Foo Bar"
{
  "id": 23
}
```

This command translates to the following HTTP Request

```
HTTP/1.1 /user POST
Host: api.hurtigtechnologies.com
Contetn-Type: application/json
Accept: application/json

{
  "email": "fo@example.com",
  "name": "For Bar"
}
```

# License

Apache2: See [LICENSE](LICENSE)

# Authors

Eddie Hurtig (hello@hurtigtechnologies.com)
