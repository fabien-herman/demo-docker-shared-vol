<#function printUnitPrice amount>
  <#return amount?string(amountFormat)?left_pad(unitPriceWidth) />
</#function>

<#function printAmount amount width=amountWidth>
  <#return amount?string(amountFormat)?left_pad(width) />
</#function>

<#function printAmountWithCurrency amount currency=currencySymbol width=amountWithCurrencyWidth>
  <#return amount?string(amountWithCurrencyFormat)?left_pad(width) />
</#function>

<#function printQuantity quantity width=quantityWidth>
  <#return quantity?string(quantityFormat)?left_pad(width) />
</#function>

<#function printWeight weight width=weightWidth>
  <#return weight?string(weightFormat)?left_pad(width) />
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

<#function center text width=receiptWidth>
  <#local textLength = text?length />
  <#local spaces = (width - textLength)/2 />
  <#return text?left_pad(spaces + textLength)?right_pad(width) />
</#function>

<#macro printLeftAligned text="" bold=false doubleWidth=false>
  <#if doubleWidth == true>
    <div id="title" class="line">${text?right_pad(receiptWidth/2)}</div>
  <#elseif bold == true>
    <div id="bold" class="line">${text?right_pad(receiptWidth)}</div>
  <#else>
    <div class="line">${text?right_pad(receiptWidth)}</div>
  </#if>
</#macro>

<#macro printRightAligned text="" bold=false doubleWidth=false>
  <#if doubleWidth == true>
    <div id="title" class="line">${text?left_pad(receiptWidth/2)}</div>
  <#elseif bold == false>
    <div class="line">${text?left_pad(receiptWidth)}</div>
  <#else>
    <div id="bold" class="line">${text?left_pad(receiptWidth)}</div>
  </#if>
</#macro>

<#macro printCentered text="" bold=false doubleWidth=false>
  <#if doubleWidth == true>
    <div id="title" class="line">${center(text, receiptWidth/2)}</div>
  <#elseif bold == false>
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

<#macro paperCut percentage=100>
  <div class="feed-cut" percentage="${percentage}"></div>
</#macro>

<#macro printBarcode data symbology width=250 height=90 codeSet="">
  <#if codeSet == "">
    <div class="barcode" data="${data}" symbology="${symbology}" width="${width}" height="${height}"></div>
  <#else>
    <div class="barcode" data="${data}" symbology="${symbology}" width="${width}" height="${height}" codeset="${codeSet}"></div>
  </#if>
</#macro>

<#macro printTitle text="">
  <@printEmptyLine />
  <div class="line" id="title">${text}</div>
  <@printEmptyLine />
</#macro>

<#-- 
  Pre-Process PriceModifications;
  - To distinguish single item promotions and multi item promotions:
    - If the priceModification.id occurs only once it is a modification for a single item
    - If the priceModification.id occurs multiple times then it is a modification for multiple items
  - To count the number of combinations:
    - For each combination another combinationId is used
      (e.g. 2x a meal deal = same priceModificationId but different combinationId)
-->
<#function preProcessPriceModifications items>
  <#assign groupedPriceModifications = {} />
  <#list items as thisItem>
    <#list thisItem.prices as thisPrice>
      <#if thisPrice.priceModifications??>
        <#list thisPrice.priceModifications as thisPriceModification>
          <#-- Only process the item level priceModifications -->
          <#if thisPriceModification.orderLevelPromotion == false >
            <#assign priceModificationId = thisPriceModification.id />
            <#assign priceModificationDetails = { "id": priceModificationId, "count": 1, "description": thisPriceModification.customerMessage, "amount": thisPriceModification.value, "combinations": [] } />
            <#if thisPriceModification.combinationReferenceId?? >
              <#assign priceModificationDetails += { "combinations": [thisPriceModification.combinationReferenceId] } />
            </#if>
            <#-- Update the details if we already had this priceModification before -->
            <#if groupedPriceModifications[priceModificationId]?? >
              <#assign alreadyGroupedPriceModification = groupedPriceModifications[priceModificationId] />
              <#assign priceModificationDetails += { "count": alreadyGroupedPriceModification.count + priceModificationDetails.count, "amount": alreadyGroupedPriceModification.amount + priceModificationDetails.amount } />
              <#if alreadyGroupedPriceModification.combinations?seq_contains(thisPriceModification.combinationReferenceId) >
                <#assign priceModificationDetails += { "combinations": alreadyGroupedPriceModification.combinations } />
              <#else>
                <#assign priceModificationDetails += { "combinations": alreadyGroupedPriceModification.combinations + priceModificationDetails.combinations } />
              </#if>
            </#if>
            <#assign groupedPriceModifications += { priceModificationId: priceModificationDetails } />
          </#if>
        </#list>
      </#if>
    </#list>
  </#list>
  <#return groupedPriceModifications>
</#function>
