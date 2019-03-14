<%@page import="com.workbench.data.TableData"%>
<%@page import="com.workbench.table.TableDto"%>
<%@page import="com.workbench.data.TableDataDto"%>
<%@page import="java.util.ArrayList"%>
<%@page import="com.workbench.table.Table"%>
<%
String user = request.getParameter("user");
if(user != null) {
	String dbname=request.getParameter("dbname");
	String tname=request.getParameter("tname");
	if(dbname!=null && tname != null){
		String type = request.getParameter("type");
		if (type != null) {
			
			//table structure
			if (type.equals("desc")) {
				String opr = request.getParameter("opr");
				if(opr!=null){
				if (opr.equals("new")) {
					String col = request.getParameter("col");
					String dtype = request.getParameter("dtype");
					String range = request.getParameter("range");
					if(new Table().addCol(dbname, tname, col, dtype, range)){
						response.sendRedirect("table.jsp?user="+user+"&tname="+tname+"&dbname="+dbname+"&msg=newcolok");
					} else {
						response.sendRedirect("table.jsp?user="+user+"&tname="+tname+"&dbname="+dbname+"&msg=newcolnotok");
					}
				} else if (opr.equals("mod")) {
					String col = request.getParameter("col");
					String dtype = request.getParameter("dtype");
					String range = request.getParameter("range");
					if(new Table().modCol(dbname, tname, col, dtype, range)){
						response.sendRedirect("table.jsp?user="+user+"&tname="+tname+"&dbname="+dbname+"&msg=modcolok");
					} else{
						response.sendRedirect("table.jsp?user="+user+"&tname="+tname+"&dbname="+dbname+"&msg=modcolnotok");
					}
				} else if (opr.equals("del")) {
					String col = request.getParameter("col");
					if(new Table().dropCol(dbname, tname, col)){
						response.sendRedirect("table.jsp?user="+user+"&tname="+tname+"&dbname="+dbname+"&msg=delcolok");
					} else{
						response.sendRedirect("table.jsp?user="+user+"&tname="+tname+"&dbname="+dbname+"&msg=delcolnotok");
					}
				}
				}
			//table data	
			} else if (type.equals("data")) {
				String opr = request.getParameter("opr");
				if(opr != null){
				if (opr.equals("new")) {
					ArrayList<TableDataDto> l = new ArrayList<>();
					ArrayList<TableDto> list = new Table().descTable(dbname, tname);
					for (TableDto dto : list) {
						TableDataDto d = new TableDataDto();
						d.setField(dto.getField());
						d.setValue(request.getParameter(dto.getField()));
						d.setType(dto.getType());
						l.add(d);
					}
					if(new TableData().insertData(dbname, tname, l)){
						response.sendRedirect("table.jsp?user="+user+"&tname="+tname+"&dbname="+dbname+"&msg=newdataok");
					} else{
						response.sendRedirect("table.jsp?user="+user+"&tname="+tname+"&dbname="+dbname+"&msg=newdatanotok");
					}
										
				} else if (opr.equals("modify")) {
					
					
				} else if (opr.equals("del")) {
					ArrayList<TableDataDto> l = new ArrayList<>();
					ArrayList<TableDto> list = new Table().descTable(dbname, tname);
					for (TableDto dto : list) {
						TableDataDto d = new TableDataDto();
						d.setField(dto.getField());
						d.setValue(request.getParameter(dto.getField()));
						d.setType(dto.getType());
						l.add(d);
					}
					if(new TableData().delData(dbname, tname, l)){
						response.sendRedirect("table.jsp?user="+user+"&tname="+tname+"&dbname="+dbname+"&msg=deldataok");
					} else{
						response.sendRedirect("table.jsp?user="+user+"&tname="+tname+"&dbname="+dbname+"&msg=deldatanotok");
					}
				}
				}
			}
		} else {
			String opr = request.getParameter("opr");
			if(opr != null){
				if (opr.equals("del")) {
					if(new Table().dropTable(dbname, tname)) {
						response.sendRedirect("home.jsp?user="+user);
					} else {
						response.sendRedirect("table.jsp?user="+user+"&dbname="+dbname+"&tname="+tname);
					}
				}
			}
		}
	}
}
%>