package dao;

import dto.Moradia;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;

public class MoradiaDAO {

    public void cadastrar(Moradia m) {
        String sql = "INSERT INTO moradia (endereco, tot_inquilino, max_inquilino, tipo, " +
                "nome_dono, telefone_dono, tempo_aluguel, valor, descricao, id_quem_cadastrou) " +
                "VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";

        Connection conn = null;
        PreparedStatement ps = null;

        try {
            conn = Conexao.getConexao();
            ps = conn.prepareStatement(sql);

            // Preenchendo o SQL com os dados do DTO
            ps.setString(1, m.getEndereco());
            ps.setInt(2, m.getTotInquilino());
            ps.setInt(3, m.getMaxInquilino());
            ps.setString(4, m.getTipo());
            ps.setString(5, m.getNomeDono());
            ps.setString(6, m.getTelefoneDono());
            ps.setInt(7, m.getTempoAluguel());
            ps.setDouble(8, m.getValor());
            ps.setString(9, m.getDescricao());
            ps.setInt(10, m.getIdQuemCadastrou()); // <--- (Precisa vir da Sessão)

            ps.execute();
            System.out.println("Moradia cadastrada com sucesso!");

        } catch (SQLException e) {
            e.printStackTrace();
            throw new RuntimeException("Erro ao cadastrar moradia: " + e.getMessage());
        } finally {
            try { if (ps != null) ps.close(); } catch (Exception e) {}
            try { if (conn != null) conn.close(); } catch (Exception e) {}
        }
    }
}