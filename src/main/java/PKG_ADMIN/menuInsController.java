package PKG_ADMIN;

import java.io.IOException;
import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/Admin_InsMainMenu")
public class menuInsController extends HttpServlet 
{

	@Override
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		String strMenuName = request.getParameter("insMenuName");
		String strMenuSeq = request.getParameter("insMenuSeq");
		
		try {
			Class.forName("oracle.jdbc.driver.OracleDriver");
			Connection con = DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521:xe", "mngauth", "1");
		
			String strProcName = "{call PKG_AD_MENUS.PROC_MAINMENUS_INS(?,?)}";
			
			CallableStatement csmt = con.prepareCall(strProcName);
			
			csmt.setString(1, strMenuName);
			csmt.setString(2, strMenuSeq);

			csmt.execute();
			
			con.close();
			con = null;
			
			response.sendRedirect("/ServBoard/Admin_MenuList");
		
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
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		doPost(req, resp);
	}
	
}
