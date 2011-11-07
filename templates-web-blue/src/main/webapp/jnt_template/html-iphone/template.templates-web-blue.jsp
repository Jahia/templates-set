<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN"
"http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ page language="java" contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="template" uri="http://www.jahia.org/tags/templateLib" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="jcr" uri="http://www.jahia.org/tags/jcr" %>
<%--@elvariable id="currentNode" type="org.jahia.services.content.JCRNodeWrapper"--%>
<%--@elvariable id="out" type="java.io.PrintWriter"--%>
<%--@elvariable id="script" type="org.jahia.services.render.scripting.Script"--%>
<%--@elvariable id="scriptInfo" type="java.lang.String"--%>
<%--@elvariable id="workspace" type="java.lang.String"--%>
<%--@elvariable id="renderContext" type="org.jahia.services.render.RenderContext"--%>
<%--@elvariable id="currentResource" type="org.jahia.services.render.Resource"--%>
<%--@elvariable id="url" type="org.jahia.services.render.URLGenerator"--%>
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="${fn:substring(renderContext.request.locale,0,2)}">
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <meta name="viewport" content="width=device-width; initial-scale=1.0; maximum-scale=1.0; user-scalable=0;" />
    <meta name="apple-mobile-web-app-capable" content="yes" />
    <meta name="apple-mobile-web-app-status-bar-style" content="black-translucent" />
    <jcr:nodeProperty node="${renderContext.mainResource.node}" name="jcr:description" inherited="true" var="description"/>
    <jcr:nodeProperty node="${renderContext.mainResource.node}" name="jcr:createdBy" inherited="true" var="author"/>
    <jcr:nodeProperty node="${renderContext.mainResource.node}" name="j:keywords" inherited="true" var="kws"/>
    <c:set var="keywords" value=""/>
    <c:forEach items="${kws}" var="keyword">
        <c:choose>
            <c:when test="${empty keywords}">
                <c:set var="keywords" value="${keyword.string}"/>
            </c:when>
            <c:otherwise>
                <c:set var="keywords" value="${keywords}, ${keyword.string}"/>
            </c:otherwise>
        </c:choose>
    </c:forEach>
    <c:if test="${!empty description}"><meta name="description" content="${description.string}" /></c:if>
    <c:if test="${!empty author}"><meta name="author" content="${author.string}" /></c:if>
    <c:if test="${!empty keywords}"><meta name="keywords" content="${keywords}" /></c:if>

    <link rel="stylesheet" type="text/css" href="<c:url value='${url.currentModule}/css/print.css'/>" media="print" />
    <title>${fn:escapeXml(renderContext.mainResource.node.displayableName)}</title>
</head>

<body>

<div class="bodywrapper"><!--start bodywrapper-->
  <!-- ACME logo -->
  <div id="header">
    <template:module path="header-col1"/>
  </div>
  <!-- Navigation menu -->
  <template:module path="headerBottom-colContent"/>
  <!-- Main content for most templates -->
  <template:area path="maincontent"/>

  <!-- News detail view -->
  <template:area path="row-col1/mainResourceDisplay"/>

  <!-- Event list view -->
  <template:area path="row1-col1/events"/>

  <!-- Publications list view -->
  <template:area path="row1-col1/publications"/>
</div>
<!--stop bodywrapper-->

<c:if test="${renderContext.editMode}">
    <template:addResources type="css" resources="edit.css" />
</c:if>
<template:addResources type="css" resources="960.css,mobile-01web.css,02mod.css,mobile-navigationN1.css,navigationN2-2.css"/>
<template:theme/>

</body>
</html>
