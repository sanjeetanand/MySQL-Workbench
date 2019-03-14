package com.workbench.conn;

import java.sql.Connection;
import java.sql.DriverManager;

public class DbmsData{
	public static String user=null,password=null,host=null;
	public static final String driver = "com.mysql.jdbc.Driver";
	private static Connection con=null;
	private DbmsData() {

	}
	public static boolean createConn(){
		try {
			Class.forName(driver);
			String url = "jdbc:mysql://"+host+"?useSSL=false";
			con=DriverManager.getConnection(url,user,password);
			if(con != null) {
				return true;
			}
			return false;
		} catch (Exception e) {
			System.out.println(e);
			return false;
		}
	}
	public static Connection getConnection() {
		return con;
	}
	public static void closeConnection() {
		con=null;
		user=null;
		password=null;
		host=null;
	}
	public static void main(String[] args) {
		DbmsData.createConn();
		System.out.println(DbmsData.getConnection());
	}
}
