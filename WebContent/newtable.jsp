<%@page import="com.workbench.table.Table"%>
<%@page import="com.workbench.table.TableDto"%>
<%@page import="java.util.ArrayList"%>
<%@page import="com.workbench.conn.DataDao"%>
<%
if(request.getMethod().equalsIgnoreCase("post")){
	String user = request.getParameter("user");
	String dbname = request.getParameter("dbname");
	String tname = request.getParameter("tname");
	if(user != null && dbname != null && tname != null) {
		String col=request.getParameter("col");
		if(col != null) {
			int colnum=Integer.parseInt(col);
			ArrayList<TableDto> list=new ArrayList<>();
			for(int i=1;i<=colnum;i++){
				TableDto dto=new TableDto();
				String f = request.getParameter("colname"+i);
				if(f != null) {
				dto.setField(f);
				dto.setType(request.getParameter("dtype"+i));
				dto.setRange(Integer.parseInt(request.getParameter("range"+i)));
				list.add(dto);
				}
			}
			if(new Table().createTable(dbname, tname, list)){
				response.sendRedirect("table.jsp?user="+user+"&dbname="+dbname+"&tname="+tname+"&msg=create");
			}
			else{
				response.sendRedirect("table.jsp?user="+user+"&dbname="+dbname+"&tname="+tname+"&msg=notcreate");
			}
		}
	} else {
		response.sendRedirect("index.jsp?msg=error");
	}
} else {
	String user = request.getParameter("user");
	String dbname = request.getParameter("dbname");
	
	if(user != null && dbname !=null) {
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

<script type="text/javascript">

	var x = 0;
	
	function addCol() {
		x++;
		
		var col = document.createElement("input");
		col.type = "text";
		col.name = "colname" + x;
		col.placeholder = "Enter column name";
		col.required = "required";
		col.setAttribute("class","form-control");
		var t1 = document.createElement("td");
		t1.appendChild(col);
		
		var array = ["varchar","int","float"];
		var selectList = document.createElement("select");
		selectList.name = "dtype" + x;
		selectList.required = "required";
		selectList.setAttribute("class","form-control");
		for (var i = 0; i < array.length; i++) {
		    var option = document.createElement("option");
		    option.value = array[i];
		    option.text = array[i];
		    selectList.appendChild(option);
		}
		var t2 = document.createElement("td");
		t2.appendChild(selectList);
		
		var range = document.createElement("input");
		range.type = "number";
		range.name = "range" + x;
		range.placeholder = "Enter range";
		range.required = "required";
		range.setAttribute("class","form-control");
		var t3 = document.createElement("td");
		t3.appendChild(range);
		
		var element = document.createElement("button");
		element.setAttribute("type", "button");
		element.setAttribute("class", "btn btn-danger btn-block");
		element.setAttribute("onclick", "remove(this)");
		var t4 = document.createElement("td");
		t4.appendChild(element);
		
		var tr = document.createElement("tr");
		tr.setAttribute("id",x);
		tr.appendChild(t1);
		tr.appendChild(t2);
		tr.appendChild(t3);
		tr.appendChild(t4);
		
		var tbody = document.getElementById("customers");
		tbody.appendChild(tr);

	}

	function add() {
		var box = document.createElement("input");
		box.type = "hidden";
		box.value = x;
		box.name = "col";
		document.getElementById('col').appendChild(box);
	}
	
	function remove(oButton) {
		document.getElementById("customers").deleteRow(oButton.parentNode.parentNode.rowIndex);
	}
</script>

</head>

<body class="bg-dark">

	<div class="container">

		<form action="newtable.jsp" id="form" method="post" name="form">
			<input type="hidden" value="<%=dbname %>" name="dbname">
			<input type="hidden" value="<%=user %>" name="user">
				
				<div id="col"></div>
			<div class="card mb-3">
				<div class="card-header">
					<i class="fas fa-table"></i> Create Table
				</div>
				<div class="card-body">
				<div class="form-group">
						<div class="col-sm-12">
							<input name="tname" placeholder="Table Name" type="text"
								class="form-control" id="focusedInput" required="required">
						</div>
					</div>
					<div class="table-responsive">
						<table class="table table-bordered" id="dataTable" width="100%"
							cellspacing="0">
							<thead>
								<tr>
									<th>Field</th>
									<th>Data Type</th>
									<th>Range</th>
									<th>Operation</th>
								</tr>
							</thead>
							<tbody id="customers">
								
							</tbody>
						</table>
					</div>
				</div>
				<div class="card-footer small text-muted" onclick="addCol()">
					Add Column
				</div>
			</div>


			<div class="form-group">
				<div class="col-sm-12">
					<input type="submit" value="Create" onclick="add()"
						class="btn btn-primary btn-block">
				</div>
			</div>
			<div class="form-group">
				<div class="col-sm-12">
					<button type="button" class="btn btn-danger btn-block"
						onclick="window.location='home.jsp?user=<%=user%>'">
						Close</button>
				</div>
			</div>

		</form>

	</div>

	<script src="vendor/jquery/jquery.min.js"></script>
	<script src="vendor/bootstrap/js/bootstrap.bundle.min.js"></script>
	<script src="vendor/jquery-easing/jquery.easing.min.js"></script>

</body>

</html>

<%
	} else {
		response.sendRedirect("index.jsp");		
	}
}
%>