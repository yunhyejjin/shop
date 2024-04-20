package shop.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.util.HashMap;

public class addGoodsActionDAO {
	public static int addGoodsAction(String category, String empId, String goodsTitle, String filename, 
			String goodsContent, int goodsAmount, int goodsPrice) throws Exception {
		
		int row = 0;
		
		Connection conn = DBHelper.getConnection();	
		String sql = "insert into goods(category, emp_id, goods_title, filename, goods_content, goods_amount, goods_price, update_date, create_date)"
				+ " values(?, ?, ?, ?, ?, ?, ?, now(), now())";
		PreparedStatement stmt = conn.prepareStatement(sql); 
		stmt.setString(1, category);
		stmt.setString(2, empId); //  Session 설정값
		stmt.setString(3, goodsTitle);
		stmt.setString(4, filename);
		stmt.setString(5, goodsContent);
		stmt.setInt(6, goodsAmount);
		stmt.setInt(7, goodsPrice);
	
		row = stmt.executeUpdate();
		
		conn.close();
		return row;
		
	}

}
