<#include "PRINT_GLOBALS.ftl">
<#include "PRINT_FUNCTIONS.ftl">

<!-- header -->
<@printLogo id=headerLogo />
<@printEmptyLine />
<#if nodeConfig??>
    <@printCentered text=localized(nodeConfig.displayName)! />
    <#if nodeConfig.phone?has_content>
        <@printCentered text=(nodeConfig.phone)! />
    </#if>
    <#if nodeConfig.address??>
        <@printCentered text=localized(nodeConfig.address.address1)! />
        <#assign address = "${localized(nodeConfig.address.city)!} - ${localized(nodeConfig.address.postalCode)!}">
        <@printCentered text=address />
    </#if>
</#if>
