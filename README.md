# Projeto de Banco de Dados (C07 - 2026/2) - Catálogo de Jogos

## 👥 Integrantes
- Lavinia Sandi
- Vitória Cássia Bernardo Rodrigues

---

## 🎮 O Tema
Escolhemos criar um sistema de **Catálogo de Jogos**. A ideia é conseguir gerenciar os jogos, quem desenvolveu, as plataformas em que eles rodam, os usuários cadastrados e as avaliações que os usuários deixam.

## 🗂️ Como o modelo foi organizado (Layers)
Para o diagrama não ficar confuso, separamos o banco em 4 partes principais (*layers* no MySQL Workbench):

1. **Perfis e Comunidade:** guarda os dados das pessoas (`Pessoa`). Usamos herança para separar em `JogadorComum` e `CriadorConteudo`, além de colocar um relacionamento recursivo (onde uma pessoa pode ser mentora de outra);
2. **Catálogo de Jogos:** fica com os dados centrais do jogo (`Jogo`). Como um jogo roda em várias plataformas e uma plataforma tem vários jogos, a gente usou uma tabela intermediária (`Jogo_Plataforma`) para fazer essa ligação (relação N:M);
3. **Indústria e Produção:** foca nos estúdios que criam os jogos (`Estudio`);
4. **Avaliações:** armazena as notas, comentários e se o usuário recomenda ou não o jogo (`Avaliacao`).

---

## ⚙️ Implementação e Manipulação de Dados (DML)
O banco foi populado com no mínimo 5 registros em cada tabela, garantindo o volume necessário para testes de consultas. Foram aplicados comandos extras para demonstrar a manutenção do catálogo:
- **UPDATE:** Utilizado para atualizar o preço de um jogo específico (Baldurs Gate 3), simulando a aplicação de uma promoção temporária na plataforma.
- **DELETE:** Utilizado para remover uma plataforma inserida de forma equivocada (Plataforma Teste), garantindo a integridade dos dados e evitando o acúmulo de registros sem vínculo.

## 🔐 Segurança e Acesso
Para a gestão do banco, implementamos controle de acesso baseado em funções (RBAC):
- Criamos a ROLE `admin_jogos`, que possui permissões totais de manipulação (SELECT, INSERT, UPDATE, DELETE) em todo o banco `Catalogo_Jogos`.
- Foram criados os usuários `dev_vitoria` e `dev_lavinia`, ambos vinculados a esta ROLE como perfil padrão, garantindo que as duas desenvolvedoras tenham acesso seguro aos dados.

#### 🧠 Consultas e Objetos do Banco
- **Consultas (JOINs):**
  - **1:1 (Herança):** Junção entre `Pessoa` e `JogadorComum`.
  - **1:N:** Busca dos jogos cadastrados de cada `Estudio`.
  - **N:M:** Associação entre `Jogo` e `Plataforma` via `Jogo_Plataforma`.
- **View (`vw_catalogo_completo`):** Exibe dados do jogo, estúdio e média de notas.
- **Function (`fn_media_avaliacao_jogo`):** Retorna a média de avaliações de um jogo por ID.
- **Procedure (`sp_cadastrar_avaliacao`):** Insere avaliações validando notas entre 0 e 10.
- **Trigger (`trg_log_alteracao_preco`):** Registra o histórico de alterações de preço dos jogos.

---

## 📁 Arquivos do Projeto
- `Catalogo_Jogos_BD.mwb`: Arquivo com a modelagem completa (Diagrama ER) feita no MySQL Workbench.
- `catalogo.sql`: Script SQL completo contendo a DDL (criação das tabelas), DML (população e manutenção de dados), DCL (segurança, roles e usuários), consultas com JOINs e a implementação dos objetos (View, Function, Procedure e Trigger).
