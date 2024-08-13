extends IObserver

class_name HealthObserver
var HUD: Node

func _init(pHUD: Node):
    if not IObserver.is_type(self):
        print("HealthObserver is not a valid IObserver")
    print("HealthObserver is ready")
    self.HUD = pHUD

func update(player: Node) -> void:
    if player.health == 1:
        self.HUD.show_info("última vida, ¡ve con cuidado!")
        self.HUD.update_health(player.health)
        return
    if not player.recoveryInmunity:
        print("player health is now: ", player.health)
        self.HUD.show_info("") 
        self.HUD.update_health(player.health)


