# Projeto de Banco de Dados - C07: Catálogo de Jogos

Trabalho prático da disciplina de Banco de Dados (2026/2) voltado para a modelagem conceitual/lógica de um sistema de catálogo e avaliação de jogos.

## 👥 Equipe
* Lavínia Sandi
* Vitória Cássia Bernardo Rodrigues

---

## 🎮 Sobre o Tema e o Modelo

O sistema foi desenvolvido para gerenciar um **Catálogo de Jogos**, abrangendo informações sobre os títulos, estúdios desenvolvedores, plataformas suportadas, perfis de usuários e o sistema de avaliações.

O diagrama foi estruturado e organizado utilizando **Layers (Camadas)** no MySQL Workbench para melhor visualização e separação lógica dos contextos:

1. **Perfis e Comunidade:** Gerencia os dados dos usuários (`Pessoa`), contemplando herança/especialização para tipos específicos de perfis (`JogadorComum` e `CriadorConteudo`), além de um relacionamento recursivo (auto-relacionamento de mentoria na própria tabela de pessoas).
2. **Catálogo de Jogos:** Concentra as informações centrais dos jogos (`Jogo`) e faz a ligação com as plataformas através de uma tabela intermediária (`Jogo_Plataforma`) para atender à relação N:M.
3. **Indústria e Produção:** Contém os dados referentes aos desenvolvedores e estúdios (`Estudio`) responsáveis pelos títulos.
4. **Avaliações:** Gerencia as notas, comentários e recomendações deixadas pelos usuários em relação aos jogos cadastrados (`Avaliacao`).

---

## 📁 Estrutura de Arquivos
* `Catalogo_Jogos_BD.mwb`: Arquivo contendo o modelo de banco de dados completo desenvolvido no MySQL Workbench.
