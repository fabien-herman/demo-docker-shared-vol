<!-- total -->
<@printLeftAligned text=spaces(quantityWidth+1) + (nls.SALE_subtotal!"TOTAL")?right_pad(receiptWidth-6-9-1-1-1) + printAmount(order.totalItems) bold=true />

<!-- discount -->
<@printLeftAligned text=spaces(quantityWidth+1) + (nls.SALE_discounts!"Discounts")?right_pad(receiptWidth-6-9-1-1-1) + printAmount(order.totalPriceModifications) />

<!-- balance -->
<@printLeftAligned text=spaces(quantityWidth+1) + (nls.SALE_balance!"Balance")?right_pad(receiptWidth-6-9-1-1-1) + printAmount(order.total) bold=true />

<!-- payments -->
<#include "PRINT_PAYMENTS.ftl">

<!-- orderChangeDue -->
<#include "PRINT_CHANGEDUE.ftl">

<!-- total number of items -->
<#include "PRINT_NUMBER_OF_ITEMS.ftl">

<!-- taxes -->
<#include "PRINT_TAXES.ftl">

<!-- customer -->
<#include "PRINT_CUSTOMER.ftl">
