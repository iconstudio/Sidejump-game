/// @description Async IAP responses
// You can write your code in this editor

show_debug_message("Async iap message");

switch (os_type) 
{
case os_android:
	{
		var eventId = async_load[? "id"];
		show_debug_message("id: " + string(eventId));

		switch (eventId)
		{
			case gpb_iap_receipt:
			{
				show_debug_message("!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!");
				show_debug_message("YY_IAP_RECEIPT");
				show_debug_message("!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!");
				var response_json = async_load[? "response_json"];
				show_debug_message(response_json);
		
				var mapId = json_decode(response_json);
				if (mapId >= 0)
				{
					if (ds_map_exists(mapId, "purchases")) 
					{
						var purchases = ds_map_find_value(mapId, "purchases");
						var purchasesSize = ds_list_size(purchases);
						for (var n = 0; n < purchasesSize; n++;)
						{
							var purchaseMap = ds_list_find_value(purchases, n);
							show_debug_message("purchaseMap: " + string(n));

							var purchaseToken = ds_map_find_value(purchaseMap, "purchaseToken");
							show_debug_message("purchaseToken: " + string(purchaseToken));
			
							var sku = ds_map_find_value(purchaseMap, "productId");
							show_debug_message("SKU: " + sku);
							if (sku == kSubTestId) 
							{
								show_debug_message("Verify sub purchase with server");
								var url = "http://10.36.11.105:8888/google-sub-verify?receiptId=";
								url += purchaseToken;
								url += "&skuId=";
								url += kSubTestId;
								show_debug_message("Verify sub purchase at URL: " + url);
								global.httpId = http_get(url);
			
								if (global.purchaseToken == "") 
								{
									global.purchaseToken = purchaseToken;
								}
							}
							else
							{
								// This is purely an example. Verifying in this manner is less secure and prone to spoofing. 
								// Ideally, developers will verify all IAPs, consumable/subs/entitlements with a server.
								show_debug_message("Verify consumable iap purchase with signature"); 
				
								var signature = GPBilling_Purchase_GetSignature(purchaseToken);
								show_debug_message("purchaseToken: " + purchaseToken + " signature: " + signature);
			
								var purchaseJsonStr = GPBilling_Purchase_GetOriginalJson(purchaseToken);
								if (GPBilling_Purchase_VerifySignature(purchaseJsonStr, signature))
								{
									show_debug_message("VERIFIED purchaseToken: " + purchaseToken);
									GPBilling_ConsumeProduct(purchaseToken);
								}
							}
						}
					}
					ds_map_destroy(mapId);
				}
		
				break;
			}
			case gpb_store_connect:
			{
				show_debug_message("YY_STORE_CONNECT");
		
				var res = GPBilling_AddProduct(kIapTestId);		
				show_debug_message("res: " + string(res));
		
				res = GPBilling_AddSubscription(kSubTestId);
				show_debug_message("res: " + string(res));
		
				res = GPBilling_QuerySubscriptions();
				show_debug_message("res: " + string(res));
		
				break;
			}
			case gpb_product_data_response:
			{
				show_debug_message("YY_PRODUCT_DATA_RESPONSE");
		
				var subs = gpb_purchase_skutype_subs;
				var receiptConst = gpb_iap_receipt;
	
				var queryPurchasesRes = GPBilling_QueryPurchases(gpb_purchase_skutype_inapp);
				show_debug_message("queryPurchasesRes: " + string(queryPurchasesRes));
		
				var purchaseMapIndex = json_decode(queryPurchasesRes);
				if (purchaseMapIndex >= 0)
				{
					var list = ds_map_find_value(purchaseMapIndex, "purchases");
					var size = ds_list_size(list);
					for (var n = 0; n < size; n++;)
					{
						var map = ds_list_find_value(list, n);
				
						// Theoretically this should be in "purchased" state, but it's not, so wt* Google.
						//var curr = ds_map_find_value(map, "purchaseState");
					    //if (curr == PURCHASE_STATE_PURCHASED)
					    {
							var purchaseToken = ds_map_find_value(map, "purchaseToken");
							GPBilling_ConsumeProduct(purchaseToken);
					    }
					}
					ds_map_destroy(purchaseMapIndex);	
				}
	
				var res = GPBilling_Sku_GetDescription(kIapTestId); show_debug_message("res: " + string(res));
				res = GPBilling_Sku_GetFreeTrialPeriod(kIapTestId); show_debug_message("res: " + string(res));
				res = GPBilling_Sku_GetIconUrl(kIapTestId); show_debug_message("res: " + string(res));
				res = GPBilling_Sku_GetIntroductoryPrice(kIapTestId); show_debug_message("res: " + string(res));
				res = GPBilling_Sku_GetIntroductoryPriceAmountMicros(kIapTestId); show_debug_message("res: " + string(res));
				res = GPBilling_Sku_GetIntroductoryPriceCycles(kIapTestId); show_debug_message("res: " + string(res));
				res = GPBilling_Sku_GetIntroductoryPricePeriod(kIapTestId); show_debug_message("res: " + string(res));
				res = GPBilling_Sku_GetOriginalJson(kIapTestId); show_debug_message("res: " + string(res));
				res = GPBilling_Sku_GetOriginalPrice(kIapTestId); show_debug_message("res: " + string(res));
				res = GPBilling_Sku_GetOriginalPriceAmountMicros(kIapTestId); show_debug_message("res: " + string(res));
				res = GPBilling_Sku_GetPrice(kIapTestId); show_debug_message("res: " + string(res));
				res = GPBilling_Sku_GetPriceAmountMicros(kIapTestId); show_debug_message("res: " + string(res));
				res = GPBilling_Sku_GetPriceCurrencyCode(kIapTestId); show_debug_message("res: " + string(res));
				res = GPBilling_Sku_GetSubscriptionPeriod(kIapTestId); show_debug_message("res: " + string(res));
				res = GPBilling_Sku_GetTitle(kIapTestId); show_debug_message("res: " + string(res));
				res = GPBilling_Sku_GetType(kIapTestId); show_debug_message("res: " + string(res));
		
				var jsonStr = GPBilling_Sku_GetOriginalJson(kIapTestId);
				var myMap = json_decode(jsonStr);
				if (myMap >= 0)
				{
					var priceStr = ds_map_find_value(myMap, "price");
					show_debug_message("price: " + priceStr);
					ds_map_destroy(myMap);
				}
		
				break;
			}
			case gpb_subscription_data_response:
			{
				show_debug_message("YY_SUBSCRIPTION_DATA_RESPONSE");
		
				res = GPBilling_QueryProducts();
				show_debug_message("res: " + string(res));
		
				break;
			}
			case gpb_purchase_status:
			{
				show_debug_message("YY_PURCHASE_STATUS");
				break;
			}
			case gpb_product_consume_response:
			{
				show_debug_message("YY_PRODUCT_CONSUME_RESPONSE");
		
				var response_json = async_load[? "response_json"];
				show_debug_message(response_json);
		
				var mapId = json_decode(response_json);
				if (mapId >= 0)
				{
					if (ds_map_exists(mapId, "purchaseToken")) 
					{
						var consumedToken = ds_map_find_value(mapId, "purchaseToken");
						show_debug_message("Purchase token consumed: " + consumedToken);
			
						if (consumedToken == global.purchaseToken)
						{
							global.purchaseToken = "";
						}
					}
					ds_map_destroy(mapId);
				}
		
				break;
			}
			case gpb_acknowledge_purchase_response:
			{
				show_debug_message("YY_ACKNOWLEDGE_PURCHASE_RESPONSE");
		
				var response_json = async_load[? "response_json"];
				show_debug_message(response_json);
		
				var responseJsonMap = json_decode(response_json);
				if (responseJsonMap >= 0)
				{
					if (ds_map_exists(responseJsonMap, "responseCode")) 
					{
						var responseCode = ds_map_find_value(responseJsonMap, "responseCode");
						show_debug_message("Response code: " + string(responseCode));
					}
					ds_map_destroy(responseJsonMap);
				}
		
				break;
			}
		}
		break;
	}
}