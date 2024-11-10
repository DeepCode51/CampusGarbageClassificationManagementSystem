<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<%@ include file="../jiazai/jcpeizhibaohan.jsp"%>
<%
	Jcpeizhi newJcpeizhi = (Jcpeizhi)session.getAttribute("jcpeizhi");
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>欢迎登录<%=newJcpeizhi.getJcpeizhiName()%></title>
<link href="<%=basePath%>shouye/muban5/css/style.css" rel="stylesheet" type="text/css" />
<script language="JavaScript" src="<%=basePath%>shouye/muban5/js/jquery.js"></script>
<script src="<%=basePath%>shouye/muban5/js/cloud.js" type="text/javascript"></script>

<script language="javascript">
	$(function(){
    $('.loginbox').css({'position':'absolute','left':($(window).width()-692)/2});
	$(window).resize(function(){  
    $('.loginbox').css({'position':'absolute','left':($(window).width()-692)/2});
    })  
});  
</script> 
<script language="javascript">
function checklogin()
{
  if(document.login.account.value=='')
     {alert('请输入帐户');
      document.login.account.focus();
      return false
    }
  if (document.login.password.value=='')
   {alert('请输入密码');
    document.login.password.focus();
    return false
   }
}
</script>

</head>

<body style="background-color:#1c77ac; background-image:url(<%=basePath%>shouye/muban5/css/light.png); background-repeat:no-repeat; background-position:center top; overflow:hidden;">



    <div id="mainBody">
      <div id="cloud1" class="cloud"></div>
      <div id="cloud2" class="cloud"></div>
    </div>  


<div class="logintop">    
    <span>欢迎登录<%=newJcpeizhi.getJcpeizhiName()%></span>
    </div>
    
    <div class="loginbody">
    
    <span class="systemlogo">
    <div style="text-align:center;font-size:60px;color:#041926;"><%=newJcpeizhi.getJcpeizhiName()%></div>
    </span> 
       
    <div class="loginbox">
    <form action="<%=basePath%>login" name="login" method="post" onSubmit="return checklogin();">
    <ul>
    <li><input name="userName" type="text" class="loginuser" onclick="JavaScript:this.value=''"/></li>
    <li><input name="password" type="password" class="loginpwd" onclick="JavaScript:this.value=''"/></li>
    <li><input type="submit" class="loginbtn" value="登录" />
    <label>
    <input type="radio" name="loginType" value="admin" checked/>管理员
	<input type="radio" name="loginType" value="user"/><%=newJcpeizhi.getUserBieming()%>
    </label>
    <label><a href="<%=basePath%>user/zhuceuser.jsp"><font color="blue">注册</font></a></label>
    </li>
    </ul>
    </form>
    <li><font color="red">${error }</font></li>
    </div>
    
    </div>
    
    
    
    <div class="loginbm">版权所有<%=newJcpeizhi.getJcpeizhiName()%></div>
</body>
</html>