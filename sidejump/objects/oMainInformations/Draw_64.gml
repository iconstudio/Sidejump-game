/// @description 정보 그리기 
draw_set_color($ffffff)
draw_set_font(fontSmall)
//*
draw_set_halign(2)
draw_set_valign(0)
draw_text(global.resolutions_gui[0] - 4, 4, oMainMenu.main_alpha)
draw_text(global.resolutions_gui[0] - 4, 22, oMainMenu.menu_drawn_y_default)
draw_text(global.resolutions_gui[0] - 4, 40, oMainMenu.menu_drawn_y_push)
draw_text(global.resolutions_gui[0] - 4, 58, oMainMenu.menu_drawn_y)
//*/
draw_set_valign(2)
draw_set_halign(0)
draw_text(4, info_drawn_y, info_caption_copyright)

draw_set_halign(2)
draw_text(global.resolutions_gui[0] - 4, info_drawn_y, info_caption_version)
draw_set_alpha(1)