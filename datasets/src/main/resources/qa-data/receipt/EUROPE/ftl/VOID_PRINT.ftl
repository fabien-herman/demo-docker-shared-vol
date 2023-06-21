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
      <#if _transaction.status == "COMPLETE" && _transaction.type == "VOID">
        <#global transaction=_transaction>
      </#if>
    </#list>

    <#include "PRINT_HEADER.ftl">

    <@printTitle text=(nls.VOID_title)!"VOID DURING" />

    <#include "PRINT_ITEMS.ftl">

    <@printEmptyLine />
    <@printCentered text=(nls.VOID_voidLine)!"VOID VOID VOID VOID VOID VOID VOID VOID" />
    <@printCentered text=(nls.VOID_voidLine)!"VOID VOID VOID VOID VOID VOID VOID VOID" />
    <@printEmptyLine />
    <@printRightAligned text=(nls.VOID_totalAmount!"VOID AMOUNT")?right_pad(receiptWidth/2-1-amountWidth-1) + printAmount(order.total) + spaces(2/2) doubleWidth=true />
    <@printEmptyLine />

    <@printSeparator "="/>
    <#include "PRINT_FOOTER.ftl">
    <@paperCut />

  </body>
</html>
</#list>
</#list>