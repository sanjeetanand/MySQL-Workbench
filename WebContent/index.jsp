<%@page import="com.workbench.conn.*"%>
<%@page import="java.util.ArrayList"%>
<% if(!DbmsData.user.equals("root")){
	response.sendRedirect("login.jsp");
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

<title>MySQL Workbench</title>
<link href="vendor/fontawesome-free/css/all.min.css" rel="stylesheet"
	type="text/css">
<link href="vendor/datatables/dataTables.bootstrap4.css"
	rel="stylesheet">
<link href="css/sb-admin.css" rel="stylesheet">

</head>

<body id="page-top" style="overflow: hidden;">

	<nav class="navbar navbar-expand navbar-dark static-top"
		style="background-color: rgb(0, 0, 0);">
		<p class="navbar-brand mr-1">Admin</p>
	</nav>

	<div id="wrapper">
		<div id="content-wrapper">
			<div class="container-fluid">

				<!-- Breadcrumbs-->
				<ol class="breadcrumb">
					<li class="breadcrumb-item">
						<h4>MySql USERS</h4>
					</li>
					<li class="breadcrumb-item active"><a href="conncontroller.jsp">Create User</a></li>
					<li class="breadcrumb-item active"><a href="home.jsp?user=root">Databases</a></li>
				</ol>

				<!-- Icon Cards-->
				<div class="row">
					<%
						ArrayList<String> list = new DataDao().viewConn();
						if (list.isEmpty()) {
					%>
					<div class="col-xl-3 col-sm-6 mb-3">
						<div class="card text-white bg-danger o-hidden h-100">
							<div class="card-body">
								<div class="card-body-icon">
									<i class="fas fa-fw fa-comments"></i>
								</div>
								<div class="mr-5">No Connection</div>
							</div>
							<a class="card-footer text-white clearfix small z-1" href="conncontroller.jsp">
								<span class="float-left">Create One</span>
								<span class="float-right"> <i class="fas fa-angle-right"></i>
							</span>
							</a>
						</div>
					</div>
					<%
						} else {
							for (int i=0;i<list.size();i=i+2) {
					%>
					<div class="col-xl-3 col-sm-6 mb-3">
						<div class="card text-white bg-primary o-hidden h-100">
							<div class="card-body">
								<div class="card-body-icon">
									<i class="fas fa-fw fa-comments"></i>
								</div>
								<div class="mr-5"><%=list.get(i)%></div>
							</div>
							<a class="card-footer text-white clearfix small z-1" href="#">
								<span class="float-left"><%=list.get(i+1)%></span> <span
								class="float-right"> <i class="fas fa-angle-right"></i>
							</span>
							</a>
							<a class="card-footer text-white clearfix small z-1" 
							href="conncontroller.jsp?opr=del&user=<%=list.get(i)%>&host=<%=list.get(i+1)%>">
								<span class="float-left">Delete</span> <span
								class="float-right"> <i class="fas fa-angle-right"></i>
							</span>
							</a>
						</div>
					</div>
					<%
						}
						}
					%>
				</div>




			</div>
			<!-- /.container-fluid -->
		</div>
		<!-- /.content-wrapper -->

	</div>
	
	<script src="vendor/jquery/jquery.min.js"></script>
	<script src="vendor/bootstrap/js/bootstrap.bundle.min.js"></script>
	<script src="vendor/jquery-easing/jquery.easing.min.js"></script>
	<script src="vendor/chart.js/Chart.min.js"></script>
	<script src="vendor/datatables/jquery.dataTables.js"></script>
	<script src="vendor/datatables/dataTables.bootstrap4.js"></script>
	<script src="js/sb-admin.min.js"></script>
	<script src="js/demo/datatables-demo.js"></script>
	<script src="js/demo/chart-area-demo.js"></script>

</body>

</html>
