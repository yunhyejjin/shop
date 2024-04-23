package shop.dao;

import java.sql.*;
import java.util.*;

public class GoodsDAO {
	// 카테고리별 출력문
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
	
	//전체 출력문
	public static ArrayList<HashMap<String, Object>> TotalList()throws Exception {
		ArrayList<HashMap<String, Object>> TotalList =
				new ArrayList<HashMap<String, Object>>();
		
		Connection conn = DBHelper.getConnection();
		String sql = "select category, COUNT(*) cnt FROM goods GROUP BY category ORDER BY category asc;";
		PreparedStatement stmt = conn.prepareStatement(sql); 
		ResultSet rs = stmt.executeQuery();
		
		while(rs.next()) {
			HashMap<String,Object> m = new HashMap<String,Object>(); 
			m.put("category", rs.getString("category")); // HashMap(key, value)
			m.put("cnt", rs.getInt("cnt"));
			TotalList.add(m); // 
		}
		
		conn.close();
		return TotalList;
	}
	
	//카테고리별 페이징 출력문
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
	
	// addGoodsAction.jsp
	public static int addGoodsAction(String category, String empId, String goodsTitle, String fileName, 
			String goodsContent, int goodsAmount, int goodsPrice) throws Exception {
		
		int row = 0;
		
		Connection conn = DBHelper.getConnection();	
		String sql = "insert into goods(category, emp_id, goods_title, filename, goods_content, goods_amount, goods_price, update_date, create_date)"
				+ " values(?, ?, ?, ?, ?, ?, ?, now(), now())";
		PreparedStatement stmt = conn.prepareStatement(sql); 
		stmt.setString(1, category);
		stmt.setString(2, empId); //  Session 설정값
		stmt.setString(3, goodsTitle);
		stmt.setString(4, fileName);
		stmt.setString(5, goodsContent);
		stmt.setInt(6, goodsAmount);
		stmt.setInt(7, goodsPrice);
	
		row = stmt.executeUpdate();
		
		conn.close();
		return row;
		
	}
	
	// goodsOne.jsp 
	public static ArrayList<HashMap<String, Object>> goodsOne(int goodsNo) throws Exception {
		ArrayList<HashMap<String, Object>> list =
				new ArrayList<HashMap<String, Object>>();
		
		Connection conn = DBHelper.getConnection();	
		String sql = "select * FROM goods where goods_no = ? ";
		PreparedStatement stmt = conn.prepareStatement(sql); 
		stmt.setInt(1, goodsNo);
		
		ResultSet rs = stmt.executeQuery();
		
		while(rs.next()) {
			HashMap<String,Object> m = new HashMap<String,Object>(); 
			m.put("category", rs.getString("category")); // HashMap(key, value)
			m.put("goodsNo", rs.getInt("goods_no")); 
			m.put("fileName", rs.getString("filename"));
			m.put("goodsTitle", rs.getString("goods_title"));
			m.put("goodsContent", rs.getString("goods_content"));
			m.put("goodsAmount", rs.getInt("goods_amount"));
			m.put("goodsPrice", rs.getInt("goods_price"));
			
			list.add(m); 
		}
		
		conn.close();
		return list;
	}
	
	//deleteGoodsAction.jsp
	public static int deleteGoods(int goodsNo) throws Exception {
		int row = 0;
		
		Connection conn = DBHelper.getConnection();	
		String sql = "DELETE FROM goods WHERE goods_no= ?";
		PreparedStatement stmt = conn.prepareStatement(sql); 
		stmt.setInt(1, goodsNo);
		row = stmt.executeUpdate();	
		
		conn.close();
		return row;
	}
	
	//updateGoodsAction.jsp
	public static int updateGoods(int goodsNo, String goodsTitle, String fileName, int goodsPrice, String goodsContent)throws Exception {
		int row = 0;
		
		Connection conn = DBHelper.getConnection();	
		String sql = "update goods set goods_title=?, filename=?, goods_price=?, goods_content=?"
				+ " WHERE goods_no =?";
		PreparedStatement stmt = conn.prepareStatement(sql); 
		stmt.setString(1,goodsTitle);
		stmt.setString(2,fileName);
		stmt.setInt(3,goodsPrice);
		stmt.setString(4,goodsContent);
		stmt.setInt(5,goodsNo);
		row = stmt.executeUpdate();	
		
		conn.close();
		return row;	
		
	}	
}
