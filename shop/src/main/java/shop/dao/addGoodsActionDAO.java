package shop.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;

public class addGoodsActionDAO {
	public static int addGoodsAction(String category, String) throws Exception {
		int row = 0;
		
		Connection conn = DBHelper.getConnection();
		String sql = "insert into goods"
				+ "(category, emp_id, goods_title, filename, goods_content, goods_price, goods_amount, update_date, create_date)"
				+ "value(?,?,?,?,?,?,?,now(),now())";
		PreparedStatement stmt = conn.prepareStatement(sql); 
		stmt.setString(1, category);
		stmt.setString(2, (String) (loginMember.get("empId"))); //  Session 설정값
		stmt.setString(3, goodsTitle);
		stmt.setString(4, filename);
		stmt.setString(5, goodsContent);
		stmt.setString(6, goodsPrice);
		stmt.setString(7, goodsAmount);
		row = stmt.executeUpdate();
		
		return row;
		
	}

}
