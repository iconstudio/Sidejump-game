/// @description Async IAP responses
// You can write your code in this editor

show_debug_message("Async social message");

var eventId = async_load[? "id"];
show_debug_message("id: " + string(eventId));

switch (eventId)
{
	case gpb_iap_receipt:
	{
		show_debug_message("YY_IAP_RECEIPT");		
		break;
	}
	case gpb_store_connect:
	{
		show_debug_message("YY_STORE_CONNECT");
		break;
	}
	case gpb_product_data_response:
	{
		show_debug_message("YY_PRODUCT_DATA_RESPONSE");
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
		break;
	}
}
