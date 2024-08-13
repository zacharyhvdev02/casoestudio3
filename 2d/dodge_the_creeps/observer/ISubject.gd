extends Node

class_name ISubject

static func is_type(obj: Object):
    return obj.has_method("add") and obj.has_method("remove") and obj.has_method("notify")
