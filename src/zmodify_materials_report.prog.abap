*&---------------------------------------------------------------------*
*& Report ZMODIFY_MATERIALS_REPORT
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zmodify_materials_report.

INCLUDE zmodify_materials_report_s01.
INCLUDE zmodify_materials_report_f01.

START-OF-SELECTION.

  SELECT * FROM zlog_mat604
        INTO TABLE gt_log
        WHERE matnr IN so_matnr AND data IN so_data.

  IF p_export = 'X'.
    PERFORM f_exportar_excel.
  ELSEIF p_dsplay = 'X'.
    PERFORM f_exibir_alv.
  ENDIF.
