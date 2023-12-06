extends Node3D

@onready var mat = $Screen.material_override

var mask := []:
	set(_mask):
		mask = _mask
		mat.set_shader_parameter("sources", mask)


var time = 0.0
var lmt = 0.0


func _ready():
	mask = mask_double_slit()

func _process(delta):
	time += delta
	
	if Input.is_action_pressed("closer") and time > lmt + 0.1:
		$DistanceSlider.value -= $DistanceSlider.step
		lmt = time
	if Input.is_action_pressed("farther") and time > lmt + 0.1:
		$DistanceSlider.value += $DistanceSlider.step
		lmt = time
	#$Screen.global_position = Vector3(0.0, 0.0, -1.2) + Vector3(0.4 * cos(0.3 * time), 0.0, -1.0 * sin(0.7 * time))
	#$Screen.rotation_degrees.y = sin(time) * 30.0


func set_mask(mask):
	mat.set_shader_parameter("sources", mask)


func mask_slit(width=0.092e-3):
	var sources = []
	add_points(sources, 1000, width, 0.010e-3, Vector3(0.0, 0.0, 0.0))
	return sources


func mask_double_slit(separation=0.247e-3):
	var sources = []
	add_points(sources, 500, 0.092e-3, 0.010e-3, Vector3(+separation / 2, 0.0, 0.0))
	add_points(sources, 500, 0.092e-3, 0.010e-3, Vector3(-separation / 2, 0.0, 0.0))
	return sources


func mask_double_diagonal_slit(separation=0.247e-3):
	var sources = []
	add_points(sources, 500, 0.092e-3, 0.001e-3, Vector3(+separation / 2, 0.0002, 0.0))
	add_points(sources, 500, 0.092e-3, 0.001e-3, Vector3(-separation / 2, 0.0, 0.0))
	return sources
	

func mask_circle(radius=0.247e-3):
	var sources = []
	add_circle_points(sources, 1000, radius, Vector3(0, 0, 0))
	return sources

func mask_double_circle(separation=0.247e-3):
	var sources = []
	add_circle_points(sources, 500, 0.247e-3, Vector3(+separation / 2, 0.0, 0.0))
	add_circle_points(sources, 500, 0.247e-3, Vector3(-separation / 2, 0.0, 0.0))
	return sources


func add_points(arr, count, width, height, center):
	for i in range(count):
		arr.append(center + Vector3(randf_range(-width / 2, width / 2), randf_range(-height / 2, height / 2), 0.0))

func add_circle_points(arr, count, radius, center):
	for i in range(count):
		var r = sqrt(randf()) * radius
		var theta = randf() * 2 * PI
		arr.append(center + Vector3(r * cos(theta), r * sin(theta), 0.0))

func _on_distance_slider_value_changed(value):
	$Screen.global_position.z = -value
	$LabelD.text = str(value)


func _on_button_tlc_pressed():
	mask = mask_double_slit()


func _on_button_tlm_pressed():
	mask = mask_double_slit(0.503e-3)


func _on_button_diag_pressed():
	mask = mask_double_diagonal_slit()


func _on_button_cs_pressed():
	mask = mask_circle()


func _on_button_cm_pressed():
	mask = mask_circle(0.503e-3)



func _on_button_tcc_pressed():
	mask = mask_double_circle(0.503e-3)


func _on_button_tcm_pressed():
	mask = mask_double_circle(1.0e-3)


func _on_button_ls_pressed():
	mask = mask_slit()


func _on_button_lm_pressed():
	mask = mask_slit(0.200e-3)
