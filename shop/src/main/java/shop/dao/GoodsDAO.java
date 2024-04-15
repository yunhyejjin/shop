package shop.dao;

import java.sql.*;
import java.util.*;

public class GoodsDAO {
	public static ArrayList<HashMap<String, Object>> GoodsList(
			String category, int startRow, int rowPerPage )throws Exception {
		ArrayList<HashMap<String, Object>> goodslist =
				new ArrayList<HashMap<String, Object>>();
		
		Connection conn = DBHelper.getConnection();
		String sql = "select * from goods where category like ? order by update_date desc limit ?, ?";
		PreparedStatement stmt = conn.prepareStatement(sql); 
		stmt.setString(1,"%"+category+"%");
		stmt.setInt(2,startRow);
		stmt.setInt(3,rowPerPage);  
		
		ResultSet rs = stmt.executeQuery();
		while(rs.next()) {
			HashMap<String,Object> m1 = new HashMap<String,Object>();
			m1.put("goodsNo", rs.getInt("goods_no"));
			m1.put("goodsTitle", rs.getString("goods_title"));
			m1.put("fileName", rs.getString("filename"));
			m1.put("goodsPrice", rs.getInt("goods_price"));
			
			goodslist.add(m1);
		}
		
		conn.close();	
		return goodslist;
	}
}
