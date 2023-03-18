extends Area2D

const HitEffect = preload("res://Effects/HitEffect.tscn")

var hurtCooldown = false setget set_hurt_cooldown

onready var timer = $Timer
onready var collisionShape = $CollisionShape2D

export var invincibile = false setget set_invincibility

signal hurt_cooldown_started
signal hurt_cooldown_ended

func set_hurt_cooldown(value):
	hurtCooldown = value
	if hurtCooldown == true:
		emit_signal("hurt_cooldown_started")
	else:
		emit_signal("hurt_cooldown_ended")

func start_dodge():
	if invincibile == false:
		collisionShape.set_deferred("disabled", true)

func end_dodge():
	if invincibile == false:
		collisionShape.set_deferred("disabled", false)
	
func set_invincibility(value):
	invincibile = value
	if invincibile == true:
		collisionShape.set_deferred("disabled", true)
	else:
		collisionShape.set_deferred("disabled", false)

func start_hurt_cooldown(duration):
	self.hurtCooldown = true
	timer.start(duration)

func create_hit_effect():
	var effect = HitEffect.instance()
	var main = get_tree().current_scene
	main.add_child(effect)
	effect.global_position = global_position

func _on_Timer_timeout():
	self.hurtCooldown = false

func _on_Hurtbox_hurt_cooldown_started():
	if invincibile == false:
		collisionShape.set_deferred("disabled", true)

func _on_Hurtbox_hurt_cooldown_ended():
	if invincibile == false:
		collisionShape.set_deferred("disabled", false)

