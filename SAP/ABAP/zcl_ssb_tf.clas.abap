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
    IF cl_abap_dbfeatures=>use_features(
      EXPORTING
        requested_features = VALUE #( ( cl_abap_dbfeatures=>amdp_table_function ) )        " List of requested features
    ) IS NOT INITIAL.
      SELECT * FROM z_ssb_auth_tf INTO TABLE @data(lt_ath).
        IF sy-subrc = 0.
          cl_demo_output=>display_data(
            EXPORTING
              value = lt_ath
          ).
        ENDIF.
    ENDIF.
  ENDMETHOD.
  METHOD fetch_change_docs.
  ENDMETHOD.
  METHOD create_file_ssb.
  ENDMETHOD.
  METHOD create_file_cdhdr.
  ENDMETHOD.
ENDCLASS.
