class_name _SceneTransition extends CanvasLayer

func change_scene (scene: PackedScene):
	$AnimationPlayer.play(&"dissolve")
	await $AnimationPlayer.animation_finished
	get_tree().change_scene_to_packed(scene)
	$AnimationPlayer.play_backwards(&"dissolve")
	
