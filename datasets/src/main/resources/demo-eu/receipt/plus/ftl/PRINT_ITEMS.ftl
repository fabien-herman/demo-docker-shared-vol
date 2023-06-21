<#if order.items??>
  <#-- Pre-Process PriceModifications, to distinguish single item promotions and multi item promotions. -->
  <#global PreProcessedPriceModifications = preProcessPriceModifications(order.items) />

  <@printSeparator "="/>
  <!--                     012345678901234567890123456789012345678901 -->
  <@printLeftAligned text=nls.SALE_itemsHeader!"    Description          P.pc/kg   Amount " />
  <@printSeparator "="/>

  <#list order.items as thisItem>
    <#include "PRINT_SINGLE_ITEM.ftl">
  </#list>
</#if>
