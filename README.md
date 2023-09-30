# GameMakerMenu
![Exemplo](https://github.com/mneet/GameMakerMenu/blob/main/imagens/Menu.gif?raw=true)
## Funcionamento Básico

![Exemplo de Funcionamento](https://github.com/mneet/GameMakerMenu/blob/main/imagens/vetor_menus.png?raw=true)
As páginas dos menus são declaradas em arrays bidimensionais, que armazenam as opções presentes em cada menu e a função associada a cada uma delas.

**Exemplo:**

![Exemplo de Menu](https://github.com/mneet/GameMakerMenu/blob/main/imagens/exemplo_menu.png?raw=true)

Neste exemplo, observe:

- No índice 0, temos o texto que será exibido na tela.
- No índice 1, especificamos a função dessa opção, como a execução de um script ou a mudança para outra página do menu.
- No índice 2, indicamos o script ou página de destino associada a essa opção.
- No índice 3, na primeira opção temos um valor que sera usado como PARAMETRO, mas ele só se encontra quando o tipo de ação é "MUDAR_ROOM"

### Diferenças Dependendo da Função da Opção

Além disso, podem haver diferenças no conteúdo a partir do índice 3, dependendo do tipo de ação associada à opção.

![Diferentes Tipos de Ação](https://github.com/mneet/GameMakerMenu/blob/main/imagens/exemplo_vetor.png?raw=true)

Ambas as opções estão presentes na mesma página do menu, mas seus conteúdos a partir do índice 3 são diferentes com base na ação associada.

### Adicionando Novas Páginas de Menu

Para criar uma nova página de menu, siga estas etapas:

1. Crie um novo vetor seguindo o mesmo layout apresentado.
2. Adicione a variável contendo esse vetor dentro da variável `menus[...]`.
3. Certifique-se de adicionar o nome dessa página ao enumerador presente no evento `create` do `obj_menuControl`. A ordem do enumerador deve corresponder à ordem das variáveis em `menus`.

## Créditos

Este sistema é baseado no tutorial do canal FriendlyCosmonaut.
