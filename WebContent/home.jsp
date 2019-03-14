<%@page import="com.workbench.conn.DataDao"%>
<%@page import="com.workbench.table.Table"%>
<%@page import="java.util.ArrayList"%>
<%@page import="com.workbench.database.Database"%>
<%
String user = request.getParameter("user");
if(user != null) {
String dbname = request.getParameter("dbname");
if(dbname != null){
	String opr=request.getParameter("opr");
	if(opr!=null){
		if(opr.equals("create")){
			if(new Database().createDatabase(dbname)){
				response.sendRedirect("home.jsp?user="+user+"&msg=createsuccess");
			} else {
				response.sendRedirect("home.jsp?user="+user+"&msg=createerror");
			}
		} else if(opr.equals("del")){
			if(new Database().dropDatabase(dbname)){
				response.sendRedirect("home.jsp?user="+user+"&msg=delsuccess");
			} else {
				response.sendRedirect("home.jsp?user="+user+"&msg=delerror");
			}
		}
	}
}
}else {
response.sendRedirect("login.jsp");
}
%>

<!DOCTYPE html>
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

</head>

<body id="page-top">
  <nav class="navbar navbar-expand navbar-dark bg-dark static-top">
    <a class="navbar-brand mr-1" href="logout.jsp">MySql Workbench</a>
    <button class="btn btn-link btn-sm text-white order-1 order-sm-0" id="sidebarToggle" href="#">
      <i class="fas fa-bars"></i>
    </button>

    <!-- Navbar Search -->
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
          <a class="dropdown-item" href="home.jsp?dbname=<%=db%>&user=<%=user%>&opr=del">Drop Database</a>
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

        <ol class="breadcrumb">
          <li class="breadcrumb-item">
            <a href="#">Database</a>
          </li>
          <!-- <li class="breadcrumb-item active">Overview</li> -->
        </ol>
      </div>
      <!-- /.container-fluid -->
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

  <!-- Bootstrap core JavaScript-->
  <script src="vendor/jquery/jquery.min.js"></script>
  <script src="vendor/bootstrap/js/bootstrap.bundle.min.js"></script>

  <!-- Core plugin JavaScript-->
  <script src="vendor/jquery-easing/jquery.easing.min.js"></script>

  <!-- Page level plugin JavaScript-->
  <script src="vendor/chart.js/Chart.min.js"></script>
  <script src="vendor/datatables/jquery.dataTables.js"></script>
  <script src="vendor/datatables/dataTables.bootstrap4.js"></script>

  <!-- Custom scripts for all pages-->
  <script src="js/sb-admin.min.js"></script>

  <!-- Demo scripts for this page-->
  <script src="js/demo/datatables-demo.js"></script>
  <script src="js/demo/chart-area-demo.js"></script>

</body>

</html>
