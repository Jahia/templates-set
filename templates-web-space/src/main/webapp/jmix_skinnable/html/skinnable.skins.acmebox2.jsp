<%@ taglib uri="http://www.jahia.org/tags/jcr" prefix="jcr" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix="template" uri="http://www.jahia.org/tags/templateLib" %>
<template:addResources type="css" resources="acmeskins.css"/>

<jcr:nodeProperty node="${currentNode}" name="jcr:title" var="title"/>

<div class="acmebox2 acmebox2-${currentNode.properties['j:style'].string}">
                <c:if test="${not empty title}">
                    <h3 class="acmebox2-title">${fn:escapeXml(title.string)}</h3>
                </c:if>
                ${wrappedContent}
                <div class="clear"></div>
                
                
</div>
<div class="acmebox2-shadow"><div class="acmebox2-shadow-left"></div><div class="acmebox2-shadow-right"></div></div>
<div class="clear"></div>