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

 
//Seleção do menu

anim_val_total = 1;
anim_val = 0;

//Controlando a página do menu
pag = 0;


#region METODOS

//Desenha menu
desenha_menu = function(_menu)
{
	// Definindo a fonte
	draw_set_font(fnt_menu);

	// Definindo alinhamento com base no menu atual
	switch(pag)
	{
		case pagina_menu.principal:
			define_align(fa_middle, fa_center);
			break;
		case pagina_menu.configuracoes:
			define_align(fa_middle, fa_right);
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
		// Checando se a seleção esta no a opção atual
		if (menus_sel[pag] == i && _menu[i][1] != menu_acao.mensagem)
		{
			_cor = c_red;
			_anim = anim_val;
		}
		
		// Calculando posição horizontal e vertical do menu na tela
		var _x_pos = _larg_tela / 2;
		var _y_pos =  (_alt_tela / 3) * 2 - _alt_menu / 2 + (i * _espaco_y);
	
		draw_text_transformed_color(_x_pos, _y_pos, _texto, 1 + _anim, 1 + _anim, image_angle,_cor, _cor,_cor, _cor, _alpha);
	}
	
	// Desenhar o menu secundário quando necessário
	// Definindo alinhamento com base no menu atual
	switch(pag)
	{
		case pagina_menu.configuracoes:
			define_align(fa_middle, fa_left);
			break;
		default:
			define_align(fa_middle, fa_center);
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
controla_menu = function(_menu)
{
	//Input
	var _up, _down, _confirm, _back, _left, _right;
	
	var _sel = menus_sel[pag];
	
	static _animar = false;

	_up			= keyboard_check_pressed(vk_up)		|| keyboard_check_pressed(ord("W"));
	_down		= keyboard_check_pressed(vk_down)	|| keyboard_check_pressed(ord("S"));
	_left		= keyboard_check_pressed(vk_left)	|| keyboard_check_pressed(ord("A"));
	_right		= keyboard_check_pressed(vk_right)	|| keyboard_check_pressed(ord("D"));
	_confirm	= keyboard_check_pressed(vk_enter);
	_back		= keyboard_check_pressed(vk_escape);
	//Checando se NÃO estou alterando as opções
	
	if (_up || _down)
	{
		menus_sel[pag] += _down - _up;	
		
		//Limitando o sel dentro do vetor
		var _tam = array_length(_menu) - 1;
		menus_sel[pag] = clamp(menus_sel[pag], 0, _tam);
		
		//Flag animação
		_animar = true;
		

	}

		//Se eu apertar para a esquerda ou para a direita, eu mexo nas opções
		if (_right || _left)
		{
			//Limite
			var _indice = _menu[_sel][3] != -1 ? 3 : 4;
			var _limite = _indice == 3 ? array_length(_menu[_sel][4]) - 1 : 10;
			
			//Mudando o indíce de opção dentro do menu atual
			menus[pag][_sel][_indice] += _right - _left;
			//garantindo que não ultrapasse os limites
			menus[pag][_sel][_indice] = clamp(menus[pag][_sel][_indice], 0, _limite);
			
			var _arg = _menu[_sel][_indice];
			_menu[_sel][2](_arg);
			
		}

	//O que fazer quando apertar o enter em uma opção
	if (_confirm)
	{
		switch(_menu[_sel][1])
		{
			//Caso seja 0, ele roda um método
			case menu_acao.rodar_metodo: _menu[_sel][2](); break;
			case menu_acao.mudar_pagina: pag = _menu[_sel][2]; break;

		}
	}
	
	//Animando a margem
	if (_animar) anim_val = anim_val_total * valor_ac(ac_margem, _up ^^ _down);
}





#endregion




//Criando meu menu
menu_principal =	[
						["JOGAR",			menu_acao.rodar_metodo,		iniciar_jogo],
						["OPÇÕES",			menu_acao.mudar_pagina,		pagina_menu.configuracoes],
						["SAIR",			menu_acao.rodar_metodo,		sair_jogo]
					];						
											
											
menu_opcoes =		[						
						["VOLUME",			menu_acao.slider,			mudar_volume, 10, [0,10]],
						["MODO DA TELA",	menu_acao.alternar,			alternar_tela_cheia, 0, ["MODO JANELA", "TELA CHEIA"]],
						["VOLTAR",			menu_acao.mudar_pagina,		pagina_menu.principal]
					];



//Salvando todos os menus

menus = [menu_principal, menu_opcoes]

//Salvando a seleção de cada menu
menus_sel = array_create(array_length(menus), 0);

