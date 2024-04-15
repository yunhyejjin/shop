package shop.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.HashMap;

//emp 테이블을 CRUD하는 STATIC 메서드의 컨테이너
public class EmpListDAO {
	
	public static ArrayList<HashMap<String, Object>> EmpList (
			int startRow, int rowPerPage)throws Exception {
		ArrayList<HashMap<String, Object>> list =
				new ArrayList<HashMap<String, Object>>();
		 
		Connection conn = DBHelper.getConnection();
		String sql = "select emp_id empId, grade, emp_name empName, emp_job empJob, hire_date hireDate, active from emp "
				+ "order by hire_date desc limit ?, ?";
		PreparedStatement stmt = conn.prepareStatement(sql); 
		stmt.setInt(1,startRow);
		stmt.setInt(2,rowPerPage);  
		
		ResultSet rs = stmt.executeQuery();
		while(rs.next()) {
			HashMap<String,Object> m = new HashMap<String,Object>();
			m.put("empId", rs.getString("empId"));
			m.put("grade", rs.getInt("grade"));
			m.put("empName", rs.getString("empName"));
			m.put("empJob", rs.getString("empJob"));
			m.put("hireDate", rs.getString("hireDate"));
			m.put("active", rs.getString("active"));
			
			list.add(m);
		}
		
		conn.close();
		
		return list;
	}
			

}
