event_inherited()
openable = false
lock = false

closing_time = 0
closing_period = seconds(0.2)

scale = 0
board_margin = 4
height_max = 200 + board_margin * 2
board_y = board_margin
board_height_max = height_max - board_margin * 2
board_height = 0
board_y_half_max = board_y + board_height_max * 0.5
board_y_half = 0

board_content_x_beign = floor(global.resolutions_gui[0] * 0.4)
board_content_y = board_y + board_margin

chapter_board_scroll = 0
chapter_board_await_time = 0
chapter_board_await_period = seconds(0.03)
chapter_board_size = 128
chapter_board_padding = 72
chapter_board_each_gap = chapter_board_padding + chapter_board_size

for (var i = chapter_get_first(); i <= chapter_get_last(); ++i) {
	with menu_add_other(oMenuEntryChapterBoard, id, -1) {
		caption = chapter_get_name(i)
		chapter_index = i

		move_target_x = i * other.chapter_board_each_gap + other.board_content_x_beign
		move_begin_x = move_target_x + global.resolutions_gui[0]
		x = move_begin_x
		move_await_period = 1 + seconds(0.05 * i)

		info_campaign = instance_create_layer(0, 0, "Menu", oMenuEntryChapterInfo)
		with info_campaign {
			visible = false
			use_custom_coords = true
		}
		button_start = menu_add_entry_caption("Start")
		with button_start {
			visible = false
			use_custom_coords = true
		}
		button_back = menu_add_entry_caption("Back", callback_campaign_back)
		with button_back {
			visible = false
			use_custom_coords = true
		}
	}
}
menu_select(0)
chapter_board_number = ds_list_size(entry_list)
