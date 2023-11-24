using System.Collections.Generic;
using System.Data.SqlClient;
using System;

namespace EcommerceCCO2023.Models.Data
{
    public class ClienteData
    {   
        // método create para cadastrar novos clientes
        // no banco de dados
        public bool Create(Cliente cliente)
        {
            bool sucesso = false;

            // criar a string SQL para fazer o cadastro
            // de novos clientes
            string insert = "exec sp_Cadcliente '" +
                cliente.Nome + "', '" +
                cliente.Foto + "', '" +
                cliente.Email + "', '" +
                cliente.Senha + "', " +
                cliente.statusCli;

            try
            {
                // criar um objeto para conectar com o BD
                SqlConnection conexaoBD = Data.ConectarBancoDados();
                // criar um objeto para executar o comando SQL
                SqlCommand cmd = new SqlCommand(insert, conexaoBD);

                if (cmd.ExecuteNonQuery() == 1)
                {
                    Data.fecharConexaoBancoDados();
                    sucesso = true;
                }
            }
            catch (SqlException erro)
            {
                Console.WriteLine("\n\n Erro de cadastro do cliente " + erro);
            }
            return sucesso;
        }

        // método read para consultar todos os clientes 
        public List<Cliente> Read()
        {
            // daclaração da lista
            List<Cliente> lista = null;

            // declarar a string SQL para fazer a consulta
            // dos dados de todos os cliente 
            string select = "select * from Clientes";

            try
            {
                // Conexão com  o BD
                SqlConnection conexaoBD = Data.ConectarBancoDados();
                // Comando que executa o SQL no BD
                SqlCommand cmd = new SqlCommand(select, conexaoBD);
                // Execução do select
                SqlDataReader reader = cmd.ExecuteReader();

                // instancão a lista
                lista = new List<Cliente>();

                while (reader.Read())
                {
                    Cliente clie = new Cliente();
                    clie.IdCliente = (int)reader["idCliente"];
                    clie.Nome = reader["nomeCli"].ToString();
                    clie.Foto = reader["foto"].ToString();
                    clie.Email = reader["email"].ToString();
                    clie.Senha = reader["senha"].ToString();
                    clie.statusCli = (int)reader["status"];
                    lista.Add(clie);
                }
            }
            catch (SqlException erro)
            {
                Console.WriteLine("\n\n\n Erro cliente " + erro + "\n\n\n");
            }

            return lista;
        }



        // método read para consultar o cliente pelo seu id
        public Cliente Read(int id)
        {
            // declarar a string SQL para fazer a consulta
            // dos dados do cliente pelo seu id
            string select = "select * from v_Cliente " +
                "where idcliente = " + id;
            // Conexão com  o BD
            SqlConnection conexaoBD = Data.ConectarBancoDados();
            // Comando que executa o SQL no BD
            SqlCommand cmd = new SqlCommand(select, conexaoBD);
            // Execução do select
            SqlDataReader reader = cmd.ExecuteReader();
            Cliente clie = null;
            if (reader.Read())
            {
                clie = new Cliente();
                clie.IdCliente = (int)reader["idcliente"];
                clie.Nome = reader["nomeCli"].ToString();
                clie.Foto = reader["foto"].ToString();
                clie.Email = reader["email"].ToString();
                clie.Senha = reader["senha"].ToString();
                clie.statusCli = (int)reader["status"];
            }
            return clie;
        }

        // método update para atualizar dados do cliente
        // no banco de dados
        public bool Update(Cliente cliente)
        {
            bool sucesso = false;

            // criar a string SQL para fazer o update
            // de cliente
            string update = "exec sp_UpCliente " +
                cliente.IdCliente + ", '" +
                cliente.Nome + "', '" +
                cliente.Foto + "', '" +
                cliente.Email + "', '" +
                cliente.Senha + "', " +
                cliente.statusCli;
            try
            {
                // criar um objeto para conectar com o BD
                SqlConnection conexaoBD = Data.ConectarBancoDados();
                // criar um objeto para executar o comando SQL
                SqlCommand cmd = new SqlCommand(update, conexaoBD);

                if (cmd.ExecuteNonQuery() == 1)
                {
                    Data.fecharConexaoBancoDados();
                    sucesso = true;
                }
            }
            catch (SqlException erro)
            {
                Console.WriteLine("\n\n Erro de atualização do cliente " + erro);
            }
            return sucesso;
        }

        // método delete para excluir um cliente pelo id
        public bool Delete(int id)
        {
            bool sucesso = false;
            // declarar a string SQL para fazer a consulta
            // dos dados do cliente pelo seu id
            string delete = "delete from clientes " +
                "where idCliente = " + id;
            // Conexão com  o BD
            SqlConnection conexaoBD = Data.ConectarBancoDados();
            // Comando que executa o SQL no BD
            SqlCommand cmd = new SqlCommand(delete, conexaoBD);

            if (cmd.ExecuteNonQuery() == 1)
            {
                Data.fecharConexaoBancoDados();
                sucesso = true;
            }
            return sucesso;
        }
    }
}
