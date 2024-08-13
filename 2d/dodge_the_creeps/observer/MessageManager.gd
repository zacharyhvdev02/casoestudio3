extends Node

class_name MessageManager

var observers = []
var player: Node

func _init(pplayer: Node):
    if not ISubject.is_type(self):
        print("MessageManager is not a valid ISubject")
    print("MessageManager is ready")
    # self.healthLabel = healthLbl
    # self.scoreLabel = scoreLbl
    self.player = pplayer

func add(observer: IObserver) -> void:
    self.observers.append(observer)
    pass

func remove(observer: IObserver) -> void:
    self.observers.remove(observer)
    pass

func notify() -> void:
    for observer in self.observers:
        observer.update(self.player)
    pass
