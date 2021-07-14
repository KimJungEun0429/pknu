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

@WebServlet("/Admin_ModAuthList")
public class authModController extends HttpServlet 
{
	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		
		doGet(req, resp);
	}
	
	@Override
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		request.setCharacterEncoding("UTF-8");
		
		String[] strAuthIDs = request.getParameterValues("authid");
		String[] strAuthNames = request.getParameterValues("authname");
		String[] strGBN = request.getParameterValues("gbn");
		
		
		try {
			Class.forName("oracle.jdbc.driver.OracleDriver");
			Connection con = DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521:xe", "mngauth", "1");
		
			String strProcName = "{call PKG_AD_AUTH.PROC_AUTH_MOD(?,?,?)}";
			
			CallableStatement csmt = con.prepareCall(strProcName);
			
			
			for(int i=0;i<strGBN.length;i++) {
				
				csmt.setString(1, strAuthIDs[i]);
				csmt.setString(2, strAuthNames[i]);
				csmt.setString(3, strGBN[i]);
				
				csmt.execute();
				
			}
			
			con.close();
			con = null;
			
			response.sendRedirect("/ServBoard/Admin_AuthList");
		
		} catch (ClassNotFoundException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		  catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		

		
		
		
		
	}
}
