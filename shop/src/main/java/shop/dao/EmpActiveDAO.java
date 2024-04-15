package shop.dao;

import java.sql.*;


public class EmpActiveDAO {
	public static int EmpActive(String active, String empId) throws Exception {
		
		Connection conn = DBHelper.getConnection();
		String sql = "update emp set active = ? where emp_id = ?";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setString(1,active);
		stmt.setString(2,empId);
		
		int row = 0;
		row = stmt.executeUpdate(); // 성공시 1반환
		
		conn.close();
		return row;
	}
}
