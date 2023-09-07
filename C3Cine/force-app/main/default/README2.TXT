Projeto C3Cine
Equipe: 
João Victor Sales Teixeira
Guilherme Santos
Davi Rodrigues


✅ = Feature já adicionada

DevOps: Git e repositório no Github para armazenar os códigos, Prints do Flow e Organograma dos relacionamentos dos objetos da org 

Repositório: https://github.com/L0rdSaiyan/C3Cine/tree/master

Notas: Organizar o layout de página de registro de cada objeto para se adequar com as exigências.
Utilizar durante o projeto: Aura, LWC, Triggers, APEX, Design Pattern SOC (Domain, Controller e Service), Flow, fórmulas e conjunto de valores globais para facilitar no desenvolvimento.
-Criação de um grupo de chatter e usuários com a licença de Chatter Free



REQUISITOS: 

*Objeto Home
Possuir componentes customizados que contém informações sobre o horário de funcionamento do cinema

*Objeto promoções✅
    CAMPOS: [Nome da promoção, Descrição, Dono do Registro, Data de expiração, está ativa?] Obrigatórios: Todos. (A obrigatoriedade pode ser feita tanto no layout da página ou com Trigger)✅
    -O Usuário deve poder Criar/Ler/Editar promoções✅
    -Ao criar uma promoção, deverá ocorrer um post no grupo do Chatter da C3Cine (Ser      feito via Triggered Flow)✅
    |
    |-> Esse post deverá conter a descrição sobre a promoção, nome e data de expiração. ✅


 *Objeto Filmes ✅
    CAMPOS: [Nome do Filme, Está em Cartaz?, a Produtora Renovou o Contrato? e Data de Fim de Exibição]   Obrigatórios: [Nome do Filme e Está em Cartaz] (A obrigatoriedade pode ser feita tanto no layout da página ou com Trigger) ✅

    -O Usuário deve poder Criar/Ler/Editar Filmes ✅
    -Ao criar um novo filme, deverá ocorrer um post no grupo do Chatter da C3Cine (Ser feito via Triggered Flow)✅
    |
    |-> Esse post deverá conter o nome do filme e a data de fim de Exibição ✅
    -Caso o filme esteja fora de cartaz e o usuário editar o campo (a Produtora Renovou o Contrato?) para (Sim), o fim de exibição do filme deverá ser atualizada para a data atual + 30 dias ✅
    |
    |-> Caso a produtora renove o contrato, deverá acontecer um post no chatter sobre isso(SOMENTE QUANDO O REGISTRO FOR ATUALIZADO) ✅

    -Possuir um botão customizado que, ao clicar nele, acontecerá um redirecionamento para uma pesquisa Google baseada no nome do registro (nome do filme) ✅
    -Caso o filme esteja com o status de (Não está em cartaz), ele não poderá ser relacionado com algum registro do objeto Ingressos.


    *Objeto Funcionários ✅

    CAMPOS: [Nome do Funcionário, CPF, E Mail, Cargo, Ingressos Vendidos, Ranks, Quantidade de vezes que foi funcionário do mês] Obrigatórios: [Nome do Funcionário, CPF, Email, Cargo] (A obrigatoriedade pode ser feita tanto no layout da página ou com Trigger)✅


    -O Usuário deve poder Criar/Ler/Editar Funcionários ✅
    -Toda vez que um registro do objeto ingressos relacionados ao funcionário que o vendeu for criado, o campo (Ingressos Vendidos) deverá sofrer um acréscimo de +1 referente ao ingresso vendido. (Trigger ou campo de resumo de totalização) ✅
    -Baseado nesse sistema de acréscimo no campo de ingressos, caso o funcionário atinja determinado número de ingressos vendidos, seu rank irá aumentado e um componente de caminho irá acompanhar o progresso (Trigger) ✅
    |
    |-> Quando o funcionário atingir o rank de "Funcionário do Mês", ele deverá receber um email o parabenizando e uma postagem no Chatter da C3Cine sobre o novo funcionário do mês. ✅
    |
    |-> Sempre quando ele alcançar o rank de "Funcionário do Mês", o campo de "Quantidade de vezes que foi funcionário do mês" deverá ser incrementado com =+1. Assim como o campo de ingressos vendidos. (Trigger)

    *Objeto Salas  ✅

    CAMPOS: [Numeração automática da sala, Tipo da sala (2D,3D), Disponível?, possui acessibilidade?, Qual?=(dependência de campo com possui acessibilidade), Quantidade de assentos disponíveis] Campos Obrigatórios: Todos. (A obrigatoriedade pode ser feita tanto no layout da página ou com Trigger) ✅

    -O Usuário deve poder Criar/Ler/Editar Salas ✅
    Quando um registro de ingressos for criado e relacionado à sala, a quantidade de assentos da sala deve diminuir
    |
    |-> Caso a quantidade de assentos chegue à 0, o campo "Disponível" será atribuído como "Não".


    *Objeto Ingressos
    CAMPOS: [Númeração automática do ingresso,Assento(quando um usuario selecionar um assento,mostrar como indisponivel), Cliente (mestre detalhes com o objeto clientes) filme (relacionamento de pesquisa com o objeto filmes, Funcionario que vendeu o ingresso (relacionamento de pesquisa com o objeto funcionário), Sala (relacionamento de pesquisa com o objeto sala), valor do ingresso]
    -O Usuário deve poder Criar/Ler/Editar Ingressos ✅
    -Caso o cliente seja PCD ou Estudante que tenha apresentado carteirinha, irá ter desconto no valor do ingresso (PCD: 40%, Estudante: 50%)
-Após um período de 30 dias, o ingresso deverá ser excluído. 
    -Enviar um email para o cliente contendo as informações do ingresso 


 *Objeto Clientes ✅
    CAMPOS: [Nome do Cliente, Email, Ingresso (relacionamento de pesquisa com o objeto ingresso), É PCD (PESSOA COM DEFICIÊNCIA)?, É estudante?, apresentou carteirinha? (campo de dependencia com o campo "É estudante?"  
    -O Usuário deve poder Criar/Ler/Editar Clientes ✅


 *+Objeto Salas: 
 Definir campos para a quantidade de assentos
 Definir a quantidade de fileiras



SCHEMA BUILDER
		



obs: 
