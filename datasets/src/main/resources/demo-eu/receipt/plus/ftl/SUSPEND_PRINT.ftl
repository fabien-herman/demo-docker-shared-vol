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

    <@printTitle text=(nls.SUSPEND_title)!"SUSPEND SLIP" />

    <@printCentered text=(nls.SUSPEND_items)!"ITEMS: " + printQuantity(order.totalItemCount)?trim />
    <@printEmptyLine />

    <@printCentered text=(nls.SUSPEND_footer)!"NOT VALID FOR RETURNS" />
    <@printEmptyLine />

    <@printSeparator "="/>
    <#include "PRINT_FOOTER.ftl">
    <@paperCut />

  </body>
</html>
</#list>
</#list>
