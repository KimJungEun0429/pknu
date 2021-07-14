package PKG_Client;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.json.simple.JSONArray;
import org.json.simple.JSONObject;

import oracle.jdbc.OracleTypes;

@WebServlet("/Client_MainMenuList")
public class mainMenuListController extends HttpServlet
{
	
	@Override
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		Connection con = null;
		
		try {
		
			Class.forName("oracle.jdbc.driver.OracleDriver");
			con = DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521:xe", "mngauth", "1");
			
			String strProcName = "{call PKG_CL_MAINMENU.PROC_MAINMENU_SEL(?)}";
			CallableStatement csmt = con.prepareCall(strProcName);
			csmt.registerOutParameter(1, OracleTypes.CURSOR);
			
			csmt.execute();
			
			
			ResultSet rs = (ResultSet)csmt.getObject(1);  //MAINMENULIST
			
			
			//JSON DATA로 만들자
			
			JSONObject mainmenus = new JSONObject();
			JSONArray mainmenuArr = new JSONArray();
			
			while(rs.next()) {
				
				System.out.println(rs.getString("MENUID"));
				
				JSONObject mRow = new JSONObject();
				mRow.put("MENUID", rs.getString("MENUID"));
				mRow.put("MENUNAME", rs.getString("MENUNAME"));

				
				mainmenuArr.add(mRow);
			}
			
			mainmenus.put("MAINMENULIST", mainmenuArr);
			
			
			response.setContentType("application/json");
			
		    PrintWriter writer = response.getWriter();
		    
		    writer.print(mainmenus.toJSONString());
		
		
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
