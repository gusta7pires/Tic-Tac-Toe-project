extends Area2D

export(Array, Texture) var player_textures;

var player_marker: int;
var sprite;
var board;
var pos_line;
var pos_columm;

func _ready():
	sprite = get_node("Sprite");
	set_player(0);

func _input_event(viewport, event, shape_idx):
	if(event is InputEventMouseButton and event.button_index == BUTTON_LEFT and event.pressed):
		board.node_clicked(pos_line, pos_columm);

func get_player():
	return player_marker;

func set_player(player):
	player_marker = player;
	
	sprite.texture = player_textures[player];

func set_board(board, line, columm): #chamado no BoardManager
	self.board = board;
	pos_line = line;
	pos_columm = columm;
