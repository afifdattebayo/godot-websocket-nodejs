extends Node

const PORT = 3000

var _server = WebSocketServer.new()

func _ready():
	_server.connect("client_connected",self,"_connected")
	_server.connect("client_disconnected",self, "_disconnected")
	_server.connect("client_close_request",self, "_close_request")
	
	_server.connect("data_received",self,"_on_data")
	
	var err = _server.listen(PORT)
	if err != OK:
		print("Unable to start server")
		set_process(false)
	else:
		print("Server started")
		
func _connected(id, proto):
	print(id, proto)	
	_server.get_peer(id).put_packet(JSON.print({"test godot server": "test godot server"}).to_utf8())
	
func _close_request(id, code, reason):
	print(id, code, reason)

func _disconnected(id, was_clean = false):
	print("closed: ",id, was_clean)

func _on_data(id):
	var payload = JSON.parse(_server.get_peer(id).get_packet().get_string_from_utf8()).result
	print(payload)

# warning-ignore:unused_argument
func _process(delta):
	_server.poll()
