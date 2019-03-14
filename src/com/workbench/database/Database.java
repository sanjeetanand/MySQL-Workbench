package com.workbench.database;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

import com.workbench.conn.DbmsData;

public class Database {

	Connection con=null;
	PreparedStatement ps=null;
	ResultSet rs=null;
	
	@SuppressWarnings("finally")
	public ArrayList<String> showDatabases() {
		ArrayList<String> list = new ArrayList<>();
		try {
			if(con==null) {
				//DbmsData.createConn();
				con=DbmsData.getConnection();
			}
				String query="Show databases";
				ps=con.prepareStatement(query);
				rs=ps.executeQuery();
				while(rs.next()) {
					list.add(rs.getString(1));
				}
		} catch(Exception e) {
			System.out.println("Exception in show Database : "+e);
		} finally {
			ps=null;
			rs=null;
			con=null;
			return list;
		}
	}

	@SuppressWarnings("finally")
	public boolean createDatabase(String name) {
		boolean flag=false;
		try {
			if(con==null) {
				//DbmsData.createConn();
				con=DbmsData.getConnection();
			}
			ps=con.prepareStatement("create database "+name);
			if(ps.executeUpdate()>0) {
				flag=true;
			}
		} catch(Exception e) {
			System.out.println("Exception in create Database : "+e);
		} finally {
			ps=null;
			con=null;
			return flag;
		}
	}
	
	@SuppressWarnings("finally")
	public boolean dropDatabase(String name) {
		boolean flag=false;
		try {
			if(con==null) {
				//DbmsData.createConn();
				con=DbmsData.getConnection();
			}
			ps=con.prepareStatement("drop database "+name);
			if(ps.executeUpdate()==0) {
				flag=true;
			}
		} catch(Exception e) {
			System.out.println("Exception in drop Database : "+e);
		} finally {
			ps=null;
			con=null;
			return flag;
		}
	}
	
	/*@SuppressWarnings("finally")
	public boolean backupDatabase(String name,String address) {
		boolean flag=false;
		try {
			if(con==null) {
				DbmsData.url="jdbc:mysql://localhost?useSSL=false";
				con=DbmsData.getConnection();
			}
			ps=con.prepareStatement("backup database "+name+" to disk = /'"+address+"/'");
			if(ps.execute()) {
				System.out.println("Database backedup");
				flag=true;
			}
		} catch(Exception e) {
			System.out.println("Exception in backup Database : "+e);
		} finally {
			ps=null;
			con=null;
			return flag;
		}
	}
	*/
	
	public static void main(String[] args) {
		Database d=new Database();
		System.out.println(d.createDatabase("San"));
		
	}
}
