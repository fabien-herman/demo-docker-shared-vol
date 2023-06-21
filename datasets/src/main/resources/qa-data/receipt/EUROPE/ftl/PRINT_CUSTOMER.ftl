<#if order.activeLoyalty??>
  <!-- Loyalty Id -->
  <#assign loyalty = order.activeLoyalty>
  <#assign n1=loyalty.loyaltyId?length-4 n2=loyalty.loyaltyId?length>
  <@printLeftAligned text=spaces(5) + ((loyalty.loyaltyType?replace("_", " ")?lower_case?cap_first) + ": ")?right_pad(receiptWidth-5-loyalty.loyaltyId?length-2) + ""?right_pad(n1, "x") + (loyalty.loyaltyId)?substring(n1,n2) />

  <#assign loyaltyBucket = "LOYALTY_REWARDS">

  <!-- Current balance -->
  <#assign loyaltyPoints = 0>
  <#if loyalty.loyaltyPointBuckets??>
    <#if loyalty.loyaltyPointBuckets[loyaltyBucket]??>
      <#assign loyaltyPoints = loyalty.loyaltyPointBuckets[loyaltyBucket]>
    </#if>
  </#if>
  <@printLeftAligned text=spaces(5) + ((nls.SALE_loyaltyPointsBalance!"Points balance") + ": ")?right_pad(receiptWidth-5-10-2) + (loyaltyPoints!0)?left_pad(10) />

  <!-- Awarded points -->
  <#assign awardedPoints = 0>
  <#if order.awardedPointBuckets??>
    <#if order.awardedPointBuckets[loyaltyBucket]??>
      <#assign awardedPoints = order.awardedPointBuckets[loyaltyBucket]>
    </#if>
  </#if>

  <#if awardedPoints != 0>
    <@printLeftAligned text=spaces(5) + ((nls.SALE_loyaltyPointsAwarded!"Points awarded") + ": ")?right_pad(receiptWidth-5-10-2) + awardedPoints?left_pad(10) />
  </#if>

  <!-- Used points -->
  <#assign usedPoints = 0>
  <#if order.usedPointBuckets??>
    <#if order.usedPointBuckets[loyaltyBucket]??>
      <#assign usedPoints = order.usedPointBuckets[loyaltyBucket]>
    </#if>
  </#if>

  <#if usedPoints != 0>
    <@printLeftAligned text=spaces(5) + ((nls.SALE_loyaltyPointsUsed!"Points used") + ": ")?right_pad(receiptWidth-5-10-2) + usedPoints?left_pad(10) />
  </#if>

  <!-- New balance -->
  <#if awardedPoints != 0 || usedPoints != 0>
    <#assign newBalance = loyaltyPoints+awardedPoints-usedPoints>
    <@printLeftAligned text=spaces(5) + ((nls.SALE_loyaltyPointsNewBalance!"New balance") + ": ")?right_pad(receiptWidth-5-10-2) + newBalance?left_pad(10) />
  </#if>
  <@printSeparator "="/>
</#if>
