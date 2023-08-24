precision highp float;

varying vec2 v_vTexcoord;
varying vec4 v_vColour;

uniform vec2 resolution;

vec4 blur(vec2 uv, vec2 resolution, vec2 direction) {
  vec4 color = vec4(0.0);
  vec2 off1 = vec2(1.411764705882353) * direction;
  vec2 off2 = vec2(3.2941176470588234) * direction;
  vec2 off3 = vec2(5.176470588235294) * direction;
  color += texture2D(gm_BaseTexture, uv) * 0.1964825501511404;
  color += texture2D(gm_BaseTexture, uv + (off1 / resolution)) * 0.2969069646728344;
  color += texture2D(gm_BaseTexture, uv - (off1 / resolution)) * 0.2969069646728344;
  color += texture2D(gm_BaseTexture, uv + (off2 / resolution)) * 0.09447039785044732;
  color += texture2D(gm_BaseTexture, uv - (off2 / resolution)) * 0.09447039785044732;
  color += texture2D(gm_BaseTexture, uv + (off3 / resolution)) * 0.010381362401148057;
  color += texture2D(gm_BaseTexture, uv - (off3 / resolution)) * 0.010381362401148057;
  return color;
}

void main()
{
	vec2 uv = vec2(gl_FragCoord.xy / resolution.xy);
	gl_FragColor = blur(uv, resolution.xy, vec2(1.1, 1.0)) * v_vColour;
}
