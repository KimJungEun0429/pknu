package PKG_ADMIN;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class programModController extends HttpServlet 
{
	
	@Override
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		String[] strChks = request.getParameterValues("chk");
		String[] strPnames = request.getParameterValues("pname");
		String[] strPurls = request.getParameterValues("purl");
		String[] strPmenuids = request.getParameterValues("pmenuid");
		String[] strPfilenames = request.getParameterValues("pfilename");
		
		String strCHK = "";
		for(int i = 0;i<strChks.length;i++) {
			
		}

	}
	
	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		
		doPost(req, resp);
	}
	
	
}
