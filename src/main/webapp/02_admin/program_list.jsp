<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>Insert title here</title>

	<style>
	
		#list_title span{
		
			display:block;
			height:40px;
			padding:4px 0px 0px 0px;
			font-size:20px;
			border:1px solid blue;
			float:left;
			text-align:center;
		}
		
		#list_content span{
		
			display:block;
			height:40px;
			padding:4px 0px 0px 0px;
			font-size:20px;
			border:1px solid blue;
			float:left;
			text-align:center;
		}
		
		
	
	</style>


	 <link rel="stylesheet" type="text/css" href="../css/easyui.css">
	 <script type="text/javascript" src="../js/jquery-3.6.0.js"></script>
     <script type="text/javascript" src="../js/jquery.easyui.min.js"></script>
     
     
     <script>
     
     var isAdd = false;
     var menuList = null; //
     var rowCount = 0;    //
     var selectedMenuID = [];
     
     $(document).ready(
    
    		function(){
    			
    			var ajaxObj = {
    					
    					type:"post", 
    					async:"true", 
    					url:"/ServBoard/Admin_MenuList_Combo", 
    					data:"", 
    					dataType:"json",  
    					success: function(data){
    						
    						menuList = data["MENUS"];
    						
    					},
    			  		error : function(xhr,status,error) {
    			      		alert("err")
    			  		},
    			  		complete:function(data,textStatus) {
    			  			
    			  		}

    				  }
    			
    			$.ajax(ajaxObj);    			
    		}
     
     );
     
     
 	var setProgramList = function(){
 		
 		
 		//콤보박스
 		var strHTML_Combo = "";
 		
 		strHTML_Combo += "<select name=''>";
 		for(var menu of menuList){
 			
 			strHTML_Combo += "<option value='"+ menu["MENUID"] + "' ++>" + menu["MENUNAME"] + "</option>";
 			
 		}
 		strHTML_Combo += "</select>";
 		
 		
		//var student = "{id:'aaa',name:'홍길동'}";
		//json.parse(); //string(text) json을 json object 형태로 변환
		//json.stringfy(); //json object 형태의 데이터를 text형태로 변환
		var strHTML = "";
		var ajaxObj = {
				
				type:"post", 
				async:"true", 
				url:"/ServBoard/Admin_ProgramList", 
				data:"name=1234", 
				dataType:"json",  
				success: function(data){
					
					
					
					var programs = data["PROGRAMS"];
					
					
					rowCount = programs.length;
					
					for(var i=0;i<programs.length;i++){
						
						var program = programs[i]
						
						var pid = program["PID"];
						var menuid = program["MENUID"];
						var pname = program["PNAME"];
						var purl = program["PURL"];
						var pfilename = program["PFILENAME"];
						
						selectedMenuID[i] = menuid;
					
						//콤보박스
				 		var strHTML_Combo = createCombo(menuid);
				 		
						/* 

						*/
						
					
						strHTML += '<div id="lists' + i + '">';
						strHTML += '<span style="width:5%">';
						strHTML += '	<input type="checkbox" name="chk" id="" class="easyui-checkbox"/>';
						strHTML += '</span>';
						strHTML += '<span style="width:20%">' + pid + '</span>';
						strHTML += '<span style="width:20%"><input type="text" name="pname" value="' + pname + '"/></span>';
						strHTML += '<span style="width:20%">' + strHTML_Combo + '</span>';
						strHTML += '<span style="width:20%"><input type="text" name="purl" value="' + purl + '"/></span>';
						strHTML += '<span style="width:15%"><input type="text" name="pfilename" value="' + pfilename + '"/></span>';
						strHTML += '</div>';
						
					}
					
					$("#list_content").html(strHTML);
					
				},
		  		error : function(xhr,status,error) {
		      		alert("err")
		  		},
		  		complete:function(data,textStatus) {
		  			
		  		}

			  }
		
		$.ajax(ajaxObj);
		
		
	}
     
 	var createCombo = function(menuid){
 		
 		var strHTML_Combo = "";
 		
 		strHTML_Combo += "<select name='pmenuid' onchange='chkMenu(this, &quot;" + menuid + "&quot;)'>";
 		for(var menu of menuList){
 			
 			strHTML_Combo += "<option value='"+ menu["MENUID"] + "'";
 			if(menuid == menu["MENUID"]){
 				strHTML_Combo += " selected ";
 			}
 			strHTML_Combo += ">" + menu["MENUNAME"] + "</option>";
 			
 		}
 		strHTML_Combo += "</select>";
 		
 		return strHTML_Combo;
 		
 	}
 	
 	var chkMenu = function(objSelect, orgMenuid){
 		//alert(orgMenuid);
 		if(selectedMenuID.includes(objSelect.value)){
 			alert("야 씨 정은아 코딩죠!!!");
 			objSelect.value = orgMenuid;
 			
 			//AJAX날려가지고 저장해버리겠습니다.
 		}
 		
 	}
 	
    var addRow = function(){
    	
    	var strHTML_Combo = createCombo("");
    	
    	var strHTML = "";
    	strHTML += '<div id="lists' + rowCount + '">';
		strHTML += '<span style="width:5%">';
		strHTML += '	<input type="checkbox" name="" id="" class="easyui-checkbox"/>';
		strHTML += '</span>';
		strHTML += '<span style="width:20%">자동생성</span>';
		strHTML += '<span style="width:20%"><input type="text" name="pname" /></span>';
		strHTML += '<span style="width:20%">' + strHTML_Combo + '</span>';
		strHTML += '<span style="width:20%"><input type="text" name="purl" /></span>';
		strHTML += '<span style="width:15%"><input type="text" name="pfilename" /></span>';
		strHTML += '</div>';    	
    	
		rowCount += 1;
		
		if(!isAdd){
			$("#list_content").append(strHTML);
			isAdd = true;
		}
		else{
			
			alert("추가는 어짜고 저짜고!!!!");
		}
    }
     
    
    var saveRow = function(){
    	
    	isAdd = false;
    	
    	
    }
     </script>
</head>
<body>
	<div id="wrap">
	
	<table border="1" width="100%" align="center" cellpadding="0" cellspacing="0">
		<tr>
			<td width="100%" height="70px" align="center">
				<!-- 메뉴구성 테이블 시작 -->
				<table border="1" width="80%" align="center" cellpadding="0" cellspacing="0">
					
					<tr>
						<td width="16%" height="40" align="center" class="selectedMenu">
							<a href="/ServBoard/Admin_AuthList"><span>권한관리</span></a>
						</td>
						<td width="16%" height="40" align="center">
							<a href="/ServBoard/Admin_MemList"><span>회원관리</span></a>
						</td>
						<td width="16%" height="40" align="center">
							<a href="/ServBoard/Admin_MenuList"><span>메뉴관리</span></a>
						</td>
						<td width="16%" height="40" align="center">
							<span>프로그램관리</span>
						</td>
						<td width="16%" height="40" align="center">
							<span>권한별상세관리</span>
						</td>
					</tr>
				</table>
				<!-- 메뉴구성 테이블 끝 -->
			</td>
		</tr>
	</table>	
	
	
	
		<div id="search">
			<input type="text" name="" id="" class="txt"/>
			
			<input type="button" value="조회" class="btn" onclick="setProgramList();"/>
			<input type="button" value="추가" class="btn" onclick="addRow();"/>
			<input type="button" value="저장" class="btn" onclick="saveRow()"/>
			<input type="button" value="삭제" class="btn"/>
		</div>
		<div id="list">
			<div id="list_title">
				<span style="width:5%">
					<input type="checkbox" name="" id="" class="easyui-checkbox"/>
				</span>
				<span style="width:20%">프로그램아이디</span>
				<span style="width:20%">프로그램명</span>
				<span style="width:20%">연결메뉴</span>
				<span style="width:20%">Servlet URL</span>
				<span style="width:15%">JSP 파일명</span>
			</div>
			<form method="post" action="/ServBoard/Admin_ModProgramList">
			<div id="list_content">
				<!-- 
				<div id="lists">
					<span style="width:5%">
						<input type="checkbox" name="" id="" class="easyui-checkbox"/>
					</span>
					<span style="width:20%">프로그램아이디</span>
					<span style="width:20%">프로그램명</span>
					<span style="width:20%">연결메뉴</span>
					<span style="width:20%">Servlet URL</span>
					<span style="width:15%">JSP 파일명</span>
				</div>
				-->
			</div>
			</form>
		</div>
	
	</div>
</body>
</html>