package shop.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.HashMap;

public class customerDAO {

	
	// HashMap<String, Object> : null이면 로그인 실패, 아니면 성공
	// String mail, String pw : 로그인폼에서 사용자가 입력한 mail/pw
	
	// 호출코드 HashMap<String, Object> m = customerDAO.customerLogin("guest1", "1234");
	public static HashMap<String, Object> customerLogin(String mail, String pw) throws Exception {
		// 초기화
		HashMap<String, Object> resultMap = null;
		
		// DB 접근
		Connection conn = DBHelper.getConnection(); 
		String sql = "select mail, pw, name from customer where mail =? and pw = password (?)";
		PreparedStatement stmt = conn.prepareStatement(sql); 
		stmt.setString(1,mail);
		stmt.setString(2,pw);  
		ResultSet rs = stmt.executeQuery();

		if(rs.next()) {
			resultMap = new HashMap<String, Object>();
			resultMap.put("mail", rs.getString("mail"));
			resultMap.put("pw", rs.getString("pw"));
			resultMap.put("name", rs.getInt("name"));
			
		}
		conn.close();
		return resultMap;
	}

}
