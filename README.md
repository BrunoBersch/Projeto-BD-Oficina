🛠️ Projeto: Banco de Dados Oficina Mecânica
Este projeto tem como objetivo modelar e implementar um banco de dados relacional para uma oficina mecânica, permitindo o gerenciamento eficiente de clientes, veículos, ordens de serviço, peças, serviços realizados e mecânicos envolvidos.

📦 Estrutura do Banco de Dados
O banco é composto pelas seguintes tabelas:

Cliente: Armazena dados pessoais e de contato dos clientes.
Veiculo: Registra informações dos veículos atendidos, vinculados aos clientes.
Servico: Lista os serviços oferecidos pela oficina, com descrição e valor.
Ordem_Servico: Representa cada atendimento realizado, com datas, status e valor total.
OS_Servico: Relaciona os serviços executados em cada ordem de serviço.
Peca: Catálogo de peças disponíveis na oficina.
OS_Peca: Peças utilizadas em cada ordem de serviço.
Mecanico: Dados dos profissionais da oficina, com especialidade e nível de senioridade.
OS_Mecanico: Registra os mecânicos que atuaram em cada ordem de serviço.


🧰 Tecnologias Utilizadas

MySQL: Sistema de gerenciamento de banco de dados relacional.
SQL: Linguagem de definição e manipulação de dados.


📁 Arquivos do Projeto

BDOficina
.sql: Criação das tabelas do banco de dados.
inserts_oficina.sql: Inserções de dados fictícios para testes.
README.md: Documentação do projeto.
