*&---------------------------------------------------------------------*
*& Include          Z_SSB_CLS
*&---------------------------------------------------------------------*
CLASS lcl_file_play DEFINITION.
  PUBLIC SECTION.
    METHODS: fetch_apps_ssb,
      fetch_change_docs,
      create_file_ssb IMPORTING
                        p_ifile TYPE filename-fileintern,
      create_file_cdhdr IMPORTING
                          p_ifile1 TYPE filename-fileintern.
  PRIVATE SECTION.
    METHODS: check_exists.
ENDCLASS.

CLASS lcl_file_play IMPLEMENTATION.
  METHOD check_exists.
  ENDMETHOD.
  METHOD fetch_apps_ssb.
  ENDMETHOD.
  METHOD fetch_change_docs.
  ENDMETHOD.
  METHOD create_file_ssb.
  ENDMETHOD.
  METHOD create_file_cdhdr.
  ENDMETHOD.
ENDCLASS.
