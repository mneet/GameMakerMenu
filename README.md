# GameMakerMenu

Como funciona:
![](https://github.com/mneet/GameMakerMenu/blob/main/imagens/vetor_menus.png?raw=true)

As paginas dos menus são declaradas em arrays bidimensionais que armazenaram as opções presentes em cada menu e a função de cada uma>

Exemplo:
![](https://github.com/mneet/GameMakerMenu/blob/main/imagens/exemplo_menu.png?raw=true)

Nesse exemplo podemos perceber que:
  No indice 0 temos o texto, o conteúdo que sera exibido na tela.
  No indice 1 temos qual é a função dessa opção, se rodara um script, se mudara a página do menu, etc
  No indice 2 temos o scrip ou pagina destino que essa opção levará.

Podemos ter também algumas diferenças dependendo do tipo de função da opção:

![image](https://github.com/mneet/GameMakerMenu/assets/100791626/1c0d5069-81c5-45ff-a121-fcb3198f0fd1)

Ambas opções estão presentes no mesma pagina de menu, mas possuem diferentes conteúdos a partir do índice 3 dependendo do tipo de ação.

Para criar uma nova pagina do menu, basta criar um novo vetor seguindo o layout apresentado, adicionar a variavel contendo esse vetor dentro da váriavel menus[...].
Também é necessário adicionar o nome dessa página no enumerador presente no evento create do obj_menuControl, atenção que a ordem do enumerador deve ser a mesma da váriavel 'menus'.



Esse sistema é baseado no tutorial do canal FriendlyCosmonaut.
