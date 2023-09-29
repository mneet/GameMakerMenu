/// @description Inserir descrição aqui
// Você pode escrever seu código neste editor

enum pagina_menu {
	principal,
	configuracoes,
	sair
}

enum menu_acao {
	rodar_metodo,
	mudar_pagina,
	slider,
	alternar,
	mensagem
}

if (!audio_group_is_loaded(ag_bgm)) audio_group_load(ag_bgm);

 
//Seleção do menu

anim_val_total = 1;
anim_val = 0;
mouse_flag = false;
animar_flag = false;
mouse_click = false;

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

		var _cor = c_white, _anim = 0, _alpha = 1;
		
		// Texto da opção atual
		var _texto = _menu[i][0];
		
		// Calculando posição horizontal e vertical do menu na tela
		var _x_pos = _larg_tela / 2;
		var _y_pos =  (_alt_tela / 3) * 2 - _alt_menu / 2 + (i * _espaco_y);
		
		//Mouse control
		var _larg_txt = string_width(_texto);
		_mouse_sel_flag = mouse_control_sel(_x_pos, _y_pos, _larg_txt, _espaco_y, _mouse_align)
		
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
				
		
		draw_text_transformed_color(_x_pos, _y_pos, _texto, 1 + _anim, 1 + _anim, image_angle,_cor, _cor,_cor, _cor, _alpha);
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
				var _txt, _esq, _dir, _cor = c_white, _margem_x = string_width("O"), _alpha = 1;
								
				_txt	= _menu[i][4][_indice];
				
				// Desenhando informativos de limtie das alternativas
				_esq	= _indice > 0 ? " << " : "";
				_dir	= _indice < array_length((_menu[i][4])) - 1 ? " >> " : "";
				
				// Calculando posição horizontal e vertical do menu na tela
				var _x_pos = _larg_tela / 4 * 2 + _margem_x;
				var _y_pos =  (_alt_tela / 3) * 2 - _alt_menu / 2 + (i * _espaco_y);
				
				// Checando se a seleção esta no a opção atual
				if (menus_sel[pag] == i) _cor = c_red;
				
				draw_text_color(_x_pos, _y_pos, _esq + _txt + _dir, _cor, _cor, _cor, _cor, _alpha);
				break;
				
			case menu_acao.slider: 
			
				// Indice da alternativa
				var _indice = _menu[i][3];
				var _txt, _esq, _dir, _margem_x = string_width("O"), _alpha = 1;
				var _cor = c_white, _cor_d, _cor_e;
								
				_txt	= _menu[i][3];
					
				// Desenhando informativos de limtie das alternativas
				_esq	= "-"
				_dir	= "+"
				
				// Calculando posição horizontal e vertical do menu na tela
				var _x_pos = _larg_tela / 4 * 2 + _margem_x;
				var _y_pos =  (_alt_tela / 3) * 2 - _alt_menu / 2 + (i * _espaco_y);
				
				_cor_e	= _indice > _menu[i][4][0] ? c_white : c_gray;
				_cor_d	= _indice < _menu[i][4][1] ? c_white : c_gray;
				
				// Checando se a seleção esta no a opção atual
				if (menus_sel[pag] == i) _cor = c_red;
				
				draw_text_color(_x_pos, _y_pos, _esq, _cor_e, _cor_e, _cor_e, _cor_e, _alpha);
				draw_text_color(_x_pos + string_width(_esq) + _margem_x, _y_pos, _txt, _cor, _cor, _cor, _cor, _alpha);
				draw_text_color(_x_pos + string_width(_txt) + _margem_x * 2 + string_width(_esq), _y_pos, _dir, _cor_d, _cor_d, _cor_d, _cor_d, _alpha);
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
	if (_right || _left)
	{
		var _indice, _limite, _arg, _arg2;
		
		switch(_menu[_sel][1])
		{
			case menu_acao.alternar:
						
				// Definindo indice e limite
				_indice = _menu[_sel][3];
				_limite = array_length(_menu[_sel][4]) - 1;
			
				// Mudando o indíce de opção dentro do menu atual
				menus[pag][_sel][3] += _right - _left;
				// Garantindo que não ultrapasse os limites
				menus[pag][_sel][3] = clamp(menus[pag][_sel][3], 0, _limite);
				// Argumento que será passado para função
				_arg = _menu[_sel][3];
				_menu[_sel][2](_arg);
				
				break;
				
			case menu_acao.slider:
						
				// Definindo indice e limite
				_indice = _menu[_sel][3];
				_limite = _menu[_sel][4][1];
			
				// Mudando o indíce de opção dentro do menu atual
				menus[pag][_sel][3] += _right - _left;
				
				// Garantindo que não ultrapasse os limites
				menus[pag][_sel][3] = clamp(menus[pag][_sel][3], 0, _limite);
				
				// Argumento que será passado para função
				//_arg = audiogroup | _arg2 = volume
				_arg = _menu[_sel][5];
				_arg2 = _menu[_sel][3];
			
				_menu[_sel][2](_arg, _arg2 / 10);
				break;			
		}

			
	}

	//O que fazer quando apertar o enter em uma opção
	if (_confirm || mouse_click)
	{
		switch(_menu[_sel][1])
		{
			//Caso seja 0, ele roda um método
			case menu_acao.rodar_metodo: _menu[_sel][2](); break;
			case menu_acao.mudar_pagina: pag = _menu[_sel][2]; break;
		}
		mouse_click = false;
	}
	
	//Animando a margem
	if (animar_flag) anim_val = anim_val_total * valor_ac(ac_margem, _up ^^ _down);
}

mouse_control_sel = function(_x_pos, _y_pos, _larg_txt, _altura_txt, _align)
{
	var _area_x, _area_y;
	_area_y = mouse_y >= _y_pos - _altura_txt / 2 && mouse_y <= _y_pos + _altura_txt / 2;
	
	// Definindo area horizontal do texto com base no alinhamento recebido
	switch(_align)
	{
		case fa_center:
			_area_x = mouse_x >= _x_pos - _larg_txt / 2 && mouse_x <= _x_pos + _larg_txt / 2;
			break;
		case fa_left:
			_area_x = mouse_x >= _x_pos  && mouse_x <= _x_pos + _larg_txt;
			break;
		case fa_right:
			_area_x = mouse_x >= _x_pos - _larg_txt && mouse_x <= _x_pos;
			break;
	}
	
	// Checando se o mouse esta sobre a area e clicou 
	if (mouse_check_button_pressed(mb_left) && _area_x && _area_y) mouse_click = true;
	
	// Retorno se o mouse esta ou não sobre a area
	if (_area_x && _area_y)	return true;
	else return false;
}




#endregion




//Criando meu menu
menu_principal =	[
						["JOGAR",				menu_acao.rodar_metodo,		iniciar_jogo],
						["OPÇÕES",				menu_acao.mudar_pagina,		pagina_menu.configuracoes],
						["SAIR",				menu_acao.mudar_pagina,		pagina_menu.sair]
					];						
											
											
menu_opcoes =		[						
						["VOLUME",				menu_acao.slider,			mudar_volume,		10, [0,10],	ag_bgm],
						["MODO DA TELA",		menu_acao.alternar,			alternar_tela_cheia, 0, ["MODO JANELA", "TELA CHEIA"]],
						["VOLTAR",				menu_acao.mudar_pagina,		pagina_menu.principal]
					];

menu_sair =			[
						["VOCÊ DESEJA SAIR?",	menu_acao.mensagem],
						["SIM",					menu_acao.rodar_metodo,		sair_jogo],
						["NÃO",					menu_acao.mudar_pagina,		pagina_menu.principal]
					];



//Salvando todos os menus
menus = [menu_principal, menu_opcoes, menu_sair]

//Salvando a seleção de cada menu
menus_sel = array_create(array_length(menus), 0);

