/// @description 초기화
global.flag_is_mobile = (os_type == os_android or os_type == os_ios) // 하지만 안드로이드만 지원
global.flag_is_browser = (os_browser == browser_not_a_browser)

device_mouse_dbclick_enable(false)

#region 화면
application_surface_enable(true)
application_surface_draw_enable(false)
global.application_texture = surface_get_texture(application_surface)
global.application_offset = application_get_position()

surface_depth_disable(true)
display_reset(8, true)
display_set_timing_method(tm_countvsyncs)

// 16 : 9
var default_width = 600
var default_height = 1200

if global.flag_is_mobile {
	display_set_sleep_margin(4)
	window_set_fullscreen(true)
	os_powersave_enable(false)
} else if global.flag_is_browser {
	display_set_sleep_margin(30)
} else {
	display_set_sleep_margin(20)
}
display_set_gui_maximize()
var window_width = window_get_width()
var window_height = window_get_height()
var gui_width = display_get_gui_width()
var gui_height = display_get_gui_height()

global.resolutions = [window_width, window_height]
global.resolutions_gui = [gui_width, gui_height]
#endregion

#region 음성
if global.flag_is_mobile {
	audio_channel_num(16)
} else if global.flag_is_browser {
	audio_channel_num(4)
} else {
	audio_channel_num(32)
}
#endregion

#region 쉐이더
global.shader_supported = shaders_are_supported()
if global.shader_supported {
	if !shader_is_compiled(shaderFXAA)
		show_debug_message("shaderFXAA is not complied. Be careful!")
}
global.shaderFXAA_texel = shader_get_uniform(shaderFXAA, "u_texel")
global.shaderFXAA_strength = shader_get_uniform(shaderFXAA, "u_strength")
global.shaderBlur_texel_size = shader_get_uniform(shaderBlur, "texelSize")

#endregion

#region 그래픽
gpu_set_ztestenable(true)
gpu_set_zwriteenable(true)
global.__d3dPrimKind = -1
global.__d3dPrimTex = -1
global.__d3dPrimBuffer = vertex_create_buffer()
vertex_format_begin()
vertex_format_add_position_3d()
vertex_format_add_normal()
vertex_format_add_colour()
vertex_format_add_texcoord()
global.__d3dPrimVF = vertex_format_end()

enum e__YYM {
	PointB,
	LineB,
	TriB,
	PointUVB,
	LineUVB,
	TriUVB,
	PointVB,
	LineVB,
	TriVB,
	Texture,
	Colour,
	NumVerts,
	PrimKind,
	NumPointCols,
	NumLineCols,
	NumTriCols,
	PointCols,
	LineCols,
	TriCols,

	// these are used when building model primitives
	V1X,
	V1Y,
	V1Z,
	V1NX,
	V1NY,
	V1NZ,
	V1C,
	V1U,
	V1V,

	V2X,
	V2Y,
	V2Z,
	V2NX,
	V2NY,
	V2NZ,
	V2C,
	V2U,
	V2V,
}

enum e__YYMKIND {
	PRIMITIVE_BEGIN,
	PRIMITIVE_END,
	VERTEX,
	VERTEX_COLOR,
	VERTEX_TEX,
	VERTEX_TEX_COLOR,
	VERTEX_N,
	VERTEX_N_COLOR,
	VERTEX_N_TEX,
	VERTEX_N_TEX_COLOR,
	SHAPE_BLOCK,
	SHAPE_CYLINDER,
	SHAPE_CONE,
	SHAPE_ELLIPSOID,
	SHAPE_WALL,
	SHAPE_FLOOR,
}

#endregion

#region 게임
enum theme {
	ruins,
	desert,
	wasteland, // 황무지
	wasteland_,
	plains_lava, // 용암 지대
	mountain_volcano, // 화산 지대
	plains, // 
	forest,
	mountain,
	forest_darker,
	forest_autumn,
	cold,
	coldest
}
#endregion

#region 네트워크
// 네트워크 초기화와 클라우드 로그인
global.network_available = os_is_network_connected()
global.platformservice_available = false
loading_interrupt_msg = -1
loading_continues = true

if !global.network_available {
	loading_interrupt_msg = show_message_async("네트워크가 연결되지 않았습니다. 연결 상태를 확인해주세요.")
	loading_continues = false
} else if global.flag_is_mobile {
	if GooglePlayServices_Status() != GooglePlayServices_SUCCESS
		GooglePlayServices_Init()

	var google_available = GooglePlayServices_Status()
	switch google_available {
		case GooglePlayServices_SERVICE_VERSION_UPDATE_REQUIRED:
			loading_interrupt_msg = show_message_async("Google Player Service의 업데이트가 필요합니다.\nPlay Store에서 업데이트 해주세요.")
			loading_continues = false
		break

		case GooglePlayServices_SERVICE_DISABLED:
			loading_interrupt_msg = show_message_async("Google Player Service가 비활성화 돼있습니다.")
			loading_continues = false
		break

		case GooglePlayServices_SERVICE_MISSING:
			loading_interrupt_msg = show_message_async("Google Player Service API를 찾을 수 없습니다.")
			loading_continues = false
		break

		case GooglePlayServices_SERVICE_INVALID:
			loading_interrupt_msg = show_message_async("설치된 Google Player Service의 버전이 올바르지 않습니다.")
			loading_continues = false
		break

		case GooglePlayServices_SUCCESS:
			achievement_login()

			global.platformservice_available = achievement_login_status()
		break

		default:
		break
	}
}
#endregion

#macro gamepad_type_xbox 0
#macro gamepad_type_playstation 1
#macro gamepad_type_other 2

instance_create_layer(0, 0, layer, oGlobal)
instance_create_layer(0, 0, layer, oGamepad)
alarm[0] = 1

