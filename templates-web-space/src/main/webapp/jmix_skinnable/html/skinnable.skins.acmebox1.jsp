<%@ taglib uri="http://www.jahia.org/tags/jcr" prefix="jcr" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix="template" uri="http://www.jahia.org/tags/templateLib" %>

<template:addResources type="css" resources="acmeskins.css"/>

<jcr:nodeProperty node="${currentNode}" name="jcr:title" var="title"/>
<div class="relative">
<div class="acmebox1">

    <c:if test="${not empty title}">
      <div class="clear"></div>
      <h3 class="acmebox1-title">${fn:escapeXml(title.string)}</h3>
    </c:if>
    <div class="acmebox1-content ${!empty currentNode.properties.acmeicon ? ' acmebox1-content-icon' : ''}"> ${wrappedContent}
      <div class="clear"></div>
    </div>

</div>
</div>