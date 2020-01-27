varying vec2 v_vTexcoord;
varying vec4 v_vColour;

uniform vec2 u_vSize;

const float FXAA_SPAN_MAX   = 8.0;
const float FXAA_REDUCE_MUL = 1.0/8.0;
const float FXAA_REDUCE_MIN = 1.0/128.0;
const vec3  LUMA            = vec3(0.299, 0.587, 0.114);

void main() {
    float lumaNW = dot(vec3(texture2D(gm_BaseTexture, v_vTexcoord - u_vSize)), LUMA);
    float lumaNE = dot(vec3(texture2D(gm_BaseTexture, v_vTexcoord + vec2(u_vSize.x, -u_vSize.y))), LUMA);
    float lumaSW = dot(vec3(texture2D(gm_BaseTexture, v_vTexcoord + vec2(-u_vSize.x, u_vSize.y))), LUMA);
    float lumaSE = dot(vec3(texture2D(gm_BaseTexture, v_vTexcoord + u_vSize)), LUMA);
    float lumaM  = dot(vec3(texture2D(gm_BaseTexture, v_vTexcoord)),  LUMA); // v_vColour
    
    vec2 dir = vec2(-lumaNW - lumaNE + lumaSW + lumaSE, lumaNW + lumaSW - lumaNE - lumaSE);
    
    dir = clamp(dir / (min(abs(dir.x), abs(dir.y)) + max((lumaNW + lumaNE + lumaSW + lumaSE) * 0.25 * FXAA_REDUCE_MUL, FXAA_REDUCE_MIN)), -FXAA_SPAN_MAX, FXAA_SPAN_MAX) * u_vSize;
    
    vec3 rgbA = 0.5 * (vec3(texture2D(gm_BaseTexture, v_vTexcoord.xy + dir * -0.167)) + vec3(texture2D(gm_BaseTexture, v_vTexcoord.xy + dir * 0.167)));
    vec3 rgbB = -0.5 * rgbA + 0.25 * (vec3(texture2D(gm_BaseTexture, v_vTexcoord.xy + dir * -0.5)) + vec3(texture2D(gm_BaseTexture, v_vTexcoord.xy + dir * 0.5)));
    
    float lumaB = dot(rgbB + rgbA, LUMA);
    
    gl_FragColor = vec4(rgbA + step(min(lumaM, min(min(lumaNW, lumaNE), min(lumaSW, lumaSE))), lumaB) * step(lumaB, max(lumaM, max(max(lumaNW, lumaNE), max(lumaSW, lumaSE)))) * rgbB, 1.0);
}

