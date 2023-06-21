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
      <#global transaction=_transaction>
    </#list>

    <#include "PRINT_HEADER.ftl">

    <div class="feed"></div>

    <#if transaction.endState.status == "OPEN">
        <div class="line" id="title">${(nls.TILL_openTillTitle)!"OPEN TILL"}</div>
    <#else>
        <div class="line" id="title">${(nls.TILL_closeTillTitle)!"CLOSE TILL"}</div>
    </#if>

    <div class="feed"></div>

    <#include "TILL_GENERAL_PRINT.ftl">

    <div class="feed-cut"></div>
   </body>
</html>
</#list>
