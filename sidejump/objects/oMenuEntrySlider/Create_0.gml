/// @description 슬라이더 초기화
event_inherited()
openable = false
height_max = 100
height = 0
scale = 0
width = floor(global.resolutions_gui[0] * 0.65)

bar_y = 30
bar_height = 4
grade_height_half = 10
bar_color_normal = $3f2a22
bar_color_ranged = oMainMenu.menu_entry_color_selected
bar_color_unselected = $291e10
bar_color_ranged_unselected = merge_color(oMainMenu.menu_entry_color_selected, 0, 0.5)

await_time = 0
await_period = seconds(0.1)

value = 0
value_min = 0
value_max = 1
can_wrap = false
callback = -1
iterate_predicate = -1

surface_width_margin = 40
surface_height_margin = (bar_height + grade_height_half) * 2
surface_width = width + surface_width_margin * 2
surface_height = height_max + surface_height_margin * 2
surface_texels = [1 / width, 1 / height_max]
event_user(1)
