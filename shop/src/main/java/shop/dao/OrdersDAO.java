package shop.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

public class OrdersDAO {
	// 고객주문추가DAO
	public static int customerOrder(String mail, int goodsNo, int totalAmount, int totalPrice, String address, String state) throws Exception {
		int row = 0;
		
		Connection conn = DBHelper.getConnection();
		/*
		 insert into orders(mail, goods_no, total_amount, total_price, address, state, update_date, create_date
		) values ('guest1', 1629, 5, 50000, 'KM타워', '주문완료',now(), NOW());
		 */
		String sql = "insert into"
				+ " orders(mail, goods_no, total_amount, total_price, address, state, update_date, create_date)"
				+ " values(?,?,?,?,?,?,now(),now())";
		PreparedStatement stmt = conn.prepareStatement(sql); 
		stmt.setString(1, mail);
		stmt.setInt(2, goodsNo); 
		stmt.setInt(3, totalAmount);
		stmt.setInt(4, totalPrice);
		stmt.setString(5, address);
		stmt.setString(6, state);
	
		row = stmt.executeUpdate();
		
		conn.close();
		return row;
	}
	
	
	
}
