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
 		
 		
 		//�޺��ڽ�
 		var strHTML_Combo = "";
 		
 		strHTML_Combo += "<select name=''>";
 		for(var menu of menuList){
 			
 			strHTML_Combo += "<option value='"+ menu["MENUID"] + "' ++>" + menu["MENUNAME"] + "</option>";
 			
 		}
 		strHTML_Combo += "</select>";
 		
 		
		//var student = "{id:'aaa',name:'ȫ�浿'}";
		//json.parse(); //string(text) json�� json object ���·� ��ȯ
		//json.stringfy(); //json object ������ �����͸� text���·� ��ȯ
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
						
						
					
						//�޺��ڽ�
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
 		
 		strHTML_Combo += "<select name='pmenuid'>";
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
 	
    var addRow = function(){
    	
    	var strHTML_Combo = createCombo("");
    	
    	var strHTML = "";
    	strHTML += '<div id="lists' + rowCount + '">';
		strHTML += '<span style="width:5%">';
		strHTML += '	<input type="checkbox" name="" id="" class="easyui-checkbox"/>';
		strHTML += '</span>';
		strHTML += '<span style="width:20%">�ڵ�����</span>';
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
			
			alert("�߰��� ��¥�� ��¥��!!!!");
		}
    }
     
    
    var saveRow = function(){
    	
    	isAdd = false;
    	
    	
    }
     </script>
</head>
<body>
	<div id="wrap">
	
		<div id="search">
			<input type="text" name="" id="" class="txt"/>
			
			<input type="button" value="��ȸ" class="btn" onclick="setProgramList();"/>
			<input type="button" value="�߰�" class="btn" onclick="addRow();"/>
			<input type="button" value="����" class="btn" onclick="saveRow()"/>
			<input type="button" value="����" class="btn"/>
		</div>
		<div id="list">
			<div id="list_title">
				<span style="width:5%">
					<input type="checkbox" name="" id="" class="easyui-checkbox"/>
				</span>
				<span style="width:20%">���α׷����̵�</span>
				<span style="width:20%">���α׷���</span>
				<span style="width:20%">����޴�</span>
				<span style="width:20%">Servlet URL</span>
				<span style="width:15%">JSP ���ϸ�</span>
			</div>
			<form method="post" action="/ServBoard/Admin_ModProgramList">
			<div id="list_content">
				<!-- 
				<div id="lists">
					<span style="width:5%">
						<input type="checkbox" name="" id="" class="easyui-checkbox"/>
					</span>
					<span style="width:20%">���α׷����̵�</span>
					<span style="width:20%">���α׷���</span>
					<span style="width:20%">����޴�</span>
					<span style="width:20%">Servlet URL</span>
					<span style="width:15%">JSP ���ϸ�</span>
				</div>
				-->
			</div>
			</form>
		</div>
	
	</div>
</body>
</html>