package com.workbench.conn;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

public class DataDao {

	Connection con=null;
	PreparedStatement ps=null;
	ResultSet rs=null;

	@SuppressWarnings("finally")
	public ArrayList<String> viewConn() {
		ArrayList<String> list = new ArrayList<>();
		try {
			if(con == null) {
				//DbmsData.createConn();
				con=DbmsData.getConnection();
				if(con != null) {
					String query="select user,host from mysql.user";
					ps=con.prepareStatement(query);
					rs = ps.executeQuery();
					while(rs.next()) {
						list.add(rs.getString("user"));
						list.add(rs.getString("host"));
					}
				}
			}	
		} catch(Exception e) {
			System.out.println("Exception at createConn : "+e);
		} finally {
			ps=null;
			rs=null;
			con=null;
			return list;
		}
	}
	
	@SuppressWarnings("finally")
	public boolean createUser(String user,String password,String host) {
		boolean flag=false;
		try {
			if(con == null) {
				//DbmsData.createConn();
				con=DbmsData.getConnection();
				if(con != null) {
					String query="create user '"+user+"'@'"+host+"' identified with mysql_native_password by '"+password+"'";
					ps=con.prepareStatement(query);
					if(ps.executeUpdate()==0) {
						flag=true;
					}
				}
			}	
		} catch(Exception e) {
			System.out.println("Exception at createConn : "+e);
		} finally {
			ps=null;
			con=null;
			return flag;
		}
	}

	@SuppressWarnings("finally")
	public ArrayList<String> selectConn(String user) {
		ArrayList<String> list = new ArrayList<>();
		try {
			if(con == null) {
				//DbmsData.createConn();
				con=DbmsData.getConnection();
				if(con != null) {
					String query="select user,host from mysql.user where user=?";
					ps=con.prepareStatement(query);
					ps.setString(1, user);
					rs=ps.executeQuery();
					while(rs.next()) {
						list.add(rs.getString("user"));
						list.add(rs.getString("host"));
						list.add(rs.getString("authentication_string"));
					}
				}
			}	
		} catch(Exception e) {
			System.out.println("Exception at selConn : "+e);
		} finally {
			rs=null;
			ps=null;
			con=null;
			return list;
		}
	}

	
	@SuppressWarnings("finally")
	public boolean delConn(String user,String host) {
		boolean flag=false;
		try {
			if(con == null) {
				//DbmsData.createConn();
				con=DbmsData.getConnection();
				if(con != null) {
					String query="drop user '"+user+"'@'"+host+"'";
					ps=con.prepareStatement(query);
					if(ps.executeUpdate()==0) {
						flag=true;
					}
				}
			}	
		} catch(Exception e) {
			System.out.println("Exception at delConn : "+e);
		} finally {
			ps=null;
			con=null;
			return flag;
		}
	}
	
	@SuppressWarnings("finally")
	public boolean authenticate(String user,String password,String host) {
		boolean flag=false;
		try {
			if(con == null) {
				DbmsData.user=user;
				DbmsData.password=password;
				DbmsData.host=host;
				if(DbmsData.createConn()) {
					con=DbmsData.getConnection();
					if(con != null) {
						flag=true;
					} else {
						flag=false;
						DbmsData.closeConnection();
					}
				} else {
					DbmsData.closeConnection();
					flag=false;
				}
			}	
		} catch(Exception e) {
			System.out.println("Exception at delConn : "+e);
		} finally {
			ps=null;
			con=null;
			return flag;
		}
	}
	public static void main(String[] args) {
		
	}
}
