<#list thisItem.prices as itemPrice>

  <!-- Determine UOMType -->
  <#if thisItem.item.UOMType??>
    <#assign UOMType=thisItem.item.UOMType>
  <#elseif thisItem.item.isUOMTypeEach??>
    <#assign UOMType="EACH">
  <#elseif thisItem.item.UOM??>
    <#if thisItem.item.UOM=="EACH">
      <#assign UOMType="EACH">
    </#if>
  <#else>
    <#assign UOMType="UNDEFINED">
  </#if>

  <!-- Only print is there is a quantity greater than 0 -->
  <#if itemPrice.quantity gt 0.0>

    <!-- Normalize VAT code -->
    <#assign vatCode=" ">
    <#if itemPrice.taxes?has_content>
      <#list itemPrice.taxes as tax>
        <#if tax.type!""!="ECO">
          <#assign vatCode=tax.indicator[0..*2]>
          <#break>
        </#if>
      </#list>
    </#if>

    <!-- Normalize item description -->
    <#if thisItem.item.displayName?has_content>
      <#assign description=localized(thisItem.item.displayName) />
    <#else>
      <#assign description="SKU " + thisItem.item.skuId />
    </#if>
    <#assign description=description[0..*descriptionWidth] />

    <!-- determine promo marker -->
    <#assign promoMarker=" " />
    <#if itemPrice.priceModifications??>
      <#list itemPrice.priceModifications as itemPriceModification>
        <#if itemPriceModification.id??>
          <#if PreProcessedPriceModifications[itemPriceModification.id].count gt 1 >
            <#-- Mark items with a priceModification that applies to multiple items -->
            <#assign promoMarker="*" />
          </#if>
        </#if>
      </#list>
    </#if>

    <!-- print item -->
    <#if UOMType == "EACH">
      <#if itemPrice.quantity == 1>
        <@printLeftAligned text=promoMarker + spaces(4) + description?right_pad(receiptWidth-1-quantityWidth-1-1-amountWidth-2) + printAmount(itemPrice.totalBeforeModifications) + spaces(2) />
      <#else>
        <#assign quantity=printQuantity(itemPrice.quantity) />
        <@printLeftAligned text=promoMarker + quantity + "X " + description?right_pad(receiptWidth-1-quantityWidth-1-1-unitPriceWidth-amountWidth-2) + printUnitPrice(itemPrice.salePrice) + printAmount(itemPrice.totalBeforeModifications) + spaces(2) />
      </#if>
    <#else>
      <@printLeftAligned text=promoMarker + spaces(4) + description?right_pad(receiptWidth-1-4-amountWidth-2) + printAmount(itemPrice.totalBeforeModifications) + spaces(2) />
      <@printLeftAligned text=promoMarker + spaces(4) + printWeight(itemPrice.quantity) + "kg X " + printUnitPrice(itemPrice.salePrice)?trim + currencySymbol + "/kg" />
    </#if>

    <!-- tare -->
    <#if UOMType == "WEIGHT">
      <#if thisItem.tare??>
        <@printLeftAligned text=spaces(quantityWidth+1) + nls.SALE_tareDescription!"Tare: " + printWeight(thisItem.tare.weight) + thisItem.tare.UOM />
      </#if>
    </#if>

    <!-- item SerialNo -->
    <#if thisItem.serial?has_content>
      <@printLeftAligned text=spaces(quantityWidth+1) + nls.SALE_serialDescription!"SerialNo: " + thisItem.serial />
    </#if>

    <!-- item Price Modifications -->
    <#if itemPrice.priceModifications??>
      <#list itemPrice.priceModifications as itemPriceModification>
        <#if itemPriceModification.id??>
          <#-- Only print items with a priceModification that applies to a single item.  If it applies to multiple items then it is printed in PRINT_TOTALS -->
          <#if PreProcessedPriceModifications[itemPriceModification.id].count == 1 >
            <#assign maxDescriptionWidth=receiptWidth-1-quantityWidth-1-1-2-amountWidth-2 />
            <#assign description=localized(itemPriceModification.customerMessage)?trim[0..*maxDescriptionWidth] />
            <@printLeftAligned text=spaces(1+quantityWidth+1+1+2) + description?right_pad(maxDescriptionWidth) + printAmount(itemPriceModification.value) + spaces(2)/>
          </#if>
        </#if>
      </#list>
    </#if>

    <!-- itemTaxes -->
    <#if itemPrice.taxes?has_content>
      <#list itemPrice.taxes as tax>
          <#if tax.type!""=="ECO">
            <@printLeftAligned text=spaces(quantityWidth+1) + tax.name?right_pad(receiptWidth-quantityWidth-1-amountWidth-1-1-1) + printAmount(tax.amount) />
          </#if>
      </#list>
    </#if>

    <!-- itemReasonCodes -->
    <#if itemPrice.reasonCodes??>
      <#list itemPrice.reasonCodes as itemReasonCode>
        <@printLeftAligned text=spaces(quantityWidth+1) + itemReasonCode.code />
      </#list>
    </#if>

  </#if>
</#list>
