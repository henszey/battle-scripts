<!doctype html>
<html>
<head>
<title>Login</title>
<link rel="stylesheet" type="text/css" href="/css/main.css" />
</head>
<body>

<form action="/dologin" method="post">
  <label for="name">Name</label>
  <input id="name" name="name" type="text"/>
  <label for="password">Password</label>
  <input id="password" name="password" type="password"/>
  <input type="submit" value="Login"/>
  <input type="submit" value="Create new user"/>
</form>

</body>
</html>