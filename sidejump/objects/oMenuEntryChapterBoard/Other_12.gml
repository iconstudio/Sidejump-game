/// @description 캠페인 시작 준비
entry_upper.lock = true
popup = instance_create_layer(0, 0, "Menu_Top", oMenuCampaignPopup)
popup.entry_upper = id
menu_choice(0)
