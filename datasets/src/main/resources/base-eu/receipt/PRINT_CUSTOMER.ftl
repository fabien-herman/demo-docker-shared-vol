<!-- customer -->
<#if order.customer??>
  <#list order.customer.loyalties as loyalty>
    <#if loyalty.primary??>
      <#if loyalty.primary == true>
        <#assign n1=loyalty.loyaltyId?length-4 n2=loyalty.loyaltyId?length>
        <div class="line">${((loyalty.loyaltyType?replace("_", " ")?lower_case?cap_first) + ": " + ""?right_pad(n1, "x") + (loyalty.loyaltyId)?substring(n1,n2))?right_pad(40)}</div>
        <div class="line">${("  Points balance: "?right_pad(20) + (loyalty.loyaltyPoints!0)?left_pad(10))?right_pad(40)}</div>
        <#assign earnedPoints = (order.totalPointsAwarded!0)-(order.pointsUsed!0)>
        <#if earnedPoints != 0>
            <div class="line">${("  Points awarded: "?right_pad(20) + (order.totalPointsAwarded!0)?left_pad(10))?right_pad(40)}</div>
            <div class="line">${("  Points used: "?right_pad(20) + (order.pointsUsed!0)?left_pad(10))?right_pad(40)}</div>
            <#assign newBalance = (loyalty.loyaltyPoints!0)+(earnedPoints!0)>
            <div class="line">${("  New balance: "?right_pad(20) + (newBalance!0)?left_pad(10))?right_pad(40)}</div>
        </#if>
      </#if>
    </#if>
  </#list>
  <div class="line"></div>
</#if>
