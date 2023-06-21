<#include "PRINT_GLOBALS.ftl">
<#include "PRINT_FUNCTIONS.ftl">

<!-- header -->
<@printLogo id=nodeConfig.configurations.RECEIPT_HEADER_IMAGE.value!1 />
<@printEmptyLine />
<#if nodeConfig??>
  <@printCentered text=localized(nodeConfig.displayName)! doubleWidth=true />
  <#if nodeConfig.address??>
    <@printCentered text=localized(nodeConfig.address.address1)! />
    <#assign address = "${localized(nodeConfig.address.postalCode)!} ${localized(nodeConfig.address.city)!}">
    <@printCentered text=address />
  </#if>
  <#if nodeConfig.phone?has_content>
    <@printCentered text="Tel: " + nodeConfig.phone />
  </#if>
</#if>
