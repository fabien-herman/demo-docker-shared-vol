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

            <#if payment.paymentEntryData.type == "REGIONAL_EUR">
                <#assign paymentTotalCurrency="Wert"/>
            </#if>

            <#if payment.totalCharged?? && payment.totalCharged.conversionRate?? && payment.totalCharged.conversionRate != 1>
                <#assign paymentCurrency=payment.totalCharged.currencyValue.currencyCode/>
                <#assign paymentOriginalValue=payment.totalCharged.currencyValue.originalValue/>
                <div id="payment" class="line">${localized(payment.displayName)?right_pad(15)}${paymentOriginalValue?string("0.00")?left_pad(9)?right_pad(10)}${paymentCurrency?right_pad(5)}${paymentTotal?string("0.00")?left_pad(10)}</div>
                <div class="line">${("  1 " + paymentCurrency + " = " + payment.totalCharged.conversionRate?string("0.0000") + " " + paymentTotalCurrency)?right_pad(40)}</div>
            <#else>
                <@printLeftAligned text=spaces(quantityWidth+1) + (localized(payment.displayName))?right_pad(receiptWidth-6-9-1-1-1) + printAmount(paymentTotal) />
            </#if>

            <!-- TRACK EFT PAYMENT TRANSACTIONS -->
            <#assign eftPaymentTransactions=[]>
            <#list payment.paymentTransactions![] as transaction>
                <#if transaction.request?? && transaction.request.type != "VOID">
                    <#if transaction.euEft?? && transaction.euEft.response?? && transaction.euEft.response.printData??>
                        <#assign eftPaymentTransactions += [transaction]>
                    </#if>
                </#if>
            </#list>

            <!-- PRINT EFT PAYMENT TRANSACTIONS DETAILS -->
            <#if eftPaymentTransactions?? && eftPaymentTransactions?has_content>
                <#assign eftTransactions = eftPaymentTransactions>
                <#include "EFT_PRINT_DATA.ftl">
            </#if>

            <#include "PRINT_REMAINING_CREDIT.ftl" ignore_missing=true>
        </#if>

        <!-- TRACK SUCCESSFUL VOIDED EFT TRANSACTIONS -->
        <#list payment.paymentTransactions![] as transaction>
            <#if transaction.successful?? && transaction.successful == true && transaction.request?? && transaction.request.type == "VOID">
                <#if transaction.euEft?? && transaction.euEft.response?? && transaction.euEft.response.printData??>
                    <#assign voidedEftTransactions += [transaction]>
                </#if>
            </#if>
        </#list>

    </#list>
</#if>

<!-- PRINT VOIDED EFT PAYMENTS DETAILS -->
<#if voidedEftTransactions?? && voidedEftTransactions?has_content>
    <div class="feed"/>
    <div class="eftPrintVoidedPaymentsTitle">${(nls.SALE_eftPrintVoidedPaymentsTitle)!"VOIDED EFT PAYMENTS"}</div>
    <#assign eftTransactions = voidedEftTransactions>
    <#include "EFT_PRINT_DATA.ftl">
</#if>
