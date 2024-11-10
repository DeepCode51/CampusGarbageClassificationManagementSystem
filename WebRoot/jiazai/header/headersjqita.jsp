<%@ page language="java" contentType="text/html; charset=utf-8"  
import="com.model.*,com.util.*,java.util.List,java.util.ArrayList,net.sf.json.JSONArray,net.sf.json.JSONObject,net.sf.json.JsonConfig"  
pageEncoding="utf-8"%>
<%
	String sjqitapage = "1";
	String sjqitarows = "6";
	String sjqitaName = "";
	String sjqitaId = "";
	String sjqitaType = "0";
	
	StringBuffer sjqitaparam = new StringBuffer("yuliucanshu=1");
	if (StringUtil.isNotEmpty(sjqitapage)) {
		sjqitaparam.append("&page=" + sjqitapage);
	}
	if (StringUtil.isNotEmpty(sjqitarows)) {
		sjqitaparam.append("&rows=" + sjqitarows);
	}
	if (StringUtil.isNotEmpty(sjqitaName)) {
		sjqitaparam.append("&sjqitaName=" + sjqitaName);
	}
	if (StringUtil.isNotEmpty(sjqitaId)) {
		sjqitaparam.append("&sjqitaId=" + sjqitaId);
	}
	if (StringUtil.isNotEmpty(sjqitaType)) {
		sjqitaparam.append("&sjqitaType=" + sjqitaType);
	}

 %>
<%
	List<Sjqita> sjqitas = new ArrayList<Sjqita>();
	Sjqita sjqita = null;
	int sjqitasshuliang = 0;
	String sjqitapath = request.getContextPath();
	String sjqitabasePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+sjqitapath+"/";
	
	String sjqitaurl = sjqitabasePath + "getSjqitas";
	JSONObject sjqitaresult = PostUtil.sendPost(sjqitaurl, sjqitaparam.toString());
	if(sjqitaresult!=null){
		JSONArray sjqitajsonArray = (JSONArray)sjqitaresult.get("rows");
		//System.out.println(sjqitajsonArray);
		sjqitas = JSONArray.toList(sjqitajsonArray, new Sjqita(), new JsonConfig());
		if(sjqitas.size()>0){
			sjqita = sjqitas.get(0);
		}
		//for(int i = 0;i < sjqitas.size();i++){
		//	System.out.println(sjqitas.get(i).getSjqitaName());
		//}
		sjqitasshuliang = (Integer)sjqitaresult.get("total");
		//System.out.println(sjqitasshuliang);
	}
%>