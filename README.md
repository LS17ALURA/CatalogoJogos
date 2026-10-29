# Projeto de Banco de Dados (C07 - 2026/2) - Catálogo de Jogos

## 👥 Integrantes
* Lavinia Sandi
* Vitória Cássia Bernardo Rodrigues

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

## 📁 Arquivos
* `Catalogo_Jogos_BD.mwb`: arquivo com a modelagem completa feita no MySQL Workbench.

* ---
## ⚙️ Implementação e Manipulação de Dados (DML)
O banco foi populado com no mínimo 5 registros em cada tabela, garantindo o volume necessário para testes de consultas. Foram aplicados comandos extras para demonstrar a manutenção do catálogo:
* **UPDATE:** Utilizado para atualizar o preço de um jogo específico (Baldurs Gate 3), simulando a aplicação de uma promoção temporária na plataforma.
* **DELETE:** Utilizado para remover uma plataforma inserida de forma equivocada (Plataforma Teste), garantindo a integridade dos dados e evitando o acúmulo de registros sem vínculo.

## 🔐 Segurança e Acesso
Para a gestão do banco, implementamos controle de acesso baseado em funções (RBAC):
* Criamos a ROLE `admin_jogos`, que possui permissões totais de manipulação (SELECT, INSERT, UPDATE, DELETE) em todo o banco `Catalogo_Jogos`.
* Foram criados os usuários `dev_vitoria` e `dev_lavinia`, ambos vinculados a esta ROLE como perfil padrão, garantindo que as duas desenvolvedoras tenham acesso seguro aos dados.

## 🧠 Consultas e Objetos de Banco (Lógica)
Para atender às necessidades de relatórios e automações do catálogo, desenvolvemos:
* **Consultas (JOINs):** [Lavínia: Explicar brevemente o que os JOINs de 1:1, 1:N e N:M estão buscando. Ex: "Busca os jogos e suas plataformas", etc.]
* **View:** [Lavínia: Colocar o nome da View e justificar. Ex: "Criada para facilitar a visualização do catálogo completo com o nome dos estúdios."]
* **Function:** [Lavínia: Colocar o nome e justificar. Ex: "Criada para calcular a média de notas de um jogo."]
* **Procedure:** [Lavínia: Colocar o nome e justificar.]
* **Trigger:** [Lavínia: Colocar o nome e justificar. Ex: "Dispara automaticamente um registro de log sempre que o preço de um jogo é alterado."]

---

## 📁 Arquivos do Projeto
- `Catalogo_Jogos_BD.mwb`: Arquivo com a modelagem completa (Diagrama ER) feita no MySQL Workbench.
- `Script_Estrutura_e_Dados.sql`: Script DDL para criação das tabelas e DML para inserção de dados e segurança (Parte 1).
- `Script_Consultas_Objetos.sql`: Script com as buscas complexas, Views, Triggers, Functions e Procedures (Parte 2).
