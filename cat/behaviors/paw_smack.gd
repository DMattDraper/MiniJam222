extends Behavior

@onready var paw_holder: Marker2D = $PawHolder
@onready var animation_player: AnimationPlayer = $PawHolder/AnimationPlayer
@onready var timer : Timer

@export var idle_time := 0.5
@export var appear_time := 3.0
@export var attack_time := 1.5
@export var retract_time := 2.0

@export var speed := 0.01

enum STATES {
	IDLE,
	APPEARING,
	ATTACKING,
	RETRACTING
}

var state : STATES = STATES.IDLE

func _ready() -> void:
	super()
	
	remove_child(paw_holder)
	room.add_child.call_deferred(paw_holder)
	paw_holder.position.x = 0
	paw_holder.position.y = Statics.game_screen_height / -2.0
	
	timer = Timer.new()
	timer.wait_time = idle_time
	timer.timeout.connect(update_state)
	add_child(timer)

func handle_behavior() -> void:
	if state == STATES.APPEARING:
		paw_holder.global_position.x = lerp(paw_holder.global_position.x, Statics.player.global_position.x, speed)

func update_state() -> void:
	match (state):
		STATES.IDLE:
			state = STATES.APPEARING
			timer.wait_time = appear_time
			animation_player.play("appear")
			paw_holder.global_position.x = Statics.player.global_position.x
		STATES.APPEARING:
			state = STATES.ATTACKING
			timer.wait_time = attack_time
			animation_player.play("attack")
		STATES.ATTACKING:
			state = STATES.RETRACTING
			timer.wait_time = retract_time
			animation_player.play("retract")
		STATES.RETRACTING:
			state = STATES.IDLE
			timer.wait_time = idle_time
			animation_player.play("RESET")
	timer.start()

func activate() -> void:
	super()
	timer.start()

func deactivate() -> void:
	super()
	timer.stop()


func _on_paw_body_entered(body: Node2D) -> void:
	if body is Player and state == STATES.ATTACKING:
		GameManager.call_deferred("reset")
