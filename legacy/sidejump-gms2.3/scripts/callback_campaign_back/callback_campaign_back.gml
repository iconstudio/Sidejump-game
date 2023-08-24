/// @description callback_campaign_back()
/// @function callback_campaign_back
function callback_campaign_back() {
	var last = noone
	with oMenuCampaignPopup {
		close = true
		entry_upper.entry_upper.lock = false // oMenuEntryCampaign
		entry_upper.entry_upper.opened = false
		entry_upper.opened = false // oMenuEntryChapterBoard
		with entry_upper.entry_upper.entry_upper { // oMenuEntryCaption: Campaign
			last = id
		}
	}

	with oMainMenu {
		menu_choice(0)
		entry_current_opened = last
	}



}
