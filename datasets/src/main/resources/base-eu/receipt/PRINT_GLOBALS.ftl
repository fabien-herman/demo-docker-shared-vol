<#global receiptWidth = 52 />

<#global currencySymbol = "" />
<#assign currencySymbols = { "GBP": "£", "EUR": "€", "USD": "$", "CNY": " ", "JPY": "¥", "CAD": "$" }>
<#if order??>
<#if order.currencyCode??>
    <#assign currencySymbol = currencySymbols[order.currencyCode]!" ">
</#if>
</#if>

<#global descriptionWidth = 30 />
<#global amountFormat = currencySymbol + "0.00" />
<#global amountWidth = 9 />

<#global weightFormat = "0.000" />
<#global weightWidth = 5 />

<#global quantityWidth = 5 />

<#global dateFormat = "dd/MM/yyyy" />
<#global timeFormat = "HH:mm:ss" />
<#global dateTimeFormat = dateFormat + " " + timeFormat />

<#global headerLogo = "1" />

<#global groupPayments = true /> <#-- by default group tenders -->
<#global printVoidedItems = false> <#-- by default hide voided items -->
<#global printVoidedPayments = false> <#-- by default hide voided payments -->