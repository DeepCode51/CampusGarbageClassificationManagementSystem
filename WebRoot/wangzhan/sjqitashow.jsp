<%@ page language="java" contentType="text/html; charset=utf-8" import="com.model.*"
	pageEncoding="utf-8"%>
<%@ include file="header.jsp"%>
<%@ include file="../jiazai/sousuobaohan.jsp"%>
<script type="text/javascript">
var userId = <%=userId%>;
	function addSjjianchu(sjqitaId){
		if (userId==0) {
			if(confirm("注册登录网站？")){
				window.location.href="<%=basePath %>shouye/index.jsp";
				return false;
			}else{
				return false;
			}
		}
		$.post("<%=basePath %>addSjjianchu?userId="+userId,{sjqitaId:sjqitaId},function(result){
			if(result.errorMsg){
				alert(result.errorMsg);
			}else{
				alert("兑换成功，请到会员中心查看详情！");
				location.reload();
			}
		},"json");
	}
	
</script>
  <!-- 内容 -->
    <div class="container">
        <div class="row">

            <div class="col-xs-12 col-sm-8 col-md-9" id="rightBox">

                <div class="positionBox">
                    <div class="titleBar">
                        <h1>当前位置</h1>
                        <span></span>
                        <a href="<%=basePath %>">首页</a> > <a href="<%=basePath %>wangzhan/sjqitalist.jsp"><%=newJcpeizhi.getSjqitaBieming() %>信息</a>
                    </div>
                </div>

                <div class="col-sm-12 col-md-12 pad">
                    
                    <div class="col-sm-12 col-md-6 pad">
                        <div class="detailGlide" style="max-width:600px; margin:0 auto">
                            <div class="slider">
                                <ul class="slider__wrapper">
                                    <li data-responsive='' data-src='<%=basePath %><%=sousuoSjqita.getSjqitaDizhi()%>' data-sub-html='' class='slider__item real'><a><img src='<%=basePath %><%=sousuoSjqita.getSjqitaDizhi()%>'></a></li>
                                </ul>
                            </div>
                            <div id="detailNav">
                            </div>
                        </div>
                        <script type="text/javascript">
                            var glide = $('.slider').glide({ navigationImg: true, navigation: "#detailNav" });
                        </script>
                    </div>
                
                    <div class="col-sm-12 col-md-6 pad">
                    <form name="form1" method="post">
                        <div class="detailTitle">
                            <%=sousuoSjqita.getSjqitaName()%>
                        </div>
                        <div class="detailParameter" style="line-height:1.8em;">
                            	上架时间：<%=DateUtil.formatDate(sousuoSjqita.getSjqitaDate(),"yyyy-MM-dd HH:mm:ss") %><br />
                            	厂家：<%=sousuoSjqita.getSjqitaMark1()%><br />
                           	 	备注：<%=sousuoSjqita.getSjqitaMark2()%><br />
                            	积分：<%=sousuoSjqita.getSjqitaDouble()%><br />
                        </div>
                        <div class="detailUrl"><a href="javascript:addSjjianchu(<%=sousuoSjqita.getSjqitaId()%>)">在线兑换</a></div>
                    </form>
                    </div>
                    
                    <div class="col-sm-12 col-md-12 pad">
                        <div class="detailTitleTxt">
                           	 详细介绍
                        </div>
                        <div class="detailContent" style="line-height:1.8em;">
                           	<%=sousuoSjqita.getSjqitaMark()%>
                        </div>
                    </div>
                </div>

            </div>

            <%@ include file="left.jsp"%>

        </div>
    </div>
<%@ include file="footer.jsp"%>