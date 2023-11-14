-------------------------------------------------------------
-- Preaparando o SQL para criar o Banco de Dados do Projeto
-------------------------------------------------------------
use master
go

-------------------------------------------------------------
-- DESTUIR O BANCO DE DADOS, CASO ELE EXITA
-------------------------------------------------------------
drop database Lanches_LP_CCO2023
go

-------------------------------------------------------------
-- CRIAR O BANCO DE DADOS
-------------------------------------------------------------
create database Lanches_LP_CCO2023
go

-------------------------------------------------------------
-- ACESSAR O BANCO DE DADOS
-------------------------------------------------------------
use Lanches_LP_CCO2023
go

-------------------------------------------------------------
-- CRIAR AS TABELAS DO BANCO DE DADOS
-------------------------------------------------------------

-------------------------------------------------------------
-- TABELA CATEGORIAS
-------------------------------------------------------------
create table Categorias
(
	idCategoria		int			not null	primary key		identity,
	categoria		varchar(30)	not null
)
go

-------------------------------------------------------------
-- Cadastrando dados na TABELA CATEGORIAS
-------------------------------------------------------------
insert into Categorias (categoria)
values	('Lanche Normal'),
		('Lanche Gourmet'),
		('Lanche Natural'),
		('Lanche Vegano')
go

-------------------------------------------------------------
-- TABELA PRODUTOS
-------------------------------------------------------------
create table Produtos
(
	idProduto	int				not null	primary key		identity,
	nome		varchar(20)		not null,
	descricao	varchar(100)	not null,
	qtdProd		int				not null	check(qtdProd >= 0),
	valor		decimal(10,2)		null	check(valor > 0.0),
	urlImg		varchar(150)		null,
	status		int					null,
	categoriaId		int				not null	default 1,
	foreign key	(categoriaId)	references	Categorias(idCategoria)
)
go

-------------------------------------------------------------
-- Procedure para cadastrar os Produtos na TABELA PRODUTOS 
-------------------------------------------------------------
create procedure sp_CadProduto
(
	@nomeProd	varchar(20),		@descProd	varchar(100),
	@qtdProd	int,				@precoProd	decimal(6,2),
	@imgProd	varchar(150),		@stsProd	int,
	@catIdProd	int
)
as
begin
	insert into Produtos (nome, descricao, qtdProd, valor, urlImg, status, categoriaId)
	values(@nomeProd, @descProd, @qtdProd, (@precoProd/100), @imgProd, @stsProd, @catIdProd)
end 
go

-------------------------------------------------------------
-- Cadastrando três lanches
-------------------------------------------------------------

exec sp_CadProduto 'X-Tudo', 'Pão, Hamburger, presunto, muçarela, alface, tomate, ovo, bacon', 100, 2590, 'XTudo.png', 1, 1
go

exec sp_CadProduto 'X-Salada', 'Pão, Hamburger, presunto, muçarela, alface, tomate', 100, 2090, 'XSalada.png', 1, 1
go

exec sp_CadProduto 'Misto quente', 'Pão, presunto, muçarela, oregano, tomate', 100, 1590, 'MistoQuente03.png', 1, 1
go

-------------------------------------------------------------
-- View para consultar todos os Produtos na TABELA PRODUTOS 
-------------------------------------------------------------
create view v_Produto
as
	select P.idProduto, P.nome NomeProd, P.descricao Descricao, 
	P.qtdProd QtdProd, P.valor Valor, P.urlImg UrlImg, P.status Status,
	P.categoriaId IdCategoria, C.categoria Categoria
	from Categorias C, Produtos P
	where P.categoriaId = C.idCategoria
go

select * from v_Produto
go

-------------------------------------------------------------
-- Procedure para alteraros dados de um Produtos na 
-- TABELA PRODUTOS 
-------------------------------------------------------------
create procedure sp_UpProduto
(
	@idProd	int,				@nomeProd	varchar(20),	
	@descProd	varchar(100),	@qtdProd	int,			
	@precoProd	decimal(6,2),	@imgProd	varchar(150),	
	@stsProd	int,			@catIdProd	int
)
as
begin
	update Produtos set nome = @nomeProd, descricao = @descProd, 
						qtdProd = @qtdProd, valor = (@precoProd/100), 
						urlImg = @imgProd, status = @stsProd, 
						categoriaId = @catIdProd
	where idProduto = @idProd
end 
go

-------------------------------------------------------------
-- TABELA CLIENTES
-------------------------------------------------------------
create table Clientes
(
	idCliente	int				not null	primary key		identity,
	nomeCli		varchar(50)		not null,
	foto		varchar(50)			null,
	email		varchar(100)	not null	unique,
	senha		varchar(20)		not null,
	status		int					null
)
go

-------------------------------------------------------------
-- Procedure para cadastrar os Clientes na TABELA CLIENTES 
-------------------------------------------------------------
create procedure sp_CadCliente
(
	@nomeCli	varchar(50),		@fotoCli	varchar(50),
	@emailCli	varchar(100),		@senhaCli	varchar(20),
	@sts		int
)
as
begin
	insert into Clientes (nomeCli, foto, email, senha, status)
	values(@nomeCli, @fotoCli, @emailCli, @senhaCli, @sts)
end
go

-------------------------------------------------------------
-- Cadastrando três clientes
-------------------------------------------------------------
exec sp_CadCliente 'Valeria Maria Volpe', 'valeria.png', 'vmvolpe@unirp.edu.br', 'Vmv123456', 1
exec sp_CadCliente 'Luciana Pavani', 'luciana.png', 'lppbueno@unirp.edu.br', 'LPPB123456', 1
exec sp_CadCliente 'Jose Aparecido de Aguiar Viana', 'viana.png', 'viana@unirp.edu.br', 'Viana123456', 1
go

-------------------------------------------------------------
-- Procedure para alteraros dados de um Cliente na 
-- TABELA CLIENTES 
-------------------------------------------------------------
create procedure sp_UpCliente
(
	@idCli		int,			@nomeCli	varchar(50),	
	@fotoCli	varchar(50),	@emailCli	varchar(100),	
	@senhaCli	varchar(20),	@sts		int
)
as
begin
	update Clientes set nomeCli = @nomeCli, foto = @fotoCli,
						email = @emailCli, senha = @senhaCli,
						status = @sts
	where idCliente = @idCli
end 
go

-------------------------------------------------------------
-- View para consultar todos os Clientes na TABELA CLIENTES
-------------------------------------------------------------
create view v_Cliente
as
	select C.idCliente, C.nomeCli, C.foto, C.email, C.senha, C.status
	from Clientes C
go

select * from v_Cliente
go