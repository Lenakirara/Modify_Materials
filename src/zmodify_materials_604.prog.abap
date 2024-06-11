*&---------------------------------------------------------------------*
*& Report ZMODIFY_MATERIALS_604
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zmodify_materials_604 MESSAGE-ID zcm0001.

INCLUDE zmodify_materials_604_s01.
INCLUDE zmodify_materials_604_f01.
INCLUDE zmodify_materials_604_f02.

INITIALIZATION.
  MOVE 'Relatório' TO sscrfields-functxt_01.

AT SELECTION-SCREEN ON VALUE-REQUEST FOR p_file.
  PERFORM f_seleciona_arquivo.

AT SELECTION-SCREEN.
  IF sy-ucomm = 'FC01'.
    SUBMIT ZMODIFY_MATERIALS_REPORT VIA SELECTION-SCREEN.
  ENDIF.

START-OF-SELECTION.
  PERFORM f_upload_arquivo.

  " Exibir mensagem de sucesso após processar todos os materiais
  IF t_log_erro IS INITIAL.
    MESSAGE i002. "Atualização realizada com sucesso para todos os materiais informados.
  ELSE.
    DATA lo_table TYPE REF TO cl_salv_table.

    TRY.
        CALL METHOD cl_salv_table=>factory
          IMPORTING
            r_salv_table = lo_table
          CHANGING
            t_table      = t_log_erro.

        CALL METHOD lo_table->display.

      CATCH cx_salv_msg.
        MESSAGE i003.
    ENDTRY.
  ENDIF.
