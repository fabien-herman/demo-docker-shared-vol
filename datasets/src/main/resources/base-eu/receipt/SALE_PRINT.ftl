<#list ORDER as order>
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
      <#if _transaction.status == "COMPLETE" && _transaction.type == "SALE">
        <#global transaction=_transaction>
      </#if>
    </#list>

    <#include "PRINT_HEADER.ftl">
    <#include "PRINT_ITEMS.ftl">
    <#include "PRINT_TOTALS.ftl">

    <!-- orderCouponTotal -->
    <#if order.totalModificationCoupons?? && order.totalModificationCoupons != 0>
    <div class="line">${(nls.SALE_totalCoupons!"TOTAL COUPONS")?right_pad(23)}${order.totalModificationCoupons?string("0.00")?left_pad(15)}</div>
    </#if>

    <!-- orderSavingsTotal -->
    <#if order.totalModificationDiscounts?? && order.totalModificationDiscounts != 0>
    <div class="line">${(nls.SALE_totalSavings!"TOTAL SAVINGS")?right_pad(23)}${order.totalModificationDiscounts?string("0.00")?left_pad(15)}</div>
    </#if>

    <!-- orderSurchargeTotal -->
    <#if order.totalModificationSurcharges?? && order.totalModificationSurcharges != 0>
    <div class="line">${(nls.SALE_totalSurcharges!"TOTAL SURCHARGES")?right_pad(23)}${order.totalModificationSurcharges?string("0.00")?left_pad(15)}</div>
    </#if>

    <#include "PRINT_BARCODE.ftl">
    <@printEmptyLine />
    <#include "PRINT_FOOTER.ftl">
    <@paperCut />

    <#include "PRINT_DEPOSIT_REFUND_VOUCHER.ftl">

  </body>
</html>
</#list>
</#list>
