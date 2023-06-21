<!-- Carrefour - negative symbol behind the amount -->
<#function printPrice price>
    <#return price?abs?string["0.00"]?left_pad(9) + (price<0)?then("-", " ") />
</#function>

<#function printAmount amount width=amountWidth>
    <#return amount?string(amountFormat)?left_pad(width) />
</#function>

<#function printAmountWithCurrency amount currency>
    <#return amount?string(currency + " " + amountFormat + ";" + currency + " -" + amountFormat)?left_pad(amountWidthWithCurrency) />
</#function>

<#function printQuantity quantity>
    <#return quantity?left_pad(quantityWidth) />
</#function>

<#function printWeight weight>
    <#return weight?string(weightFormat)?left_pad(weightWidth) />
</#function>

<#function center text totalWidth=receiptWidth)>
    <#local textLength = text?length />
    <#local spaces = (totalWidth - textLength)/2 />
    <#return text?left_pad(spaces + textLength)?right_pad(totalWidth) />
</#function>

<#function printDateTime dt>
    <#return dt?datetime("iso")?string[dateTimeFormat] />
</#function>

<#function printDate dt>
    <#return dt?datetime("iso")?string[dateFormat] />
</#function>

<#function printTime dt>
    <#return dt?datetime("iso")?string[timeFormat] />
</#function>

<#function spaces len>
    <#return " "?right_pad(len) />
</#function>

<#macro printLeftAligned text="" bold=false doublewidth=false>
    <#if doublewidth == true>
        <div id="title" class="line">${text?right_pad(receiptWidth/2)}</div>
    <#elseif bold == true>
        <div id="bold" class="line">${text?right_pad(receiptWidth)}</div>
    <#else>
        <div class="line">${text?right_pad(receiptWidth)}</div>
    </#if>
</#macro>

<#macro printTitle text="">
    <@printEmptyLine />
    <div class="line" id="title">${text}</div>
    <@printEmptyLine />
</#macro>

<#macro printRightAligned text="" bold=false>
    <#if bold == false>
        <div class="line">${text?left_pad(receiptWidth)}</div>
    <#else>
        <div id="bold" class="line">${text?left_pad(receiptWidth)}</div>
    </#if>
</#macro>

<#macro printCentered text="" bold=false>
    <#if bold == false>
        <div class="line">${center(text)}</div>
    <#else>
        <div id="bold" class="line">${center(text)}</div>
    </#if>
</#macro>

<#macro printLogo id = 1>
    <div id="headerLogo" class="print-image" bitmapNumber="${id}"></div>
</#macro>

<#macro printEmptyLine>
    <div class="line"></div>
</#macro>

<#macro printSeparator char>
    <@printLeftAligned text=""?right_pad(receiptWidth, char) />
</#macro>

<#macro paperCut>
    <div class="feed-cut"></div>
</#macro>

<#macro printBarcode data symbology codeset = "">
    <#if codeset == "">
        <div class="barcode" data="${data}" symbology="${symbology}"></div>
    <#else>
        <div class="barcode" data="${data}" symbology="${symbology}" codeset="${codeset}"></div>
    </#if>
</#macro>