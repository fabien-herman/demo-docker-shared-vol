<#if transaction??>
    <@printCentered text=printDate(transaction.completionTimestamp) + " " + printTime(transaction.completionTimestamp) + " " + (transaction.nodeId!"") + " " + (transaction.endpointId!"") + " " + (transaction.userId!"") + " " + (transaction.sequenceNumber) />
    <@printCentered text=transaction.transactionNumber />
</#if>
