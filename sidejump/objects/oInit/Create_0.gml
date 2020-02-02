/// @description 초기화
loading_failed = true
#region 외부 파일
enum input {
	keyboard,
	mouse,
	gamepad
}

global.file_profile = "player.dat"

global.file_settings = "options.json"
global.settings = ds_map_create()
setting_load()

global.controls_keyboard = ds_map_create()
global.controls_gamepad = ds_map_create()
controls_clear()

#endregion

#region 일반
global.flag_is_mobile = (os_type == os_android or os_type == os_ios) // 하지만 안드로이드만 지원
global.flag_is_browser = (os_browser != browser_not_a_browser)
global.flag_is_desktop = (os_type == os_windows or os_type == os_macosx or os_type == os_linux) and !global.flag_is_browser
#macro SECOND 100 // == seconds(1)
device_mouse_dbclick_enable(false)
#endregion

#region 화면
application_surface_enable(true)
application_surface_draw_enable(true)

surface_depth_disable(true)
display_reset(0, false)
display_set_timing_method(tm_countvsyncs)

if global.flag_is_mobile {
	display_set_sleep_margin(4)
	window_set_fullscreen(true)
	os_powersave_enable(false)
} else if global.flag_is_browser {
	display_set_sleep_margin(30)
} else {
	display_set_sleep_margin(10)
}

// 기본 화면 크기는 960x480
default_width = 960
default_height = 480
global.resolutions_default = [default_width, default_height]
#endregion

#region 음성
audio_loaded = true
if global.flag_is_mobile {
	audio_channel_num(16)
} else if global.flag_is_browser {
	audio_channel_num(4)
} else {
	audio_channel_num(32)
}
if !audio_group_is_loaded(audiogroup_everthing) {
	audio_group_load(audiogroup_everthing)
	audio_loaded = false
}
#endregion

#region 쉐이더
global.shader_supported = shaders_are_supported()
if global.shader_supported {
	if !shader_is_compiled(shaderFXAA)
		show_debug_message("shaderFXAA is not complied. Be careful!")
}
global.shaderFXAA_vSize = shader_get_uniform(shaderFXAA, "u_vSize");
global.shaderBlur_resolution = shader_get_uniform(shaderBlur, "resolution")
global.shaderBlurCentral_resolution = shader_get_uniform(shaderBlurCentral, "resolution")
global.shaderOutline_resolution = shader_get_uniform(shaderOutline, "resolution")
global.shaderPlayerGlow_player_position = shader_get_uniform(shaderPlayerGlow, "player_position")
#endregion

#region 그래픽
gpu_set_ztestenable(true)
gpu_set_zwriteenable(true)
#endregion

#region 게임
enum theme {
	moor,
	cave,
	volcano,
	forest,
	coast,
	city,
	factory,
	mountain,
	sky,
	space
}
global.chapter_info = ds_map_create()
ds_map_add(global.chapter_info, theme.moor, "Cleft Moor")
ds_map_add(global.chapter_info, theme.cave, "Underworld")
ds_map_add(global.chapter_info, theme.volcano, "Volcano")
ds_map_add(global.chapter_info, theme.forest, "Red Forest")
ds_map_add(global.chapter_info, theme.coast, "The Coast")
ds_map_add(global.chapter_info, theme.city, "Tearing City")
ds_map_add(global.chapter_info, theme.factory, "Factory of Doom")
ds_map_add(global.chapter_info, theme.mountain, "Spine Mountain")
ds_map_add(global.chapter_info, theme.sky, "Skyrocket")
ds_map_add(global.chapter_info, theme.space, "Space")

enum camera_mode {
	follow,
	fixed,
	cutscene,
	transition
}

enum camera_position {
	left_up,
	left_middle,
	left_down,
	center_up,
	center_middle,
	center_down,
	right_up,
	right_middle,
	right_down
}
#endregion

#region 네트워크
// 네트워크 초기화와 클라우드 로그인
global.network_available = os_is_network_connected()
global.platformservice_available = false
network_interrupt_msg = -1

if !global.network_available {
	network_interrupt_msg = show_message_async("네트워크가 연결되지 않았습니다. 연결 상태를 확인해주세요.")
} else if global.flag_is_mobile {
	if GooglePlayServices_Status() != GooglePlayServices_SUCCESS
		GooglePlayServices_Init()

	var google_available = GooglePlayServices_Status()
	switch google_available {
		case GooglePlayServices_SERVICE_VERSION_UPDATE_REQUIRED:
			network_interrupt_msg = show_message_async("Google Player Service의 업데이트가 필요합니다.\nPlay Store에서 업데이트 해주세요.")
		break

		case GooglePlayServices_SERVICE_DISABLED:
			network_interrupt_msg = show_message_async("Google Player Service가 비활성화 돼있습니다.")
		break

		case GooglePlayServices_SERVICE_MISSING:
			network_interrupt_msg = show_message_async("Google Player Service API를 찾을 수 없습니다.")
		break

		case GooglePlayServices_SERVICE_INVALID:
			network_interrupt_msg = show_message_async("설치된 Google Player Service의 버전이 올바르지 않습니다.")
		break

		case GooglePlayServices_SUCCESS:
			achievement_login()

			global.platformservice_available = achievement_login_status()
			loading_failed = false
		break

		default:
		break
	}
} else {
	loading_failed = false
}
#endregion

#macro gamepad_type_xbox 0
#macro gamepad_type_playstation 1
#macro gamepad_type_other 2

if audio_loaded and !loading_failed
	event_user(0)
