//
// Simple passthrough fragment shader
//
varying vec2 v_vTexcoord;
varying vec4 v_vColour;
varying float player_distance;

void main()
{
	const float glow_range_inner = 24.0;
	const float glow_range_outer = 24.0;
	float distance_factor;
	
	if (player_distance < glow_range_inner) {
		distance_factor = 1.0;
	} else if (player_distance < glow_range_inner + glow_range_outer) {
		distance_factor = smoothstep(1.0, 0.0, (player_distance - glow_range_inner) / glow_range_outer);
	} else {
		distance_factor = 0.0;
	}
	
	vec4 result = texture2D(gm_BaseTexture, v_vTexcoord);
	result += distance_factor * vec4(0.1, 0.1, 0.1, 0.0);
	
	gl_FragColor = v_vColour * result;
}
