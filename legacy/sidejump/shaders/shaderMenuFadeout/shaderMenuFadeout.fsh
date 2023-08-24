//
// Simple passthrough fragment shader
//
varying vec2 v_vTexcoord;
varying vec4 v_vColour;

uniform float shroud_alpha;

void main()
{
    vec4 original = texture2D( gm_BaseTexture, v_vTexcoord );
		original.rgb -= shroud_alpha;
		
		gl_FragColor = v_vColour * original;
}
