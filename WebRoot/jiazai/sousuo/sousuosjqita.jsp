<%@ page language="java" contentType="text/html; charset=utf-8"  
import="com.model.*,com.util.*,java.util.List,java.util.ArrayList,net.sf.json.JSONArray,net.sf.json.JSONObject,net.sf.json.JsonConfig"  
pageEncoding="utf-8"%>
<%
	String sousuoSjqitapage = (String) request.getParameter("page");
	String sousuoSjqitarows = (String) request.getParameter("rows");
	String sousuoSjqitaName = (String) request.getParameter("sjqitaName");
	String sousuoSjqitaId = (String) request.getParameter("sjqitaId");
	String sousuosjqitaType = "0";
	
	StringBuffer sousuoSjqitaparam = new StringBuffer("yuliucanshu=1");
	if (StringUtil.isEmpty(sousuoSjqitapage)) {
		sousuoSjqitapage = "1";
	}
	sousuoSjqitaparam.append("&page=" + sousuoSjqitapage);
	if (StringUtil.isEmpty(sousuoSjqitarows)) {
		sousuoSjqitarows = "9";
	}
	sousuoSjqitaparam.append("&rows=" + sousuoSjqitarows);
	if (StringUtil.isNotEmpty(sousuoSjqitaName)) {
		sousuoSjqitaparam.append("&sjqitaName=" + sousuoSjqitaName);
	}
	if (StringUtil.isNotEmpty(sousuoSjqitaId)) {
		sousuoSjqitaparam.append("&sjqitaId=" + sousuoSjqitaId);
	}
	if (StringUtil.isNotEmpty(sousuosjqitaType)) {
		sousuoSjqitaparam.append("&sjqitaType=" + sousuosjqitaType);
	}

	List<Sjqita> sousuoSjqitas = new ArrayList<Sjqita>();
	Sjqita sousuoSjqita = null;
	int sousuoSjqitasshuliang = 0;
	String sousuoSjqitapath = request.getContextPath();
	String sousuoSjqitabasePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+sousuoSjqitapath+"/";
	
	String sousuoSjqitaurl = sousuoSjqitabasePath + "getSjqitas";
	JSONObject sousuoSjqitaresult = PostUtil.sendPost(sousuoSjqitaurl, sousuoSjqitaparam.toString());
	if(sousuoSjqitaresult!=null){
		JSONArray sousuoSjqitajsonArray = (JSONArray)sousuoSjqitaresult.get("rows");
		//System.out.println(sousuoSjqitajsonArray);
		sousuoSjqitas = JSONArray.toList(sousuoSjqitajsonArray, new Sjqita(), new JsonConfig());
		if(sousuoSjqitas.size()>0){
			sousuoSjqita = sousuoSjqitas.get(0);
		}
		//for(int i = 0;i < sjqitas.size();i++){
		//	System.out.println(sjqitas.get(i).getSjqitaName());
		//}
		sousuoSjqitasshuliang = (Integer)sousuoSjqitaresult.get("total");
		//System.out.println(sjqitasshuliang);
	}
	int sjqitarowCount = 1;
	sjqitarowCount = Integer.parseInt(sousuoSjqitarows);
	int sjqitacurrPage = 0;
	sjqitacurrPage = Integer.parseInt(sousuoSjqitapage);
	int sjqitatotalPage = 0;
	sjqitatotalPage = (sousuoSjqitasshuliang + sjqitarowCount - 1)/sjqitarowCount;
%>