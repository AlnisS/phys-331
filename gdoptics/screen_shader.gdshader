shader_type spatial;

render_mode unshaded;

varying flat vec4 world_vertex;
varying float intensity;

const int n_sources = 1000;
const float wavelength = 635e-8;

uniform vec3 sources[n_sources];


// The `vertex` function executes once per vertex in the mesh used as the target
// for rendering. Essentially, it runs for every point on the screen.
void vertex() {
	// find the position of this point on the screen in world space
	world_vertex = MODEL_MATRIX * vec4(VERTEX, 1.0);
	vec3 screen_point_position = world_vertex.xyz;

	vec2 phasor = vec2(0.0);
	
	// iterate over point sources in the mask
	for (int i = 0; i < n_sources; i++) {
		float dist = distance(screen_point_position, sources[i].xyz);
		float phase = 2.0 * PI * dist / wavelength;
		phase = mod(phase, 2.0 * PI);
		
		// add resulting phasor to total phasor for this point on the screen
		phasor.x += cos(phase);
		phasor.y += sin(phase);
	}
	
	// normalize phasor to 0...1 range
	phasor /= float(n_sources);
	
	// light intensity = phasor magnitude squared
	intensity = pow(length(phasor), 2.0);
	
	COLOR.rgb = vec3(intensity, 0.0, 0.0) + vec3(0.01);
}


// use the color calculated for each screen point as the rendered color
void fragment() {
	ALBEDO = COLOR.rgb;
}
