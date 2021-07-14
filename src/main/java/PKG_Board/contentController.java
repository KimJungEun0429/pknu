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

@WebServlet("/BoardContent")
public class contentController extends HttpServlet
{

	@Override
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		String idx = request.getParameter("idx");
		
		try {
			Class.forName("oracle.jdbc.driver.OracleDriver");
			Connection con = DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521:xe", "board", "1");
		
			String strProcName2 = "{call PKG_BOARD.PROC_BOARD_SEL(?,?,?)}";
			CallableStatement csmt2 = con.prepareCall(strProcName2);
			csmt2.setString(1, "LIST");
			csmt2.setString(2, idx);
			csmt2.registerOutParameter(3, OracleTypes.CURSOR);
			
			csmt2.execute();
			
			ResultSet rs = (ResultSet)csmt2.getObject(3);
			
			rs.next();
				
			listDAO list = new listDAO();
			list.setIdx(rs.getString("IDX"));
			list.setTitle(rs.getString("TITLE"));
			list.setContents(rs.getString("CONTENTS"));
			list.setBnum(rs.getString("BNUM"));
				

			con.close();
			con = null;
			
			request.setAttribute("content", list);
		
			
			request.getRequestDispatcher("/01_client/content.jsp").forward(request, response);
		
		} catch (ClassNotFoundException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		
	}
	
	@Override
	protected void doPost(HttpServletRequest requset, HttpServletResponse response) throws ServletException, IOException {
		
	}
	
}
