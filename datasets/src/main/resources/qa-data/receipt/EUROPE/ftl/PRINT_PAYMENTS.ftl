<!-- payments -->
<#assign voidedEftTransactions=[]/>
<#if order.payments??>
  <#list order.payments as payment>
    <#if !payment.voided?? || payment.voided == false >
      <#if payment.totalCharged.originalValue != 0>
          <#assign paymentTotal=payment.totalCharged.originalValue/>
          <#assign paymentTotalCurrency=payment.totalCharged.currencyCode/>
      <#else>
          <#assign paymentTotal=payment.totalAuthorized.originalValue/>
          <#assign paymentTotalCurrency=payment.totalAuthorized.currencyCode/>
      </#if>

      <#if payment.totalCharged?? && payment.totalCharged.conversionRate?? && payment.totalCharged.conversionRate != 1>
          <#assign paymentCurrency=payment.totalCharged.currencyValue.currencyCode/>
          <#assign paymentOriginalValue=payment.totalCharged.currencyValue.originalValue/>
          <@printLeftAligned text=spaces(1+quantityWidth+1+1) + (localized(payment.displayName))?right_pad(receiptWidth-1-quantityWidth-1-1-amountWidth - 5 - amountWidth-2) + printAmount(paymentOriginalValue) + paymentCurrency?right_pad(5) + printAmount(paymentTotal) />
          <@printLeftAligned text=spaces(1+quantityWidth+1+1) + "  1 " + paymentCurrency + " = " + payment.totalCharged.conversionRate?string("0.0000") + " " + paymentTotalCurrency />
      <#else>
          <@printLeftAligned text=spaces(1+quantityWidth+1+1) + (localized(payment.displayName))?right_pad(receiptWidth-1-quantityWidth-1-1-amountWidth-2) + printAmount(paymentTotal) />
      </#if>
    </#if>            
  </#list>
</#if>
