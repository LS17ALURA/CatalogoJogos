# Projeto de Banco de Dados (C07 - 2026/2) - Catálogo de Jogos

## 👥 Integrantes
* Lavínia Sandi
* Vitória Cássia Bernardo Rodrigues

---

## 🎮 O Tema
Escolhemos criar um sistema de **Catálogo de Jogos**. A ideia é conseguir gerenciar os jogos, quem desenvolveu, as plataformas em que eles rodam, os usuários cadastrados e as avaliações que a galera deixa.

## 🗂️ Como o modelo foi organizado (Layers)
Para o diagrama não ficar confuso, separamos o banco em 4 partes principais (*layers* no MySQL Workbench):

1. **Perfis e Comunidade:** guarda os dados das pessoas (`Pessoa`). Usamos herança para separar em `JogadorComum` e `CriadorConteudo`, além de colocar um relacionamento recursivo (onde uma pessoa pode ser mentora de outra);
2. **Catálogo de Jogos:** fica com os dados centrais do jogo (`Jogo`). Como um jogo roda em várias plataformas e uma plataforma tem vários jogos, a gente usou uma tabela intermediária (`Jogo_Plataforma`) para fazer essa ligação (relação N:M);
3. **Indústria e Produção:** foca nos estúdios que criam os jogos (`Estudio`);
4. **Avaliações:** armazena as notas, comentários e se o usuário recomenda ou não o jogo (`Avaliacao`).

---

## 📁 Arquivos
* `Catalogo_Jogos_BD.mwb`: arquivo com a modelagem completa feita no MySQL Workbench.
