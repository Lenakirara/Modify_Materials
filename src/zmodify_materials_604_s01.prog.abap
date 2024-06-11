*&---------------------------------------------------------------------*
*& Include          ZMODIFY_MATERIALS_604_S01
*&---------------------------------------------------------------------*

TABLES: mara,
        sscrfields,
        makt.

TYPES: BEGIN OF ty_excel,
         matnr TYPE mara-matnr,
         matkl TYPE mara-matkl,
       END OF ty_excel.

TYPES: BEGIN OF ty_log_erro,
         matnr TYPE mara-matnr,
         txt   TYPE text200,
       END OF ty_log_erro.

DATA: t_excel    TYPE TABLE OF ty_excel,
      t_log_erro TYPE TABLE OF ty_log_erro,
      t_message  TYPE STANDARD TABLE OF bdcmsgcoll.

DATA: w_excel   TYPE ty_excel,
      w_mara    TYPE mara,
      w_makt    TYPE makt-maktx,
      w_message TYPE bdcmsgcoll.

DATA: BEGIN OF t_bdcdata OCCURS 0.
    INCLUDE STRUCTURE bdcdata.
DATA: END OF t_bdcdata.

DATA v_mode TYPE c.

PARAMETERS: p_file  TYPE localfile.

SELECTION-SCREEN FUNCTION KEY 1.
