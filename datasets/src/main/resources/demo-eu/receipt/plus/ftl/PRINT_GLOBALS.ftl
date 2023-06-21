<#global receiptWidth = 42 />

<#global currencySymbol = "" />
<#assign currencySymbols = { "GBP": "£", "EUR": "€", "USD": "$", "CNY": " ", "JPY": "¥", "CAD": "$" }>
<#if order??>
<#if order.currencyCode??>
  <#assign currencySymbol = currencySymbols[order.currencyCode]!"">
</#if>
</#if>

<#global descriptionWidth = 20 />

<#global amountFormat = "0.00" />
<#global amountWidth = 9 />

<#global unitPriceWidth = 6 />

<#global amountWithCurrencyFormat = currencySymbol + "0.00" />
<#global amountWithCurrencyWidth = 9 />

<#global quantityFormat = "0" />
<#global quantityWidth = 2 />

<#global weightFormat = "0.000" />
<#global weightWidth = 5 />

<#global dateFormat = "d-M-yyyy" />
<#global timeFormat = "HH:mm" />
<#global dateTimeFormat = dateFormat + " " + timeFormat />
