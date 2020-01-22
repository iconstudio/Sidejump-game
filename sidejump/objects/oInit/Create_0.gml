/// @description 초기화
loading_failed = true
#region 일반
global.flag_is_mobile = (os_type == os_android or os_type == os_ios) // 하지만 안드로이드만 지원
global.flag_is_browser = (os_browser == browser_not_a_browser)
#macro SECOND 100 // == seconds(1)
device_mouse_dbclick_enable(false)
#endregion

#region 화면
window_set_fullscreen(true)
application_surface_enable(true)
application_surface_draw_enable(true)

surface_depth_disable(true)
display_reset(8, false)
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
display_width = display_get_width()
display_height = display_get_height()
window_size = []
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
global.shaderFXAA_texel = shader_get_uniform(shaderFXAA, "u_texel")
global.shaderFXAA_strength = shader_get_uniform(shaderFXAA, "u_strength")
global.shaderBlur_texel_size = shader_get_uniform(shaderBlur, "texelSize")
global.shaderPlayerGlow_player_position = shader_get_uniform(shaderPlayerGlow, "player_position")
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
	night,
	cave,
	volcano,
	forest,
	ocean,
	city,
	factory,
	cold,
	sky,
	space
}

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

if audio_loaded and !loading_failed {
	event_user(0)
} else {
	
}
