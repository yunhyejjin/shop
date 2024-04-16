package shop.dao;

import java.sql.*;

public class GoodsPageDAO {
	public static int GoodsPage(String category) throws Exception {
		int totalRow = 0;
		
		Connection conn = DBHelper.getConnection();
		String sql = "select count(*) cnt from goods where category like ? ";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setString(1,"%"+category+"%");
		
		ResultSet rs = stmt.executeQuery();
		
		if(rs.next()) {
			totalRow = rs.getInt("cnt");
		}
		
		conn.close();
		return totalRow;
	}
	

}
