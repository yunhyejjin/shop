package shop.dao;

import java.sql.*;
import java.util.ArrayList;
import java.util.HashMap;

public class CategoryDAO {
	public static ArrayList<HashMap<String, Object>> categoryList() throws Exception{
		ArrayList<HashMap<String, Object>> categoryList =
				new ArrayList<HashMap<String, Object>>();
		
		Connection conn = DBHelper.getConnection();
		String sql = "select * from category";
		PreparedStatement stmt = conn.prepareStatement(sql);
		
		ResultSet rs = stmt.executeQuery(); 
		
		while(rs.next()) {
			HashMap<String, Object> m = new HashMap<>();
			m.put("category",rs.getString("category"));
			m.put("createdate",rs.getString("create_date"));
			categoryList.add(m); 
		}
		
		conn.close();	
		return categoryList;
	}
	
	// addCategoryAction.jsp
	public static int addCategory(String category)throws Exception {
		int row = 0;
		
		Connection conn = DBHelper.getConnection();	
		String sql = "insert into category(category) values(?)";
		PreparedStatement stmt = conn.prepareStatement(sql); 
		stmt.setString(1, category);
		row = stmt.executeUpdate();

		conn.close();
		return row;
	}
	
	// deleteCategoryAction.jsp
	public static int deleteCategory(String category) throws Exception {
		int row = 0;
		
		Connection conn = DBHelper.getConnection();	
		String sql = "DELETE FROM category WHERE category= ?";
		PreparedStatement stmt = conn.prepareStatement(sql); 
		stmt.setString(1, category);
		row = stmt.executeUpdate();	
		
		conn.close();
		return row;
	}

}
