extends RigidBody2D

onready var break_s : AudioStreamPlayer = get_node("sound_break")
onready var start_s : AudioStreamPlayer = get_node("sound_start")
onready var ywin_s : AudioStreamPlayer = get_node("sound_win")
onready var hit_s : AudioStreamPlayer = get_node("sound_hit")
onready var lose_s : AudioStreamPlayer = get_node("sound_lose")

var game_started : bool = false

func _input(event):
	if event.is_action_pressed("play_game") and game_started == false:
		linear_velocity = Vector2(50,-200)
		game_started = true
		start_s.play()



# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	var bodies_collinding = get_colliding_bodies()
	for body in bodies_collinding:
		if body.is_in_group("gr_blocks"):
			body.queue_free()
			break_s.play()
			if body.get_parent().get_child_count() == 1:
				print("ganaste :c")
				ywin_s.play()
				get_tree().paused = true
				yield(ywin_s, "finished")
				queue_free()
				var replay_scn = load("res://title/replay.tscn")
				get_parent().add_child(replay_scn.instance())
		elif body.get_name() == "border-bottom":
			print("perdiste :c")
			get_tree().paused = true
			lose_s.play()
			yield(lose_s, "finished")
			queue_free()
			var replay_scn = load("res://title/replay.tscn")
			get_parent().add_child(replay_scn.instance())
		else:
				hit_s.play()
	pass
