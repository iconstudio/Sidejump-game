event_inherited();

#macro kIapTestId "iap_test_1"
#macro kSubTestId "sub_test_1"

global.purchaseList=ds_list_create();
iap_activate(global.purchaseList);
var gpinitRes = GPBilling_ConnectToStore();
show_debug_message("GP Init: " + string(gpinitRes));

global.purchaseToken = "";