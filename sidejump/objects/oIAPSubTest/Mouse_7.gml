/// @description Subscription IAP Test
event_inherited();

show_debug_message("Subscription test button pressed");

var status = GPBilling_IsStoreConnected();
if (status)
{
	show_debug_message("Calling to purchase " + string(kSubTestId));
	GPBilling_PurchaseSubscription(kSubTestId);
}