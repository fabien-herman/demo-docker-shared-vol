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
    <@printEmptyLine />

    <#if transaction.endState.status == "OPEN">
      <@printTitle text=(nls.TILL_openTillTitle)!"OPEN TILL" />
    <#else>
      <@printTitle text=(nls.TILL_closeTillTitle)!"CLOSE TILL" />
    </#if>
    <@printEmptyLine />

    <#include "TILL_GENERAL_PRINT.ftl">

    <@paperCut />
  </body>
</html>
</#list>


