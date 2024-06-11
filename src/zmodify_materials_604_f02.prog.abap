*&---------------------------------------------------------------------*
*& Include          ZMODIFY_MATERIALS_604_F02
*&---------------------------------------------------------------------*
*&---------------------------------------------------------------------*
*& Form f_busca_dados
*&---------------------------------------------------------------------*
*& text
*&---------------------------------------------------------------------*
*& -->  p1        text
*& <--  p2        text
*&---------------------------------------------------------------------*
FORM f_busca_dados .

  LOOP AT t_excel INTO w_excel.

    CALL FUNCTION 'CONVERSION_EXIT_MATN1_INPUT'
      EXPORTING
        input        = w_excel-matnr
      IMPORTING
        output       = w_excel-matnr
      EXCEPTIONS
        length_error = 1
        OTHERS       = 2.

    "Verifica se existe um registro na MARA
    SELECT SINGLE * FROM mara
       INTO w_mara
       WHERE matnr = w_excel-matnr.

    IF w_mara IS NOT INITIAL.
      PERFORM f_monta_bdc.
    ELSE.
      PERFORM f_adiciona_log_erro USING w_excel-matnr 'Não encontrou registro na MARA'.
    ENDIF.

  ENDLOOP.

ENDFORM.
*&---------------------------------------------------------------------*
*& Form f_monta_bdc
*&---------------------------------------------------------------------*
*& text
*&---------------------------------------------------------------------*
*& -->  p1        text
*& <--  p2        text
*&---------------------------------------------------------------------*
FORM f_monta_bdc .

  SELECT SINGLE maktx FROM makt
    INTO w_makt
    WHERE matnr = w_excel-matnr AND spras = sy-langu.

  PERFORM f_insere_linhas USING:
                'X' 'SAPLMGMM' '0060',
                ' ' 'BDC_CURSOR' 'RMMG1-MATNR',
                ' ' 'BDC_OKCODE' '=ENTR',
                ' ' 'RMMG1-MATNR' w_excel-matnr,
                'X' 'SAPLMGMM' '0070',
                ' ' 'BDC_CURSOR' 'MSICHTAUSW-DYTXT(01)',
                ' ' 'BDC_OKCODE' '=ENTR',
                ' ' 'MSICHTAUSW-KZSEL(01)' 'X',
                'X' 'SAPLMGMM' '4004',
                ' ' 'BDC_OKCODE' '=BU',
                ' ' 'MAKT-MAKTX' w_makt,
                ' ' 'BDC_CURSOR' 'MARA-MATKL',
                ' ' 'MARA-MEINS' 'KG',
                ' ' 'MARA-MATKL' w_excel-matkl.

  IF t_bdcdata[] IS NOT INITIAL.
    v_mode = 'N'.

    CALL TRANSACTION 'MM02' USING t_bdcdata MODE v_mode MESSAGES INTO t_message.

    IF sy-subrc <> 0.
      PERFORM f_adiciona_log_erro USING w_excel-matnr 'Erro na Call Transaction'.
    ELSE.
      PERFORM f_adiciona_log_sucesso.
    ENDIF.
  ENDIF.

ENDFORM.
*&---------------------------------------------------------------------*
*& Form f_insere_linhas
*&---------------------------------------------------------------------*
*& text
*&---------------------------------------------------------------------*
*&      --> P_
*&      --> P_
*&      --> P_
*&---------------------------------------------------------------------*
FORM f_insere_linhas  USING   p_cod
                              p_nome
                              p_valor.

  CLEAR t_bdcdata.

  MOVE p_cod TO t_bdcdata-dynbegin.

  IF p_cod = 'X'.
    MOVE:
    p_nome TO t_bdcdata-program,
    p_valor TO t_bdcdata-dynpro.
  ELSE.
    MOVE:
    p_nome TO t_bdcdata-fnam,
    p_valor TO t_bdcdata-fval.
  ENDIF.

  APPEND t_bdcdata.

ENDFORM.
*&---------------------------------------------------------------------*
*& Form f_adiciona_log_sucesso
*&---------------------------------------------------------------------*
*& text
*&---------------------------------------------------------------------*
*& -->  p1        text
*& <--  p2        text
*&---------------------------------------------------------------------*
FORM f_adiciona_log_sucesso .

  DATA s_log TYPE zlog_mat604.

  s_log-matnr   = w_excel-matnr.
  s_log-maktx   = w_makt.
  s_log-data    = sy-datum.
  s_log-usuario = sy-uname.

  INSERT zlog_mat604 FROM s_log.

  CLEAR s_log.

ENDFORM.
*&---------------------------------------------------------------------*
*& Form f_adiciona_log_erro
*&---------------------------------------------------------------------*
*& text
*&---------------------------------------------------------------------*
*&      --> W_EXCEL_MATNR
*&      --> P_
*&---------------------------------------------------------------------*
FORM f_adiciona_log_erro  USING   pv_matnr TYPE matnr
                                  pv_txt   TYPE text200.

   DATA: s_log_erro TYPE ty_log_erro.

  " adiciona registro
  s_log_erro-matnr   = pv_matnr.
  s_log_erro-txt     = pv_txt.

  APPEND s_log_erro TO t_log_erro.

   CLEAR s_log_erro.

ENDFORM.
