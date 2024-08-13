extends Node

class_name IObserver

static func is_type(obj : Object) -> bool:
    return obj.has_method("update")