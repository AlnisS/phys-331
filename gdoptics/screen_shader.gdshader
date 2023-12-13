shader_type spatial;

render_mode unshaded;

// declare as varying to allow using in fragment(), if needed
varying flat vec4 world_vertex;

// light intensity (square of magnitude of phasor)
varying float intensity;

const float wavelength = 635e-8;

// TODO: investigate & expand this limit
const int n_sources = 1000;

// point sources of light in the mask
// TODO: incorporate specification of phases of source light
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
		// calculate phase of arriving light, relative to starting phase of 0
		float dist = distance(screen_point_position, sources[i].xyz);
		float phase = 2.0 * PI * dist / wavelength;
		
		// modulo brings phase to within 2*PI of 0 to avoid errors on some GPUs
		phase = mod(phase, 2.0 * PI);
		
		// add resulting phasor to total phasor for this point on the screen
		phasor.x += cos(phase);
		phasor.y += sin(phase);
	}
	
	// normalize phasor to 0...1 range
	phasor /= float(n_sources);
	
	// light intensity = phasor magnitude squared
	intensity = pow(length(phasor), 2.0);
	
	// TODO: actually calculate the color based on wavelength
	COLOR.rgb = vec3(intensity, 0.0, 0.0) + vec3(0.01);
}


// use the color calculated for each screen point as the rendered color
void fragment() {
	ALBEDO = COLOR.rgb;
}
