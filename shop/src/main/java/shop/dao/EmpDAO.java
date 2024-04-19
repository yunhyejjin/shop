package shop.dao;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.HashMap;

// emp 테이블을 CRUD하는 STATIC 메서드의 컨테이너
public class EmpDAO {

	
	// HashMap<String, Object> : null이면 로그인 실패, 아니면 성공
	// String empId, String empPw : 로그인폼에서 사용자가 입력한 id/pw
	
	// 호출코드 HashMap<String, Object> m = EmpDAO.empLogin("admin", "1234");
	public static HashMap<String, Object> empLogin(String empId, String empPw) throws Exception {
		// 초기화
		HashMap<String, Object> resultMap = null;
		
		// DB 접근
		Connection conn = DBHelper.getConnection(); 
		String sql = "select emp_id empId, emp_name empName, grade from emp where active='ON' and emp_id =? and emp_pw = password (?)";
		PreparedStatement stmt = conn.prepareStatement(sql); 
		stmt.setString(1,empId);
		stmt.setString(2,empPw);  
		ResultSet rs = stmt.executeQuery();

		if(rs.next()) {
			resultMap = new HashMap<String, Object>();
			resultMap.put("empId", rs.getString("empId"));
			resultMap.put("empName", rs.getString("empName"));
			resultMap.put("grade", rs.getInt("grade"));
			
		}
		conn.close();
		return resultMap;
	}

}
