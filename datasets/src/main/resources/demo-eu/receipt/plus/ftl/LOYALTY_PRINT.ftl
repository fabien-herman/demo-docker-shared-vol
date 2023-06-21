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

    <@printTitle text=(nls.LOYALTY_title)!"LOYALTY" />
    <@printEmptyLine />

    <#assign customer = transaction.endState>
    <#include "PRINT_CUSTOMER.ftl">

    <#assign n1=loyalty.loyaltyId?length-4 n2=loyalty.loyaltyId?length>
    <@printLeftAligned text=spaces(5) + ((loyalty.loyaltyType?replace("_", " ")?lower_case?cap_first) + ": ")?right_pad(receiptWidth-5-loyalty.loyaltyId?length-2) + ""?right_pad(n1, "x") + (loyalty.loyaltyId)?substring(n1,n2) />

    <#if customer.rewardPointBuckets??>
      <#list customer.rewardPointBuckets?keys as key>
        <@printLeftAligned text=spaces(5) + (key?lower_case?cap_first + " balance: ")?right_pad(receiptWidth-5-10-2) + ((customer.rewardPointBuckets[key])!0)?left_pad(10) />
      </#list>
    </#if>
    <@printEmptyLine />

    <@printSeparator "="/>
    <#include "PRINT_FOOTER.ftl">
    <@paperCut />
  </body>
</html>
</#list>
