shader_type spatial;

render_mode unshaded;

varying flat vec4 world_vertex;
varying float amplitude;

const int n_sources = 1000;
const float wavelength = 635e-8;

uniform vec3 sources[n_sources];


void vertex() {
//	vec3 sources[] = { vec3(-4.1489e-06, 0.0000e+00, 1.1016e-05), vec3(-2.4994e-05, 0.0000e+00, -9.8834e-06), vec3(-1.7662e-05, 0.0000e+00, -2.0383e-05), vec3(-1.5687e-05, 0.0000e+00, -7.7220e-06), vec3(-5.1616e-06, 0.0000e+00, 1.9408e-06), vec3(-4.0403e-06, 0.0000e+00, 9.2610e-06), vec3(-1.4777e-05, 0.0000e+00, 1.8906e-05), vec3(-2.3631e-05, 0.0000e+00, 8.5234e-06), vec3(-4.1348e-06, 0.0000e+00, 2.9345e-06), vec3(-1.7981e-05, 0.0000e+00, -1.5095e-05), vec3(1.5037e-05, 0.0000e+00, 2.3413e-05), vec3(-9.3288e-06, 0.0000e+00, 9.6161e-06), vec3(1.8819e-05, 0.0000e+00, 1.9730e-05), vec3(-2.0748e-05, 0.0000e+00, -2.3047e-05), vec3(-1.6508e-05, 0.0000e+00, 1.8907e-05), vec3(-2.0083e-05, 0.0000e+00, -3.9446e-06), vec3(2.2894e-05, 0.0000e+00, 1.6583e-06), vec3(9.5939e-06, 0.0000e+00, -9.2242e-06), vec3(9.3250e-06, 0.0000e+00, 1.6731e-05), vec3(-2.4086e-05, 0.0000e+00, 1.2507e-05), vec3(2.4443e-05, 0.0000e+00, 1.2408e-05), vec3(-1.0978e-05, 0.0000e+00, 1.4464e-05), vec3(-1.9839e-05, 0.0000e+00, -2.6053e-06), vec3(2.0430e-05, 0.0000e+00, -1.0319e-05), vec3(-1.0611e-05, 0.0000e+00, -1.8499e-05), vec3(-2.4032e-05, 0.0000e+00, 8.9418e-06), vec3(-1.4419e-05, 0.0000e+00, -1.1723e-05), vec3(-4.2134e-07, 0.0000e+00, -2.2332e-05), vec3(3.7059e-06, 0.0000e+00, -1.7664e-05), vec3(4.4653e-06, 0.0000e+00, 9.9879e-06), vec3(-1.9883e-05, 0.0000e+00, -4.2972e-06), vec3(9.7200e-06, 0.0000e+00, -4.2910e-06), vec3(-2.2502e-05, 0.0000e+00, 1.7948e-06), vec3(8.1897e-06, 0.0000e+00, 7.4446e-07), vec3(2.2230e-05, 0.0000e+00, 4.3278e-06), vec3(2.0170e-05, 0.0000e+00, -1.8126e-05), vec3(-1.8036e-05, 0.0000e+00, 1.5370e-05), vec3(-5.1162e-06, 0.0000e+00, -1.6732e-05), vec3(2.1375e-05, 0.0000e+00, -7.6117e-06), vec3(1.2541e-05, 0.0000e+00, 1.1300e-05), vec3(1.9165e-05, 0.0000e+00, 6.1836e-06), vec3(1.2547e-05, 0.0000e+00, -7.5551e-06), vec3(-1.1504e-05, 0.0000e+00, 1.9794e-05), vec3(-3.5954e-06, 0.0000e+00, 2.3242e-05), vec3(8.1721e-06, 0.0000e+00, 6.0848e-06), vec3(-1.9263e-05, 0.0000e+00, 2.2474e-05), vec3(-2.5044e-06, 0.0000e+00, 3.9195e-06), vec3(-4.5932e-06, 0.0000e+00, -1.3149e-05), vec3(2.0169e-05, 0.0000e+00, 3.6840e-06), vec3(-2.4856e-05, 0.0000e+00, 5.8572e-06) };
	
	world_vertex = MODEL_MATRIX * vec4(VERTEX, 1.0);
	vec3 target = world_vertex.xyz;
	
//	vec3 displacements[n_sources];

	float phasor_x = 0.0;
	float phasor_y = 0.0;
	
	float magnitude = 0.0;
	
	for (int i = 0; i < n_sources; i++) {
		float dist = distance(target, sources[i].xyz);
//		float dist = distance(target, vec3(0.0));
		float phase = 2.0 * PI * dist / wavelength;
		phasor_x += cos(phase);
		phasor_y += sin(phase);
	}
	
	phasor_x /= float(n_sources);
	phasor_y /= float(n_sources);
	
	magnitude = sqrt(phasor_x * phasor_x + phasor_y * phasor_y);
	
	magnitude *= magnitude;
	
//	magnitude *= magnitude;
	
//	magnitude *= 5.0;
	
//	magnitude = phasor_x;
//	magnitude = phasor_x;
	
	amplitude = magnitude;
}

void fragment() {
//	ALBEDO = world_vertex.xyz;
	ALBEDO = vec3(amplitude, 0.0, 0.0) + vec3(0.01);
}
