<%@ page language="java" import="com.model.*"  pageEncoding="utf-8"%>
<% Jcpeizhi newJcpeizhi = (Jcpeizhi)session.getAttribute("jcpeizhi"); %>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title><%=newJcpeizhi.getSjqitaBieming()%>信息</title>
<link rel="stylesheet" type="text/css" href="../jquery-easyui-1.3.3/themes/default/easyui.css">
<link rel="stylesheet" type="text/css" href="../jquery-easyui-1.3.3/themes/icon.css">
<script type="text/javascript" src="../jquery-easyui-1.3.3/jquery.min.js"></script>
<script type="text/javascript" src="../jquery-easyui-1.3.3/jquery.easyui.min.js"></script>
<script type="text/javascript" src="../jquery-easyui-1.3.3/locale/easyui-lang-zh_CN.js"></script>
<link rel="stylesheet" href="../fuwenben/themes/default/default.css" />
<link rel="stylesheet" href="../fuwenben/plugins/code/prettify.css" />
<script charset="utf-8" src="../fuwenben/kindeditor-all.js"></script>
<script charset="utf-8" src="../fuwenben/lang/zh-CN.js"></script>
<script charset="utf-8" src="../fuwenben/plugins/code/prettify.js"></script>

	<script>
		KindEditor.ready(function(K) {
			var editor1 = K.create('textarea[name="sjqitaMark"]', {
				cssPath : '../fuwenben/plugins/code/prettify.css',
				uploadJson : '../upload/fileUpload',
				afterCreate : function() {
					var self = this;
					K.ctrl(document, 13, function() {
						self.sync();
						document.forms['example'].submit();
					});
					K.ctrl(self.edit.doc, 13, function() {
						self.sync();
						document.forms['example'].submit();
					});
				},
				afterBlur: function(){this.sync();}
			});
			prettyPrint();
		});
	</script>
<script type="text/javascript">
var url;
	function searchSjqita(){
		$('#dg').datagrid('load',{
			sjqitaName:$('#s_sjqitaName').val(),
			sjleixingId:$('#s_sjleixingId').combobox("getValue")
		});
	}
	
	function saveSjqita(){
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
	
	function openSjqitaAddDialog(){
		$("#dlg").dialog("open").dialog("setTitle","添加<%=newJcpeizhi.getSjqitaBieming()%>信息");
		url="../addSjqita";
	}
	
	function resetValue(){
	}
	
	function deleteSjqita(){
		var selectedRows=$("#dg").datagrid('getSelections');
		if(selectedRows.length==0){
			$.messager.alert("系统提示","请选择要删除的数据！");
			return;
		}
		var strIds=[];
		for(var i=0;i<selectedRows.length;i++){
			strIds.push(selectedRows[i].sjqitaId);
		}
		var ids=strIds.join(",");
		$.messager.confirm("系统提示","您确认要删掉这<font color=red>"+selectedRows.length+"</font>条数据吗？",function(r){
			if(r){
				$.post("../deleteSjqita",{delIds:ids},function(result){
					if(result.success){
						$.messager.alert("系统提示","您已成功删除<font color=red>"+result.delNums+"</font>条数据！");
						$("#dg").datagrid("reload");
					}else{
						$.messager.alert('系统提示','<font color=red>'+selectedRows[result.errorIndex].sjqitaName+'</font>'+result.errorMsg);
					}
				},"json");
			}
		});
	}
	
	function closeSjqitaDialog(){
		$("#dlg").dialog("close");
		resetValue();
	}
	
	function openSjqitaModifyDialog(){
		var selectedRows=$("#dg").datagrid('getSelections');
		if(selectedRows.length!=1){
			$.messager.alert("系统提示","请选择一条要编辑的数据！");
			return;
		}
		var row=selectedRows[0];
		$("#dlg").dialog("open").dialog("setTitle","编辑<%=newJcpeizhi.getSjqitaBieming()%>信息");
		$("#fm").form("load",row);
		url="../addSjqita?sjqitaId="+row.sjqitaId;
	}
	
	function formatSex(sjqitaSex, row) {  
		if(sjqitaSex==0){
			return "男";
		}
		if(sjqitaSex==1){
			return "女";
		}
	}
	
	function formatType1(sjqitaType1, row) {  
		if(sjqitaType1==0){
			return "零";
		}
		if(sjqitaType1==1){
			return "一";
		}
	}
	
	function formatType(sjqitaType, row) {  
		if(sjqitaType==0){
			return "上架";
		}
		if(sjqitaType==1){
			return "下架";
		}
	}
	
	function formatChakan(sjqitaImg, row) {
		if(sjqitaImg){
			return '<a target="_blank" style="color:red;" href="../' + sjqitaImg + '">查看' + '</a>'; 
		}else {
			return "未上传";
		}
	}
	
	function formatXiazai(sjqitaImgName, row) {
		if(sjqitaImgName){
			return '<a target="_blank" style="color:red;" href="../downFile?filename=' + sjqitaImgName + '">下载' + '</a>'; 
		}else {
			return "未上传";
		}
	}
	
	function daochuSjqita(){
		var selectedRows=$("#dg").datagrid('getSelections');
		if(selectedRows.length==0){
			$.messager.alert("系统提示","请选择要导出的数据！");
			return;
		}
		var sjqitaIds=[];
		for(var i=0;i<selectedRows.length;i++){
			sjqitaIds.push(selectedRows[i].sjqitaId);
		}
		var ids=sjqitaIds.join(",");
		$.messager.confirm("系统提示","您确认要导出数据吗？",function(r){
			if(r){
				$.post("../daochuSjqita",{delIds:ids},function(result){
					if(result.success){
						$.messager.alert("系统提示","您已成功导出数据：D:！");
						$("#dg").datagrid("reload");
					}else{
						$.messager.alert('系统提示','<font color=red>'+selectedRows[result.errorIndex].sjqitaName+'</font>'+result.errorMsg);
					}
				},"json");
			}
		});
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
	
	function daoruSjqitas(){
		$("#daoru").dialog("open").dialog("setTitle","导入<%=newJcpeizhi.getSjqitaBieming()%>信息");
		daoruurl="../daoruSjqita";
	}
	
	function closeDaoruSjqita(){
		$("#daoru").dialog("close");
		resetValue();
	}
	
	function saveDaoruSjqita(){
		$("#drfm").form("submit",{
			url:daoruurl,
			onSubmit:function(){
				return $(this).form("validate");
			},
			success:function(result){
			
				if(result.errorMsg){
					$.messager.alert("系统提示",result.errorMsg);
					return;
				}else{
					$.messager.alert("系统提示","保存成功");
					resetValue();
					$("#daoru").dialog("close");
					$("#dg").datagrid("reload");
				}
			}
		});
	}
	
	function shangchuanSjqita(){
		var selectedRows=$("#dg").datagrid('getSelections');
		if(selectedRows.length!=1){
			$.messager.alert("系统提示","请选择一条要编辑的数据！");
			return;
		}
		var row=selectedRows[0];
		$("#shangchuan").dialog("open").dialog("setTitle","上传<%=newJcpeizhi.getSjqitaBieming()%>信息");
		$("#shchfm").form("load",row);
		shchurl="../shangchuanSjqita?sjqitaId="+row.sjqitaId;
	}
	
	function closeShangchuanSjqita(){
		$("#shangchuan").dialog("close");
		resetValue();
	}
	
	function saveShangchuanSjqita(){
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
	
	function shenheSjqita(){
		var selectedRows=$("#dg").datagrid('getSelections');
		if(selectedRows.length!=1){
			$.messager.alert("系统提示","请选择一条要执行的数据！");
			return;
		}
		var row=selectedRows[0];
		url="../addSjqita?sjqitaId="+row.sjqitaId;
		$.messager.confirm("系统提示","您确认要执行吗？",function(r){
			if(r){
				$.post(url,{sjqitaType:1},function(result){
					if(result.errorMsg){
						$.messager.alert("系统提示",result.errorMsg);
						$("#dg").datagrid("reload");
					}else{
						$.messager.alert("系统提示","您已成功执行！");
						$("#dg").datagrid("reload");
					}
				},"json");
			}
		});
	}
	
	function shangjiaSjqita(){
		var selectedRows=$("#dg").datagrid('getSelections');
		if(selectedRows.length!=1){
			$.messager.alert("系统提示","请选择一条要执行的数据！");
			return;
		}
		var row=selectedRows[0];
		url="../addSjqita?sjqitaId="+row.sjqitaId;
		$.messager.confirm("系统提示","您确认要执行吗？",function(r){
			if(r){
				$.post(url,{sjqitaType:0},function(result){
					if(result.errorMsg){
						$.messager.alert("系统提示",result.errorMsg);
						$("#dg").datagrid("reload");
					}else{
						$.messager.alert("系统提示","您已成功执行！");
						$("#dg").datagrid("reload");
					}
				},"json");
			}
		});
	}
	
	function xiajiaSjqita(){
		var selectedRows=$("#dg").datagrid('getSelections');
		if(selectedRows.length!=1){
			$.messager.alert("系统提示","请选择一条要执行的数据！");
			return;
		}
		var row=selectedRows[0];
		url="../addSjqita?sjqitaId="+row.sjqitaId;
		$.messager.confirm("系统提示","您确认要执行吗？",function(r){
			if(r){
				$.post(url,{sjqitaType:1},function(result){
					if(result.errorMsg){
						$.messager.alert("系统提示",result.errorMsg);
						$("#dg").datagrid("reload");
					}else{
						$.messager.alert("系统提示","您已成功执行！");
						$("#dg").datagrid("reload");
					}
				},"json");
			}
		});
	}
	
	function chakanNeirong(sjqitaId, row) {
		return '<a style="color:red;"target="_blank" href="<%=basePath%>wangzhan/sjqitaneirong.jsp?sjqitaId=' + sjqitaId + '">查看' + '</a>';  
	}
</script>
</head>
<body style="margin: 5px;">
<!--startprint-->
	<table id="dg" title="<%=newJcpeizhi.getSjqitaBieming()%>信息" class="easyui-datagrid" fitColumns="true"
	 pagination="true" url="../getSjqitas?sjqitaType=0" fit="true" rownumbers="true" toolbar="#tb">
		<thead>
			<tr>
				<th field="cb" checkbox="true"></th>
				<th field="sjqitaId" width="10" formatter="chakanNeirong">查看</th>
				<th field="sjqitaName" width="40">名称</th>
				<th field="sjqitaMark1" width="40">厂家</th>
				<th field="sjqitaMark2" width="40">备注</th>
				<th field="sjqitaDouble" width="10">积分</th>
				<th field="sjqitaDizhi" width="20" formatter="formatChakan">缩略图</th>
				<th field="sjqitaDate" width="20" formatter="datetostr">时间</th>
			</tr>
		</thead>
	</table>
	
<!--endprint-->
	<div id="dlg" class="easyui-dialog" style="width: 850px;height: 420px;padding: 10px 20px"
		closed="true" buttons="#dlg-buttons">
		<form id="fm" method="post">
			<table cellspacing="5px;">
				<tr>
					<td>名称：</td>
					<td><input type="text" name="sjqitaName" id="sjqitaName" class="easyui-validatebox" required="true"/></td>
					<td>厂家：</td>
					<td><input type="text" name="sjqitaMark1" id="sjqitaMark1" class="easyui-validatebox" required="true"/></td>
				</tr>
				<tr>
					<td>备注：</td>
					<td><input type="text" name="sjqitaMark2" id="sjqitaMark2" class="easyui-validatebox" required="true"/></td>
					<td>积分：</td>
					<td><input type="text" name="sjqitaDouble" id="sjqitaDouble" class="easyui-validatebox" required="true"/></td>
				</tr>
				<tr>
					<td valign="top"><%=newJcpeizhi.getSjqitaBieming()%>描述：</td>
					<td colspan="4"><textarea name="sjqitaMark" id="sjqitaMark" cols="100" rows="12" style="width:700px;height:250px;visibility:hidden;"></textarea></td>
				</tr>
			</table>
		</form>
	</div>
	
	<div id="dlg-buttons">
		<a href="javascript:saveSjqita()" class="easyui-linkbutton" iconCls="icon-ok">保存</a>
		<a href="javascript:closeSjqitaDialog()" class="easyui-linkbutton" iconCls="icon-cancel">关闭</a>
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
		<a href="javascript:saveShangchuanSjqita()" class="easyui-linkbutton" iconCls="icon-ok">保存</a>
		<a href="javascript:closeShangchuanSjqita()" class="easyui-linkbutton" iconCls="icon-cancel">关闭</a>
	</div>
<!--导入-->	
	<div id="daoru" class="easyui-dialog" style="width: 320px;height: 140px;padding: 10px 20px"
		closed="true" buttons="#daoru-buttons">
		<form id="drfm" method="post" enctype="multipart/form-data">
			<table cellspacing="5px;">
				<tr>
					<td><input type="file" name="uploadFile" id="uploadFile" class="easyui-validatebox" required="true"/></td>
				</tr>
			</table>
		</form>
	</div>
	
	<div id="daoru-buttons">
		<a href="javascript:saveDaoruSjqita()" class="easyui-linkbutton" iconCls="icon-ok">保存</a>
		<a href="javascript:closeDaoruSjqita()" class="easyui-linkbutton" iconCls="icon-cancel">关闭</a>
	</div>
	
</body>
</html>