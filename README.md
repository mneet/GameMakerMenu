<!DOCTYPE html>
<html>

<head>
    <title>GameMakerMenu</title>
</head>

<body>
    <h1>GameMakerMenu</h1>

    <img src="https://github.com/mneet/GameMakerMenu/blob/main/imagens/vetor_menus.png?raw=true" alt="Exemplo de Funcionamento">

    <p>O <strong>GameMakerMenu</strong> é uma biblioteca que simplifica a criação de menus interativos em jogos desenvolvidos no GameMaker Studio. Ele permite criar menus dinâmicos com várias opções e ações associadas a cada uma delas.</p>

    <h2>Funcionamento Básico</h2>

    <p>As páginas dos menus são declaradas em arrays bidimensionais, que armazenam as opções presentes em cada menu e a função associada a cada uma delas.</p>

    <h3>Exemplo:</h3>

    <img src="https://github.com/mneet/GameMakerMenu/blob/main/imagens/exemplo_menu.png?raw=true" alt="Exemplo de Menu">

    <p>Neste exemplo, observe:</p>

    <ul>
        <li>No índice 0, temos o texto que será exibido na tela.</li>
        <li>No índice 1, especificamos a função dessa opção, como a execução de um script ou a mudança para outra página do menu.</li>
        <li>No índice 2, indicamos o script ou página de destino associada a essa opção.</li>
    </ul>

    <h4>Diferenças Dependendo da Função da Opção</h4>

    <p>Além disso, podem haver diferenças no conteúdo a partir do índice 3, dependendo do tipo de ação associada à opção.</p>

    <img src="https://github.com/mneet/GameMakerMenu/assets/100791626/1c0d5069-81c5-45ff-a121-fcb3198f0fd1"
        alt="Diferentes Tipos de Ação">

    <p>Ambas as opções estão presentes na mesma página do menu, mas seus conteúdos a partir do índice 3 são diferentes com base na ação associada.</p>

    <h3>Adicionando Novas Páginas de Menu</h3>

    <p>Para criar uma nova página de menu, siga estas etapas:</p>

    <ol>
        <li>Crie um novo vetor seguindo o mesmo layout apresentado.</li>
        <li>Adicione a variável contendo esse vetor dentro da variável <code>menus[...]</code>.</li>
        <li>Certifique-se de adicionar o nome dessa página ao enumerador presente no evento <code>create</code> do <code>obj_menuControl</code>. A ordem do enumerador deve corresponder à ordem das variáveis em <code>menus</code>.</li>
    </ol>

    <h2>Créditos</h2>

    <p>Este sistema é baseado no tutorial do canal FriendlyCosmonaut.</a>.</p>

</body>

</html>

