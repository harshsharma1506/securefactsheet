*&---------------------------------------------------------------------*
*& Report Z_SSB_AUTH_FILES
*&---------------------------------------------------------------------*
*& Author - Harsh Sharma
*&---------------------------------------------------------------------*
REPORT z_ssb_auth_files.

INCLUDE: z_ssb_data,
         z_ssb_sel,
         z_ssb_cls.

START-OF-SELECTION.
  DATA(go_ssb) = NEW lcl_file_play( ).
  IF p_ssb IS NOT INITIAL.
    go_ssb->fetch_apps_ssb(
      IMPORTING
        e_tab = g_it_ssb
    ).
  ELSE.
    go_ssb->fetch_change_docs(
      IMPORTING
        e_tab1 = g_it_chg
    ).
  ENDIF.
