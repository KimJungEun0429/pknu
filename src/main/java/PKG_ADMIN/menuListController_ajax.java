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

import PKG_ADMIN_DAO.MenuListDAO;
import oracle.jdbc.OracleTypes;

@WebServlet("/Admin_MenuList_Ajax")
public class menuListController_ajax extends HttpServlet 
{
	@Override
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		Connection con = null;
		
		//권한리스트에 관련 데이터를 가져오자
		try {
			
			Class.forName("oracle.jdbc.driver.OracleDriver");
			con = DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521:xe", "mngauth", "1");
			
			String strProcName = "{call PKG_AD_MENUS.PROC_MENUS_SEL(?)}";
			CallableStatement csmt = con.prepareCall(strProcName);

			csmt.registerOutParameter(1, OracleTypes.CURSOR);
			
			csmt.execute();
			
			
			ResultSet rs = (ResultSet)csmt.getObject(1);  //MAINMENULIST
			
			/*
			String strXML = "";
			strXML += "<?xml version='1.0'?>";
			strXML += "<menus>";
			
			while(rs.next()) {
				strXML += "<menu>";
				strXML += "<menuid>" + rs.getString("MENUID") + "</menuid>";
				strXML += "<menuname>" + rs.getString("MENUNAME") + "</menuname>";
				strXML += "</menu>";
			}
			
			strXML += "</menus>";
			
			response.setContentType("text/xml");
		  */
			
			
			JSONObject Menus = new JSONObject();
			JSONArray MenuArr = new JSONArray();
			
			while(rs.next()) {
				
				JSONObject Menu = new JSONObject();
				Menu.put("MENUID", rs.getString("MENUID"));
				Menu.put("MENUNAME", rs.getString("MENUNAME"));
				
				MenuArr.add(Menu);
				
			}
			
			Menus.put("MENUS", MenuArr);
			
			response.setContentType("application/json");
			
			
			
			
		    PrintWriter writer = response.getWriter();
		    //writer.print(strXML);
		    writer.print(Menus.toJSONString());

			
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
