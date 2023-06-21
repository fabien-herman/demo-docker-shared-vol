<#list ORDER as order>
<#list NLS as nls>
<!DOCTYPE html [
   <!ENTITY nbsp "&#160;">
]>
<html xmls:localeUtil="http://toshibagcs.com/saxon-extension">
  <body>
    <!-- should only be 1 config, but data type is still list -->
    <#list CONFIG[0..*1] as _config>
       <#global nodeConfig=_config>
    </#list>

    <#list TRANSACTION[0..*1] as _transaction>
      <#if _transaction.status == "COMPLETE" && _transaction.type == "SUSPEND">
        <#global transaction=_transaction>
      </#if>
    </#list>

    <#include "PRINT_HEADER.ftl">

    <div class="feed"></div>

    <div class="feed"></div>
    
    <div class="line" id="title">${(nls.SUSPEND_title)!"SUSPEND SLIP"}</div>

    <div class="feed"></div>
    
    <div id="transInfo">
        <div class="line">${(nls.SUSPEND_items)!"ITEMS: "}${order.totalItemCount}</div>
    </div>

    <div class="feed" count="1"></div>

    <#include "PRINT_BARCODE.ftl">

    <div class="line">${(nls.SUSPEND_footer)!"NOT VALID FOR RETURNS"}</div>

    <div class="feed" count="1"></div>

    <#include "PRINT_TRANSACTION.ftl">
    <div class="line"></div>
    
    <#if nodeConfig??>
      <div class="line">${(nodeConfig.configurations.RECEIPT_FOOTER_SALE_PRINT.value.value)!}</div>
      <div class="feed"></div>
    </#if>
    <div class="feed-cut"></div>
  </body>
</html>
</#list>
</#list>