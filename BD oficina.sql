-- drop database oficina;
CREATE DATABASE IF NOT EXISTS oficina;
USE oficina;

-- Tabela Cliente
CREATE TABLE Cliente (
    id_cliente INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(50) NOT NULL,
    sobrenome VARCHAR(50),
    cpf CHAR(11) UNIQUE,
    endereco VARCHAR(255),
    telefone CHAR(11),
    email VARCHAR(100) UNIQUE,
    dt_ultima_visita DATE
);

-- Tabela Veículo
CREATE TABLE Veiculo (
    id_veiculo INT AUTO_INCREMENT PRIMARY KEY,
    placa CHAR(7) UNIQUE not null,
    marca VARCHAR(30) not null,
    modelo VARCHAR(30) not null,
    ano YEAR not null,
    chassi CHAR(17) UNIQUE not null,
    tipo_combustivel ENUM('Gasolina', 'Alcool', 'Flex', 'Eletrico', 'Diesel'),
    numero_portas TINYINT,
    id_cliente INT,
    FOREIGN KEY (id_cliente) REFERENCES Cliente(id_cliente)
);

-- Tabela Serviço
CREATE TABLE Servico (
    id_servico INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(50) not null,
    valor DECIMAL(10,2) not null,
    descricao TEXT
);

-- Tabela Ordem de Serviço
CREATE TABLE Ordem_Servico (
    id_ordem_servico INT AUTO_INCREMENT PRIMARY KEY,
    dt_emissao DATETIME,
    dt_prev_entrega DATETIME,
    dt_conclusao DATETIME,
    status ENUM('Aberta', 'Em_progresso', 'Fechada', 'Cancelada'),
    valor_total DECIMAL(10,2),
    id_veiculo INT NOT NULL,
    FOREIGN KEY (id_veiculo) REFERENCES Veiculo(id_veiculo)
);

-- Tabela OS_Servico (Serviços realizados em uma OS)
CREATE TABLE OS_Servico (
    id_os_servico INT AUTO_INCREMENT PRIMARY KEY,
    id_ordem_servico INT NOT NULL,
    id_servico INT NOT NULL,
    horas_trabalhadas DECIMAL(5,2),
    FOREIGN KEY (id_ordem_servico) REFERENCES Ordem_Servico(id_ordem_servico),
    FOREIGN KEY (id_servico) REFERENCES Servico(id_servico)
);

-- Tabela Peça
CREATE TABLE Peca (
    id_peca INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(50) NOT NULL,
    preco DECIMAL(10,2) not null,
    quantidade INT,
    descricao TEXT
);

-- Tabela OS_Peca (Peças utilizadas em uma OS)
CREATE TABLE OS_Peca (
    id_os_peca INT AUTO_INCREMENT PRIMARY KEY,
    id_peca INT,
    id_ordem_servico INT,
    quantidade_utilizada INT,
    FOREIGN KEY (id_ordem_servico) REFERENCES Ordem_Servico(id_ordem_servico),
    FOREIGN KEY (id_peca) REFERENCES Peca(id_peca)
);

-- Tabela Mecânico
CREATE TABLE Mecanico (
    id_mecanico INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(50) not null,
    especialidade VARCHAR(50),
    data_contratacao DATE
);

-- Tabela OS_Mecanico (Mecânicos que atuaram em uma OS)
CREATE TABLE OS_Mecanico (
    id_os_mecanico INT AUTO_INCREMENT PRIMARY KEY,
    id_mecanico INT NOT NULL,
    id_ordem_servico INT NOT NULL,
    horas_trabalhadas DECIMAL(5,2),
    FOREIGN KEY (id_mecanico) REFERENCES Mecanico(id_mecanico),
    FOREIGN KEY (id_ordem_servico) REFERENCES Ordem_Servico(id_ordem_servico)
);

INSERT INTO Cliente (nome, sobrenome, cpf, endereco, telefone, email, dt_ultima_visita) VALUES
('Sarah', 'Lopes', '62305791461', 'Residencial Maria Liz Vargas Santa Cecilia 91109639 Borges de Leão / PR', '55849277195', 'maria-liz35@example.org', '2025-06-25'),
('Liam', 'Costa', '73649081539', 'Loteamento Larissa Gomes, 3 Alpes 77327-233 Araújo de Rocha / PB', '55519279281', 'ryan69@example.org', '2025-04-17'),
('Valentina', 'Costela', '92608514324', 'Condomínio de Pires, 87 Concórdia 34729-695 da Luz de Cirino / PA', '55319883022', 'riosyuri@example.net', '2023-12-16'),
('Larissa', 'Alves', '49650278338', 'Núcleo Ramos, 704 Vista Do Sol 48244-830 Silveira da Mata / TO', '55319298345', 'fonsecafelipe@example.net', '2025-06-19'),
('Rhavi', 'Garcia', '21865407380', 'Estação Ana Clara Cirino, 802 Jardim Felicidade 47534-233 Cavalcanti / DF', '55849961058', 'peixotoluiz-gustavo@example.net', '2024-05-19'),
('Marcela', 'Nogueira', '41539072860', 'Parque de Sales, 1 Conjunto Califórnia Ii 02065635 Aragão / CE', '55719930463', 'leonardomonteiro@example.net', '2024-03-21'),
('Davi', 'Dias', '20981735630', 'Parque Cavalcanti, 56 Frei Leopoldo 12536-090 Novaes da Serra / GO', '55719440628', 'aylaaraujo@example.net', '2024-01-30'),
('Henrique', 'Oliveira', '79536024152', 'Recanto Silveira, 98 Alto Vera Cruz 85320-820 das Neves Alegre / RR', '55819527898', 'henry-gabriel96@example.org', '2024-06-15'),
('Diego', 'Cunha', '05927641334', 'Núcleo Pinto, 6 Vila Piratininga 84069-717 Pastor / DF', '55819191016', 'maria64@example.org', '2024-10-29'),
('Raul', 'Aparecida', '29310567406', 'Travessa Gabrielly Porto, 598 Alto Dos Pinheiros 47651464 Moreira de Goiás / MA', '55419080090', 'fernanda25@example.net', '2024-05-19');


INSERT INTO Veiculo (placa, marca, modelo, ano, chassi, tipo_combustivel, numero_portas, id_cliente) VALUES
('TOY6373', 'Toyota', 'Corolla', 2023, 'CHS593039XYZ', 'Eletrico', 2, 1),
('HON5819', 'Honda', 'Civic', 2021, 'CHS111520XYZ', 'Alcool', 2, 2),
('FOR6717', 'Ford', 'Fiesta', 2013, 'CHS727142XYZ', 'Alcool', 4, 3),
('CHE6793', 'Chevrolet', 'Onix', 2018, 'CHS119026XYZ', 'Gasolina', 4, 4),
('VOL9822', 'Volkswagen', 'Gol', 2016, 'CHS214056XYZ', 'Diesel', 4, 5),
('HYU4658', 'Hyundai', 'HB20', 2017, 'CHS582232XYZ', 'Eletrico', 2, 6),
('REN1466', 'Renault', 'Sandero', 2023, 'CHS944510XYZ', 'Eletrico', 2, 7),
('FIA5793', 'Fiat', 'Argo', 2014, 'CHS781886XYZ', 'Alcool', 4, 8),
('NIS9749', 'Nissan', 'Versa', 2016, 'CHS202848XYZ', 'Eletrico', 4, 9),
('JEE9260', 'Jeep', 'Renegade', 2014, 'CHS680955XYZ', 'Gasolina', 4, 10);

INSERT INTO Servico (nome, valor, descricao) VALUES
('Troca de óleo', 386.78, 'Serviço de troca de óleo realizado conforme especificações.'),
('Alinhamento e balanceamento', 189.48, 'Serviço de alinhamento e balanceamento realizado conforme especificações.'),
('Revisão de freios', 491.11, 'Serviço de revisão de freios realizado conforme especificações.'),
('Troca de filtro de ar', 308.96, 'Serviço de troca de filtro de ar realizado conforme especificações.'),
('Troca de pastilhas de freio', 362.02, 'Serviço de troca de pastilhas de freio realizado conforme especificações.'),
('Revisão elétrica', 272.91, 'Serviço de revisão elétrica realizado conforme especificações.'),
('Troca de correia dentada', 427.59, 'Serviço de troca de correia dentada realizado conforme especificações.'),
('Diagnóstico eletrônico', 289.18, 'Serviço de diagnóstico eletrônico realizado conforme especificações.'),
('Revisão de suspensão', 381.63, 'Serviço de revisão de suspensão realizado conforme especificações.'),
('Troca de bateria', 308.74, 'Serviço de troca de bateria realizado conforme especificações.');

INSERT INTO Peca (nome, preco, quantidade, descricao) VALUES
('Óleo lubrificante 5W30', 35.16, 10, 'Peça utilizada para óleo lubrificante 5w30'),
('Kit alinhamento', 197.40, 20, 'Peça utilizada para kit alinhamento'),
('Pastilhas de freio dianteiras', 117.34, 14, 'Peça utilizada para pastilhas de freio dianteiras'),
('Filtro de ar', 52.48, 16, 'Peça utilizada para filtro de ar'),
('Disco de freio', 53.18, 16, 'Peça utilizada para disco de freio'),
('Fusível automotivo', 49.44, 13, 'Peça utilizada para fusível automotivo'),
('Correia dentada', 49.98, 2, 'Peça utilizada para correia dentada'),
('Scanner OBD', 143.45, 10, 'Peça utilizada para scanner obd'),
('Amortecedor dianteiro', 160.51, 4, 'Peça utilizada para amortecedor dianteiro'),
('Bateria 60Ah', 77.04, 6, 'Peça utilizada para bateria 60ah');


INSERT INTO Mecanico (nome, especialidade, data_contratacao, senioridade) VALUES
('Joao melo', 'Mecânico de motor', '2021-03-11', 'Senior'),
('Pedro braga', 'Mecânico de freios', '2022-09-16', 'Junior'),
('Jorge', 'Mecânico de suspensão', '2020-02-19', 'Junior'),
('Greisson', 'Mecânico elétrico', '2021-09-10', 'Senior'),
('Felipe', 'Mecânico de transmissão', '2020-06-13', 'Pleno'),
('Lucas', 'Mecânico de diagnóstico', '2020-04-13', 'Pleno'),
('Adilson', 'Mecânico de injeção eletrônica', '2022-04-13', 'Senior'),
('Picachu', 'Mecânico de pneus', '2021-01-17', 'Senior'),
('Joao alberto', 'Mecânico geral', '2023-08-18', 'Pleno'),
('Pedro vargas', 'Mecânico de manutenção preventiva', '2020-06-16', 'Senior');


INSERT INTO Ordem_Servico (dt_emissao, dt_prev_entrega, dt_conclusao, status, valor_total, id_veiculo) VALUES
('2025-09-17 13:29:08.177086', '2025-11-11 09:19:27.508730', '2025-09-17 23:15:47.152056', 'Fechada', 1119.93, 1),
('2024-12-11 02:50:40.499443', '2025-11-15 19:09:52.824435', '2025-02-14 02:00:02.600575', 'Em_progresso', 402.90, 2),
('2025-07-11 17:21:23.369052', '2025-07-18 10:29:14.085627', '2025-07-17 05:06:16.801448', 'Cancelada', 1313.86, 3),
('2025-10-03 05:56:20.278311', '2025-11-05 18:48:34.662489', '2025-10-25 00:52:18.584334', 'Em_progresso', 998.56, 4),
('2025-05-19 18:35:43.294167', '2025-05-27 13:55:43.089336', '2025-05-21 14:04:32.984293', 'Cancelada', 756.89, 5),
('2025-07-04 22:54:06.968459', '2025-10-24 05:41:33.910246', '2025-08-20 09:17:29.688868', 'Em_progresso', 780.33, 6),
('2024-12-07 02:22:20.444202', '2025-01-14 19:00:42.883872', '2024-12-25 10:05:07.883113', 'Em_progresso', 800.51, 7),
('2025-03-01 09:28:03.694991', '2025-03-03 03:15:53.465908', '2025-03-03 01:44:41.701622', 'Aberta', 451.07, 8),
('2025-03-28 17:15:58.262713', '2025-11-02 23:24:02.989975', '2025-08-19 14:16:23.672647', 'Aberta', 866.55, 9),
('2025-06-29 06:39:51.492610', '2025-08-18 16:57:20.570300', '2025-07-21 22:43:44.815162', 'Aberta', 991.41, 10);


INSERT INTO OS_Servico (id_ordem_servico, id_servico, horas_trabalhadas) VALUES
(1, 4, 4.22),
(2, 7, 6.21),
(3, 10, 6.15),
(4, 7, 4.83),
(5, 5, 3.60),
(6, 6, 5.58),
(7, 9, 7.13),
(8, 4, 7.09),
(9, 2, 2.69),
(10, 5, 5.62);


INSERT INTO OS_Peca (id_peca, id_ordem_servico, quantidade_utilizada) VALUES
(7, 1, 4),
(9, 2, 5),
(5, 3, 2),
(7, 4, 3),
(8, 5, 3),
(5, 6, 5),
(3, 7, 3),
(7, 8, 5),
(9, 9, 5),
(9, 10, 2);


INSERT INTO OS_Mecanico (id_mecanico, id_ordem_servico, horas_trabalhadas) VALUES
(1, 1, 6.74),
(2, 5, 2.52),
(3, 6, 5.43),
(4, 1, 5.16),
(5, 6, 3.71),
(6, 5, 4.11),
(7, 10, 6.53),
(8, 3, 7.00),
(9, 4, 7.98),
(10, 2, 4.35);

select * from veiculo;

-- busca pelas peças mais caras que 15 reais
SELECT 
    p.nome, p.preco
FROM
    peca p
WHERE
    p.preco > 15
ORDER BY p.preco DESC;


-- busca por quantos serviços cada mecânico realizou e os ordena por numero de serviços
SELECT m.nome AS Mecanico, COUNT(osm.id_os_mecanico) AS Total_Servicos FROM OS_Mecanico osm
	JOIN Mecanico m ON osm.id_mecanico = m.id_mecanico
GROUP BY m.id_mecanico
ORDER BY Total_Servicos DESC;


-- Busca pelo valor gasto por cada cliente
SELECT c.nome, c.sobrenome, SUM(os.valor_total) AS Total_Gasto FROM Ordem_Servico os
	JOIN Veiculo v ON os.id_veiculo = v.id_veiculo
	JOIN Cliente c ON v.id_cliente = c.id_cliente
GROUP BY c.id_cliente
ORDER BY Total_Gasto DESC;


-- busca pelas peças mais utilizadas
SELECT p.nome AS Peca, SUM(op.quantidade_utilizada) AS Total_Utilizada FROM OS_Peca op
	JOIN Peca p ON op.id_peca = p.id_peca
GROUP BY p.id_peca
ORDER BY Total_Utilizada DESC;


-- busca pelos serviços mais feitos
SELECT s.nome AS Servico, COUNT(oss.id_os_servico) AS Total_Realizado FROM OS_Servico oss
	JOIN Servico s ON oss.id_servico = s.id_servico
GROUP BY s.id_servico
ORDER BY Total_Realizado DESC;


-- busca pelos serviços que tiveram custo menor que 200
SELECT s.nome AS Servico, COUNT(os.id_os_servico) AS Total_Execucoes, SUM(s.valor) AS Custo_Total FROM OS_Servico os
	JOIN Servico s ON os.id_servico = s.id_servico
GROUP BY s.id_servico
HAVING SUM(s.valor) < 200
ORDER BY Custo_Total DESC;


-- busca pelos veiculos que tiveram custo total maior que 1000
SELECT v.placa, v.marca, v.modelo, SUM(os.valor_total) AS Valor_Total_OS FROM Ordem_Servico os
	JOIN Veiculo v ON os.id_veiculo = v.id_veiculo
GROUP BY v.id_veiculo
HAVING SUM(os.valor_total) > 1000
ORDER BY Valor_Total_OS DESC;
