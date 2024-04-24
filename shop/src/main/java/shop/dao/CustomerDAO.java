package shop.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Set;

public class CustomerDAO {
	// HashMap<String, Object> : null이면 로그인 실패, 아니면 성공
	// String mail, String pw : 로그인폼에서 사용자가 입력한 mail/pw
	
	// 호출코드 HashMap<String, Object> m = customerDAO.customerLogin("guest1", "1234");
	public static HashMap<String, Object> customerLogin(String customerMail, String customerPw) throws Exception {
		// 초기화
		HashMap<String, Object> resultMap = null;
		
		// DB 접근
		Connection conn = DBHelper.getConnection(); 
		String sql = "select * from customer where mail =? and pw = password (?)";
		PreparedStatement stmt = conn.prepareStatement(sql); 
		stmt.setString(1,customerMail);
		stmt.setString(2,customerPw);  
		ResultSet rs = stmt.executeQuery();

		if(rs.next()) {
			resultMap = new HashMap<String, Object>();
			resultMap.put("customerMail", rs.getString("mail"));
			resultMap.put("customerPw", rs.getString("pw"));
			
		}
		
		conn.close();
		return resultMap;
	}
	
	// addCustomer-checkAction.jsp 메일중복확인
	public static int check(String checkMail)throws Exception {
		int row = 0;
		
		Connection conn = DBHelper.getConnection(); 
		String sql = "select mail from customer where mail = ?";
		PreparedStatement stmt = conn.prepareStatement(sql); 
		stmt.setString(1, checkMail);
		ResultSet rs = stmt.executeQuery();
		System.out.println(rs);
		
		if(rs.next()) {
			row = 1; // mail이 있으면 row=1
		}
		
		conn.close();
		return row;
	}
	
	// addCustomerAction.jsp
	public static int addCustomer(String mail, String pw, String name, String birth, String gender)throws Exception{
		int row = 0;
		
		Connection conn = DBHelper.getConnection();
		String sql = "insert into "
				+ "customer(mail, pw, name, birth, gender, update_date, create_date) "
				+ "values(?,password(?),?,?,?,now(),now())";
		PreparedStatement stmt = conn.prepareStatement(sql);
		System.out.println("addCustomerAction.jspDAO : " +stmt);
		
		stmt.setString(1, mail);
		stmt.setString(2, pw);
		stmt.setString(3, name);
		stmt.setString(4, birth);
		stmt.setString(5, gender);
		row = stmt.executeUpdate();	
		
		conn.close();
		return row;
	}

	// 회원정보상세페이지(customerOne)
	public static ArrayList<HashMap<String, Object>> customerOne(String oneMail) throws Exception {
		ArrayList<HashMap<String, Object>> list = new ArrayList<HashMap<String, Object>>();
		
		// DB 접근
		Connection conn = DBHelper.getConnection(); 
		String sql = "select mail, name, birth, gender from customer where mail =?";
		PreparedStatement stmt = conn.prepareStatement(sql); 
		stmt.setString(1, oneMail);
		ResultSet rs = stmt.executeQuery();
	
		while(rs.next()) {
			HashMap<String, Object> m = new HashMap<String, Object>();
			m.put("mail", rs.getString("mail"));
			m.put("name", rs.getString("name"));
			m.put("birth", rs.getString("birth"));
			m.put("gender", rs.getString("gender"));
			list.add(m);
				
		}
		
		conn.close();
		return list;
	}
	
	//updateCustomerAction.jsp
	public static int updateCustomer(String mail, String pw, String name, String gender) throws Exception {
			int row = 0;
			
			Connection conn = DBHelper.getConnection(); 
			String sql = "UPDATE customer SET pw = PASSWORD(?), name = ?, gender = ? where mail =?";
			
			PreparedStatement stmt = conn.prepareStatement(sql); 
			System.out.println(stmt);
			
			stmt.setString(1, pw);
			stmt.setString(2, name);
			stmt.setString(3, gender);
			stmt.setString(4, mail);
			row = stmt.executeUpdate();
			
			conn.close();
			return row;
	}
	
}
