extends Node
## A bus for cross domain communication using signals.

@warning_ignore_start("unused_signal")
## Will trigger game over sequence with player's death animation.
## Used by spikes or other object to kill player.
signal player_died 
@warning_ignore_restore("unused_signal")
