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


@WebServlet("/Admin_ModMemberList")
public class memberModController extends HttpServlet 
{
	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		doPost(req, resp);
	}
	
	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		
		//req.setCharacterEncoding("UTF-8");
		
		String[] strMemberIDs = req.getParameterValues("authid");
		String[] strMemberNames = req.getParameterValues("authname"); 
		String[] strMemberAuthes = req.getParameterValues("auth");
		String[] strGBNs = req.getParameterValues("gbn");
		
		int dataNums = strMemberNames.length;
		
		Connection con;
		
		try {
			
			Class.forName("oracle.jdbc.driver.OracleDriver");
			con = DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521:xe", "mngauth", "1");
			
			String strProcName = "{call PKG_AD_MEMBER.PROC_MEMBER_MOD(?,?,?,?)}";
			
			CallableStatement csmt = con.prepareCall(strProcName);
			
			for(int i=0;i<dataNums;i++) {
				String strGBN = strGBNs[i];

				
				if(strGBN.equals("I")) {
					csmt.setString(1, "");
				}
				else {
					csmt.setString(1, strMemberIDs[i]);
				}
				
				csmt.setString(2, strMemberNames[i]);
				csmt.setString(3, strMemberAuthes[i]);
				csmt.setString(4, strGBNs[i]);
				
				System.out.println(strMemberAuthes[i]);
				
				csmt.execute();
				
			}
			
			con.close();
			con = null;
			
			
			
		} catch (ClassNotFoundException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	
		resp.sendRedirect("/ServBoard/Admin_MemList");
		
	}
}
