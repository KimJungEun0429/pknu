package PKG_ADMIN;

import java.io.IOException;
import java.io.PrintWriter;
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

import org.json.simple.JSONArray;
import org.json.simple.JSONObject;

import PKG_ADMIN_DAO.AuthListDAO;
import PKG_ADMIN_DAO.MemberListDAO;
import PKG_ADMIN_DAO.MenuListDAO;
import oracle.jdbc.OracleTypes;

@WebServlet("/Admin_MenuList_Combo")
public class menuListController_Combo extends HttpServlet 
{
	@Override
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		
		String strMainMenuName = request.getParameter("mainMenuName");
		
		
		Connection con = null;
		
		//권한리스트에 관련 데이터를 가져오자
		try {
			
			Class.forName("oracle.jdbc.driver.OracleDriver");
			con = DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521:xe", "mngauth", "1");
			
			String strProcName = "{call PKG_AD_MENUS.PROC_MENUS_SEL(?)}";
			CallableStatement csmt = con.prepareCall(strProcName);
			csmt.registerOutParameter(1, OracleTypes.CURSOR);
			
			csmt.execute();
			
			
			ResultSet rs = (ResultSet)csmt.getObject(1);  //MENULIST
			
			
			
			JSONObject menus = new JSONObject();
			JSONArray menuArr = new JSONArray();
			
			
			while(rs.next()) {
				
				
				JSONObject menu = new JSONObject();
				menu.put("MENUID", rs.getString("MENUID"));
				menu.put("MENUNAME", rs.getString("MENUNAME"));

				menuArr.add(menu);
			}
			
			menus.put("MENUS", menuArr);
		
			response.setContentType("application/json");
			
		    PrintWriter writer = response.getWriter();
		    //writer.print(strXML);
		    writer.print(menus.toJSONString());

			
			
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
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		doGet(req, resp);
	}
}
