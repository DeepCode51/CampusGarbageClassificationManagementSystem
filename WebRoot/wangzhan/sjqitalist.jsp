<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ include file="header.jsp"%>
<%@ include file="../jiazai/sousuobaohan.jsp"%>
    
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
                    
                    <div class="productList">
                    <%if(sousuoSjqitas!=null){ %>
						<%for(int i = 0; i < sousuoSjqitas.size(); i++){ %>
						<%Sjqita newSjqita = sousuoSjqitas.get(i); %>
                        <div class="col-xs-6 col-sm-4 col-md-3 col-mm-6 productImg">
                            <a title="<%=newSjqita.getSjqitaName() %>" href='<%=basePath %>wangzhan/sjqitashow.jsp?sjqitaId=<%=newSjqita.getSjqitaId()%>'>
                                <span class="imgLink-hover"><span class="hover-link"></span></span>
                                <img src="<%=basePath %><%=newSjqita.getSjqitaDizhi() %>" alt="<%=newSjqita.getSjqitaName() %>" />
                            </a>
                            <a class="productTitle" href="<%=basePath %>wangzhan/sjqitashow.jsp?sjqitaId=<%=newSjqita.getSjqitaId()%>" title="<%=newSjqita.getSjqitaName() %>">
                                <%=newSjqita.getSjqitaName() %>
                            </a>
                        </div>
                    	<%} %>
                    <%} %>       
                    </div>

                    <div class='pageBar'>
                    <div class='pageList'>
                    <a href="sjqitalist.jsp?page=1">首页</a>
                    <%if(sjqitacurrPage!=1){ %>
            		<a href="sjqitalist.jsp?page=<%=(sjqitacurrPage-1) %>">上页</a>&nbsp;
            		<%} %>
   					<%if(sjqitacurrPage!=sjqitatotalPage){ %>
            		<a href="sjqitalist.jsp?page=<%=(sjqitacurrPage+1) %>">下页</a>&nbsp;
            		<a href="sjqitalist.jsp?page=<%=sjqitatotalPage %>">尾页</a>
            		<%} %>
                    </div>
                    </div>

                </div>

            </div>

            <%@ include file="left.jsp"%>

        </div>
    </div>
<%@ include file="footer.jsp"%>