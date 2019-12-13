show_debug_message("!!!!!!!!!!!!!!!!!!!!!ASYNC HTTP RESPONSE!!!!!!!!!!!!!!!!!!!!!");

if (ds_map_find_value(async_load, "id") == global.httpId)
{
	if (ds_map_find_value(async_load, "status") == 0)
	{
		r_str = ds_map_find_value(async_load, "result");
		show_debug_message("Server response: " + r_str);
		
		if (r_str == "success")
		{
			if (global.purchaseToken != "") 
			{
				GPBilling_AcknowledgePurchase(global.purchaseToken);
			}
		}
	}
    else
    {
		r_str = "null";
    }
}
