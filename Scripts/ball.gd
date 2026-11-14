extends RigidBody2D

signal fell(ball)

@export var fall_y : float = 1200.0
var has_fallen := false
var start_position : Vector2

@onready var sprite = $Sprite2D

func _ready():
	start_position = global_position
	add_to_group("Ball")
	for p in get_tree().get_nodes_in_group("Player"):
		add_collision_exception_with(p)
	contact_monitor = true
	max_contacts_reported = 4
	body_entered.connect(_on_body_entered)

func _physics_process(_delta):
	if not has_fallen and global_position.y > fall_y:
		has_fallen = true
		fell.emit(self)

func _integrate_forces(state):
	var target = Vector2.DOWN
	if state.linear_velocity.length() > 100:
		target = state.linear_velocity.normalized()
	var diff = state.transform.y.angle_to(target)
	state.angular_velocity = diff * 8.0

func _on_body_entered(body):
	if body.is_in_group("Player"):
		return
	flash()
	if not has_fallen:
		has_fallen = true
		fell.emit(self)

func flash():
	var mat = sprite.material as ShaderMaterial
	mat.set_shader_parameter("flash", 1.0)
	await get_tree().create_timer(0.1).timeout
	mat.set_shader_parameter("flash", 0.0)

func reset_ball():
	freeze = true
	global_position = start_position
	linear_velocity = Vector2.ZERO
	angular_velocity = 0.0
	has_fallen = false
	await get_tree().create_timer(1.0).timeout
	freeze = false
