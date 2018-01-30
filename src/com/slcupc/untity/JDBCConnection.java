package com.slcupc.untity;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class JDBCConnection {
	public static Connection getConnection() {
		Connection conn = null;
		try {
			// ��������
			Class.forName("com.mysql.jdbc.Driver");
			// �����ַ���
			String url = "jdbc:mysql://localhost:3306/test?useSSL=false";
			// �û���
			String username = "root";
			// 
			String password = "123456789";
			conn = DriverManager.getConnection(url, username, password);

		} catch (ClassNotFoundException e) {
			e.printStackTrace();
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return conn;
	}
}
