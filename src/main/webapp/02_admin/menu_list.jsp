<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
    
<%@ page import="java.util.ArrayList"%>
<%@ page import="PKG_ADMIN_DAO.*"%>     
    
    
    
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>Insert title here</title>
<style>

	body{
		margin:0px;
	}
	
	.txt{
		width:96%;
		height:40px;
		border-width:0px;
		text-align:center;
		font-size:16px;
	}
	
	.selectedMenu{
		background-color:#444444;
		color:#fefefe;
		font-weight:bolder;
	}
	
	#insertDiv{
	
		position:absolute;
		top:100px;
		left:200px;
		visibility:hidden;
		background-color:#ffffff;
	
	}
	
	#selMenuList{
		font-size:20px;
	}
</style>

	<script src="/ServBoard/js/jquery-3.6.0.js"></script>
	<script>
		
		$(document).ready(
			function(){
				
				make_SelectMenuList();
			}	
		);
		
		//var vStrHTML;
		var selectData;
		var make_SelectMenuList = function(){
			
			vStrHTML = "";
			
			var ajaxObj = {
					
					type:"post", 
					async:true, 
					url:"/ServBoard/Admin_MenuList_Ajax", 
					data:"", 
					dataType:"xml",  
					success: function(data){
						selectData = data;
						//alert(selectData);
						/*
						vStrHTML += "<select name='selMenuList' id='selMenuList'>";
						
						$(data).find("menu").each(
							function(){
								var menuid = $(this).find("menuid").text();
								var menuname =  $(this).find("menuname").text();
								
								if(menuid == menupid){
									vStrHTML += "<option value='" + menuid + "' selected>";
									vStrHTML += menuname;
									vStrHTML += "</option>";
								}
								else{
									vStrHTML += "<option value='" + menuid + "'>";
									vStrHTML += menuname;
									vStrHTML += "</option>";
								}
							}		
						);
						
						vStrHTML += "</select>";
						*/
					},
			  		error : function(xhr,status,error) {
			      		alert("err")
			  		},
			  		complete:function(data,textStatus) {
			  				
			  		}

				  }
			
			$.ajax(ajaxObj);
		}
	
		var sMainMenuID = "";
	
		var showSubMenuList = function(selectedMainMenuID){
			
			
			location.href = "/ServBoard/Admin_MenuList?selectedMainMenuID=" + selectedMainMenuID;
			
		}
		
		var search = function(){
			
			
			var strMainMenuName = $("#mainMenuName").val();
			
			location.href = "/ServBoard/Admin_MenuList?mainMenuName=" + strMainMenuName;
			
		}
		
		
		var makeSelectHtml = function(menupid){
			var vStrHTML = "";
			
			vStrHTML += "<select name='selMenuList' id='selMenuList' onchange='chk_menu(this)'>";
			
			$(selectData).find("menu").each(
				function(){
					var menuid = $(this).find("menuid").text();
					var menuname =  $(this).find("menuname").text();
					
					if(menuid == menupid){
						vStrHTML += "<option value='" + menuid + "' selected>";
						vStrHTML += menuname;
						vStrHTML += "</option>";
					}
					else{
						vStrHTML += "<option value='" + menuid + "'>";
						vStrHTML += menuname;
						vStrHTML += "</option>";
					}
				}		
			);
			
			vStrHTML += "</select>";
			
			return vStrHTML;
		}
		
		var setSubMenuList = function(selectedMainMenuID,gbn){
 
			//make_SelectMenuList();
						
			//���θ޴��� Ŭ���Ҷ� mainmenuID�� ����
			sMainMenuID = selectedMainMenuID;
			//$("#hSubMenuName").val(selectedMainMenuID);
			
			var strSubMenuName = "";
			
			if(gbn == 2){
				strSubMenuName	= $("#subMenuName").val();
			}
			
			
			
			var strHTML = "";
			var ajaxObj = {
					
					type:"post", 
					async:true, 
					url:"/ServBoard/Admin_SubMenuList", 
					data:"selectedMainMenuID=" + selectedMainMenuID + "&subMenuName=" + strSubMenuName, 
					dataType:"xml",  
					success: function(data){
						
						
						
						
						$(data).find("submenu").each(
								
							function(){
																
								var menuid = $(this).find("menuid").text();
								var menuname = $(this).find("menuname").text();
								var menuseq = $(this).find("menuseq").text();
								var menulvl = $(this).find("menulvl").text();
								var menupid = $(this).find("menupid").text();
								
							
								strHTML += "<tr>";
								strHTML += "	<td width='7%' height='40px' align='center'>";
								strHTML += "		<input type='checkbox' name='' value='' />";
								strHTML += "	</td>";
								strHTML += "	<td width='22%' height='40px' align='center'>";
								strHTML += 				menuid	
								strHTML += "	</td>";
								strHTML += "	<td width='34%' height='40px'>";
								strHTML += "      <input type='text' style='text-align:left' name='subMenuName' value='" + menuname + "' class='txt'/>";      		
								strHTML += "	</td>";
								strHTML += "	<td width='7%' height='40px' align='center'>";
								strHTML += "      <input type='text' name='subMenuSeq' value='" + menuseq + "' class='txt'/>";		
								strHTML += "	</td>";
								strHTML += "	<td width='7%' height='40px' align='center'>";
								strHTML += "      <input type='text' name='subMenuLvl' value='" + menulvl + "' class='txt'/>";	
								strHTML += "	</td>";
								strHTML += "	<td width='22%' height='40px' align='center'>";
								strHTML += "		<div id='sMenuID'>" + makeSelectHtml(menupid) + "</div>";
								strHTML += "	</td>";
								strHTML += "	<td width='1%' height='40px' align='center'>";
									
								strHTML += "	</td>";
								strHTML += "</tr>";
							}
								
						);
						$("#subMenuTbl tbody").html("");
						$("#subMenuTbl tbody").append(strHTML);
						
					},
			  		error : function(xhr,status,error) {
			      		alert("err")
			  		},
			  		complete:function(data,textStatus) {
			  			
			  		}

				  }
			
			$.ajax(ajaxObj);
			
			
		}
	
		
	var insertShow = function(){
		
		$("#insertDiv").attr("style", "visibility:visible");
		
	}
	
	var insertHidden = function(){
		$("#insertDiv").attr("style", "visibility:hidden");
	}
		
	var chg_BgColor = function(obj, bgcolor){
		
		$("#tbl").attr("style", "background-color:#ffffff");
		$(obj).attr("style", "background-color:" + bgcolor);
	}
	
	
	var subSearch = function(){
		//setSubMenuList($("#hSubMenuName").val(), 2);
		setSubMenuList(sMainMenuID,2);
		
	}
	
	
	var chk_menu = function(obj){
		
		//���缱�õ� ���� ��������
		var selectedMenuID = $(obj).val();
		
		//���õǸ� �ȵǴ� ���� ã�Ƽ� �ȵǸ� ���â�� �������
		
	}
	
	</script>

</head>

<%

	ArrayList<MenuListDAO> mainMenuList = (ArrayList<MenuListDAO>)request.getAttribute("maimMenuList");
	//ArrayList<MenuListDAO> subMenuList = (ArrayList<MenuListDAO>)request.getAttribute("subMenuList");

%>


<body>

	<table border="1" width="100%" align="center" cellpadding="0" cellspacing="0">
		<tr>
			<td width="100%" height="70px" align="center">
				<!-- �޴����� ���̺� ���� -->
				<table border="1" width="80%" align="center" cellpadding="0" cellspacing="0">
					
					<tr>
						<td width="16%" height="40" align="center" class="selectedMenu">
							<a href="/ServBoard/Admin_AuthList"><span>���Ѱ���</span></a>
						</td>
						<td width="16%" height="40" align="center">
							<a href="/ServBoard/Admin_MemList"><span>ȸ������</span></a>
						</td>
						<td width="16%" height="40" align="center">
							<span>�޴�����</span>
						</td>
						<td width="16%" height="40" align="center">
							<span>���α׷�����</span>
						</td>
						<td width="16%" height="40" align="center">
							<span>���Ѻ��󼼰���</span>
						</td>
					</tr>
				</table>
				<!-- �޴����� ���̺� �� -->
			</td>
		</tr>
	</table>
	
	<table border="1" width="100%" height="880px" align="center" cellpadding="0" cellspacing="0">
		<tr>
			<td width="40%" align="center" height="880px" valign="top">
				<table border="1" width="100%"  align="center" cellpadding="0" cellspacing="0" id="tbl">
				    <tr>
						<td width="39%" height="40" colspan="2">
							<input type="text" name="mainMenuName" id="mainMenuName"/>
							<input type="button" value="��ȸ" onclick="search()"/>
						</td>
						<td width="61%" height="40" colspan="4" align="right">
							<input type="button" value="�߰�" onclick="insertShow();"/>
							<input type="button" value="����" />
							<input type="button" value="����" />
						</td>
					</tr>
					<tr>
						<td width="10%" height="40px" align="center">
							<input type="checkbox" name="" value="" />
						</td>
						<td width="29%" height="40px" align="center">
							�޴����̵�
						</td>
						<td width="40%" height="40px" align="center">
							�޴���
						</td>
						<td width="10%" height="40px" align="center">
							����
						</td>
						<td width="10%" height="40px" align="center">
							����
						</td>
						<td width="1%" height="40px" align="center">
						
						</td>
					</tr>
					
					<%
						for(MenuListDAO mainMenu : mainMenuList)
						{
					%>
					<tr onclick="setSubMenuList('<%=mainMenu.getMenuID() %>',1);chg_BgColor(this, '#eeeeee');"
						 
					>
						<td width="10%" height="40px" align="center">
							<input type="checkbox" name="" value="" />
						</td>
						<td width="29%" height="40px" align="center">
							<%=mainMenu.getMenuID() %>
						</td>
						<td width="40%" height="40px" >
							<input type="text" name="mainMenuNames" value="<%=mainMenu.getMenuName() %>" class="txt"/>
						</td>
						<td width="10%" height="40px" align="center">
							<input type="text" name="mainMenuNames" value="<%=mainMenu.getMenuSeq() %>" class="txt"/>
						</td>
						<td width="10%" height="40px" align="center">
							<%=mainMenu.getMenuLvl() %>
						</td>
						<td width="1%" height="40px" align="center">
						
						</td>
					</tr>
					
					<%
						}
					%>
					
				</table>
				<input type="hidden" id="searchValue" />
			</td>
			<td width="60%" align="center" valign="top">
				<!-- ����޴� ���̺� ���� -->
				<table border="1" width="100%"  align="center" cellpadding="0" cellspacing="0" >
					 <tr>
						<td width="29%" height="40" colspan="2">
							<input type="text" name="subMenuName" id="subMenuName"/>
							<input type="button" value="��ȸ" onclick="subSearch()"/>
						</td>
						<td width="71%" height="40" colspan="4" align="right">
							<input type="button" value="�߰�" onclick="subInsertShow();"/>
							<input type="button" value="����" />
							<input type="button" value="����" />
						</td>
					</tr>
					<tr>
						<td width="7%" height="40px" align="center">
							<input type="checkbox" name="" value="" />
						</td>
						<td width="22%" height="40px" align="center">
							�޴����̵�
						</td>
						<td width="34%" height="40px" align="center">
							�޴���
						</td>
						<td width="7%" height="40px" align="center">
							����
						</td>
						<td width="7%" height="40px" align="center">
							����
						</td>
						<td width="22%" height="40px" align="center">
							�θ���̵�
						</td>
						<td width="1%" height="40px" align="center">
						
						</td>
					</tr>
				
				
					
				</table>
				<table border="1" width="100%"  align="center" cellpadding="0" cellspacing="0" id="subMenuTbl">
					<tr>
						<td width="7%" height="0px" align="center">
						
						</td>
						<td width="22%" height="0px" align="center">
						
						</td>
						<td width="34%" height="0px" align="center">
							
						</td>
						<td width="7%" height="0px" align="center">
							
						</td>
						<td width="7%" height="0px" align="center">
							
						</td>
						<td width="22%" height="0px" align="center">
							
						</td>
						<td width="1%" height="0px" align="center">
						
						</td>
					</tr>
				</table>
				<!-- ����޴� ���̺� �� -->
			
			</td>
		</tr>
	</table>
	
	
	<div id="insertDiv">
		<form name="insertForm" action="/ServBoard/Admin_InsMainMenu">
		<table border="1" cellpadding="0" cellspacing="0" width="350px" align="center">
			<tr>
				<td width="300px" height="40px" align="center" colspan="2">
					�ָ޴� ����
				</td>
				<td width="50px" height="40px" align="center" onclick="insertHidden()">
					X
				</td>
			</tr>
			<tr>
				<td width="100px" height="40px" align="center">
					�޴����̵�
				</td>
				<td width="250px" height="40px" align="center" colspan="2">
					�ڵ�����
				</td>
			</tr>
			<tr>
				<td width="100px" height="40px" align="center">
					�޴���
				</td>
				<td width="250px" height="40px" align="center" colspan="2">
					<input type="text" name="insMenuName" id="insMenuName" class="txt" />
				</td>
			</tr>
			<tr>
				<td width="100px" height="40px" align="center">
					�޴�SEQ
				</td>
				<td width="250px" height="40px" align="center" colspan="2">
					<input type="text" name="insMenuSeq" id="insMenuSeq" class="txt" />
				</td>
			</tr>
			<tr>
				<td width="100px" height="40px" align="center">
					�޴�LVL
				</td>
				<td width="250px" height="40px" align="center" colspan="2">
					1
				</td>
			</tr>
			<tr>
				<td width="350px" height="40px" align="center" colspan="3">
					<input type="submit" value="�߰��ϱ�" />
				</td>
			</tr>
		</table>	
		</form>
	</div>
	<input type="hidden" name="hSubMenuName" id="hSubMenuName" />
</body>
</html>