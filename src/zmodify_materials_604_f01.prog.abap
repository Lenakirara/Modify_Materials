*&---------------------------------------------------------------------*
*& Include          ZMODIFY_MATERIALS_604_F01
*&---------------------------------------------------------------------*
*&---------------------------------------------------------------------*
*& Form f_seleciona_arquivo
*&---------------------------------------------------------------------*
*& text
*&---------------------------------------------------------------------*
*& -->  p1        text
*& <--  p2        text
*&---------------------------------------------------------------------*
FORM f_seleciona_arquivo .

  CALL FUNCTION 'KD_GET_FILENAME_ON_F4'
    EXPORTING
      field_name    = p_file
    CHANGING
      file_name     = p_file
    EXCEPTIONS
      mask_too_long = 1
      OTHERS        = 2.

  IF sy-subrc <> 0.
    MESSAGE i000. "Erro na seleção do arquivo
  ENDIF.

ENDFORM.
*&---------------------------------------------------------------------*
*& Form f_upload_arquivo
*&---------------------------------------------------------------------*
*& text
*&---------------------------------------------------------------------*
*& -->  p1        text
*& <--  p2        text
*&---------------------------------------------------------------------*
FORM f_upload_arquivo .

  DATA vl_filename TYPE string.
  vl_filename = p_file.

  CALL FUNCTION 'GUI_UPLOAD'
    EXPORTING
      filename                = vl_filename
      filetype                = 'ASC'
      has_field_separator     = 'X'
    TABLES
      data_tab                = t_excel
    EXCEPTIONS
      file_open_error         = 1
      file_read_error         = 2
      no_batch                = 3
      gui_refuse_filetransfer = 4
      invalid_type            = 5
      no_authority            = 6
      unknown_error           = 7
      bad_data_format         = 8
      header_not_allowed      = 9
      separator_not_allowed   = 10
      header_too_long         = 11
      unknown_dp_error        = 12
      access_denied           = 13
      dp_out_of_memory        = 14
      disk_full               = 15
      dp_timeout              = 16
      OTHERS                  = 17.

  IF sy-subrc <> 0.
    MESSAGE i001. "Erro na abertura do arquivo
    STOP.
  ELSE.
    PERFORM f_busca_dados.
  ENDIF.

ENDFORM.
