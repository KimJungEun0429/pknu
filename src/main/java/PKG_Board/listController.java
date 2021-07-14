package PKG_Board;

import java.io.IOException;
import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import PKG_DAO.MemberDAO;
import PKG_DAO.listDAO;
import oracle.jdbc.OracleTypes;

@WebServlet("/BoardList")
public class listController extends HttpServlet 
{

	@Override
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		Connection con;
		
		try {
			
			String strURL = request.getParameter("strURL");
			
			System.out.println(strURL);
			
			Class.forName("oracle.jdbc.driver.OracleDriver");
			con = DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521:xe", "board", "1");
		
			String strProcName2 = "{call PKG_BOARD.PROC_BOARD_SEL(?,?,?)}";
			CallableStatement csmt2 = con.prepareCall(strProcName2);
			csmt2.setString(1, "LIST");
			csmt2.setString(2, "");
			csmt2.registerOutParameter(3, OracleTypes.CURSOR);
			
			csmt2.execute();
			
			ResultSet rs = (ResultSet)csmt2.getObject(3);
			
			ArrayList<listDAO> arr = new ArrayList<listDAO>();
			ArrayList arr2 = new ArrayList();
			while(rs.next()){
				
				listDAO list = new listDAO();
				list.setIdx(rs.getString("IDX"));
				list.setTitle(rs.getString("TITLE"));
				list.setContents(rs.getString("CONTENTS"));
				list.setBnum(rs.getString("BNUM"));
				list.setAdmin(rs.getString("ADMIN"));
				arr.add(list);
				arr2.add(list);
			}
			
			Statement stmt = con.createStatement();
			
			String strSql = "SELECT MEMID, MEMNAME FROM MEMBERS";
			ResultSet rs3 = stmt.executeQuery(strSql);
			ArrayList<MemberDAO> arrMember = new ArrayList<MemberDAO>();
			
			
			while(rs3.next()) {
				MemberDAO member = new MemberDAO();
				member.setMemID(rs3.getString("MEMID"));
				member.setMemName(rs3.getString("MEMNAME"));
				
				arrMember.add(member);
			}
			
			
			con.close();
			con = null;
			
			//System.out.println(rs.getString("TITLE"));
			
			request.setAttribute("list", arr);
			request.setAttribute("list2", arr2);
			request.setAttribute("members", arrMember);
			
			request.getRequestDispatcher("/01_client/" + strURL).forward(request, response);
		
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
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);
	}
}
