<%@ taglib prefix="jcr" uri="http://www.jahia.org/tags/jcr" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="utility" uri="http://www.jahia.org/tags/utilityLib" %>
<%@ taglib prefix="template" uri="http://www.jahia.org/tags/templateLib" %>
<%--@elvariable id="currentNode" type="org.jahia.services.content.JCRNodeWrapper"--%>
<template:addResources type="css" resources="acmeteaser.css"/>
<jcr:nodeProperty node="${currentNode}" name="image" var="image"/>

 <%--<jcr:nodeProperty node="${currentNode}" name="link" var="link"/>--%>

<div class="boxacmeteaser">
    <template:addCacheDependency uuid="${currentNode.properties.link.string}"/>
    <template:addCacheDependency uuid="${image.string}"/>
	<c:if test="${not empty currentNode.properties.link.node}">
		<a style="padding-left: 90px; background: url('${image.node.url}') 10px 10px no-repeat;" href="<c:url value='${url.base}${currentNode.properties.link.node.path}.html'/>">
				<h3 style="margin: 5px 0px 5px 0px;"><jcr:nodeProperty node="${currentNode}" name="jcr:title"/></h3>
				${currentNode.properties.abstract.string} 
		</a>
	</c:if>
</div>