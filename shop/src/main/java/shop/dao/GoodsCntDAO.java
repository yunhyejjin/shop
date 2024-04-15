package shop.dao;

import java.sql.*;
import java.util.*;

public class GoodsCntDAO {
	public static ArrayList<HashMap<String, Object>> CategoryList(
			String category, int cnt)throws Exception {
		ArrayList<HashMap<String, Object>> totalList =
				new ArrayList<HashMap<String, Object>>();
		
		Connection conn = DBHelper.getConnection();
		String sql = "select category, COUNT(*) cnt FROM goods GROUP BY category ORDER BY category asc;";
		PreparedStatement stmt = conn.prepareStatement(sql); 
		ResultSet rs = stmt.executeQuery();
		
		while(rs.next()) {
			HashMap<String,Object> m = new HashMap<String,Object>(); 
			m.put("category", rs.getString("category")); // HashMap(key, value)
			m.put("cnt", rs.getInt("cnt"));
			totalList.add(m); // 
		}
		
		conn.close();
		return totalList;
		
	}

}
