extends Node3D

@onready var mat = $Screen.material_override

func _ready():
	var sources = []
	
#	var width := 0.05e-3
#	var height := 0.01e-3
#	var center = Vector3(0.0, 0.0, 0.0)
#
#	for i in range(500):
#		sources.append(center + Vector3(randf_range(-width / 2, width / 2), randf_range(-height / 2, height / 2), 0.0))
#
#	for i in range(500):
#		sources.append(center + Vector3(randf_range(-height / 2, height / 2), randf_range(-width / 2, width / 2), 0.0))
	
#	var separation := 0.247e-3
#	add_points(sources, 500, 0.092e-3, 0.010e-3, Vector3(+separation / 2, 0.0, 0.0))
#	add_points(sources, 500, 0.092e-3, 0.010e-3, Vector3(-separation / 2, 0.0, 0.0))


	var separation := 0.247e-3
	add_points(sources, 500, 0.092e-3, 0.010e-3, Vector3(+separation / 2, 0.0002, 0.0))
	add_points(sources, 500, 0.092e-3, 0.010e-3, Vector3(-separation / 2, 0.0, 0.0))


#	var separation := 0.247e-2
#	add_points(sources, 250, 0.010e-2, 0.010e-2, Vector3(+separation / 2 * 0.0, +separation / 2, 0.0))
#	add_points(sources, 250, 0.010e-2, 0.010e-2, Vector3(-separation / 2 * 0.0, +separation / 2, 0.0))
#	add_points(sources, 250, 0.010e-2, 0.010e-2, Vector3(+separation / 2 * 0.0, -separation / 2, 0.0))
#	add_points(sources, 250, 0.010e-2, 0.010e-2, Vector3(-separation / 2 * 0.0, -separation / 2, 0.0))

#	add_points(sources, 1000, 0.200e-2, 0.200e-2, Vector3(0.0, 0.0, 0.0))

#
#	add_points(sources, 500, 1.0e-5, 1.0e-5, Vector3(1.0e-4, 0.0, 0.0))
#	add_points(sources, 500, 1.0e-5, 1.0e-4, Vector3(-1.0e-4, 0.0, 0.0))
	
	mat.set_shader_parameter("sources", sources)
	pass


var time = 0.0

func _process(delta):
	time += delta
	$Screen.global_position = Vector3(0.0, 0.0, -1.2) + Vector3(0.4 * cos(0.3 * time), 0.0, -1.0 * sin(0.7 * time))
	$Screen.rotation_degrees.y = sin(time) * 30.0

func add_points(arr, count, width, height, center):
	for i in range(500):
		arr.append(center + Vector3(randf_range(-width / 2, width / 2), randf_range(-height / 2, height / 2), 0.0))


func _on_distance_slider_value_changed(value):
	$Screen.global_position.z = -value
