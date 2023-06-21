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
    <div class="line" id="title">${(nls.TILL_tillPickupTitle)!"TILL PICKUP"}</div>
    <div class="feed"></div>

    <#include "TILL_GENERAL_PRINT.ftl">
    <div class="feed"></div>

    <#include "TILL_CONTENTS_PRINT.ftl">

  <div class="feed"></div>

  <@paperCut />

   </body>
</html>
</#list>
