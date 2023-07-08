extends Node2D


func _on_audio_stream_player_finished():
	$AudioStreamPlayer.play()

