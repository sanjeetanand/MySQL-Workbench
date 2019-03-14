<!DOCTYPE html>
<%@page import="com.workbench.data.TableData"%>
<%@page import="com.workbench.data.TableDataDto"%>
<%@page import="com.workbench.table.TableDto"%>
<%@page import="com.workbench.conn.DataDao"%>
<%@page import="com.workbench.table.Table"%>
<%@page import="com.workbench.database.Database"%>
<%@page import="java.util.ArrayList"%>
<jsp:useBean id="dao" class="com.workbench.table.Table"></jsp:useBean>
<%
String user = request.getParameter("user");
if(user != null) {
	String dbname=request.getParameter("dbname");
	String tname=request.getParameter("tname");
	if(dbname!=null && tname != null){
		
%>
<html lang="en">

<head>

  <meta charset="utf-8">
  <meta http-equiv="X-UA-Compatible" content="IE=edge">
  <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
  <meta name="description" content="">
  <meta name="author" content="">
  <title>MySql Workbench</title>
  <link href="vendor/fontawesome-free/css/all.min.css" rel="stylesheet" type="text/css">
  <link href="vendor/datatables/dataTables.bootstrap4.css" rel="stylesheet">
  <link href="css/sb-admin.css" rel="stylesheet">

<script>
function dataFun() {
  var data = document.getElementById("datatable");
  var desc = document.getElementById("desctable");
  data.style.display = "block";
  desc.style.display = "none";
}
function descFun() {
	  var data = document.getElementById("datatable");
	  var desc = document.getElementById("desctable");
	  data.style.display = "none";
	  desc.style.display = "block";
	}
</script>

</head>

<body id="page-top" onload="dataFun()">

  <nav class="navbar navbar-expand navbar-dark bg-dark static-top">
    <a class="navbar-brand mr-1" href="logout.jsp">MySql Workbench</a>
    <button class="btn btn-link btn-sm text-white order-1 order-sm-0" id="sidebarToggle" href="#">
      <i class="fas fa-bars"></i>
    </button>
    
    <form class="d-none d-md-inline-block form-inline ml-auto mr-0 mr-md-3 my-2 my-md-0" action="home.jsp" method="post">
      <div class="input-group">
      <input type="hidden" value="<%=user %>" name="user">
      <input type="hidden" value="create" name="opr">
        <input name="dbname" type="text" class="form-control" placeholder="Database name..." aria-label="Search" aria-describedby="basic-addon2">
        <div class="input-group-append">
          <input type="Submit" class="btn btn-primary" type="button" value="create">
        </div>
      </div>
    </form>
  </nav>

  <div id="wrapper">

    <!-- Sidebar -->
    <ul class="sidebar navbar-nav">
      <li class="nav-item active">
        <a class="nav-link" href="home.jsp?user=<%=user%>">
          <i class="fas fa-fw fa-tachometer-alt"></i>
          <span>Database</span>
        </a>
      </li>
      
      <%
      ArrayList<String> list = new Database().showDatabases();
      if(!list.isEmpty()) {
      for(String db : list) {
      %>
      <li class="nav-item dropdown">
        <a class="nav-link dropdown-toggle" href="#" id="pagesDropdown" role="button" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
          <i class="fas fa-fw fa-folder"></i>
          <span><%=db %></span>
        </a>
        <div class="dropdown-menu" aria-labelledby="pagesDropdown">
          <h6 class="dropdown-header">Tables</h6>
          <%ArrayList<String> table = new Table().showTables(db);
          if(!table.isEmpty()){
          for(String tb : table){%>
          <a class="dropdown-item" href="table.jsp?user=<%=user%>&dbname=<%=db%>&tname=<%=tb%>"><%=tb %></a>
          <%}} %>
          <div class="dropdown-divider"></div>
          <a class="dropdown-item" href="home.jsp?dbname=<%=db%>&user=<%=user %>&opr=del">Drop Database</a>
          <a class="dropdown-item" href="newtable.jsp?dbname=<%=db%>&user=<%=user%>">Create Table</a>
        </div>
      </li>
   	  <%}} %>
   	  <li class="nav-item">
        <a class="nav-link" href="logout.jsp">
          <i class="fas fa-fw fa-chart-area"></i>
          <span>Close</span></a>
      </li>
    </ul>

    <div id="content-wrapper">

      <div class="container-fluid">

        <!-- Breadcrumbs-->
        <ol class="breadcrumb">
          <li class="breadcrumb-item"><%=dbname %></li>
          <li class="breadcrumb-item"><%=tname %></li>
          <li class="breadcrumb-item" onclick="dataFun()" style="color: blue; cursor: pointer;">Data</li>
          <li class="breadcrumb-item" onclick="descFun()" style="color: blue; cursor: pointer;">Description</li>
          <li class="breadcrumb-item">
          <a href="tablecontroller.jsp?user=<%=user%>&dbname=<%=dbname%>&tname=<%=tname%>&opr=del">
          Del Table</a></li>
        </ol>

<!-- Table Desc -->
<div id="desctable">
         <div class="card mb-3">
          <div class="card-header">
            <i class="fas fa-table"></i>
            Table Description</div>
          <div class="card-body">
            <div class="table-responsive">
              <table class="table table-bordered" width="100%" cellspacing="0">
                <thead>
                  <tr>
                    <th>Field</th>
                    <th>Range</th>
                    <th>Range</th>
                    <th>Operation</th>
                  </tr>
                </thead>
                <tbody>
                <%
                ArrayList<TableDto> desc = new Table().descTable(dbname, tname);
                if(!desc.isEmpty()){
                	for(TableDto dto : desc){
                %>
                  <tr>
                    <td><%=dto.getField() %></td>
                    <td><%=dto.getType() %></td>
                    <td><%=dto.getRange() %></td>
                    <td>
                    <a href="tablecontroller.jsp?user=<%=user%>&tname=<%=tname%>&dbname=<%=dbname%>&type=desc&opr=del&col=<%=dto.getField()%>">
                    Del</a>
                    &nbsp&nbsp&nbsp&nbsp
                    <a href="descform.jsp?user=<%=user%>&tname=<%=tname%>&dbname=<%=dbname%>&opr=mod&col=<%=dto.getField()%>">
                    Mod</a>
                    </td>    
                  </tr>
                  <%} } %>              
                </tbody>
              </table>
            </div>
          </div>
          <div class="card-footer small text-muted" id="">
          <a href="descform.jsp?user=<%=user%>&tname=<%=tname%>&dbname=<%=dbname%>&opr=new">
          Add Column</a>
          </div>
        </div>
        </div>
		<!-- desc close -->

       <div id="datatable">
        <!-- Table Data -->
        <div class="card mb-3">
          <div class="card-header">
            <i class="fas fa-table"></i>
            Table Data</div>
          <div class="card-body">
            <div class="table-responsive">
              <table class="table table-bordered" id="dataTable" width="100%" cellspacing="0">
                
                <thead>
                  <tr>
                  <% if (desc != null) {
						for (TableDto d : desc) {%>
                    <th><%=d.getField()%></th>
                  <% }}%>
                  <th>Opr</th>
                  </tr>
                </thead>
                
                <tbody>
                <%
                ArrayList<ArrayList> data = dao.selectTable(dbname, tname);
				if (data != null) {
					for (ArrayList list2 : data) {
                %>
                  <tr>
                  <%for (int i = 0; i < list2.size(); i++) {%>
                    <td><%=list2.get(i)%></td>
                    <%}%>
                    <td>
                    <a href="tablecontroller.jsp?user=<%=user%>&tname=<%=tname%>&dbname=<%=dbname%>&type=data&opr=del&
						<%int j = 0;%>
						<%for (TableDto d : desc) {%>
						<%=d.getField()%>=<%=list2.get(j)%>&
						<%j++;
						}%>">Del</a>
              
                    &nbsp&nbsp&nbsp&nbsp
                    
                    <a href="dataform.jsp?user=<%=user%>&tname=<%=tname%>&dbname=<%=dbname%>&opr=mod&
						<%int k = 0;%>
						<%for (TableDto d : desc) {%>
						<%=d.getField()%>=<%=list2.get(k)%>&
						<%k++;
						}%>">Mod</a>
                    </td>
                  </tr> 
                  <%}}%>                 
                </tbody>
              </table>
            </div>
          </div>
          <div class="card-footer small text-muted">
          <a href="dataform.jsp?user=<%=user%>&tname=<%=tname%>&dbname=<%=dbname%>&opr=new">Add Record</a>
          </div>
        </div>
 </div>
 

      </div>
      <!-- /.container-fluid -->

      <!-- Sticky Footer -->
      <footer class="sticky-footer">
        <div class="container my-auto">
          <div class="copyright text-center my-auto">
            <span>Copyright © MySql Workbench 2019</span>
          </div>
        </div>
      </footer>

    </div>
    <!-- /.content-wrapper -->

  </div>
  <!-- /#wrapper -->

  <script src="vendor/jquery/jquery.min.js"></script>
  <script src="vendor/bootstrap/js/bootstrap.bundle.min.js"></script>
  <script src="vendor/jquery-easing/jquery.easing.min.js"></script>
  <script src="vendor/datatables/jquery.dataTables.js"></script>
  <script src="vendor/datatables/dataTables.bootstrap4.js"></script>
  <script src="js/sb-admin.min.js"></script>
  <script src="js/demo/datatables-demo.js"></script>

</body>

</html>
<%
} else {
		response.sendRedirect("home.jsp?user="+user);
}
} else {
	response.sendRedirect("index.jsp");
}
%>