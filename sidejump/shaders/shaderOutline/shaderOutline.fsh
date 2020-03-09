//
// Simple passthrough fragment shader
//
varying vec2 v_vTexcoord;
varying vec4 v_vColour;
varying vec2 v_vPositionCache[8];

void main() {
	vec4 summary = vec4(0.0, 0.0, 0.0, 0.0);  
	for (int i = 0; i < 8; ++i) {
		vec4 temp = texture2D(gm_BaseTexture, v_vTexcoord + v_vPositionCache[i]);
		temp.r = 0.0;
		temp.g = 0.0;
		temp.b = 0.0;
		summary += temp;
	}
	summary.a = summary.a / 2.0;
	summary += texture2D(gm_BaseTexture, v_vTexcoord);
	//if (1.0 < summary.a) {
		
	//}

	gl_FragColor = v_vColour * summary;
}
