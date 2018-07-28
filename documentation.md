## Sign-up

`POST` to `/users/`

Content-Type: `application/json`

Body:
```json
{
  "user": {
    "email": "michi@41.de",
    "password": "12345678",
    "podcasters": {
    	"forename": "Michi"
    }
  }
}
```

Returns:
```json
{
  "data": {
    "id": 38,
    "email": "michi@41.de"
  }
}
```

Sends email with confirm key, e.g. `[URL]/confirm?key=SFMyNTY.eyJzaWduZWQiOjE1MzE2MTM0NDksImRhdGEiOnsiZW1haWwiOiJtaWNoaUA0MS5kZSJ9fQ.ObL0R3R-racHK4H21AgJeJboKF1ubfT3lJakdENywQ8`

## Confirm Sign-up

`GET` to `[URL]/confirm?key=SFMyNTY.eyJzaWduZWQiOjE1MzE2MTM0NDksImRhdGEiOnsiZW1haWwiOiJtaWNoaUA0MS5kZSJ9fQ.ObL0R3R-racHK4H21AgJeJboKF1ubfT3lJakdENywQ8`

Returns:
```json
{
  "info": {
    "detail": "Your account has been confirmed"
  }
}
```

Sends mail with content, e.g. "Your account has been confirmed."

## Log-in

`POST` to `/sessions/`

Content-Type: `application/json`

Body:
```json
{
  "session": {
    "email": "michi@41.de",
    "password": "12345678"
  }
}
```

Returns:
```json
{
  "access_token": "SFMyNTY.eyJzaWduZWQiOjE1MzE2MTQ5NzIsImRhdGEiOjM4fQ.2HsszP3_8XqKSvQIYpghJ3d3Nx8O688PxyZzIPT344Y"
}
```

## Log-out

TODO: Wie kann ich mich ausloggen? Frontend-seitig?

## Edit Profile

TODO: Wie muss ich den Token Key senden, damit id_check oder user_check erfüllt sind?

`PUT` to `/podcasters/:id`

Content-Type: `application/json`

Body:
```json
{
  
}
```

## Request Reset Password

`POST` to `/password_resets/`

Content-Type: `application/json`

Body:
```json
{
  "password_reset": {
    "email": "michi@41.de"
  }
}
```

Returns:
```json
{
  "info": {
    "detail": "Check your inbox for instructions on how to reset your password"
  }
}
```

Sends email with password reset key, e.g. `[url]/password_resets/edit?key=SFMyNTY.eyJzaWduZWQiOjE1MzE2MTUyMjEsImRhdGEiOnsiZW1haWwiOiJtaWNoaUA0MS5kZSJ9fQ.Y973cC6QkFqeMJfFzneHcNGTG46RMWOzn5465Aiqb-8`

## Reset Password

`PUT` to `/password_resets/update/`

Content-Type: `application/json`

Body:
```json
{
  "password_reset": {
  	"key": "SFMyNTY.eyJzaWduZWQiOjE1MzE2MTUyMjEsImRhdGEiOnsiZW1haWwiOiJtaWNoaUA0MS5kZSJ9fQ.Y973cC6QkFqeMJfFzneHcNGTG46RMWOzn5465Aiqb-8",
    "email": "michi@41.de",
    "password": "123456789"
  }
}
```

Returns:
```json
{
  "info": {
    "detail": "Your password has been reset"
  }
}
```

Sends email with content, e.g. "Your password has been reset."