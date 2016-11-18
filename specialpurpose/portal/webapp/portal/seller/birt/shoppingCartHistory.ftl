

<#assign birt = JspTaglibs["/WEB-INF/birt.tld"]/>

<@birt.report id="birtReport"
    reportDesign="component://portal/webapp/portal/seller/report/shoppingCartHistoryHTML.rptdesign"
    baseURL="/portal"
    height="700"
    width="900"
    format="html"
    isHostPage="false"
    pageNum="2">
</@birt.report>

