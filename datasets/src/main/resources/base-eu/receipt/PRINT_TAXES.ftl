<!-- taxes -->
<#if order.taxes?has_content>
    <@printEmptyLine />
    <@printCentered text=spaces(2) + (nls.SALE_TaxRate!"Rate")?left_pad(amountWidth) + (nls.SALE_TaxNet!"Net")?left_pad(amountWidth) + (nls.SALE_TaxAmount!"Tax")?left_pad(amountWidth) + (nls.SALE_TaxGross!"Gross")?left_pad(amountWidth) />
    <#list order.taxes as tax>

        <#if tax.type!"" != "ECO">
            <#if tax.rateType! == "PERCENT">
                <#assign rate=tax.rate?string("0.0") + "%" />
            <#else>
                <#assign rate=tax.rate?string(amountFormat) />
            </#if>

            <@printCentered text=tax.indicator?right_pad(2) + rate?left_pad(amountWidth) + printAmount(tax.taxableAmount!0) + printAmount(tax.amount) + printAmount(tax.amountWithTax) />
        </#if>

    </#list>
    <@printEmptyLine />
</#if>
