CREATE OR REPLACE PROCEDURE pr_atualizar_imovel(
    p_id_moradia INT,
    p_id_usuario_logado INT,
    p_novo_endereco VARCHAR,
    p_novo_valor NUMERIC,
    p_nova_descricao TEXT,
    p_novo_max_inquilinos INT,
    p_novo_telefone CHAR(11),
    p_novo_nome_dono VARCHAR 
)
LANGUAGE plpgsql
AS $$
DECLARE
    v_id_criador_anuncio INT;
BEGIN
    -- 1. Descobre qual usuário criou esse anúncio no sistema
    SELECT id_quem_cadastrou INTO v_id_criador_anuncio
    FROM moradia
    WHERE id_moradia = p_id_moradia;

    -- Se o imóvel não existe
    IF NOT FOUND THEN
        RAISE EXCEPTION 'Imóvel % não encontrado.', p_id_moradia;
    END IF;

    -- 2. Segurança: A conta logada (p_id_usuario_logado) é a mesma que criou o anúncio?
    -- Se X criou, só X pode editar.
    IF v_id_criador_anuncio != p_id_usuario_logado THEN
        RAISE EXCEPTION 'Acesso negado: Apenas o usuário que cadastrou este imóvel pode editá-lo.';
    END IF;

    -- 3. Executa a atualização
    UPDATE moradia
    SET 
        endereco = p_novo_endereco,
        valor = p_novo_valor,
        descricao = p_nova_descricao,
        max_inquilino = p_novo_max_inquilinos,
        telefone_dono = p_novo_telefone,
        nome_dono = p_novo_nome_dono     -- Atualiza o nome do dono, se precisar
    WHERE id_moradia = p_id_moradia;
    
    RAISE NOTICE 'Imóvel atualizado com sucesso.';
END;
$$;