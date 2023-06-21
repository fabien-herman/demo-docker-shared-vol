<#if transaction?? && transaction.endState??>
  <#list transaction.endState.contents as content>
    <#assign tenderName = content.type>
    <#if content.displayName?has_content >
      <#assign tenderName = localized(content.displayName)>
    </#if>
    <#if content.tillAmountReconcilable?? && content.tillAmountReconcilable == true && content.amount??>
      <@printCentered text=tenderName + " " + content.currencyCode + " " + ((nls.TILL_amount)!"Amount: ") + printAmount((content.amount!0))?trim />
    </#if>
    <#if content.tillQuantityReconcilable?? && content.tillQuantityReconcilable == true && content.quantity??>
      <@printCentered text=tenderName + " " + content.currencyCode + " " + ((nls.TILL_quantity)!"Quantity: ") + printQuantity((content.quantity!0))?trim />
    </#if>
  </#list>
</#if>
