<!-- orderChangeDue -->  
<#if order.paymentShortage lt 0>
    <#assign changeDue=order.paymentShortage />
<#else>
    <#assign changeDue=0 />
</#if>
<@printLeftAligned text=""?right_pad(quantityWidth+1) + (nls.SALE_change!"CHANGE")?right_pad(receiptWidth-6-9-1-1-1) + printAmount(changeDue) />
