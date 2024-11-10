<%@ page language="java" import="com.model.*"  pageEncoding="utf-8"%>
<% Jcpeizhi newJcpeizhi = (Jcpeizhi)session.getAttribute("jcpeizhi"); %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title><%=newJcpeizhi.getUxinxiBieming()%><%=newJcpeizhi.getUxtypeBieming()%></title>
<link rel="stylesheet" type="text/css" href="../jquery-easyui-1.3.3/themes/default/easyui.css">
<link rel="stylesheet" type="text/css" href="../jquery-easyui-1.3.3/themes/icon.css">
<script type="text/javascript" src="../jquery-easyui-1.3.3/jquery.min.js"></script>
<script type="text/javascript" src="../jquery-easyui-1.3.3/jquery.easyui.min.js"></script>
<script type="text/javascript" src="../jquery-easyui-1.3.3/locale/easyui-lang-zh_CN.js"></script>
<script type="text/javascript">
	var url;
	
	function searchUxtype(){
		$('#dg').datagrid('load',{
			uxtypeName:$('#s_uxtypeName').val()
		});
	}
	
	function deleteUxtype(){
		var selectedRows=$("#dg").datagrid('getSelections');
		if(selectedRows.length==0){
			$.messager.alert("系统提示","请选择要删除的数据！");
			return;
		}
		var strIds=[];
		for(var i=0;i<selectedRows.length;i++){
			strIds.push(selectedRows[i].uxtypeId);
		}
		var ids=strIds.join(",");
		//输出选择的行
		//$.messager.alert("ids:" + ids);
		$.messager.confirm("系统提示","您确认要删掉这<font color=red>"+selectedRows.length+"</font>条数据吗？",function(r){
			if(r){
				$.post("../deleteUxtype",{delIds:ids},function(result){
					if(result.success){
						$.messager.alert("系统提示","您已成功删除<font color=red>"+result.delNums+"</font>条数据！");
						$("#dg").datagrid("reload");
					}else{
						$.messager.alert('系统提示','<font color=red>'+selectedRows[result.errorIndex].uxtypeName+'</font>'+result.errorMsg);
					}
				},"json");
			}
		});
	}
	
	function openUxtypeAddDialog(){
		$("#dlg").dialog("open").dialog("setTitle","添加<%=newJcpeizhi.getUxinxiBieming()%><%=newJcpeizhi.getUxtypeBieming()%>");
		url="../addUxtype";
	}
	
	function saveUxtype(){
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
					$.messager.alert("系统提示","保存成功！");
					resetValue();
					$("#dlg").dialog("close");
					$("#dg").datagrid("reload");
				}
			}
		});
	}
	
	function resetValue(){
		$("#uxtypeName").val("");
		$("#uxtypeMark").val("");
	}
	
	function closeUxtypeDialog(){
		$("#dlg").dialog("close");
		resetValue();
	}
	
	function openUxtypeModifyDialog(){
		var selectedRows=$("#dg").datagrid('getSelections');
		if(selectedRows.length!=1){
			$.messager.alert("系统提示","请选择一条要编辑的数据！");
			return;
		}
		var row=selectedRows[0];
		$("#dlg").dialog("open").dialog("setTitle","编辑<%=newJcpeizhi.getUxinxiBieming()%><%=newJcpeizhi.getUxtypeBieming()%>");
		$("#fm").form("load",row);
		url="../addUxtype?uxtypeId="+row.uxtypeId;
	}
	
	function formatType(shujuType, row) {  
		if(shujuType==0){
			return "男";
		}
		if(shujuType==1){
			return "女";
		}
	}
</script>
</head>
<body style="margin: 5px;">
	<table id="dg" title="<%=newJcpeizhi.getUxinxiBieming()%><%=newJcpeizhi.getUxtypeBieming()%>" class="easyui-datagrid" fitColumns="true"
	 pagination="true" url="../getUxtypes" fit="true" rownumbers="true" toolbar="#tb">
		<thead>
			<tr>
				<th field="cb" checkbox="true"></th>
				<th field="uxtypeId" width="10" hidden="true">编号</th>
				<th field="uxtypeName" width="50">名称</th>
				<th field="uxtypeMark" width="100">描述</th>
			</tr>
		</thead>
	</table>
	
	<div id="dlg" class="easyui-dialog" style="width: 380px;height: 260px;padding: 10px 20px"
		closed="true" buttons="#dlg-buttons">
		<form id="fm" method="post">
			<table>
				<tr>
					<td>名称：</td>
					<td><input type="text" name="uxtypeName" id="uxtypeName" class="easyui-validatebox" required="true"/></td>
				</tr>
				<tr>
					<td valign="top">描述：</td>
					<td><textarea rows="7" cols="30" name="uxtypeMark" id="uxtypeMark"></textarea></td>
				</tr>
			</table>
		</form>
	</div>
	
	<div id="dlg-buttons">
		<a href="javascript:saveUxtype()" class="easyui-linkbutton" iconCls="icon-ok">保存</a>
		<a href="javascript:closeUxtypeDialog()" class="easyui-linkbutton" iconCls="icon-cancel">关闭</a>
	</div>
	
</body>
</html>