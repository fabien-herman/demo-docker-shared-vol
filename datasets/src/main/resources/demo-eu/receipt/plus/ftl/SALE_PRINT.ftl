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
      <#if _transaction.status == "COMPLETE" && _transaction.type == "SALE">
        <#global transaction=_transaction>
      </#if>
    </#list>

    <#include "PRINT_HEADER.ftl">
    <#include "PRINT_ITEMS.ftl">
    <#include "PRINT_TOTALS.ftl">
    <#include "PRINT_FOOTER.ftl">
    <#include "PRINT_FOOTER_INOQO.ftl">
    <@paperCut />

  </body>
</html>
</#list>
</#list>
