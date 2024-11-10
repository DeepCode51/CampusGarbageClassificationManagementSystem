<%@ page language="java" import="com.model.*"  pageEncoding="utf-8"%>
<% Jcpeizhi newJcpeizhi = (Jcpeizhi)session.getAttribute("jcpeizhi"); %>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title><%=newJcpeizhi.getUserBieming()%><%=newJcpeizhi.getUxinxiBieming()%></title>
<link rel="stylesheet" type="text/css" href="../jquery-easyui-1.3.3/themes/default/easyui.css">
<link rel="stylesheet" type="text/css" href="../jquery-easyui-1.3.3/themes/icon.css">
<script type="text/javascript" src="../jquery-easyui-1.3.3/jquery.min.js"></script>
<script type="text/javascript" src="../jquery-easyui-1.3.3/jquery.easyui.min.js"></script>
<script type="text/javascript" src="../jquery-easyui-1.3.3/locale/easyui-lang-zh_CN.js"></script>
<script type="text/javascript">
var url;
	function searchUxinxi(){
		$('#dg').datagrid('load',{
			uxinxiName:$('#s_uxinxiName').val(),
			uxtypeId:$('#s_uxtypeId').combobox("getValue"),
			userId:$('#s_userId').combobox("getValue")
		});
	}
	
	function saveUxinxi(){
		$("#fm").form("submit",{
			url:url,
			onSubmit:function(){
				return $(this).form("validate");
			},
			success:function(result){
			
				var s=result;
				var result = eval('(' + result + ')');
			
				if(result.errorMsg){
					$.messager.alert("系统提示",result.errorMsg);
					return;
				}else{
					$.messager.alert("系统提示","保存成功");
					resetValue();
					$("#dlg").dialog("close");
					$("#dg").datagrid("reload");
				}
			}
		});
	}
	
	function openUxinxiAddDialog(){
		$("#dlg").dialog("open").dialog("setTitle","添加<%=newJcpeizhi.getUserBieming()%><%=newJcpeizhi.getUxinxiBieming()%>");
		url="../addUxinxi";
	}
	
	function resetValue(){
	}
	
	function deleteUxinxi(){
		var selectedRows=$("#dg").datagrid('getSelections');
		if(selectedRows.length==0){
			$.messager.alert("系统提示","请选择要删除的数据！");
			return;
		}
		var strIds=[];
		for(var i=0;i<selectedRows.length;i++){
			strIds.push(selectedRows[i].uxinxiId);
		}
		var ids=strIds.join(",");
		$.messager.confirm("系统提示","您确认要删掉这<font color=red>"+selectedRows.length+"</font>条数据吗？",function(r){
			if(r){
				$.post("../deleteUxinxi",{delIds:ids},function(result){
					if(result.success){
						$.messager.alert("系统提示","您已成功删除<font color=red>"+result.delNums+"</font>条数据！");
						$("#dg").datagrid("reload");
					}else{
						$.messager.alert('系统提示','<font color=red>'+selectedRows[result.errorIndex].uxinxiName+'</font>'+result.errorMsg);
					}
				},"json");
			}
		});
	}
	
	function closeUxinxiDialog(){
		$("#dlg").dialog("close");
		resetValue();
	}
	
	function openUxinxiModifyDialog(){
		var selectedRows=$("#dg").datagrid('getSelections');
		if(selectedRows.length!=1){
			$.messager.alert("系统提示","请选择一条要编辑的数据！");
			return;
		}
		var row=selectedRows[0];
		$("#dlg").dialog("open").dialog("setTitle","编辑<%=newJcpeizhi.getUserBieming()%><%=newJcpeizhi.getUxinxiBieming()%>");
		url="../addUxinxi?uxinxiId="+row.uxinxiId;
	}
	
	function formatChakan(shujuImg, row) {
		if(shujuImg){
			return '<a target="_blank" style="color:red;" href="../' + shujuImg + '">查看' + '</a>'; 
		}else {
			return "未上传";
		}
	}
	
	function formatXiazai(shujuImgName, row) {
		if(shujuImgName){
			return '<a target="_blank" style="color:red;" href="../downFile?filename=' + shujuImgName + '">下载' + '</a>'; 
		}else {
			return "未上传";
		}
	}
	
	function datetostr(dateTime, row) {
		if(dateTime){
			var JsonDateValue = new Date(dateTime.time);
			var text = JsonDateValue.toLocaleString();
			return text;
		}else{
			return "未填写";
		}
	}
	
	function doPrint() {      
        bdhtml=window.document.body.innerHTML;      
        sprnstr="<!--startprint-->";      
        eprnstr="<!--endprint-->";      
        prnhtml=bdhtml.substr(bdhtml.indexOf(sprnstr)+17);      
        prnhtml=prnhtml.substring(0,prnhtml.indexOf(eprnstr));      
        window.document.body.innerHTML=prnhtml;   
        window.print();      
	}
	
	function shangchuanUxinxi(){
		var selectedRows=$("#dg").datagrid('getSelections');
		if(selectedRows.length!=1){
			$.messager.alert("系统提示","请选择一条要编辑的数据！");
			return;
		}
		var row=selectedRows[0];
		$("#shangchuan").dialog("open").dialog("setTitle","上传<%=newJcpeizhi.getUserBieming()%><%=newJcpeizhi.getUxinxiBieming()%>");
		$("#shchfm").form("load",row);
		shchurl="../shangchuanUxinxi?uxinxiId="+row.uxinxiId;
	}
	
	function closeShangchuanUxinxi(){
		$("#shangchuan").dialog("close");
		resetValue();
	}
	
	function saveShangchuanUxinxi(){
		$("#shchfm").form("submit",{
			url:shchurl,
			onSubmit:function(){
				return $(this).form("validate");
			},
			success:function(result){
			
				var s=result;
				var result = eval('(' + result + ')');
			
				if(result.errorMsg){
					$.messager.alert("系统提示",result.errorMsg);
					return;
				}else{
					$.messager.alert("系统提示","保存成功");
					resetValue();
					$("#shangchuan").dialog("close");
					$("#dg").datagrid("reload");
				}
			}
		});
	}
	
	function formatType1(shujuType1, row) {  
		if(shujuType1==0){
			return "零";
		}
		if(shujuType1==1){
			return "一";
		}
	}
	
	function formatType2(shujuType2, row) {  
		if(shujuType2==0){
			return "0";
		}
		if(shujuType2==1){
			return "1";
		}
	}
	
	function datetostr(date, row) {
		if(date){
			var date = new Date(date.time);
        	var y=date.getFullYear();
        	var m=date.getMonth()+1;
        	var d=date.getDate();
        	var h=date.getHours();
        	var m1=date.getMinutes();
        	var s=date.getSeconds();
        	m = m<10?("0"+m):m;
        	d = d<10?("0"+d):d;
        	return y+"-"+m+"-"+d;
			var text = JsonDateValue.toLocaleString();
			return text;
		}else{
			return "未填写";
		}
	}
</script>
</head>
<body style="margin: 5px;">
<!--startprint-->
	<table id="dg" title="<%=newJcpeizhi.getUserBieming()%><%=newJcpeizhi.getUxinxiBieming()%>" class="easyui-datagrid" fitColumns="true"
	 pagination="true" url="../getUxinxis" fit="true" rownumbers="true" toolbar="#tb">
		<thead>
			<tr>
				<th field="cb" checkbox="true"></th>
				<th field="uxinxiId" width="10" hidden="true">编号</th>
				<th field="userId" width="20" hidden="true"><%=newJcpeizhi.getUserBieming()%>ID</th>
				<th field="userName" width="20"><%=newJcpeizhi.getUserBieming()%></th>
				<th field="uxtypeId" width="20" hidden="true"><%=newJcpeizhi.getUxtypeBieming()%>ID</th>
				<th field="uxtypeName" width="20"><%=newJcpeizhi.getUxtypeBieming()%></th>
				<th field="uxinxiName" width="40">名称</th>
				<th field="uxinxiMark" width="80">详情</th>
				<th field="uxinxiDate" width="20" formatter="datetostr">时间</th>
			</tr>
		</thead>
	</table>
	
	<div id="tb">
		<div>
		&nbsp;名称：&nbsp;<input type="text" name="s_uxinxiName" id="s_uxinxiName" size="10"/>
		&nbsp;<%=newJcpeizhi.getUxtypeBieming()%>：&nbsp;<input class="easyui-combobox" id="s_uxtypeId" name="s_uxtypeId"  data-options="panelHeight:'auto',editable:false,valueField:'uxtypeId',textField:'uxtypeName',url:'../uxtypeComboList'"/>
		&nbsp;<%=newJcpeizhi.getUserBieming()%>：&nbsp;<input class="easyui-combobox" id="s_userId" name="s_userId"  data-options="panelHeight:'auto',editable:false,valueField:'userId',textField:'userName',url:'../userComboList'"/>
		<a href="javascript:searchUxinxi()" class="easyui-linkbutton" iconCls="icon-search" plain="true">搜索</a>
		</div>
	</div>
<!--endprint-->
	
	<div id="dlg" class="easyui-dialog" style="width: 520px;height: 300px;padding: 10px 20px"
		closed="true" buttons="#dlg-buttons">
		<form id="fm" method="post">
			<table>
				<tr>
					<td>名称：</td>
					<td><input type="text" name="uxinxiName" id="uxinxiName" class="easyui-validatebox" required="true"/></td>
					<td><%=newJcpeizhi.getUxtypeBieming()%>：</td>
					<td><input class="easyui-combobox" id="uxtypeId" name="uxtypeId"  data-options="panelHeight:'auto',editable:false,valueField:'uxtypeId',textField:'uxtypeName',url:'../uxtypeComboList'"/></td>
				</tr>
				<tr>
					<td>备注：</td>
					<td><input type="text" name="uxinxiMark1" id="uxinxiMark1" class="easyui-validatebox" required="true"/></td>
					<td><%=newJcpeizhi.getUserBieming()%>：</td>
					<td><input class="easyui-combobox" id="userId" name="userId"  data-options="panelHeight:'auto',editable:false,valueField:'userId',textField:'userName',url:'../userComboList'"/></td>
				</tr>
				<tr>
					<td>数量：</td>
					<td><input type="text" name="uxinxiZong" id="uxinxiZong" class="easyui-validatebox" required="true"/></td>
					<td>复数：</td>
					<td><input type="text" name="uxinxiDouble" id="uxinxiDouble" class="easyui-validatebox" required="true"/></td>
				</tr>
				<tr>
					<td valign="top">详情：</td>
					<td colspan="4"><textarea rows="7" cols="50" name="uxinxiMark" id="uxinxiMark"></textarea></td>
				</tr>
			</table>
		</form>
	</div>
	
	<div id="dlg-buttons">
		<a href="javascript:saveUxinxi()" class="easyui-linkbutton" iconCls="icon-ok">保存</a>
		<a href="javascript:closeUxinxiDialog()" class="easyui-linkbutton" iconCls="icon-cancel">关闭</a>
	</div>
<!--上传-->	
	<div id="shangchuan" class="easyui-dialog" style="width: 320px;height: 140px;padding: 10px 20px"
		closed="true" buttons="#shangchuan-buttons">
		<form id="shchfm" method="post" enctype="multipart/form-data">
			<table cellspacing="5px;">
				<tr>
					<td><input type="file" name="uploadFile" id="uploadFile" class="easyui-validatebox" required="true"/></td>
				</tr>
			</table>
		</form>
	</div>
	
	<div id="shangchuan-buttons">
		<a href="javascript:saveShangchuanUxinxi()" class="easyui-linkbutton" iconCls="icon-ok">保存</a>
		<a href="javascript:closeShangchuanUxinxi()" class="easyui-linkbutton" iconCls="icon-cancel">关闭</a>
	</div>
</body>
</html>