<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>���Ѻ� �޴�</title>


<script type="text/javascript" src="../js/jquery-3.6.0.js"></script>
<script>

	$(document).ready(
	
			function(){
				setAuthList();
			}
			
	);
	

	var setAuthList = function(){
	
		var strHTML = "";
		
		var ajaxObj = {
				
				type:"post", 
				async:"true", 
				url:"/ServBoard/Admin_AuthList_AJAX", 
				data:"authname=''", 
				dataType:"xml",  
				success: function(data){
					
					strHTML += "<table border='1' width='90%' align='center'>";
					
					$(data).find("authList").each(
					
							function(){
								var authID = $(this).find("authID").text();
								var authName = $(this).find("authName").text();
								
								if(authID != ""){
								
									strHTML += "<tr onclick='javascript:setTopMenuList(&quot;" + authID + "&quot;)'>";
									strHTML += "<td width='30%' height='40px' align='center'>";
									strHTML += authID;
									strHTML += "</td>";
									strHTML += "<td width='70%' height='40px' align='center'>";
									strHTML += authName;
									strHTML += "</td>";
									strHTML += "</tr>";
								}
							}
					)
					
					
					strHTML += "</table>";
					
					$("#authList").html(strHTML);
					
				},
		  		error : function(xhr,status,error) {
		      		alert("err")
		  		},
		  		complete:function(data,textStatus) {
		  			
		  		}
	
			  }
		
		$.ajax(ajaxObj);
		
		
	}
	
	var setTopMenuList = function(selectedAuthID){
		//alert(selectedAuthID);
		
		var strHTML = "";
		
		var ajaxObj = {
				
				type:"post", 
				async:"true", 
				url:"/ServBoard/Admin_AuthTopMenuList", 
				data:"selectedAuthID=" + selectedAuthID, 
				dataType:"json",  
				success: function(data){
					
					strHTML += "<table border='1' width='90%' align='center'>";
					strHTML += "<tr>";
					strHTML += "	<td width='20%' height='30px' align='center'>�޴����̵�</td>";
					strHTML += "	<td width='30%' height='30px' align='center'>�޴��̸�</td>";
					strHTML += "	<td width='12%' height='30px' align='center'>�޴�����</td>";
					strHTML += "	<td width='8%' height='30px' align='center'>��ȸ</td>";
					strHTML += "	<td width='8%' height='30px' align='center'>����</td>";
					strHTML += "	<td width='8%' height='30px' align='center'>�߰�</td>";
					strHTML += "	<td width='8%' height='30px' align='center'>����</td>";
					strHTML += "</tr>";
					
					
						var topMenus = data["MENUS"];
						for(var topMenu of topMenus){
							
							var topMenuID = topMenu["MENUID"];
							var topMenuName = topMenu["MENUNAME"];
							var topMenuLvl = topMenu["MENULVL"];
							var authSel = topMenu["AUTH_SEL"];
							var authUp = topMenu["AUTH_UP"];
							var authIns = topMenu["AUTH_INS"];
							var authDel = topMenu["AUTH_DEL"];
							
							
							strHTML += "<tr >";
							strHTML += "	<td width='20%' height='30px' align='center' onclick='setSubMenusList(&quot;" + selectedAuthID + "&quot;,&quot;" + topMenuID + "&quot;)'>";
							strHTML += topMenuID;
							strHTML += "	</td>";
							strHTML += "	<td width='38%' height='30px' onclick='setSubMenusList(&quot;" + selectedAuthID + "&quot;,&quot;" + topMenuID + "&quot;)'>";
							strHTML += topMenuName;
							strHTML += "	</td>";
							strHTML += "	<td width='10%' height='30px' align='center' onclick='setSubMenusList(&quot;" + selectedAuthID + "&quot;,&quot;" + topMenuID + "&quot;)'>";
							strHTML += topMenuLvl;
							strHTML += "	</td>";
							strHTML += "	<td width='8%' height='30px' align='center'>";
							strHTML += "<input type='checkbox' id='top" + topMenuID + "Sel' onclick='chkSelClick(&quot;" + topMenuID + "&quot;, &quot;Sel&quot;, &quot;top&quot;)'";
							if(authSel == "Y") {strHTML += "checked";}
							strHTML += " />";
							strHTML += "	</td>";
							strHTML += "	<td width='8%' height='30px' align='center'>";
							strHTML += "<input type='checkbox' id='top" + topMenuID + "Up' ";
							if(authUp == "Y") {strHTML += "checked";}
							strHTML += " />";
							strHTML += "	</td>";
							strHTML += "	<td width='8%' height='30px' align='center'>";
							strHTML += "<input type='checkbox' id='top" + topMenuID + "Add' ";
							if(authIns == "Y") {strHTML += "checked";}
							strHTML += " />";
							strHTML += "	</td>";
							strHTML += "	<td width='8%' height='30px' align='center'>";
							strHTML += "<input type='checkbox' id='top" + topMenuID + "Del' ";
							if(authDel == "Y") {strHTML += "checked";}
							strHTML += " />";
							strHTML += "	</td>";
							strHTML += "</tr>";
							
						}
						
										
					strHTML += "</table>";
					
					$("#topMenuList").html(strHTML);
					
				},
		  		error : function(xhr,status,error) {
		      		alert("err")
		  		},
		  		complete:function(data,textStatus) {
		  			
		  		}
	
			  }
		
		$.ajax(ajaxObj);
		
		
	}		
		
	
	var chkSelClick = function(selectedMenuID, colName, gbn){
		
		var selectedChkID = gbn + selectedMenuID + colName;
		
		if(!$("#" + selectedChkID).prop("checked")){
			
			$( "input[id*='" + gbn + selectedMenuID + "']" ).prop("checked", false);
			
			var selectedSubMenuID = selectedMenuID + "Sel";
			var subChks = $( "input[id*='" + selectedSubMenuID + "']" );
			//alert(subChks.length);
			
			for(var subChk of subChks){
				subChk.click();
				
			}
			
			$("#" + selectedChkID).prop("checked", false);
		}
		else{
			
			var selectedSubMenuID = selectedMenuID + "Sel";
			var subChks = $( "input[id*='" + selectedSubMenuID + "']" );
			//alert(subChks.length);
			
			for(var subChk of subChks){
				subChk.checked = true;
				
			}
			
		}
		
	}

	
	
	var setSubMenusList = function(selectedAuthID, selectedMenuID){
		
		//alert(selectedAuthID + "-" + selectedMenuID);
		
		var strHTML = "";
		
		var ajaxObj = {
				
				type:"post", 
				async:"true", 
				url:"/ServBoard/Admin_AuthSubMenuList", 
				data:"selectedAuthID=" + selectedAuthID + "&selectedMenuID=" + selectedMenuID, 
				dataType:"json",  
				success: function(data){
					
					strHTML += "<table border='1' width='90%' align='center'>";
					strHTML += "<tr>";
					strHTML += "	<td width='20%' height='30px' align='center'>�޴����̵�</td>";
					strHTML += "	<td width='30%' height='30px' align='center'>�޴��̸�</td>";
					strHTML += "	<td width='12%' height='30px' align='center'>�޴�����</td>";
					strHTML += "	<td width='8%' height='30px' align='center'>��ȸ</td>";
					strHTML += "	<td width='8%' height='30px' align='center'>����</td>";
					strHTML += "	<td width='8%' height='30px' align='center'>�߰�</td>";
					strHTML += "	<td width='8%' height='30px' align='center'>����</td>";
					strHTML += "</tr>";
					
					
						var subMenus = data["MENUS"];
						for(var subMenu of subMenus){
							
							var subMenuID = subMenu["MENUID"];
							var subMenuName = subMenu["MENUNAME"];
							var subMenuLvl = subMenu["MENULVL"];
							var authSel = subMenu["AUTH_SEL"];
							var authUp = subMenu["AUTH_UP"];
							var authIns = subMenu["AUTH_INS"];
							var authDel = subMenu["AUTH_DEL"];
							var rootID = subMenu["ROOTID"];
							var parentID = subMenu["PARENTID"];
							
							
							strHTML += "<tr onclick=''>";
							strHTML += "	<td width='20%' height='30px' align='center'>";
							strHTML += subMenuID;
							strHTML += "	</td>";
							strHTML += "	<td width='38%' height='30px' style='padding-left:" + subMenuLvl * 30 + "px'>";
							strHTML += subMenuName;
							strHTML += "	</td>";
							strHTML += "	<td width='10%' height='30px' align='center'>";
							strHTML += subMenuLvl;
							strHTML += "	</td>";
							strHTML += "	<td width='8%' height='30px' align='center'>";
							strHTML += "<input type='checkbox' id='sub" + subMenuID + rootID + "Sel' onclick='chkSelClick(&quot;" + subMenuID + "&quot;, &quot;Sel&quot;, &quot;sub&quot;)'";
							if(authSel == "Y") {strHTML += "checked";}
							strHTML += " />";
							strHTML += "	</td>";
							strHTML += "	<td width='8%' height='30px' align='center'>";
							strHTML += "<input type='checkbox' id='sub" + subMenuID + rootID + "Up' ";
							if(authUp == "Y") {strHTML += "checked";}
							strHTML += " />";
							strHTML += "	</td>";
							strHTML += "	<td width='8%' height='30px' align='center'>";
							strHTML += "<input type='checkbox' id='sub" + subMenuID + rootID + "Add' ";
							if(authIns == "Y") {strHTML += "checked";}
							strHTML += " />";
							strHTML += "	</td>";
							strHTML += "	<td width='8%' height='30px' align='center'>";
							strHTML += "<input type='checkbox' id='sub" + subMenuID + rootID + "Del' ";
							if(authDel == "Y") {strHTML += "checked";}
							strHTML += " />";
							strHTML += "	</td>";
							strHTML += "</tr>";
							
						}
						
										
					strHTML += "</table>";
					
					$("#subMenuList").html(strHTML);
					
					
					

					
				},
		  		error : function(xhr,status,error) {
		      		alert("err")
		  		},
		  		complete:function(data,textStatus) {
		  			
		  		}
	
			  }
		
		$.ajax(ajaxObj);
		
		
	}

</script>


</head>
<body>
	
		<table border="1" width="100%" align="center" cellpadding="0" cellspacing="0">
		<tr>
			<td width="100%" height="70px" align="center">
				<!-- �޴����� ���̺� ���� -->
				<table border="1" width="80%" align="center" cellpadding="0" cellspacing="0">
					<tr>
						<td width="16%" height="40" align="center">
							<a href="/ServBoard/Admin_AuthList"><span>���Ѱ���</span></a>
						</td>
						<td width="16%" height="40" align="center" class="selectedMenu">
							<span>ȸ������</span>
						</td>
						<td width="16%" height="40" align="center">
							<a href="/ServBoard/Admin_MenuList"><span>�޴�����</span></a>
						</td>
						<td width="16%" height="40" align="center">
							<a href="/ServBoard/02_admin/program_list.jsp"><span>���α׷�����</span></a>
						</td>
						<td width="16%" height="40" align="center">
							<span>���Ѻ��󼼰���</span>
						</td>
					</tr>
				</table>
				<!-- �޴����� ���̺� �� -->
			</td>
		</tr>
		<tr>
			<td>
			
				<!-- ���Ѻ��� ���̾ƿ� ���� -->
				<table border="1" cellpadding="0" cellspacing="0" width="100%" align="center">
					<tr>
						<td width="20%" height="670px" align="center" rowspan="2" valign="top">
							<!-- ���Ѹ���Ʈ �������� -->
							<div id="authList"></div>
							<!-- ���Ѹ���Ʈ �������� -->
						</td>
						<td width="80%" height="200px" align="center">
							<!-- TopMenuList ���� -->
							<div id="topMenuList"></div>
							<!-- TopMenuList �� -->
						</td>
					</tr>
					<tr>
						<td width="80%" height="470px" align="center" valign="top">
							<!-- SubMenuList ���� -->
							<div id="subMenuList"></div>
							<!-- SubMenuList �� -->
						</td>
					</tr>
				</table>
				<!-- ���Ѻ��� ���̾ƿ� �� -->
			
			</td>
		</tr>
	</table>
	
</body>
</html>