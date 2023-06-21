<#if order.items??>
  <#-- 
  CS(x) := round(100 * EXP(-0.45 * x ^0.6)) where x is defined as
  x := 1000 * (sum over all products(weight_in_kg(p) * co2_per_kg(p)) / sum over all products(weight_in_kg(p) * kcal_per_kg(p)))
  -->

  <#assign sum_kg_co2_e = 0 />
  <#assign sum_kcal = 0 />
  <#list order.items as thisItem>
    <#list thisItem.prices as thisPrice>
      <#assign quantity = thisPrice.quantity />
      <#assign weight_in_kg = thisItem.item.attributes["weight_in_kq"]!0.25 />
      <#assign kg_co2_e_per_kg = thisItem.item.attributes["kg_co2_e_per_kg"]!0 />
      <#assign kcal_per_kg = thisItem.item.attributes["kcal_per_100g"]!0 * 10 />
      <#assign sum_kg_co2_e = sum_kg_co2_e + (quantity * weight_in_kg * kg_co2_e_per_kg) />
      <#assign sum_kcal = sum_kcal + (quantity * weight_in_kg * kcal_per_kg) />
    </#list>
    <#assign x = 1000 * (sum_kg_co2_e / sum_kcal) />
  </#list>

  <#assign x = 0.125 />
  <@printLeftAligned text="x = " + x />

  <#if x gte 1>
    <@printLeftAligned text=x + " >= 1" />
  <#elseif x gte 0.1>
    <@printLeftAligned text=x + " >= 0.1" />
  <#elseif x gte 0.01>
    <@printLeftAligned text=x + " >= 0.01" />
  <#elseif x gte 0.001>
    <@printLeftAligned text=x + " >= 0.001" />
  <#else>
    <@printLeftAligned text=x + " < 0.001" />
  </#if>

  <#-- ImpactScore -->
  <@printEmptyLine />
  <@printCentered text=(nls.SALE_impactScore!"Impactscore on your purchase.") />

  <#assign climateScore=72 />
  <#if climateScore gt 70>
    <@printCentered text=(nls.SALE_veryGood!"VERY GOOD!") doubleWidth=true />
  <#else>
    <@printCentered text=(nls.SALE_good!"GOOD!") doubleWidth=true />
  </#if>
  <@printCentered text=(nls.SALE_climateScore!"Climatescore") + " " + climateScore + "/100" />

  <@printEmptyLine />
  <@printLeftAligned text=(nls.SALE_mostSustainableProduct!"Most sustainable product:") />
  <#assign thisItem=order.items[0] />
  <#assign co2=thisItem.item.attributes["kg_co2_e_per_kg"]!0 />
  <#if thisItem.item.displayName?has_content>
    <#assign description=localized(thisItem.item.displayName) />
  <#else>
    <#assign description="SKU " + thisItem.item.skuId />
  </#if>
  <#assign description=description[0..*descriptionWidth] />
  <@printLeftAligned text=description?right_pad(receiptWidth-3-6-2) + co2 + "kg CO2" bold=true />

  <@printEmptyLine />
  <@printLeftAligned text=(nls.SALE_productWithHighestFootprint!"Product with the highest footprint:") />
  <#assign thisItem=order.items[1] />
  <#assign co2=thisItem.item.attributes["kg_co2_e_per_kg"]!0 />
  <#if thisItem.item.displayName?has_content>
    <#assign description=localized(thisItem.item.displayName) />
  <#else>
    <#assign description="SKU " + thisItem.item.skuId />
  </#if>
  <#assign description=description[0..*descriptionWidth] />
  <@printLeftAligned text=description?right_pad(receiptWidth-3-6-2) + co2 + "kg CO2" bold=true />

  <@printEmptyLine />
  <@printCentered text=(nls.SALE_findOutMore1!"Find out more about the effects of your") />
  <@printCentered text=(nls.SALE_findOutMore2!"purchase on the climate, the environment,") />
  <@printCentered text=(nls.SALE_findOutMore3!"animal wellfareand health and discover") />
  <@printCentered text=(nls.SALE_findOutMore4!"sustainable alternatives.") />

  <@printEmptyLine />
  <@printBarcode data="https://sustainability.inoqo.com/sustainability/" symbology="PTR_BCS_QRCODE" />
  <@printEmptyLine />
  <@printCentered text=(nls.SALE_inoqo!"Powered by inoqo") bold=true />
  <@printEmptyLine />
</#if>
