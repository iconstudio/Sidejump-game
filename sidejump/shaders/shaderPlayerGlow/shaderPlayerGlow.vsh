attribute vec3 in_Position;                  // (x,y,z)
attribute vec4 in_Colour;                    // (r,g,b,a)
attribute vec2 in_TextureCoord;              // (u,v)

varying vec2 v_vTexcoord;
varying vec4 v_vColour;

uniform vec4 player_position;
varying float player_distance;

void main()
{
		vec4 object_space_pos = vec4( in_Position.x, in_Position.y, in_Position.z, 1.0);
    gl_Position = gm_Matrices[MATRIX_WORLD_VIEW_PROJECTION] * object_space_pos;
		
		vec4 temp = vec4(240.0, 295.0, 0.0, 0.0);
		if (player_position.x == -1.0 && player_position.y == -1.0) {
			player_distance = 9999.0;
		} else {
			player_distance = sqrt(pow(player_position.x - object_space_pos.x, 2.0) + pow(player_position.y - object_space_pos.y, 2.0));
		}

    v_vColour = in_Colour;
    v_vTexcoord = in_TextureCoord;
}
