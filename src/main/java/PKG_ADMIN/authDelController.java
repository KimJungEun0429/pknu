package PKG_ADMIN;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/Admin_DelAuthList")
public class authDelController extends HttpServlet 
{

	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		
		doPost(req, resp);
	}
	
	@Override
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		String[] strCHKs = request.getParameterValues("chk");
		String[] strAuthIDs = request.getParameterValues("authid");
		

		for(String strCHK : strCHKs) {
			//System.out.println(a);
			
			
		}
	}
}
