<#include "PRINT_FISCAL_SIGNATURE.ftl" ignore_missing=true>
<#include "PRINT_TRANSACTION.ftl">
<@printEmptyLine />

<#if nodeConfig??>
  <@printCentered text=(nodeConfig.configurations.RECEIPT_FOOTER_SALE_PRINT.value.value)! />
  <@printEmptyLine />
</#if>

<#if order??>
  <#include "PRINT_DEMO_BARCODE.ftl" ignore_missing=true>
  <#if order.items??>
    <#list order.items as orderItem>
      <#list orderItem.prices as itemPrice>
        <#if itemPrice.priceModifications??>
          <#list itemPrice.priceModifications as priceModification>
            <#if priceModification.receiptFooters??>
              <#list priceModification.receiptFooters as receiptFooter>
                <#if receiptFooter.message?? && !receiptFooter.orderLevelMessage>
                  <div class="line">${localized(receiptFooter.message)}</div>
                </#if>
                <#if receiptFooter.barcodeData?? && receiptFooter.symbology??>
                  <div class="barcode" data="${receiptFooter.barcodeData}" symbology="${receiptFooter.symbology}"></div>
                  <div class="line">${receiptFooter.barcodeData}</div>
                </#if>
              </#list>
            </#if>
          </#list>
        </#if>
      </#list>
    </#list>
  </#if>

  <#if order.priceModifications??>
    <#assign printBottleReturnCoupon = false>
    <#if order.reasonCodes??>
      <#list order.reasonCodes as reasonCode>
        <#if reasonCode.id?? && reasonCode.code??>
          <#if reasonCode.id == "BOTTLE_RETURN_REASON_CODE" && reasonCode.code == "COUPON"> 
            <#assign printBottleReturnCoupon = true>
          </#if>
        </#if>
      </#list>
    </#if>

    <#list order.priceModifications as priceModification>
      <#assign printReceiptFooters = true>
      <#if priceModification.offerId?? && priceModification.offerId == "BOTTLE_RETURN_COUPON_OUT" && printBottleReturnCoupon == false> 
        <#assign printReceiptFooters = false>
      </#if>
      <#if printReceiptFooters> 
        <#if priceModification.receiptFooters??>
          <#list priceModification.receiptFooters as receiptFooter>
            <#if receiptFooter.message??>
              <div class="line">${center(localized(receiptFooter.message))}</div>
            </#if>
            <#if receiptFooter.barcodeData?? && receiptFooter.symbology??>
              <div class="barcode" data="${receiptFooter.barcodeData}" symbology="PTR_BCS_EAN13"></div>
              <div class="line">${center("Coupon: " + receiptFooter.barcodeData)}</div>
            </#if>
          </#list>
        </#if>
      </#if>
    </#list>
  </#if>
</#if>