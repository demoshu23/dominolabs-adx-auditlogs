import json
def normalize_log(log):
    return {
        "Time": log.get("time"),
        "Source": log.get("source"),
        "User": log.get("user"),
        "Action": log.get("action"),
        "Details": json.dumps(log.get("details", {}))
    }