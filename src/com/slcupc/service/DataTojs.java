package com.slcupc.service;

import java.sql.ResultSet;
import java.sql.SQLException;

import org.json.JSONArray;
import org.json.JSONException;
import org.json.JSONObject;

import com.slcupc.dao.PointDao;

public class DataTojs {
	
	/**
	 * 将ResultSet结果集转为JSONObject
	 */
	public static String getJson() throws SQLException, JSONException {
		//JSONObject json=null;
		String lsCity;
		JSONArray jsonMembers =new JSONArray();
		ResultSet rs=PointDao.getPoint();
		//rs=PointDao.getPoint();
		while(rs.next()) {
			JSONObject city1 = new JSONObject();
			//将每一条数据转换为一个json对象
			city1.put("ID", rs.getString(1));
			city1.put("city", rs.getString(2));
			city1.put("X", rs.getString(3));
			city1.put("Y", rs.getString(4));
			//将json对象添加到一个json数组中
			jsonMembers.put(city1);	
		}
		rs.close();
		lsCity=jsonMembers.toString();
		return lsCity;
	}
	public static String[] getAddress() throws JSONException, SQLException {
		ResultSet rs=PointDao.getAddress();
		String [] adds=new String[rs.getMetaData().getColumnCount()];
		while(rs.next()) {
			for(int i=0;i<rs.getMetaData().getColumnCount();i++) {
				adds[i]=rs.getString(2);
			}
		}
		rs.close();
		return adds;
	}
}
