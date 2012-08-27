import org.jahia.services.content.JCRContentUtils
import org.jahia.taglibs.jcr.node.JCRTagUtils
import org.apache.taglibs.standard.functions.Functions

title = currentNode.properties['jcr:title']
baseline = currentNode.properties['j:baselineNode']
maxDepth = currentNode.properties['j:maxDepth']
startLevel = currentNode.properties['j:startLevel']
styleName = currentNode.properties['j:styleName']
layoutID = currentNode.properties['j:layoutID']
// menuItemView = currentNode.properties['j:menuItemView'] ignored

def base;
if (!baseline || baseline.string =='home') {
    base = currentNode.resolveSite.home
} else if (baseline.string == 'currentPage') {
    base = JCRTagUtils.getMeAndParentsOfType(renderContext.mainResource.node, "jnt:page")[0]
}
if (!base) {
    base = renderContext.mainResource.node
}
startLevelValue = startLevel ? startLevel.long : 0


def printMenu;
printMenu = { node, navMenuLevel, omitFormatting ->
    if (navMenuLevel == 1) {
        if(styleName) {
            print ("<div class=\"${styleName.string}\">")
        }
        if (title) {
            print ("<span>${Functions.escapeXml(title.string)}</span>")
        }
        if (layoutID) {
            print("<div id=\"${layoutID.string}\">")
        }
    }

    empty = true
    if (node) {
        children = JCRContentUtils.getChildrenOfType(node, "jmix:navMenuItem")
        print (navMenuLevel == 1 ? "<select onchange=\"window.location=this.value\">" : "")


        children.eachWithIndex() { menuItem, index ->
            itemPath = menuItem.path
            inpath = renderContext.mainResource.node.path == itemPath || renderContext.mainResource.node.path.startsWith(itemPath)
            isSelected = menuItem.isNodeType("jmix:link") ?
                renderContext.mainResource.node.path == menuItem.properties['j:node'].node.path :
                renderContext.mainResource.node.path == itemPath
            correctType = true
            if (menuItem.properties['j:displayInMenu']) {
                correctType = false
                menuItem.properties['j:displayInMenu'].each() {
                    correctType |= it.node == currentNode
                }
            }
            selected = isSelected? "selected" : "";
            if ((startLevelValue < navMenuLevel || inpath) && correctType) {
                empty = false;
                hasChildren = navMenuLevel < maxDepth.long && JCRTagUtils.hasChildrenOfType(menuItem,"jnt:page,jnt:nodeLink,jnt:externalLink")
                if (startLevelValue < navMenuLevel) {
                    listItemCssClass = (hasChildren ? "hasChildren" : "") + (inpath ? " inpath" : "") + (isSelected ? " selected" : "") + (index == 0 ? " firstInLevel" : "") + (index == children.size()-1 ? " lastInLevel" : "") ;

                    // template:module : page.menuElement.jsp - need to handle other types than page
                    prefix = ""
                    for (it=1; it < navMenuLevel; it++) {
                        prefix +="- "
                    }
                    title = prefix + menuItem.displayableName
                    description = menuItem.properties['jcr:description']
                    linkTitle = description ? " title=\"${description.string}\"" : ""
                    if (menuItem.isNodeType("jnt:page")) {
                        link = menuItem.url

                        print "<option ${selected} value=\"${link}\"${linkTitle}>${title}</option>"
                    } else if (menuItem.isNodeType("jnt:nodeLink")) {
                        reference = menuItem.properties['j:node']
                        target = menuItem.properties['j:target']
                        if (reference && reference.node) {
                            link = url.base + reference.node.path + ".html"
                            print "<option ${selected} value=\"${link}\"${linkTitle} ${target ? target.string : ""}>${title}</option>"
                        }
                    } else if (menuItem.isNodeType("jnt:externalLink")) {
                        url = menuItem.properties['j:url']
                        target = menuItem.properties['j:target']
                        if (!url.string.startsWith("http")) {
                            print "<option ${selected} value=\"http://${url.string}\" ${linkTitle} ${target ? target.string : ""}>${title}</option>"
                        } else {
                            print "<option ${selected} value=\"${url.string}\" ${linkTitle} ${target ? target.string : ""}>${title}</option>"
                        }
                    }
                    // end template:module

                    if (hasChildren) {
                        printMenu(menuItem,navMenuLevel+1,true)
                    }


                } else if (hasChildren) {

                    printMenu(menuItem,navMenuLevel+1,true)

                }
            }

        }

        if (empty && renderContext.editMode) {
            print "<li class=\" selected\"><a onclick=\"return false;\" href=\"#\">Page1</a></li><li class=\"\"><a onclick=\"return false;\" href=\"#\">Page2</a></li><li class=\"\"><a onclick=\"return false;\" href=\"#\">Page3</a></li>"
        }
        print (navMenuLevel == 1 ? "</select>" : "")
    }

    if (navMenuLevel == 1) {
        if (layoutID) {
            print("</div>")
        }
        if(styleName) {
            print ("</div>")
        }
    }

}

printMenu(base,1,false)

