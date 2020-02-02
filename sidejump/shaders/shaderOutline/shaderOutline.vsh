precision highp float;

attribute vec3 in_Position;                  // (x,y,z)
attribute vec4 in_Colour;                    // (r,g,b,a)
attribute vec2 in_TextureCoord;              // (u,v)

varying vec2 v_vTexcoord;
varying vec4 v_vColour;
varying vec2 v_vPositionCache[8];

varying vec2 texel_size;
uniform vec2 resolution;

void main()
{
    vec4 object_space_pos = vec4( in_Position.x, in_Position.y, in_Position.z, 1.0);
    gl_Position = gm_Matrices[MATRIX_WORLD_VIEW_PROJECTION] * object_space_pos;
    
    v_vColour = in_Colour;
    v_vTexcoord = in_TextureCoord;
		
		vec2 texel_size = vec2(1.0 / resolution[0], 1.0 / resolution[1]);
		v_vPositionCache[0] = vec2(texel_size.x, 0.0);
		v_vPositionCache[1] = vec2(texel_size.x, texel_size.y);
		v_vPositionCache[2] = vec2(0.0, texel_size.y);
		v_vPositionCache[3] = vec2(-texel_size.x, texel_size.y);
		v_vPositionCache[4] = vec2(-texel_size.x, 0.0);
		v_vPositionCache[5] = vec2(-texel_size.x, -texel_size.y);
		v_vPositionCache[6] = vec2(0.0, -texel_size.y);
		v_vPositionCache[7] = vec2(texel_size.x, -texel_size.y);
}
