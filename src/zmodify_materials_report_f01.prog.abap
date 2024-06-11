*&---------------------------------------------------------------------*
*& Include          ZMODIFY_MATERIALS_REPORT_F01
*&---------------------------------------------------------------------*
*&---------------------------------------------------------------------*
*& Form f_exportar_excel
*&---------------------------------------------------------------------*
*& text
*&---------------------------------------------------------------------*
*& -->  p1        text
*& <--  p2        text
*&---------------------------------------------------------------------*
FORM f_exportar_excel .

  CALL METHOD cl_gui_frontend_services=>file_save_dialog
    EXPORTING
      window_title      = 'File Save Dialog'
      default_extension = 'xls'
      initial_directory = 'D:\'
    CHANGING
      filename          = gv_filename
      path              = gv_path
      fullpath          = gv_fullpath
      user_action       = gv_result.

  gv_fname = gv_fullpath.

  CALL FUNCTION 'GUI_DOWNLOAD'
    EXPORTING
      bin_filesize            = ''
      filename                = gv_fname
      filetype                = 'ASC'
      write_field_separator   = 'X'
    TABLES
      data_tab                = gt_log
    EXCEPTIONS
      file_write_error        = 1
      no_batch                = 2
      gui_refuse_filetransfer = 3
      invalid_type            = 4
      no_authority            = 5
      unknown_error           = 6
      header_not_allowed      = 7
      separator_not_allowed   = 8
      filesize_not_allowed    = 9
      header_too_long         = 10
      dp_error_create         = 11
      dp_error_send           = 12
      dp_error_write          = 13
      unknown_dp_error        = 14
      access_denied           = 15
      dp_out_of_memory        = 16
      disk_full               = 17
      dp_timeout              = 18
      file_not_found          = 19
      dataprovider_exception  = 20
      control_flush_error     = 21
      OTHERS                  = 22.

  IF sy-subrc <> 0.
    MESSAGE 'Erro ao exibir relatório.' TYPE 'E'.
  ENDIF.

ENDFORM.
*&---------------------------------------------------------------------*
*& Form f_exibir_alv
*&---------------------------------------------------------------------*
*& text
*&---------------------------------------------------------------------*
*& -->  p1        text
*& <--  p2        text
*&---------------------------------------------------------------------*
FORM f_exibir_alv .

  DATA: lo_table TYPE REF TO cl_salv_table.

  TRY.
      CALL METHOD cl_salv_table=>factory
        IMPORTING
          r_salv_table = lo_table
        CHANGING
          t_table      = gt_log.

      CALL METHOD lo_table->display.

    CATCH cx_salv_msg.
      MESSAGE 'Erro ao exibir ALV.' TYPE 'E'.
  ENDTRY.

ENDFORM.
