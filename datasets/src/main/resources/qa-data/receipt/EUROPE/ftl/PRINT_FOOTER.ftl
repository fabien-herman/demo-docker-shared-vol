<#if transaction??>
  <#assign username="user " + transaction.userId />
  <@printCentered text=(nls.SALE_associate!"associate") + " " + username />
  <@printCentered text=printDateTime(transaction.completionTimestamp) + " " + (nls.SALE_pos!"pos") + " " + (transaction.endpointId!"") + " " + (nls.SALE_receipt!"receipt") + " " + (transaction.sequenceNumber) />
</#if>
<@printEmptyLine />

<#if nodeConfig??>
  <@printCentered text=(nls.SALE_receiptFooter!"Thank you for shopping with Toshiba.") bold=true />
  <@printEmptyLine />
</#if>

<#if transaction??>
  <@printBarcode data=transaction.transactionNumber symbology="PTR_BCS_Code128_Parsed" codeSet="{B" />
</#if>
