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
<title><%=newJcpeizhi.getSjduochuBieming()%>信息</title>
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
			var editor1 = K.create('textarea[name="sjduochuMark"]', {
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
	function searchSjduochu(){
		$('#dg').datagrid('load',{
			sjxingtaiId:$('#s_sjxingtaiId').combobox("getValue")
		});
	}
	
	function saveSjduochu(){
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
	
	function openSjduochuAddDialog(){
		$("#dlg").dialog("open").dialog("setTitle","添加<%=newJcpeizhi.getSjduochuBieming()%>信息");
		url="../addSjduochu";
	}
	
	function resetValue(){
	}
	
	function deleteSjduochu(){
		var selectedRows=$("#dg").datagrid('getSelections');
		if(selectedRows.length==0){
			$.messager.alert("系统提示","请选择要删除的数据！");
			return;
		}
		var strIds=[];
		for(var i=0;i<selectedRows.length;i++){
			strIds.push(selectedRows[i].sjduochuId);
		}
		var ids=strIds.join(",");
		$.messager.confirm("系统提示","您确认要删掉这<font color=red>"+selectedRows.length+"</font>条数据吗？",function(r){
			if(r){
				$.post("../deleteSjduochu",{delIds:ids},function(result){
					if(result.success){
						$.messager.alert("系统提示","您已成功删除<font color=red>"+result.delNums+"</font>条数据！");
						$("#dg").datagrid("reload");
					}else{
						$.messager.alert('系统提示','<font color=red>'+selectedRows[result.errorIndex].sjduochuName+'</font>'+result.errorMsg);
					}
				},"json");
			}
		});
	}
	
	function closeSjduochuDialog(){
		$("#dlg").dialog("close");
		resetValue();
	}
	
	function openSjduochuModifyDialog(){
		var selectedRows=$("#dg").datagrid('getSelections');
		if(selectedRows.length!=1){
			$.messager.alert("系统提示","请选择一条要编辑的数据！");
			return;
		}
		var row=selectedRows[0];
		$("#dlg").dialog("open").dialog("setTitle","编辑<%=newJcpeizhi.getSjduochuBieming()%>信息");
		$("#fm").form("load",row);
		url="../addSjduochu?sjduochuId="+row.sjduochuId;
	}
	
	function formatSex(sjduochuSex, row) {  
		if(sjduochuSex==0){
			return "男";
		}
		if(sjduochuSex==1){
			return "女";
		}
	}
	
	function formatType1(sjduochuType1, row) {  
		if(sjduochuType1==0){
			return "零";
		}
		if(sjduochuType1==1){
			return "一";
		}
	}
	
	function formatType(sjduochuType, row) {  
		if(sjduochuType==0){
			return "空闲";
		}
		if(sjduochuType==1){
			return "预订";
		}
		if(sjduochuType==2){
			return "入住";
		}
	}
	
	function formatChakan(sjduochuImg, row) {
		if(sjduochuImg){
			return '<a target="_blank" style="color:red;" href="../' + sjduochuImg + '">查看' + '</a>'; 
		}else {
			return "未上传";
		}
	}
	
	function formatXiazai(sjduochuImgName, row) {
		if(sjduochuImgName){
			return '<a target="_blank" style="color:red;" href="../downFile?filename=' + sjduochuImgName + '">下载' + '</a>'; 
		}else {
			return "未上传";
		}
	}
	
	function daochuSjduochu(){
		var selectedRows=$("#dg").datagrid('getSelections');
		if(selectedRows.length==0){
			$.messager.alert("系统提示","请选择要导出的数据！");
			return;
		}
		var sjduochuIds=[];
		for(var i=0;i<selectedRows.length;i++){
			sjduochuIds.push(selectedRows[i].sjduochuId);
		}
		var ids=sjduochuIds.join(",");
		$.messager.confirm("系统提示","您确认要导出数据吗？",function(r){
			if(r){
				$.post("../daochuSjduochu",{delIds:ids},function(result){
					if(result.success){
						$.messager.alert("系统提示","您已成功导出数据：D:！");
						$("#dg").datagrid("reload");
					}else{
						$.messager.alert('系统提示','<font color=red>'+selectedRows[result.errorIndex].sjduochuName+'</font>'+result.errorMsg);
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
	
	function daoruSjduochus(){
		$("#daoru").dialog("open").dialog("setTitle","导入<%=newJcpeizhi.getSjduochuBieming()%>信息");
		daoruurl="../daoruSjduochu";
	}
	
	function closeDaoruSjduochu(){
		$("#daoru").dialog("close");
		resetValue();
	}
	
	function saveDaoruSjduochu(){
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
	
	function shangchuanSjduochu(){
		var selectedRows=$("#dg").datagrid('getSelections');
		if(selectedRows.length!=1){
			$.messager.alert("系统提示","请选择一条要编辑的数据！");
			return;
		}
		var row=selectedRows[0];
		$("#shangchuan").dialog("open").dialog("setTitle","上传<%=newJcpeizhi.getSjduochuBieming()%>信息");
		$("#shchfm").form("load",row);
		shchurl="../shangchuanSjduochu?sjduochuId="+row.sjduochuId;
	}
	
	function shipinSjduochu(){
		var selectedRows=$("#dg").datagrid('getSelections');
		if(selectedRows.length!=1){
			$.messager.alert("系统提示","请选择一条要编辑的数据！");
			return;
		}
		var row=selectedRows[0];
		$("#shangchuan").dialog("open").dialog("setTitle","上传<%=newJcpeizhi.getSjduochuBieming()%>信息");
		$("#shchfm").form("load",row);
		shchurl="../shipinSjduochu?sjduochuId="+row.sjduochuId;
	}
	
	function closeShangchuanSjduochu(){
		$("#shangchuan").dialog("close");
		resetValue();
	}
	
	function saveShangchuanSjduochu(){
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
	
	function shenheSjduochu(){
		var selectedRows=$("#dg").datagrid('getSelections');
		if(selectedRows.length!=1){
			$.messager.alert("系统提示","请选择一条要执行的数据！");
			return;
		}
		var row=selectedRows[0];
		url="../addSjduochu?sjduochuId="+row.sjduochuId;
		$.messager.confirm("系统提示","您确认要执行吗？",function(r){
			if(r){
				$.post(url,{sjduochuType:1},function(result){
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
	
	function shangjiaSjduochu(){
		var selectedRows=$("#dg").datagrid('getSelections');
		if(selectedRows.length!=1){
			$.messager.alert("系统提示","请选择一条要执行的数据！");
			return;
		}
		var row=selectedRows[0];
		url="../addSjduochu?sjduochuId="+row.sjduochuId;
		$.messager.confirm("系统提示","您确认要执行吗？",function(r){
			if(r){
				$.post(url,{sjduochuType:0},function(result){
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
	
	function xiajiaSjduochu(){
		var selectedRows=$("#dg").datagrid('getSelections');
		if(selectedRows.length!=1){
			$.messager.alert("系统提示","请选择一条要执行的数据！");
			return;
		}
		var row=selectedRows[0];
		url="../addSjduochu?sjduochuId="+row.sjduochuId;
		$.messager.confirm("系统提示","您确认要执行吗？",function(r){
			if(r){
				$.post(url,{sjduochuType:1},function(result){
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
	
	function chakanNeirong(sjduochuId, row) {
		return '<a style="color:red;"target="_blank" href="<%=basePath%>wangzhan/sjduochuneirong.jsp?sjduochuId=' + sjduochuId + '">查看' + '</a>';  
	}
</script>
</head>
<body style="margin: 5px;">
<!--startprint-->
	<table id="dg" title="<%=newJcpeizhi.getSjduochuBieming()%>信息" class="easyui-datagrid" fitColumns="true"
	 pagination="true" url="../getSjduochus" fit="true" rownumbers="true" toolbar="#tb">
		<thead>
			<tr>
				<th field="cb" checkbox="true"></th>
				<th field="sjduochuId" width="10" formatter="chakanNeirong">查看</th>
				<th field="sjduochuName" width="40">名称</th>
				<th field="sjduochuMark1" width="20">说明</th>
				<th field="sjduochuMark2" width="60">备注</th>
				<th field="sjxingtaiId" width="20" hidden="true"><%=newJcpeizhi.getSjxingtaiBieming()%>ID</th>
				<th field="sjxingtaiName" width="20"><%=newJcpeizhi.getSjxingtaiBieming()%></th>
				<th field="sjduochuImg" width="20" formatter="formatChakan">图片</th>
				<th field="buyuanName" width="10" formatter="formatXiazai">视频</th>
				<th field="roleName" width="20" formatter="formatChakan">查看</th>
				<th field="sjduochuDate" width="20" formatter="datetostr">时间</th>
			</tr>
		</thead>
	</table>
	
	<div id="tb">
		<div>
			<a href="javascript:openSjduochuAddDialog()" class="easyui-linkbutton" iconCls="icon-add" plain="true">添加</a>
			<a href="javascript:openSjduochuModifyDialog()" class="easyui-linkbutton" iconCls="icon-edit" plain="true">修改</a>
			<a href="javascript:deleteSjduochu()" class="easyui-linkbutton" iconCls="icon-remove" plain="true">删除</a>
			<a href="javascript:shangchuanSjduochu()" class="easyui-linkbutton" iconCls="icon-add" plain="true">上传缩略图</a>
			<a href="javascript:shipinSjduochu()" class="easyui-linkbutton" iconCls="icon-add" plain="true">上传视频</a>
		</div>
		<div>
		&nbsp;<%=newJcpeizhi.getSjxingtaiBieming()%>：&nbsp;<input class="easyui-combobox" id="s_sjxingtaiId" name="s_sjxingtaiId"  data-options="panelHeight:'auto',editable:false,valueField:'sjxingtaiId',textField:'sjxingtaiName',url:'../sjxingtaiComboList'"/>
		<a href="javascript:searchSjduochu()" class="easyui-linkbutton" iconCls="icon-search" plain="true">搜索</a>
		</div>
	</div>
<!--endprint-->
	<div id="dlg" class="easyui-dialog" style="width: 850px;height: 420px;padding: 10px 20px"
		closed="true" buttons="#dlg-buttons">
		<form id="fm" method="post">
			<table cellspacing="5px;">
				<tr>
					<td>名称：</td>
					<td><input type="text" name="sjduochuName" id="sjduochuName" class="easyui-validatebox" required="true"/></td>
					<td><%=newJcpeizhi.getSjxingtaiBieming()%>：</td>
					<td><input class="easyui-combobox" id="sjxingtaiId" name="sjxingtaiId"  data-options="panelHeight:'auto',editable:false,valueField:'sjxingtaiId',textField:'sjxingtaiName',url:'../sjxingtaiComboList'"/></td>
				</tr>
				<tr>
					<td>说明：</td>
					<td><input type="text" name="sjduochuMark1" id="sjduochuMark1" class="easyui-validatebox" required="true"/></td>
					<td>备注：</td>
					<td><input type="text" name="sjduochuMark2" id="sjduochuMark2" class="easyui-validatebox" required="true"/></td>
				</tr>
				<tr>
					<td valign="top"><%=newJcpeizhi.getSjduochuBieming()%>描述：</td>
					<td colspan="4"><textarea name="sjduochuMark" id="sjduochuMark" cols="100" rows="12" style="width:700px;height:250px;visibility:hidden;"></textarea></td>
				</tr>
			</table>
		</form>
	</div>
	
	<div id="dlg-buttons">
		<a href="javascript:saveSjduochu()" class="easyui-linkbutton" iconCls="icon-ok">保存</a>
		<a href="javascript:closeSjduochuDialog()" class="easyui-linkbutton" iconCls="icon-cancel">关闭</a>
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
		<a href="javascript:saveShangchuanSjduochu()" class="easyui-linkbutton" iconCls="icon-ok">保存</a>
		<a href="javascript:closeShangchuanSjduochu()" class="easyui-linkbutton" iconCls="icon-cancel">关闭</a>
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
		<a href="javascript:saveDaoruSjduochu()" class="easyui-linkbutton" iconCls="icon-ok">保存</a>
		<a href="javascript:closeDaoruSjduochu()" class="easyui-linkbutton" iconCls="icon-cancel">关闭</a>
	</div>
	
</body>
</html>