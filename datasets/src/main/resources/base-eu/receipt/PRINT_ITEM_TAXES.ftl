<#if itemPrice.taxes?has_content>
  <#list itemPrice.taxes as tax>
    <#if tax.taxType?? && tax.taxType!="VAT">
      <div class="line">${""?right_pad(9)}<#if tax.displayName??>${localized(tax.displayName)?right_pad(15)}<#else>${tax.name?right_pad(15)}</#if> ${tax.amount?string("0.00;;roundingMode=halfUp")?left_pad(10)}</div>
    </#if>
  </#list>
</#if>
