#version 300 es

#ifdef GL_ES
precision mediump float;
#endif

uniform float width_i;
uniform int rotation;

out vec4 uv_pair;

// Keep in sync with Scene.vert; shaders cannot share this function.
vec2 rotated_uv(vec2 uv) {
	if (rotation == 90) {
		return vec2(1.0 - uv.y, uv.x);
	}
	if (rotation == 180) {
		return vec2(1.0 - uv.x, 1.0 - uv.y);
	}
	if (rotation == 270) {
		return vec2(uv.y, 1.0 - uv.x);
	}
	return uv;
}
//--------------------------------------------------------------------------------------
// Vertex Shader
//--------------------------------------------------------------------------------------
void main()
{
	float idHigh = float(gl_VertexID >> 1);
	float idLow = float(gl_VertexID & int(1));

	float x = idHigh * 4.0 - 1.0;
	float y = idLow * 4.0 - 1.0;

	float u_right = idHigh * 2.0;
	float u_left = u_right - width_i;
	float v = idLow * 2.0;

	uv_pair = vec4(rotated_uv(vec2(u_left, v)), rotated_uv(vec2(u_right, v)));
	gl_Position = vec4(x, y, 0.0, 1.0);
}
