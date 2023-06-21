<#if order.items??>
    <#assign sales = []>
    <#assign exchanges = []>
    <#assign returns = []>
    <#list order.items as orderItem>
    <#if orderItem.type == "SALE">
        <#assign sales = sales + [orderItem]>
    </#if>
    <#if orderItem.type == "RETURN">
        <#assign returns = returns + [orderItem]>
    </#if>
    <#if orderItem.type == "EXCHANGE">
        <#assign exchanges = exchanges + [orderItem]>
    </#if>
    </#list>

    <#if sales?has_content>
        <@printEmptyLine />
        <!--                     01234567890123456789012345678901234567890123456789012345 -->
        <@printLeftAligned text="  QTY DESCRIPTION                  PRICE    AMOUNT  " bold=true/>
        <#list sales as thisItem>
            <#include "PRINT_SINGLE_ITEM.ftl">
        </#list>
    </#if>

    <#if exchanges?has_content>
        <@printTitle text=(nls.EXCHANGE_title)!"EXCHANGES"/>
        <#list exchanges as thisItem>
            <#include "PRINT_SINGLE_ITEM.ftl">
        </#list>
    </#if>

    <#if returns?has_content>
        <@printTitle text=(nls.RETURN_title)!"RETURNS"/>
        <#list returns as thisItem>
            <#include "PRINT_SINGLE_ITEM.ftl">
        </#list>
    </#if>
</#if>
