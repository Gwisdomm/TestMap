package com.slcupc.dao;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

import com.slcupc.untity.JDBCConnection;

public class PointDao {
	static Connection  conn;
	public  static ResultSet getPoint() throws SQLException {
		conn=JDBCConnection.getConnection();
		Statement stmt=conn.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE);
		String sql="select *from point_table order by 1";
		ResultSet rs=stmt.executeQuery(sql);
		return rs;
	}
	public static ResultSet getAddress() throws SQLException {
	 conn=JDBCConnection.getConnection();
	 Statement stmt=conn.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE);
	 String sql="select  *from address order by 1";
	 ResultSet rs=stmt.executeQuery(sql);
	 return rs;
	}
}
