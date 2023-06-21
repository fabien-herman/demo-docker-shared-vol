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
  <div class="line" id="title">${(nls.LOYALTY_title)!"LOYALTY"}</div>
  <div class="feed"></div>

  <#assign customer = transaction.endState>
  <#assign n1 = customer.loyaltyId?length-4 n2 = customer.loyaltyId?length>
  <#lt><div class="line">${""?right_pad(4)}****  LOYALTY ID  ${""?left_pad(n1, "*")}${customer.loyaltyId?substring(n1,n2)}</div>

  <#if customer.rewardPointBuckets??>
    <#list customer.rewardPointBuckets?keys as key>
      <#lt><div class="line">${""?right_pad(1)}  ${key} BALANCE = ${customer.rewardPointBuckets[key]}</div>
    </#list>
  </#if>

  <div class="feed"></div>

  <#include "PRINT_FOOTER.ftl">
  <@paperCut />

  </body>
</html>
</#list>
