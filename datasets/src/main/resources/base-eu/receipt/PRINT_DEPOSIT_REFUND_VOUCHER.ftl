<#list ORDER as order>
    <#if order.depositRefundVoucherPaymentInfo??>
        <#if nodeConfig??>
          <#list nodeConfig.configurations.DEPOSIT_REFUND_BARCODE_TYPES.value.headers as headerEntry>
            <#if headerEntry.name == "REGEX">
              <#assign regexIndex=headerEntry?index>
            <#elseif headerEntry.name == "SYMBOLOGY">
              <#assign symbologyIndex=headerEntry?index>
            <#elseif headerEntry.name == "ACTIVE">
              <#assign activeIndex=headerEntry?index>
            <#elseif headerEntry.name == "SOURCE">
              <#assign sourceIndex=headerEntry?index>
            </#if>
          </#list>
          <#if regexIndex?? && symbologyIndex?? && activeIndex?? && sourceIndex??>
              <#assign rowsData = nodeConfig.configurations.DEPOSIT_REFUND_BARCODE_TYPES.value.rows>
              <#list rowsData?keys as key>
                <#assign rowEntry=rowsData[key]>
                <#assign allValues=rowEntry["row"]>
                <#assign isActive=allValues[activeIndex]>
                <#assign source=allValues[sourceIndex]>
                <#assign isInternal=allValues[sourceIndex]>
                <#if isActive?? && isActive && source == "INTERNAL">
                  <#assign regex=allValues[regexIndex]>
                  <#assign symbology=allValues[symbologyIndex]>
                  <#if regex??>
                      <#assign regexAfterPrefix = regex?keep_after("<prefix>")>
                      <#if regexAfterPrefix??>
                          <#assign prefixGroupEndIndex = regexAfterPrefix?index_of(")")-1>
                          <#if prefixGroupEndIndex??>
                              <#assign voucherPrefixValue = regexAfterPrefix[0..prefixGroupEndIndex]>
                          </#if>
                      </#if>
                  </#if>
                  <#if symbology??>
                     <#assign mappedSymbology = symbology?replace("-", "")?upper_case>
                  </#if>
                  <#break>
                </#if>
              </#list>
          </#if>
        </#if>
        <#if voucherPrefixValue?? && mappedSymbology??>
            <#list order.depositRefundVoucherPaymentInfo as voucherPaymentInfo>
                <#assign voucherBarcode = voucherPrefixValue+voucherPaymentInfo.depositRefundVoucher.uniqueId>
                <#assign voucherAmount = "">
                <#assign voucherExpiration = "">
                <#if voucherPaymentInfo.depositRefundVoucher.expirationTimestamp??>
                  <#assign voucherExpiration = voucherPaymentInfo.depositRefundVoucher.expirationTimestamp?datetime("yyyy-MM-dd\'T\'HH:mm:ss.SSSXXX")?string.short>
                </#if>
                <#if voucherPaymentInfo.depositRefundVoucher.totalVoucherAmount??>
                  <#assign voucherAmount = voucherPaymentInfo.depositRefundVoucher.totalVoucherAmount?string("0.00")>
                </#if>
                 <#if voucherBarcode?? && voucherAmount?has_content && voucherExpiration?has_content>
                    <div class="feed" count="2"></div>
                    <div class="depositRefundVoucherTitle">${(nls.SALE_depositRefundVoucherTitle)!"DEPOSIT REFUND VOUCHER"}</div>
                    <div class="feed"></div>
                    <div class="line">${(nls.SALE_depositRefundVoucherAmount)!"AMOUNT"}: ${voucherAmount}</div>
                    <div class="feed"></div>
                    <div class="line">${(nls.SALE_depositRefundVoucherExpiration)!"EXPIRATION"}: ${voucherExpiration}</div>
                    <div class="feed"></div>
                    <div class="barcode" data="${voucherBarcode}" symbology="${mappedSymbology}"></div>
                    <div class="feed"></div>
                    <div class="feed-cut"></div>
                <#else>
                   <div class="feed"></div>
                   <div class="depositRefundVoucherTitle">${(nls.SALE_depositRefundVoucherInvalidData)!"DEPOSIT REFUND VOUCHER\nINVALID DATA"}</div>
        </#if>
            </#list>
        <#else>
               <div class="feed"></div>
               <div class="depositRefundVoucherTitle">${(nls.SALE_depositRefundVoucherConfigError)!"DEPOSIT REFUND VOUCHER BARCODE\nINVALID CONFIGURATION"}</div>
        </#if>
    </#if>
</#list>
