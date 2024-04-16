package shop.dao;

import java.sql.*;
import java.util.*;

public class addGoodsDAO {
	public static ArrayList<String> addGoods() throws Exception {
		ArrayList<String> categoryList = new ArrayList<String>();
		
		Connection conn = DBHelper.getConnection();
		String sql = "SELECT category FROM category";
		PreparedStatement stmt = conn.prepareStatement(sql); 
		
		ResultSet rs = stmt.executeQuery(); 
		
		while(rs.next()) {
			
			categoryList.add(rs.getString("category")); 
		}
		
		conn.close();
		return categoryList;
	}

}
