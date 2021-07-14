package PKG_ADMIN;

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

@WebServlet("/Admin_ProgramList")
public class programListController extends HttpServlet 
{
	@Override
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		
		Connection con = null;
		
		try {
		
			Class.forName("oracle.jdbc.driver.OracleDriver");
			con = DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521:xe", "mngauth", "1");
			
			String strProcName = "{call PKG_AD_PROGRAM.PROC_PROGRAM_LIST(?,?)}";
			CallableStatement csmt = con.prepareCall(strProcName);
			csmt.setString(1, "");
			csmt.registerOutParameter(2, OracleTypes.CURSOR);
			
			csmt.execute();
			
			
			ResultSet rs = (ResultSet)csmt.getObject(2);  //MAINMENULIST
			
			
			//JSON DATA로 만들자
			
			JSONObject programs = new JSONObject();
			JSONArray programArr = new JSONArray();
			
			while(rs.next()) {
				
				System.out.println(rs.getString("PID"));
				
				JSONObject pRow = new JSONObject();
				pRow.put("PID", rs.getString("PID"));
				pRow.put("MENUID", rs.getString("MENUID"));
				pRow.put("PNAME", rs.getString("PNAME"));
				pRow.put("PURL", rs.getString("PURL"));
				pRow.put("PFILENAME", rs.getString("PFILENAME"));
				
				programArr.add(pRow);
			}
			
			programs.put("PROGRAMS", programArr);
			
			
			response.setContentType("application/json");
			
		    PrintWriter writer = response.getWriter();
		    
		    writer.print(programs.toJSONString());
		
		
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
