// Os recursos de script mudaram para a v2.3.0; veja
// https://help.yoyogames.com/hc/en-us/articles/360005277377 para obter mais informações
function scr_funcoes(){

}

enum pagina_menu {
	principal,
	configuracoes,
	sair,
	gameplay
}

enum menu_acao {
	rodar_script,
	mudar_pagina,
	slider,
	alternar,
	mensagem,
	mudar_room
}

//Define align
///@function define_align(vertical, horizontal)
function define_align(_ver, _hor)
{
	draw_set_halign(_hor)
	draw_set_valign(_ver)
}

//Pegar o valor da animation curve
///@function valor_ac(animation_curve, animar, [canal])
function valor_ac(_anim, _animar = false, _chan = 0)
{
	//Posição da animação
	static _pos = 0, _val = 0;
	
	//Aumentando o valor do pos
	//Em 1 segundo o pos vai do 0 até o 1 (final da animação)
	_pos += delta_time / 1000000;
	
	if (_animar) _pos = 0;
	
	//Pegando o valor do canal
	var _canal = animcurve_get_channel(_anim, _chan);
	_val = animcurve_channel_evaluate(_canal, _pos);
	
	
	
	return _val;
}

function trans_room(_dest)
{
	var _trans = instance_create_layer(x,y, layer, obj_transicao);
	_trans.destino = _dest;
}

function sair_jogo()
{
	game_end();
}

function mudar_volume(_audiog ,_volume)
{
	audio_group_set_gain(_audiog, _volume , 0);	
	show_debug_message("mudei volume");
}

function alternar_tela_cheia(_fullscreen)
{
	
	//Dependendo da opção selecionada eu seto como full screen e reinicio as variáveis
	window_set_fullscreen(_fullscreen);

	screenWidth = display_get_gui_width();
	screenHeight = display_get_gui_height();

	///set window size
	window_set_size(screenWidth, screenHeight);

	camera_set_view_size(view_camera[0], screenWidth, screenHeight);

	view_wport = screenWidth;
	view_hport = screenHeight;
	show_debug_message("mudei screen");
	
	surface_resize(application_surface, screenWidth, screenHeight);	
}