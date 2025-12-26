-- Query para CARREGAR DADOS DO IMÓVEL (Preencher tela de edição)
SELECT 
    id_moradia, 
    endereco, 
    valor, 
    descricao, 
    max_inquilino, 
    tipo, 
    telefone_dono,
    nome_dono,        
    id_quem_cadastrou -- Para o Front saber se libera o botão editar
FROM moradia
WHERE id_moradia = ?;