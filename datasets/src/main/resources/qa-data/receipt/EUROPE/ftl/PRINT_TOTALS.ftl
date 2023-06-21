  <!-- already printed item level priceModifications -->
<#assign alreadyPrintedItemDiscount = 0 />
<#list PreProcessedPriceModifications?values as priceModification>
  <#if priceModification.count == 1>
    <#-- Itemlevel promo, single items -->
    <#assign alreadyPrintedItemDiscount += priceModification.amount />
  </#if>
</#list>

<!-- subtotal -->
<@printRightAligned text=""?right_pad(receiptWidth/2, "=") />
<@printRightAligned text=(nls.SALE_subtotal!"Subtotal")?right_pad(receiptWidth/2-1-amountWidth-1) + printAmount(order.totalItems + alreadyPrintedItemDiscount) + spaces(2/2) doubleWidth=true />
<@printEmptyLine />

<!-- item level priceModifications -->
<#list PreProcessedPriceModifications?values as priceModification>
  <#if priceModification.count gt 1>
    <#-- Itemlevel promo, multiple items -->
    <#assign maxDescriptionWidth=receiptWidth-1-quantityWidth-1-1-2-amountWidth />
    <#assign description=localized(priceModification.description)?trim[0..*maxDescriptionWidth] />
    <#assign promoMarker="*" />
    <#if priceModification.combinations?size == 1>
      <#assign quantity=spaces(quantityWidth+2) />
    <#else>
      <#assign quantity=printQuantity(priceModification.combinations?size) + "X " />
    </#if>
    <@printLeftAligned text=promoMarker + quantity + description?right_pad(maxDescriptionWidth) + printAmountWithCurrency(priceModification.amount) + spaces(2)/>
  </#if>
</#list>

<!-- order level priceModifications -->
<#if order.priceModifications??>
  <#list order.priceModifications as priceModification>
    <#if ! (priceModification.value == 0) >
      <#assign maxDescriptionWidth=receiptWidth-1-quantityWidth-1-1-2-amountWidth />
      <#assign description=localized(priceModification.customerMessage)?trim[0..*maxDescriptionWidth] />
      <#assign promoMarker=" " />
      <@printLeftAligned text=promoMarker + spaces(quantityWidth+2) + description?right_pad(maxDescriptionWidth) + printAmountWithCurrency(priceModification.value) + spaces(2)/>
    <#-- pointsAwarded field is not always set?  TBC.
    <#elseif ! (priceModification.pointsAwarded == 0) >
      <#assign maxDescriptionWidth=receiptWidth-1-quantityWidth-1-1-2-quantityWidth />
      <#assign description=localized(priceModification.customerMessage)?trim[0..*maxDescriptionWidth] />
      <#assign promoMarker=" " />
      <@printLeftAligned text=promoMarker + spaces(quantityWidth+2) + description?right_pad(maxDescriptionWidth) + printQuantity(priceModification.pointsAwarded) + spaces(2)/>
    -->      
    </#if>
  </#list>
</#if>

<!-- balance -->
<@printRightAligned text=""?right_pad(receiptWidth/2, "=") />
<@printRightAligned text=(nls.SALE_balance!"Balance")?right_pad(receiptWidth/2-1-amountWidth-1) + printAmount(order.total) + spaces(2/2) doubleWidth=true />

<!-- total savings -->
<#if order.totalNegativePriceModifications?? && order.totalNegativePriceModifications != 0>
  <@printEmptyLine />
  <@printLeftAligned text=spaces(1+quantityWidth+1+1) + (nls.SALE_totalSavings!"TOTAL SAVINGS") + " " + printAmountWithCurrency(order.totalNegativePriceModifications)?trim bold=true />
  <@printEmptyLine />
</#if>

<!-- payments -->
<#include "PRINT_PAYMENTS.ftl">

<!-- orderChangeDue -->
<#if order.paymentShortage lt 0>
    <#assign changeDue=order.paymentShortage />
<#else>
    <#assign changeDue=0 />
</#if>
<@printLeftAligned text=spaces(1+quantityWidth+1+1) + (nls.SALE_change!"CHANGE")?right_pad(receiptWidth-1-quantityWidth-1-1-amountWidth-2) + printAmount(changeDue) />

<!-- taxes -->
<#include "PRINT_TAXES.ftl">

<!-- orderItemCount -->
<@printEmptyLine />
<@printLeftAligned text=spaces(1+quantityWidth+1+1) + printQuantity(order.totalItemCount)?trim + " " + nls.SALE_totalItems!"items" />
<@printSeparator "="/>

<!-- customer -->
<#include "PRINT_CUSTOMER.ftl">
