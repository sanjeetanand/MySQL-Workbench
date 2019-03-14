<!DOCTYPE html>
<%@page import="com.workbench.table.Table"%>
<%@page import="com.workbench.table.TableDto"%>
<%@page import="java.util.ArrayList"%>
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
			ArrayList<TableDto> list = new Table().descTable(dbname,tname);
			if(list.isEmpty()) {
				response.sendRedirect("table.jsp?dbname="+dbname+"&tname="+tname+"&user="+user);
			} else {
%>
	<div class="container">
		<div class="card card-login mx-auto mt-5">
			<div class="card-header">
				New Record in table
				<%=tname %></div>
			<div class="card-body">

				<form action="tablecontroller.jsp" id="form" method="post"
					name="form">
					<input type="hidden" name="user" value="<%=user %>"> <input
						type="hidden" name="dbname" value="<%=dbname %>"> <input
						type="hidden" name="tname" value="<%=tname%>"> <input
						type="hidden" name="type" value="data"> <input
						type="hidden" name="opr" value="new">

					<%for(TableDto dto : list) {%>
					<div class="form-group">
						<div class="col-sm-12">
							<input name="<%=dto.getField() %>"
								placeholder="<%=dto.getField() %> <%=dto.getType() %>(<%=dto.getRange() %>)"
								type="text" class="form-control" id="focusedInput"
								required="required">
						</div>
					</div>
					<%} %>

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
			}
			} else if(opr.equals("mod")){
				ArrayList<TableDto> desc = new Table().descTable(dbname, tname);
                if(!desc.isEmpty()){
                	
%>
	<div class="container">
		<div class="card card-login mx-auto mt-5">
			<div class="card-header">
				Modify Data in table
				<%=tname %></div>
			<div class="card-body">

				<form action="tablecontroller.jsp" id="form" method="post"
					name="form">
					<input type="hidden" name="user" value="<%=user %>"> <input
						type="hidden" name="dbname" value="<%=dbname %>"> <input
						type="hidden" name="tname" value="<%=tname%>"> <input
						type="hidden" name="type" value="data"> <input
						type="hidden" name="opr" value="mod">

					<%
for(TableDto dto : desc){
	String s = request.getParameter(dto.getField());
%>
					<div class="form-group">
						<div class="col-sm-12">
							<input name="<%=dto.getField() %>" 
							placeholder="<%=dto.getField() %> <%=dto.getType() %>(<%=dto.getRange() %>)" 
							type="text" class="form-control" id="focusedInput" value="<%=s%>">
						</div>
					</div>
<%}%>
					
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