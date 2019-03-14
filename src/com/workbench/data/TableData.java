package com.workbench.data;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import com.workbench.data.TableDataDto;
import com.workbench.conn.DbmsData;

public class TableData {

	Connection con=null;
	ResultSet rs=null;
	PreparedStatement ps=null;

	@SuppressWarnings("finally")
	public boolean delData(String dbname,String tname, ArrayList<TableDataDto> list) {
		boolean flag=false;
		try {
			if(con==null) {
				//DbmsData.createConn();
				con=DbmsData.getConnection();
			}
			int j=0;
			String query="delete from "+dbname+"."+tname+" where ";
			for(TableDataDto dto : list) {
					query=query+dto.getField()+" = ?";
					j++;
					if(j<list.size()) {
						query=query+" and ";
					}
			}
			
			ps=con.prepareStatement(query);
			
			int i=1;
			for(TableDataDto dto : list) {
				if(dto.getType().equalsIgnoreCase("varchar")) {
					ps.setString(i, dto.getValue());
				} else if(dto.getType().equalsIgnoreCase("int")) {
					ps.setInt(i, Integer.parseInt(dto.getValue()));
				} else if(dto.getType().equalsIgnoreCase("float")) {
					ps.setFloat(i, Float.parseFloat(dto.getValue()));
				}
				i++;
			}
			
			if(ps.executeUpdate()>=0) {
				flag=true;
			}
		} catch(Exception e) {
			System.out.println("Exception in del Data : "+e);
		} finally {
			ps=null;
			con=null;
			return flag;
		}
	}
	
	@SuppressWarnings("finally")
	public boolean insertData(String dbname,String tname, ArrayList<TableDataDto> list) {
		boolean flag=false;
		try {
			if(con==null) {
				//DbmsData.createConn();
				con=DbmsData.getConnection();
			}
			int j=0;
			String query="insert into "+dbname+"."+tname+"(";
			for(TableDataDto dto : list) {
					query=query+dto.getField();
					j++;
					if(j<list.size()) {
						query=query+",";
					}
			}
			query=query+") values (";
			for(int k=0;k<list.size()-1;k++) {
				query=query+"?,";
			}
			query=query+"?)";
			
			ps=con.prepareStatement(query);
			
			int i=1;
			for(TableDataDto dto : list) {
				if(dto.getType().equalsIgnoreCase("varchar")) {
					ps.setString(i, dto.getValue());
				} else if(dto.getType().equalsIgnoreCase("int")) {
					ps.setInt(i, Integer.parseInt(dto.getValue()));
				} else if(dto.getType().equalsIgnoreCase("float")) {
					ps.setFloat(i, Float.parseFloat(dto.getValue()));
				}
				i++;
			}
			
			if(ps.executeUpdate()>=0) {
				flag=true;
			}
		} catch(Exception e) {
			System.out.println("Exception in insert Data : "+e);
		} finally {
			ps=null;
			con=null;
			return flag;
		}
	}
	
	public static void main(String[] args) {
		ArrayList<TableDataDto> list=new ArrayList<>();
		TableDataDto dto=new TableDataDto();
		dto.setField("Name");
		dto.setValue("SanjeetAnand");
		dto.setType("varchar");
		list.add(dto);
		System.out.println(new TableData().insertData("Student", "StudentD", list));
	}
}
