<%@page import="com.workbench.conn.DbmsData"%>
<%
DbmsData.closeConnection();
response.sendRedirect("login.jsp");
%>