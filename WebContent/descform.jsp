
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
	<%
String user = request.getParameter("user");
String dbname = request.getParameter("dbname");
String tname = request.getParameter("tname");
if (dbname != null && tname != null && user !=null) {
	String opr = request.getParameter("opr");
	if (opr != null) {
		if (opr.equals("new")) {
%>

	<div class="container">
		<div class="card card-login mx-auto mt-5">
			<div class="card-header">
				New Column in table
				<%=tname %></div>
			<div class="card-body">

				<form action="tablecontroller.jsp" id="form" method="post"
					name="form">
					<input type="hidden" name="user" value="<%=user %>"> <input
						type="hidden" name="dbname" value="<%=dbname %>"> <input
						type="hidden" name="tname" value="<%=tname%>"> <input
						type="hidden" name="type" value="desc"> <input
						type="hidden" name="opr" value="new">
					<div class="form-group">
						<div class="col-sm-12">
							<input name="col" placeholder="Field Name" type="text"
								class="form-control" id="focusedInput" required="required">
						</div>
					</div>
					<div class="form-group">
						<div class="col-sm-12">
							<select name="dtype" required="required" class="form-control" id="focusedInput">
								<option value="varchar">Varchar</option>
								<option value="int">Integer</option>
								<option value="float">Float</option>
							</select>
						</div>
					</div>
					<div class="form-group">
						<div class="col-sm-12">
							<input name="range" placeholder="range" type="number"
								class="form-control" id="focusedInput">
						</div>
					</div>

					<div class="form-group">
						<div class="col-sm-12">
							<input type="submit" value="Add"
								class="btn btn-primary btn-block">
						</div>
					</div>
					<div class="form-group">
						<div class="col-sm-12">
							<button type="button" class="btn btn-danger btn-block"
								onclick="window.location='table.jsp?user=<%=user%>&dbname=<%=dbname%>&tname=<%=tname%>'">
								Close</button>
						</div>
					</div>

				</form>
			</div>
		</div>
	</div>
	<%
		} else if(opr.equals("mod")){
			String col=request.getParameter("col");
			if(col != null) {
%>
	<div class="container">
		<div class="card card-login mx-auto mt-5">
			<div class="card-header">
				Modify Column in table
				<%=tname %></div>
			<div class="card-body">

				<form action="tablecontroller.jsp" id="form" method="post"
					name="form">
					<input type="hidden" name="user" value="<%=user %>"> <input
						type="hidden" name="dbname" value="<%=dbname %>"> <input
						type="hidden" name="tname" value="<%=tname%>"> <input
						type="hidden" name="type" value="desc"> <input
						type="hidden" name="opr" value="mod">
					<div class="form-group">
						<div class="col-sm-12">
							<input name="col" placeholder="Field Name" type="text"
								class="form-control" id="focusedInput"
								value="<%=col%>">
						</div>
					</div>
					<div class="form-group">
						<div class="col-sm-12">
							<select name="dtype" required="required" class="form-control" id="focusedInput">
								<option value="varchar">Varchar</option>
								<option value="int">Integer</option>
								<option value="float">Float</option>
							</select>
						</div>
					</div>
					<div class="form-group">
						<div class="col-sm-12">
							<input name="range" placeholder="range" type="number"
								class="form-control" id="focusedInput">
						</div>
					</div>

					<div class="form-group">
						<div class="col-sm-12">
							<input type="submit" value="Modify"
								class="btn btn-primary btn-block">
						</div>
					</div>
					<div class="form-group">
						<div class="col-sm-12">
							<button type="button" class="btn btn-danger btn-block"
								onclick="window.location='table.jsp?user=<%=user%>&dbname=<%=dbname%>&tname=<%=tname %>'">
								Close</button>
						</div>
					</div>

				</form>
			</div>
		</div>
	</div>
	<%
			}
		}
	}
}
%>
	<script src="vendor/jquery/jquery.min.js"></script>
	<script src="vendor/bootstrap/js/bootstrap.bundle.min.js"></script>
	<script src="vendor/jquery-easing/jquery.easing.min.js"></script>

</body>

</html>