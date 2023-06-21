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

    <@printTitle text=(nls.TILL_tillPickupTitle)!"TILL PICKUP" />
    <@printEmptyLine />

    <#include "TILL_GENERAL_PRINT.ftl">
    <@printEmptyLine />

    <#include "TILL_CONTENTS_PRINT.ftl">
    <@printEmptyLine />

    <@paperCut />
  </body>
</html>
</#list>
