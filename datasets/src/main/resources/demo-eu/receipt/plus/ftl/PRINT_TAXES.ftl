<!-- taxes -->
<#if order.taxes?has_content>
  <@printEmptyLine />
  <!--                     012345678901234567890123456789012345678901 -->
  <@printLeftAligned text=spaces(5) + (nls.SALE_orderTaxes!"Taxes")?right_pad(receiptWidth-5-amountWidth-amountWidth-2) + (nls.SALE_taxAmount!"Tax")?left_pad(amountWidth) + (nls.SALE_taxGross!"Gross")?left_pad(amountWidth) />
  <#list order.taxes?sort_by("rate") as tax>
    <#if tax.type!"" != "ECO">
      <#if tax.rateType! == "PERCENT">
        <#assign rate=tax.rate?string("0.0") + "%" />
      <#else>
        <#assign rate=tax.rate?string(amountFormat) />
      </#if>

      <#if tax.displayName?has_content>
        <#assign description=localized(tax.displayName) />
      <#else>
        <#assign description="VAT " + tax.indicator + " " + (rate + "%")/>
      </#if>
      <#assign description=description[0..*20] />
      <@printLeftAligned text=spaces(5) + description?right_pad(receiptWidth-5-amountWidth-amountWidth-2) + printAmount(tax.amount) + printAmount(tax.amountWithTax) />
    </#if>
  </#list>
</#if>
