/// @description Inserir descrição aqui
// Você pode escrever seu código neste editor

if (!audio_group_is_loaded(ag_bgm)) audio_group_load(ag_bgm);

// Valores da animação
anim_val_total = 1;
anim_val = 0;
animar_flag = false;

// Controle do mouse
mouse_flag = false;
mouse_click = false;
mouse_alt = 0;

// Alpha menu
alpha = 1;

//Controlando a página do menu
pag = 0;


#region METODOS

//Desenha menu
menu_draw = function(_menu)
{
	// Definindo a fonte
	draw_set_font(fnt_menu);
	static _animar = false;
	var _mouse_align, _mouse_sel_flag;
	
	// Definindo alinhamento com base no menu atual
	switch(pag)
	{
		case pagina_menu.sair:
		case pagina_menu.principal:
			define_align(fa_middle, fa_center);
			_mouse_align = fa_center;
			break;
		case pagina_menu.configuracoes:
			define_align(fa_middle, fa_right);
			_mouse_align = fa_right;
			break;
		default: 
			define_align(fa_middle, fa_center);
			_mouse_align = fa_center;
			break;
	}

	// Quantidade de opções no menu atual
	var _qtd = array_length(_menu);

	// Altura e largura da tela
	var _alt_tela = display_get_gui_height();	
	var _larg_tela = display_get_gui_width();


	// Tamanho de cada linha e tamanho total do menu
	var _espaco_y = string_height("I") + 16;
	var _alt_menu = _espaco_y * _qtd;


	// Desenhando as opções do menu primário
	for (var i = 0; i < _qtd; i++)
	{

		var _cor = c_white, _anim = 0;
		
		// Texto da opção atual
		var _texto = _menu[i][0];
		
		// Calculando posição horizontal e vertical do menu na tela
		var _x_pos = _larg_tela / 2;
		var _y_pos =  (_alt_tela / 3) * 2 - _alt_menu / 2 + (i * _espaco_y);
		
		//Mouse control
		var _larg_txt = string_width(_texto);
		_mouse_sel_flag = mouse_control_sel(_x_pos, _y_pos, _larg_txt, _espaco_y, _mouse_align)
		
		// Se o mouse está em cima e não seja a mesma opção
		if (_mouse_sel_flag && menus_sel[pag] != i) 
		{
			animar_flag = true;
			menus_sel[pag] = i
			if (animar_flag) anim_val = anim_val_total * valor_ac(ac_margem, true);
		}
		
		// Checando se a seleção esta no a opção atual
		if (menus_sel[pag] == i && _menu[i][1] != menu_acao.mensagem)
		{
			_cor = c_red;
			_anim = anim_val;
		}
				
		
		draw_text_transformed_color(_x_pos, _y_pos, _texto, 1 + _anim, 1 + _anim, image_angle,_cor, _cor,_cor, _cor, alpha);
	}
	
	// Desenhar o menu secundário quando necessário
	// Definindo alinhamento com base no menu atual
	switch(pag)
	{
		case pagina_menu.configuracoes:
			define_align(fa_middle, fa_left);
			_mouse_align = fa_left;
			break;
		default:
			define_align(fa_middle, fa_center);
			_mouse_align = fa_center;
	}
		
	for (var i = 0; i < _qtd; i++)
	{
		//Checar se eu preciso desenhar a opção
		switch(_menu[i][1])
		{
			case menu_acao.alternar: 
			
				// Indice da alternativa
				var _indice = _menu[i][3];
				var _txt, _esq, _dir, _margem_x = string_width("|");
				var _cor = c_white, _cor_d, _cor_e;
				var _x_pos, _y_pos,_txt_pos, _esq_pos, _dir_pos, _sign_size, _size_tot;
								
				_txt	= _menu[i][4][_indice];
				
				// Desenhando informativos de limtie das alternativas
				_esq	= "<<"
				_dir	= ">>"
				
				_cor_e	= _indice > 0 ? c_white : c_gray;
				_cor_d	= _indice < array_length(_menu[i][4]) - 1 ? c_white : c_gray;
				
				// Calculando posição horizontal e vertical do menu na tela
				_x_pos = _larg_tela / 4 * 2 + _margem_x;
				_y_pos =  (_alt_tela / 3) * 2 - _alt_menu / 2 + (i * _espaco_y);
				
				// Calculando posições dos elementos
				_esq_pos = _x_pos + _margem_x
				_txt_pos = _x_pos + string_width(_esq) + _margem_x
				_dir_pos = _x_pos + string_width(_txt)  + string_width(_esq) + _margem_x
				
				// Tamanho total e tamanho dos sinais
				_size_tot = string_width(_esq + _txt + _dir);
				_sign_size = string_width(_esq);
				
				//Controle de seleção por mouse
				_mouse_sel_flag = mouse_control_sel(_x_pos, _y_pos, _size_tot, _espaco_y, _mouse_align)		
				// Se o mouse está em cima e não seja a mesma opção
				if (_mouse_sel_flag && menus_sel[pag] != i) 
				{
					animar_flag = true;
					menus_sel[pag] = i
					if (animar_flag) anim_val = anim_val_total * valor_ac(ac_margem, true);
				}
			
				mouse_control_alt(_y_pos, _esq_pos, _dir_pos, _txt_pos, _sign_size, _espaco_y)
				
				// Checando se a seleção esta no a opção atual
				if (menus_sel[pag] == i) _cor = c_red;
				
				draw_text_color(_esq_pos, _y_pos, _esq, _cor_e, _cor_e, _cor_e, _cor_e, alpha);
				draw_text_color(_txt_pos, _y_pos, _txt, _cor, _cor, _cor, _cor, alpha);
				draw_text_color(_dir_pos, _y_pos, _dir, _cor_d, _cor_d, _cor_d, _cor_d, alpha);
				break;
				
			case menu_acao.slider: 
			
				// Indice da alternativa
				var _indice = _menu[i][3];
				var _txt, _esq, _dir, _margem_x = string_width("|");
				var _cor = c_white, _cor_d, _cor_e;
								
				_txt	= _menu[i][3];
					
				// Desenhando informativos de limtie das alternativas
				_esq	= "-"
				_dir	= "+"
				
				// Calculando posição horizontal e vertical do menu na tela
				var _x_pos = _larg_tela / 4 * 2 + _margem_x;
				var _y_pos =  (_alt_tela / 3) * 2 - _alt_menu / 2 + (i * _espaco_y);
				
				// Calculando posições dos simbolos e do texto
				_esq_pos = _x_pos + _margem_x
				_txt_pos = _x_pos + string_width(_esq) + (_margem_x *2)
				_dir_pos = _x_pos + string_width(_txt)  + string_width(_esq) + _margem_x * 3
				
				// Definindo cor dos simbolos com base nos limites presentes no layout
				_cor_e	= _indice > _menu[i][4][0] ? c_white : c_gray;
				_cor_d	= _indice < _menu[i][4][1] ? c_white : c_gray;
				
				// Tamanho total e tamanho dos sinais
				_size_tot = string_width(_esq + string(_txt) + _dir);
				_sign_size = string_width(_esq);
				
				//Controle de seleção por mouse
				_mouse_sel_flag = mouse_control_sel(_x_pos, _y_pos, _size_tot, _espaco_y, _mouse_align)	
				
				// Se o mouse está em cima e não seja a mesma opção
				if (_mouse_sel_flag && menus_sel[pag] != i) 
				{
					animar_flag = true;
					menus_sel[pag] = i
					if (animar_flag) anim_val = anim_val_total * valor_ac(ac_margem, true);
				}
				
				// Controle de alterações no menu secundário
				mouse_control_alt(_y_pos, _esq_pos, _dir_pos, _txt_pos, _sign_size, _espaco_y)
				
				// Checando se a seleção esta no a opção atual
				if (menus_sel[pag] == i) _cor = c_red;
				
				draw_text_color(_esq_pos, _y_pos, _esq, _cor_e, _cor_e, _cor_e, _cor_e, alpha);
				draw_text_color(_txt_pos, _y_pos, _txt, _cor, _cor, _cor, _cor, alpha);
				draw_text_color(_dir_pos , _y_pos, _dir, _cor_d, _cor_d, _cor_d, _cor_d, alpha);
				break;
		}
	}

	//Resetando draw set
	draw_set_font(-1);
	define_align(-1, -1)
}

//Controlando o menu
input_control = function(_menu)
{
	//Input
	var _up, _down, _confirm, _back, _left, _right;
	
	var _sel = menus_sel[pag];
	

	_up			= keyboard_check_pressed(vk_up)		|| keyboard_check_pressed(ord("W"));
	_down		= keyboard_check_pressed(vk_down)	|| keyboard_check_pressed(ord("S"));
	_left		= keyboard_check_pressed(vk_left)	|| keyboard_check_pressed(ord("A"));
	_right		= keyboard_check_pressed(vk_right)	|| keyboard_check_pressed(ord("D"));
	_confirm	= keyboard_check_pressed(vk_enter);
	_back		= keyboard_check_pressed(vk_escape);
	//Checando se NÃO estou alterando as opções
	
	if (_up || _down)
	{
		// Armazenando seleção anterior
		var _aux = _sel;
		
		menus_sel[pag] += _down - _up;			
		// Limitando o sel dentro do vetor
		var _tam = array_length(_menu) - 1;
		menus_sel[pag] = clamp(menus_sel[pag], 0, _tam);
		
		// Caso seleção seja do tipo mensagem, reverte mudança
		if (_menu[menus_sel[pag]][1] == menu_acao.mensagem) menus_sel[pag] = _aux;
		

		
		// Flag animação
		animar_flag = true;
		

	}

	//Se eu apertar para a esquerda ou para a direita, eu mexo nas opções
	if ((_right || _left) || mouse_alt != 0)
	{
		var _indice, _limite, _arg, _arg2, _aux;
		
		switch(_menu[_sel][1])
		{
			case menu_acao.alternar:
				
				_aux = menus[pag][_sel][3];
				// Definindo indice e limite
				_indice = _menu[_sel][3];
				_limite = array_length(_menu[_sel][4]) - 1;
			
				// Mudando o indíce de opção dentro do menu atual
				menus[pag][_sel][3] += mouse_alt;
				menus[pag][_sel][3] += (_right - _left)
				
				// Garantindo que não ultrapasse os limites
				menus[pag][_sel][3] = clamp(menus[pag][_sel][3], 0, _limite);
				
				// Argumento que será passado para função
				// Se tiver tido mudança 
				if (menus[pag][_sel][3] != _aux)
				{
					_arg = _menu[_sel][3];
					_menu[_sel][2](_arg);
				}
				
				break;
				
			case menu_acao.slider:
				
				_aux = menus[pag][_sel][3];
				// Definindo indice e limite
				_indice = _menu[_sel][3];
				_limite = _menu[_sel][4][1];
			
				// Mudando o indíce de opção dentro do menu atual
				menus[pag][_sel][3] += mouse_alt;
				menus[pag][_sel][3] += (_right - _left);
				
				// Garantindo que não ultrapasse os limites
				menus[pag][_sel][3] = clamp(menus[pag][_sel][3], 0, _limite);
				
				// Argumento que será passado para função
				//_arg = audiogroup | _arg2 = volume
				if (menus[pag][_sel][3] != _aux)
				{
					_arg = _menu[_sel][5];
					_arg2 = _menu[_sel][3];		
					_menu[_sel][2](_arg, _arg2 / 10);
				}
				
				break;			
		}
		mouse_alt =0 ;
			
	}

	//O que fazer quando apertar o enter em uma opção
	if (_confirm || mouse_click)
	{
		switch(_menu[_sel][1])
		{
			//Caso seja 0, ele roda um método
			case menu_acao.rodar_script: _menu[_sel][2](); break;
			case menu_acao.mudar_pagina: pag = _menu[_sel][2]; break;
			case menu_acao.mudar_room: 
				_menu[_sel][2](_menu[_sel][3]);
				alpha = 0;
				break;
		}
		mouse_click = false;
	}
	
	//Animando a margem
	if (animar_flag) anim_val = anim_val_total * valor_ac(ac_margem, _up ^^ _down);
}

mouse_control_sel = function(_x_pos, _y_pos, _larg_txt, _altura_txt, _align)

{
	var _area_x, _area_y, _m_x, _m_y, _box, _x1, _x2, _y1, _y2;
	
	// Pegando posição do mouse relativa a GUI
	_m_x = device_mouse_x_to_gui(0);
	_m_y = device_mouse_y_to_gui(0);
	
	// Calculando a altura do retangulo para colisão
	_y1 = _y_pos - _altura_txt / 2; 
	_y2 = _y_pos + _altura_txt / 2;
	
	// Calculando a largura do retangulo para colisão de acordo com alinhamento recebido
	switch(_align)
	{
		case fa_center:
			_x1 = _x_pos - _larg_txt / 2; 
			_x2 = _x_pos + _larg_txt / 2;
			break;
		case fa_left:
			_x1 = _x_pos; 
			_x2 = _x_pos + _larg_txt;
			break;
		case fa_right:
			_x1 = _x_pos - _larg_txt;
			_x2 = _x_pos;
			break;
	}
	
	// Definindo a area de colisão com base nas posições calculadas
	_box = point_in_rectangle(_m_x, _m_y, _x1, _y1, _x2, _y2);
	
	// Checando se o mouse esta sobre a area e clicou 
	if (mouse_check_button_pressed(mb_left) && _box) mouse_click = true;
	
	// Retorno se o mouse esta ou não sobre a area
	if (_box)	return true;
	else return false;
}

mouse_control_alt = function(_y_pos, _esq_pos, _dir_pos, _txt_pos, _sign_size, _altura, _ind)
{
	var _area_x_esq, _area_x_dir, _area_y, _margem = string_width("|");
	
	var _m_x, _m_y, _box_esq, _box_dir, _x1_esq, _x2_esq, _x1_dir, _x2_dir, _y1, _y2;
	
	// Pegando posição do mouse relativa a GUI
	_m_x = device_mouse_x_to_gui(0);
	_m_y = device_mouse_y_to_gui(0);
	
	// Calculando a altura do retangulo para colisão
	_y1 = _y_pos - _altura / 2; 
	_y2 = _y_pos + _altura / 2;
	
	// Calculando area de colisão esquerda
	_x1_esq = _esq_pos - _margem;
	_x2_esq = _esq_pos + _sign_size + _margem;
	
	// Calculando area de colisão direita
	_x1_dir = _dir_pos - _margem
	_x2_dir = _dir_pos + _sign_size + _margem
	
	// Definindo caixas de colisão 
	_box_dir = point_in_rectangle(_m_x, _m_y, _x1_dir, _y1, _x2_dir, _y2);
	_box_esq = point_in_rectangle(_m_x, _m_y, _x1_esq, _y1, _x2_esq, _y2);

	
	// Checando se o mouse esta sobre a area e clicou 
	if (mouse_check_button_pressed(mb_left))
	{
		// Se clicou na esquerad diminui, direita aumenta
		if (_box_esq) mouse_alt = -1;
		else if (_box_dir) mouse_alt = 1;
	}
	
}


#endregion



//Criando meu menu
menu_principal =	[
						["JOGAR",						menu_acao.mudar_room,		trans_room,		rm_gameplay],
						["OPÇÕES",						menu_acao.mudar_pagina,		pagina_menu.configuracoes],
						["SAIR",						menu_acao.mudar_pagina,		pagina_menu.sair]
					];									
														
														
menu_opcoes =		[									
						["VOLUME",						menu_acao.slider,			mudar_volume,		10, [0,10],	ag_bgm],
						["MODO DA TELA",				menu_acao.alternar,			alternar_tela_cheia, 0, ["MODO JANELA", "TELA CHEIA"]],
						["VOLTAR",						menu_acao.mudar_pagina,		pagina_menu.principal]
					];

menu_sair =			[
						["VOCÊ DESEJA SAIR?",			menu_acao.mensagem],
						["SIM",							menu_acao.rodar_script,		sair_jogo],
						["NÃO",							menu_acao.mudar_pagina,		pagina_menu.principal]
					];

menu_gameplay =		[
						["Quer voltar para o menu?",	menu_acao.mensagem],
						["VOLTAR",						menu_acao.mudar_room,		trans_room,		rm_menu_inicial],
					];	



//Salvando todos os menus
menus = [menu_principal, menu_opcoes, menu_sair, menu_gameplay]

//Salvando a seleção de cada menu
menus_sel = array_create(array_length(menus), 0);

