package com.workbench.table;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

import com.workbench.conn.DbmsData;

public class Table {
	Connection con=null;
	ResultSet rs=null;
	PreparedStatement ps=null;

	
	@SuppressWarnings("finally")
	public ArrayList<TableDto> descTable(String dbname, String tname) {
		ArrayList<TableDto> list = new ArrayList<>();
		try {
			if(con==null) {
				con=DbmsData.getConnection();
			}
			ps=con.prepareStatement("desc "+dbname+"."+tname);
			rs=ps.executeQuery();
			TableDto dto;
			while(rs.next()) {
				dto=new TableDto();
				dto.setField(rs.getString("Field"));
				char[] c= rs.getString("Type").toCharArray();
				String sum="",y="";
				for(char x : c) {
					if(Character.isDigit(x)) {
						sum=sum+x;
					} else if(Character.isLetter(x)) {
						y=y+x;
					}
				}
				dto.setType(y);
				dto.setRange(Integer.parseInt(sum));
				list.add(dto);
			}
		} catch(Exception e) {
			System.out.println("Exception in descTable :"+e);
		} finally {
			ps=null;
			rs=null;
			con=null;
			return list;
		}
	}
	
	@SuppressWarnings("finally")
	public ArrayList<String> showTables(String dbname) {
		ArrayList<String> list = new ArrayList<>();
		try {
			if(con==null) {
				con=DbmsData.getConnection();
			}
			PreparedStatement db = con.prepareStatement("use "+dbname);
			if(db.executeUpdate()==0) {
				ps=con.prepareStatement("show tables");
				rs=ps.executeQuery();
				while(rs.next()) {
					list.add(rs.getString(1));
				}
			}	
		} catch(Exception e) {
			System.out.println("Exception in show Tables : "+e);
		} finally {
			rs=null;
			ps=null;
			con=null;
			return list;
		}
	}

	@SuppressWarnings("finally")
	public ArrayList<ArrayList> selectTable(String dbname,String tname) {
		ArrayList<ArrayList> list = new ArrayList<>();
		try {
			if(con==null) {
				con=DbmsData.getConnection();
			}
			ps=con.prepareStatement("desc "+dbname+"."+tname);
			rs=ps.executeQuery();
			int rowcount = 0;
			if (rs.last()) {
				rowcount = rs.getRow();
				rs.beforeFirst();
			}
			String arr[][]=new String[rowcount][2];
			int j=0;
			while (rs.next()) {
				for(int i=0;i<2;i++) {
					arr[j][i]=rs.getString(i+1);
				}
				j++;
			}
			rs=null;
			ps=null;
			ps=con.prepareStatement("select * from "+dbname+"."+tname);
			rs=ps.executeQuery();
			
			while(rs.next()) {
				ArrayList data3=new ArrayList();
				for(int i=0;i<rowcount;i++) {
					if(arr[i][1].substring(0, 3).equals("var")) {
						data3.add(rs.getString(i+1));
					}
					else if(arr[i][1].substring(0, 3).equals("int")) {
						data3.add(rs.getInt(i+1));
					}
					else if(arr[i][1].substring(0, 3).equals("flo")) {
						data3.add(rs.getFloat(i+1));
					}
				}
				list.add(data3);
			}
		} catch(Exception e) {
			System.out.println("Exception in Select Tables : "+e);
		} finally {
			rs=null;
			ps=null;
			con=null;
			return list;
		}
	}
	
	@SuppressWarnings("finally")
	public boolean createTable(String dbname,String tname,ArrayList<TableDto> list) {
		boolean flag=false;
		try {
			if(con==null) {
				con=DbmsData.getConnection();
			}
			int i=1;
			String query="create table "+dbname+"."+tname+"(";
			for(TableDto dto : list) {
				query=query+" "+dto.getField()+" "+dto.getType()+"("+dto.getRange()+")";
				if(i<list.size()) {
					query=query+",";
				}
				i++;
			}
			query=query+")";
			ps=con.prepareStatement(query);
			if(ps.executeUpdate()==0) {
				flag=true;
			}
		} catch(Exception e) {
			System.out.println("Exception in create Tables : "+e);
		} finally {
			ps=null;
			con=null;
			return flag;
		}
	}
	
	@SuppressWarnings("finally")
	public boolean dropTable(String dbname,String tname) {
		boolean flag=false;
		try {
			if(con==null) {
				con=DbmsData.getConnection();
			}
			ps=con.prepareStatement("drop table "+dbname+"."+tname);
			if(ps.executeUpdate()==0) {
				flag=true;
			}
		} catch(Exception e) {
			System.out.println("Exception in drop Tables : "+e);
		} finally {
			ps=null;
			con=null;
			return flag;
		}
	}
	
	@SuppressWarnings("finally")
	public boolean addCol(String dbname,String tname,String colname,String dtype,String range) {
		boolean flag=false;
		try {
			if(con==null) {
				con=DbmsData.getConnection();	
			}
			String query="alter table "+dbname+"."+tname+" add "+colname+" "+dtype+"("+range+")";
			ps=con.prepareStatement(query);
			if(ps.executeUpdate()==0) {
				flag=true;
			}
		} catch(Exception e) {
			System.out.println("Exception in add columns : "+e);
		} finally {
			ps=null;
			con=null;
			return flag;
		}
	}
	
	@SuppressWarnings("finally")
	public boolean dropCol(String dbname,String tname,String colname) {
		boolean flag=false;
		try {
			if(con==null) {
				con=DbmsData.getConnection();	
			}
			String query="alter table "+dbname+"."+tname+" drop column "+colname;
			ps=con.prepareStatement(query);
			if(ps.executeUpdate()==0) {
				flag=true;
			}
		} catch(Exception e) {
			System.out.println("Exception in drop columns : "+e);
		} finally {
			ps=null;
			con=null;
			return flag;
		}
	}

	@SuppressWarnings("finally")
	public boolean modCol(String dbname,String tname,String colname,String dtype,String range) {
		boolean flag=false;
		try {
			if(con==null) {
				con=DbmsData.getConnection();
			}
			String query="alter table "+dbname+"."+tname+" modify column "+colname+" "+dtype+"("+range+")";
			ps=con.prepareStatement(query);
			if(ps.executeUpdate()==0) {
				flag=true;
			}
		} catch(Exception e) {
			System.out.println("Exception in modify columns : "+e);
		} finally {
			ps=null;
			con=null;
			return flag;
		}
	}
	
	public static void main(String[] args) {
		Table t=new Table();
		ArrayList<TableDto> list=t.descTable("E_Commerce","cart_master");
		for(TableDto l : list) {
			System.out.println(l.Field+" "+l.Type+" "+l.Range);
		}
		/*list.add("Class");
		list.add("Varchar");
		list.add("(20)");
		list.add(",");
		list.add("Roll");
		list.add("Int");
		list.add("(2)");*/
		//System.out.println(t.addCol("Sanjeet","Nitu",list));
		//2dArray
	}
}
