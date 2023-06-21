<#list thisItem.prices as itemPrice>

    <!-- Determine UOM -->
    <#if !thisItem.item.UOM??>
        <#assign UOM="EACH">
    <#else>
        <#assign UOM=thisItem.item.UOM>
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

        <!-- print item -->
        <#if UOM != "EACH">
            <#assign quantity=printWeight(itemPrice.quantity) />
        <#else>
            <#assign quantity=printQuantity(itemPrice.quantity) />
        </#if>
        <@printLeftAligned text=quantity + " " + description?right_pad(receiptWidth-quantityWidth-1-2*amountWidth-1-1-1) + printAmount(itemPrice.salePrice) + printAmount(itemPrice.subTotal) + " " + vatCode />

        <!-- tare -->
        <#if UOM != "EACH">
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
                <@printLeftAligned text=spaces(quantityWidth+1) + localized(itemPriceModification.customerMessage)?right_pad(receiptWidth-quantityWidth-1-2*amountWidth-1-1-1) + printAmount(itemPriceModification.value) />
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
