extends IObserver

class_name ScoreObserver
var HUD: Node

func _init(pHUD: Node):
    if not IObserver.is_type(self):
        print("HealthObserver is not a valid IObserver")
    print("HealthObserver is ready")
    self.HUD = pHUD

func update(player: Node) -> void:
    if player.score == 20:
        self.HUD.show_message("Has ganado")
        self.HUD.update_score(player.score)
        player.win.emit()
    else:
        self.HUD.update_score(player.score)