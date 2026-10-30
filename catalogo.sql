DROP DATABASE IF EXISTS Catalogo_Jogos;
CREATE DATABASE Catalogo_Jogos;
USE Catalogo_Jogos;

-- 1. CRIAÇÃO DAS TABELAS (DDL)

CREATE TABLE Estudio (
    idEstudio INT AUTO_INCREMENT PRIMARY KEY,
    nomeEstudio VARCHAR(45) NOT NULL,
    paisOrigem VARCHAR(30),
    qntFuncionarios INT
);

CREATE TABLE Plataforma (
    idPlataforma INT AUTO_INCREMENT PRIMARY KEY,
    nomePlataforma VARCHAR(30) NOT NULL,
    fabricante VARCHAR(30)
);

CREATE TABLE Jogo (
    idJogo INT AUTO_INCREMENT PRIMARY KEY,
    titulo VARCHAR(45) NOT NULL,
    anoLancamento INT,
    preco DECIMAL(10,2),
    classificacaoEtaria VARCHAR(10),
    Estudio_idEstudio INT,
    FOREIGN KEY (Estudio_idEstudio) REFERENCES Estudio(idEstudio)
);

CREATE TABLE Jogo_Plataforma (
    dataDisponibilizacao DATE,
    requisitoMinimo TEXT,
    Jogo_idJogo INT,
    Plataforma_idPlataforma INT,
    PRIMARY KEY (Jogo_idJogo, Plataforma_idPlataforma),
    FOREIGN KEY (Jogo_idJogo) REFERENCES Jogo(idJogo),
    FOREIGN KEY (Plataforma_idPlataforma) REFERENCES Plataforma(idPlataforma)
);

CREATE TABLE Pessoa (
    idPessoa INT AUTO_INCREMENT PRIMARY KEY,
    nickname VARCHAR(45) NOT NULL,
    email VARCHAR(45) NOT NULL,
    dataNascimento DATE,
    idPessoa_Mentor INT,
    FOREIGN KEY (idPessoa_Mentor) REFERENCES Pessoa(idPessoa)
);

-- Herança: Jogador Comum
CREATE TABLE JogadorComum (
    horasJogadasTotais INT DEFAULT 0,
    Pessoa_idPessoa INT PRIMARY KEY,
    FOREIGN KEY (Pessoa_idPessoa) REFERENCES Pessoa(idPessoa) ON DELETE CASCADE
);

-- Herança: Criador de Conteúdo
CREATE TABLE CriadorConteudo (
    canalTwitchYouTube VARCHAR(100),
    seloAnalista TINYINT(1) DEFAULT 0,
    Pessoa_idPessoa INT PRIMARY KEY,
    FOREIGN KEY (Pessoa_idPessoa) REFERENCES Pessoa(idPessoa) ON DELETE CASCADE
);

CREATE TABLE Avaliacao (
    idAvaliacao INT AUTO_INCREMENT PRIMARY KEY,
    nota INT NOT NULL,
    comentario TEXT,
    recomendado TINYINT(1) DEFAULT 1,
    dataAvaliacao DATE,
    Pessoa_idPessoa INT,
    Jogo_idJogo INT,
    FOREIGN KEY (Pessoa_idPessoa) REFERENCES Pessoa(idPessoa),
    FOREIGN KEY (Jogo_idJogo) REFERENCES Jogo(idJogo)
);

-- Tabela de Log para o Trigger (Parte 2)
CREATE TABLE Log_Preco_Jogo (
    id_log INT AUTO_INCREMENT PRIMARY KEY,
    idJogo INT NOT NULL,
    preco_antigo DECIMAL(10,2),
    preco_novo DECIMAL(10,2),
    data_alteracao DATETIME DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (idJogo) REFERENCES Jogo(idJogo)
);

-- 2. CARGA DE DADOS (DML)

INSERT INTO Estudio (nomeEstudio, paisOrigem, qntFuncionarios) VALUES 
('Nintendo EPD', 'Japão', 800),
('Santa Monica Studio', 'EUA', 250),
('Larian Studios', 'Bélgica', 400),
('CD Projekt Red', 'Polônia', 1200),
('ConcernedApe', 'EUA', 1);

INSERT INTO Plataforma (nomePlataforma, fabricante) VALUES 
('PlayStation 5', 'Sony'),
('Nintendo Switch', 'Nintendo'),
('PC', 'Microsoft'),
('Xbox Series X', 'Microsoft'),
('PlayStation 4', 'Sony');

INSERT INTO Jogo (titulo, anoLancamento, preco, classificacaoEtaria, Estudio_idEstudio) VALUES 
('Zelda: Tears of the Kingdom', 2023, 350.00, 'Livre', 1),
('God of War Ragnarök', 2022, 299.90, '18+', 2),
('Baldurs Gate 3', 2023, 199.99, '18+', 3),
('The Witcher 3', 2015, 79.99, '18+', 4),
('Stardew Valley', 2016, 24.99, 'Livre', 5);

INSERT INTO Jogo_Plataforma (dataDisponibilizacao, requisitoMinimo, Jogo_idJogo, Plataforma_idPlataforma) VALUES 
('2023-05-12', 'N/A', 1, 2),
('2022-11-09', 'N/A', 2, 1),
('2023-08-03', '8GB RAM, GTX 970', 3, 3),
('2015-05-19', '6GB RAM, GTX 660', 4, 3),
('2016-02-26', '2GB RAM, Gráficos Integrados', 5, 3);

INSERT INTO Pessoa (nickname, email, dataNascimento, idPessoa_Mentor) VALUES 
('Fallen', 'fallen@email.com', '1991-05-30', NULL),
('Alanzoka', 'alan@email.com', '1990-05-13', 1),
('GamerBR', 'gamer@email.com', '2005-02-24', 1),
('NoobMaster', 'noob@email.com', '2010-01-01', NULL),
('ProPlayer', 'pro@email.com', '2000-10-10', NULL),
('BiaGamer', 'bia@email.com', '1998-03-12', 2),
('CarolPlay', 'carol@email.com', '2001-07-25', NULL),
('Zigueira', 'zig@email.com', '1988-10-02', NULL),
('Yoda', 'yoda@email.com', '1995-09-18', 8),
('JovemNerd', 'jn@email.com', '1979-12-28', NULL);

INSERT INTO CriadorConteudo (canalTwitchYouTube, seloAnalista, Pessoa_idPessoa) VALUES 
('twitch.tv/gaules', 1, 1),
('youtube.com/alanzoka', 0, 2),
('youtube.com/carolplay', 1, 7),
('twitch.tv/zigueira', 1, 8),
('twitch.tv/yoda', 0, 9);

INSERT INTO JogadorComum (horasJogadasTotais, Pessoa_idPessoa) VALUES 
(450, 3),
(12, 4),
(3000, 5),
(150, 6),
(800, 10);

INSERT INTO Avaliacao (nota, comentario, recomendado, dataAvaliacao, Pessoa_idPessoa, Jogo_idJogo) VALUES 
(10, 'Obra prima!', 1, '2023-08-15', 3, 3),
(9, 'Muito bom, mas pesado.', 1, '2023-09-10', 1, 3),
(10, 'Relaxante.', 1, '2021-01-05', 4, 5),
(8, 'História incrível.', 1, '2022-12-01', 2, 2),
(5, 'Não faz meu estilo.', 0, '2023-06-20', 5, 1);

-- Comandos DML extras (Simulação de manutenção)
SET SQL_SAFE_UPDATES = 0;
UPDATE Jogo SET preco = 149.90 WHERE titulo = 'Baldurs Gate 3';
INSERT INTO Plataforma (nomePlataforma, fabricante) VALUES ('Plataforma Teste', 'Teste');
DELETE FROM Plataforma WHERE nomePlataforma = 'Plataforma Teste';
SET SQL_SAFE_UPDATES = 1;

-- 3. SEGURANÇA E ROLES (DCL)

DROP ROLE IF EXISTS 'admin_jogos';
DROP USER IF EXISTS 'dev_vitoria'@'localhost', 'dev_lavinia'@'localhost';

CREATE ROLE 'admin_jogos';
GRANT SELECT, INSERT, UPDATE, DELETE ON Catalogo_Jogos.* TO 'admin_jogos';

CREATE USER 'dev_vitoria'@'localhost' IDENTIFIED BY 'senha123';
CREATE USER 'dev_lavinia'@'localhost' IDENTIFIED BY 'senha456';

GRANT 'admin_jogos' TO 'dev_vitoria'@'localhost', 'dev_lavinia'@'localhost';
SET DEFAULT ROLE 'admin_jogos' TO 'dev_vitoria'@'localhost', 'dev_lavinia'@'localhost';

-- 4. CONSULTAS COM JOINS (PARTE 2)

-- JOIN 1:1 (Herança: Pessoa -> JogadorComum)
SELECT p.idPessoa, p.nickname, p.email, j.horasJogadasTotais 
FROM Pessoa p
INNER JOIN JogadorComum j ON p.idPessoa = j.Pessoa_idPessoa;

-- JOIN 1:N (Estudio -> Jogo)
SELECT e.nomeEstudio AS estudio, e.paisOrigem, j.titulo AS jogo, j.preco 
FROM Estudio e
INNER JOIN Jogo j ON e.idEstudio = j.Estudio_idEstudio
ORDER BY e.nomeEstudio;

-- JOIN N:M (Jogo <-> Plataforma)
SELECT j.titulo AS jogo, p.nomePlataforma AS plataforma, p.fabricante 
FROM Jogo j
INNER JOIN Jogo_Plataforma jp ON j.idJogo = jp.Jogo_idJogo
INNER JOIN Plataforma p ON jp.Plataforma_idPlataforma = p.idPlataforma
ORDER BY j.titulo;

-- 5. OBJETOS DO BANCO DE DADOS (PARTE 2)

-- VIEW: Catálogo Completo com Média de Notas
CREATE OR REPLACE VIEW vw_catalogo_completo AS
SELECT 
    j.idJogo,
    j.titulo,
    j.preco,
    e.nomeEstudio AS estudio,
    e.paisOrigem,
    COALESCE(ROUND(AVG(a.nota), 1), 0) AS media_nota,
    COUNT(a.idAvaliacao) AS total_avaliacoes
FROM Jogo j
INNER JOIN Estudio e ON j.Estudio_idEstudio = e.idEstudio
LEFT JOIN Avaliacao a ON j.idJogo = a.Jogo_idJogo
GROUP BY j.idJogo, j.titulo, j.preco, e.nomeEstudio, e.paisOrigem;

-- FUNCTION: Média de Notas de um Jogo por ID
DELIMITER //
CREATE FUNCTION fn_media_avaliacao_jogo(p_idJogo INT)
RETURNS DECIMAL(3,1)
DETERMINISTIC
READS SQL DATA
BEGIN
    DECLARE v_media DECIMAL(3,1);
    SELECT AVG(nota) INTO v_media FROM Avaliacao WHERE Jogo_idJogo = p_idJogo;
    RETURN COALESCE(v_media, 0.0);
END //
DELIMITER ;

-- PROCEDURE: Cadastro Validados de Avaliações (Nota entre 0 e 10)
DELIMITER //
CREATE PROCEDURE sp_cadastrar_avaliacao(
    IN p_idPessoa INT,
    IN p_idJogo INT,
    IN p_nota INT,
    IN p_comentario TEXT,
    IN p_recomendado TINYINT(1)
)
BEGIN
    IF p_nota < 0 OR p_nota > 10 THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Erro: A nota deve estar entre 0 e 10.';
    ELSE
        INSERT INTO Avaliacao (nota, comentario, recomendado, dataAvaliacao, Pessoa_idPessoa, Jogo_idJogo)
        VALUES (p_nota, p_comentario, p_recomendado, CURDATE(), p_idPessoa, p_idJogo);
    END IF;
END //
DELIMITER ;

-- TRIGGER: Log Automático de Alteração de Preço
DELIMITER //
CREATE TRIGGER trg_log_alteracao_preco
AFTER UPDATE ON Jogo
FOR EACH ROW
BEGIN
    IF OLD.preco <> NEW.preco THEN
        INSERT INTO Log_Preco_Jogo (idJogo, preco_antigo, preco_novo)
        VALUES (NEW.idJogo, OLD.preco, NEW.preco);
    END IF;
END //
DELIMITER ;

USE Catalogo_Jogos;

-- 1. TESTE DAS CONSULTAS COM JOINS
-- A) Relacionamento 1:1 (Herança: Pessoa e JogadorComum)
SELECT p.idPessoa, p.nickname, p.email, j.horasJogadasTotais
FROM Pessoa p
INNER JOIN JogadorComum j ON p.idPessoa = j.Pessoa_idPessoa;

-- B) Relacionamento 1:N (Estúdio e Jogos)
SELECT e.nomeEstudio AS estudio, e.paisOrigem, j.titulo AS jogo, j.preco
FROM Estudio e
INNER JOIN Jogo j ON e.idEstudio = j.Estudio_idEstudio
ORDER BY e.nomeEstudio;

-- C) Relacionamento N:M (Jogo e Plataforma via Jogo_Plataforma)
SELECT j.titulo AS jogo, p.nomePlataforma AS plataforma, p.fabricante
FROM Jogo j
INNER JOIN Jogo_Plataforma jp ON j.idJogo = jp.Jogo_idJogo
INNER JOIN Plataforma p ON jp.Plataforma_idPlataforma = p.idPlataforma
ORDER BY j.titulo;

-- 2. TESTE DA VIEW (vw_catalogo_completo)
SELECT * FROM vw_catalogo_completo;

-- 3. TESTE DA FUNCTION (fn_media_avaliacao_jogo)
SELECT fn_media_avaliacao_jogo(1) AS media_nota_jogo_1;

-- 4. TESTE DA PROCEDURE (sp_cadastrar_avaliacao)
-- A) Inserção válida (Nota entre 0 e 10)
CALL sp_cadastrar_avaliacao(1, 1, 9, 'Jogo excelente!', 1);

-- B) Verificação da nova inserção
SELECT * FROM Avaliacao WHERE Pessoa_idPessoa = 1 AND Jogo_idJogo = 1;

-- C) Teste de validação de erro (Descomente a linha abaixo para testar a rejeição de nota > 10)
-- CALL sp_cadastrar_avaliacao(1, 1, 15, 'Nota inválida de teste', 1);

-- 5. TESTE DA TRIGGER (trg_log_alteracao_preco)
-- A) Atualiza o preço do jogo 1 para disparar a Trigger
UPDATE Jogo SET preco = 199.90 WHERE idJogo = 1;

-- B) Consulta a tabela de auditoria para verificar a gravação automática do histórico
SELECT * FROM Log_Preco_Jogo;
