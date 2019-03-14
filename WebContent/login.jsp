<%@page import="com.workbench.conn.DataDao"%>
<%
if(request.getMethod().equalsIgnoreCase("post")){
	String user = request.getParameter("user");
	String password = request.getParameter("password");
	String host = request.getParameter("host");
	String port = request.getParameter("port");
	if(user != null && host != null) {
		if(password == null){
			password = "";
		}
		if(new DataDao().authenticate(user,password,host)){
			if(user.equals("root")){
				response.sendRedirect("index.jsp");
			} else {
			response.sendRedirect("home.jsp?user="+user);
			}
		} else {
			response.sendRedirect("login.jsp?msg=error");
		}
	} else {
		response.sendRedirect("login.jsp?msg=blank");
	}
} else if (request.getMethod().equalsIgnoreCase("get")){
	String msg = request.getParameter("msg");
	if(msg !=null) {
		if(msg.equals("blank")){
			
		} else if(msg.equals("error")){
			
		}
	}
%>

<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport"
	content="width=device-width, initial-scale=1, shrink-to-fit=no">
<meta name="description" content="">
<meta name="author" content="">
<title>MySql Workbench</title>
<link href="vendor/fontawesome-free/css/all.min.css" rel="stylesheet"
	type="text/css">
<link href="css/sb-admin.css" rel="stylesheet">

</head>

<body class="bg-dark">

	<div class="container">
		<div class="card card-login mx-auto mt-5">
			<div class="card-header">Connection</div>
			<div class="card-body">
			
				<form action="login.jsp" id="form" method="post" name="form">
					<div class="form-group">
						<div class="col-sm-12">
							<input name="user" placeholder="User" type="text"
								class="form-control" id="focusedInput" required="required">
						</div>
					</div>
					<div class="form-group">
						<div class="col-sm-12">
							<input name="password" placeholder="Password" type="password"
								class="form-control" id="focusedInput">
						</div>
					</div>
					<div class="form-group">
						<div class="col-sm-12">
							<input name="host" placeholder="Host" type="text"
								class="form-control" id="focusedInput">
						</div>
					</div>
					<div class="form-group">
						<div class="col-sm-12">
							<input name="port" placeholder="Port" type="text"
								class="form-control" id="focusedInput">
						</div>
					</div>
					
					<div class="form-group">
						<div class="col-sm-12">
							<input type="submit" value="Login" class="btn btn-primary btn-block">
						</div>
					</div>
					
				</form>
				
			</div>
		</div>
	</div>

	<script src="vendor/jquery/jquery.min.js"></script>
	<script src="vendor/bootstrap/js/bootstrap.bundle.min.js"></script>
	<script src="vendor/jquery-easing/jquery.easing.min.js"></script>

</body>

</html>
<%}%>