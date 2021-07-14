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

@WebServlet("/Admin_DelMemberList")
public class memberDelController extends HttpServlet 
{

	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		
		doPost(req, resp);
	}
	 
	@Override
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		String[] strMemberIDs = request.getParameterValues("chk");
		
		try {
			Class.forName("oracle.jdbc.driver.OracleDriver");
			Connection con = DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521:xe", "mngauth", "1");
		
			String strProcName = "{call PKG_AD_MEMBER.PROC_MEMBER_DEL(?)}";
			
			CallableStatement csmt = con.prepareCall(strProcName);
			
			
			for(int i=0;i<strMemberIDs.length;i++) {
				
				csmt.setString(1, strMemberIDs[i]);
				
				csmt.execute();
				
			}
			
			con.close();
			con = null;
			
			response.sendRedirect("/ServBoard/Admin_MemList");
		
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
