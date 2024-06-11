*&---------------------------------------------------------------------*
*& Include          ZMODIFY_MATERIALS_REPORT_S01
*&---------------------------------------------------------------------*

TABLES: zlog_mat604.

DATA: gt_log      TYPE TABLE OF zlog_mat604,
      gv_filename TYPE string,
      gv_path     TYPE string,
      gv_fullpath TYPE string,
      gv_result   TYPE i,
      gv_default  TYPE string,
      gv_fname    TYPE string.

SELECTION-SCREEN BEGIN OF BLOCK b1 WITH FRAME TITLE TEXT-001.
  PARAMETERS: p_export RADIOBUTTON GROUP a DEFAULT 'X',
              p_dsplay RADIOBUTTON GROUP a.
SELECTION-SCREEN END OF BLOCK b1.

SELECTION-SCREEN BEGIN OF BLOCK b2 WITH FRAME TITLE TEXT-002.
  SELECT-OPTIONS: so_matnr FOR zlog_mat604-matnr,
                  so_data FOR zlog_mat604-data.
SELECTION-SCREEN END OF BLOCK b2.
