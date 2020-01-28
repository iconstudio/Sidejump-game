/// @description callback_campaign_back()
/// @function callback_campaign_back
with oMenuCampaignPopup {
	close = true
	entry_upper.entry_upper.lock = false // oMenuEntryCampaign
	entry_upper.opened = false // oMenuEntryChapterBoard
	// oMenuEntryCaption: Campaign
	oMainMenu.entry_last = entry_upper
	oMainMenu.entry_choice_index = 0
	oMainMenu.entry_choice = entry_upper.entry_upper
}
