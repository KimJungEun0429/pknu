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
import PKG_ADMIN_DAO.MemberListDAO;
import PKG_ADMIN_DAO.MenuListDAO;
import oracle.jdbc.OracleTypes;

@WebServlet("/Admin_MenuList")
public class menuListController extends HttpServlet 
{
	@Override
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		
		String strMainMenuName = request.getParameter("mainMenuName");
		
		
		Connection con = null;
		
		//권한리스트에 관련 데이터를 가져오자
		try {
			
			Class.forName("oracle.jdbc.driver.OracleDriver");
			con = DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521:xe", "mngauth", "1");
			
			String strProcName = "{call PKG_AD_MENUS.PROC_MAINMENUS_SEL(?,?,?,?,?)}";
			CallableStatement csmt = con.prepareCall(strProcName);
			csmt.setString(1, "");
			csmt.setString(2, strMainMenuName);
			csmt.setString(3, "");
			csmt.registerOutParameter(4, OracleTypes.CURSOR);
			csmt.registerOutParameter(5, OracleTypes.CURSOR);
			
			csmt.execute();
			
			
			ResultSet rs = (ResultSet)csmt.getObject(4);  //MAINMENULIST
			
			
			
			ArrayList<MenuListDAO> maimMenuList = new ArrayList<MenuListDAO>();
			
			
			while(rs.next()) {
				
				
				MenuListDAO mainMenu = new MenuListDAO();
				
				mainMenu.setMenuID(rs.getString("MENUID"));
				mainMenu.setMenuName(rs.getString("MENUNAME"));
				mainMenu.setMenuSeq(rs.getString("MENUSEQ"));
				mainMenu.setMenuLvl(rs.getString("MENULVL"));
				
				maimMenuList.add(mainMenu);
			}
			
		
			
			request.setAttribute("maimMenuList", maimMenuList);
			request.getRequestDispatcher("/02_admin/menu_list.jsp").forward(request, response);
			
			
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
