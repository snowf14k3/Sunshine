#version 300 es

#ifdef GL_ES
precision mediump float;
#endif

uniform int rotation;

out vec2 tex;

// Keep in sync with ConvertUV.vert; shaders cannot share this function.
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

void main()
{
	float idHigh = float(gl_VertexID >> 1);
	float idLow = float(gl_VertexID & int(1));

	float x = idHigh * 4.0 - 1.0;
	float y = idLow * 4.0 - 1.0;

	float u = idHigh * 2.0;
	float v = idLow * 2.0;

	gl_Position = vec4(x, y, 0.0, 1.0);
	tex = rotated_uv(vec2(u, v));
}
