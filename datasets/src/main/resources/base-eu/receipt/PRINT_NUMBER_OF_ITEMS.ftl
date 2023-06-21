<!-- orderItemCount -->
<@printLeftAligned text=""?right_pad(quantityWidth+1) + (nls.SALE_totalItemsSold!"Number of items:")?right_pad(receiptWidth-quantityWidth-1-quantityWidth-1-1-1) + printQuantity(order.totalItemCount) />
