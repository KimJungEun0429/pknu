package PKG_ADMIN;

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

import PKG_ADMIN_DAO.AuthListDAO;
import oracle.jdbc.OracleTypes;
import java.io.PrintWriter;

@WebServlet("/Admin_NewAuthID")
public class authNewIDController extends HttpServlet 
{
	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		
		doPost(req, resp);
	}
	
	@Override
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		Connection con = null;
		
		//권한리스트에 관련 데이터를 가져오자
		try {
			
			Class.forName("oracle.jdbc.driver.OracleDriver");
			con = DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521:xe", "mngauth", "1");
			
			String strProcName = "{call PKG_AD_AUTH.PROC_AUTH_NEWID(?)}";
			CallableStatement csmt = con.prepareCall(strProcName);
			csmt.registerOutParameter(1, OracleTypes.CURSOR);
			
			csmt.execute();
			
			ResultSet rs = (ResultSet)csmt.getObject(1);
			
			rs.next();
			
			String strXML = "<?xml version='1.0'?>";
			strXML += "<authNewID>" + rs.getString("AUTHID")+ "</authNewID>"; 
			
			response.setContentType("text/xml");
		   	
		    PrintWriter writer = response.getWriter();
		    writer.print(strXML);
			
			
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
