package PKG_Board;

import java.io.IOException;
import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import PKG_DAO.listDAO;
import oracle.jdbc.OracleTypes;

@WebServlet("/BoardInsert")
public class InsertController extends HttpServlet 
{

	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		
	}
	
	@Override
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		String strTitle = request.getParameter("title");
		String strContent = request.getParameter("content");
		
		//DB연결
		
		//1.Connection
		try {
			
			Class.forName("oracle.jdbc.driver.OracleDriver");
			Connection con = DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521:xe", "board", "1");
			
			String strProcName = "{call PKG_BOARD.PROC_BOARD_INS(?,?,?,?)}";
			
			CallableStatement csmt = con.prepareCall(strProcName);
			csmt.setString(1, strTitle);
			csmt.setString(2, strContent);
			csmt.setString(3, "MEM001");
			csmt.setString(4, "M001");
			
			csmt.execute();
			
			String strProcName2 = "{call PKG_BOARD.PROC_BOARD_SEL(?,?,?)}";
			CallableStatement csmt2 = con.prepareCall(strProcName2);
			csmt2.setString(1, "LIST");
			csmt2.setString(2, "");
			csmt2.registerOutParameter(3, OracleTypes.CURSOR);
			
			csmt2.execute();
			
			ResultSet rs = (ResultSet)csmt2.getObject(3);
			
			ArrayList<listDAO> arr = new ArrayList<listDAO>();
			ArrayList arr2 = new ArrayList();
			while(rs.next()){
				
				listDAO list = new listDAO();
				list.setIdx(rs.getString("IDX"));
				list.setTitle(rs.getString("TITLE"));
				list.setContents(rs.getString("CONTENTS"));
				list.setBnum(rs.getString("BNUM"));
				
				arr.add(list);
				arr2.add(list);
			}
			
			con.close();
			con = null;
			
			//System.out.println(rs.getString("TITLE"));
			
			request.setAttribute("list", arr);
			request.setAttribute("list2", arr2);
			
			//list data를 가져오자
			request.getRequestDispatcher("/01_client/list.jsp").forward(request, response);
			
		} 
		catch (ClassNotFoundException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
	}
	
}
