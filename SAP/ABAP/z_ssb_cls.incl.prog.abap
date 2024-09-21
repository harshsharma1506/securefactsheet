*&---------------------------------------------------------------------*
*& Include          Z_SSB_CLS
*&---------------------------------------------------------------------*
CLASS lcl_file_play DEFINITION.
  PUBLIC SECTION.
    METHODS: fetch_apps_ssb EXPORTING
                              e_tab TYPE STANDARD TABLE,
      fetch_change_docs  EXPORTING
                           e_tab1 TYPE STANDARD TABLE,
      create_file_ssb IMPORTING
                        p_ifile TYPE localfile
                        i_tab2  TYPE STANDARD TABLE,
      create_file_cdhdr IMPORTING
                          p_ifile1 TYPE localfile
                          i_tab3   TYPE STANDARD TABLE.
  PRIVATE SECTION.
    DATA: lv_filename TYPE localfile,
          lt_text     TYPE truxs_t_text_data.
    METHODS: check_exists.
ENDCLASS.

CLASS lcl_file_play IMPLEMENTATION.
  METHOD check_exists.
    TRANSLATE p_path TO UPPER CASE.
    CALL FUNCTION 'FILE_GET_NAME'
      EXPORTING
        logical_filename = CONV char60( p_path )
      IMPORTING
        file_name        = lv_filename
      EXCEPTIONS
        file_not_found   = 1
        OTHERS           = 2.
  ENDMETHOD.
  METHOD fetch_apps_ssb.
    IF cl_abap_dbfeatures=>use_features(
      EXPORTING
        requested_features = VALUE #( ( cl_abap_dbfeatures=>amdp_table_function ) )        " List of requested features
    ) IS NOT INITIAL.
      SELECT * FROM z_ssb_auth_tf INTO TABLE @DATA(lt_auth). "since it will only have the 2k entries it's fine to have select *
      IF sy-subrc = 0.
        e_tab = lt_auth.
        DATA(lv_path_ssb) = p_path && '/' && p_file.
        me->create_file_ssb( p_ifile = CONV #( lv_path_ssb  )
                             i_tab2 = e_tab ).
      ENDIF.
    ENDIF.
  ENDMETHOD.
  METHOD fetch_change_docs.
    DATA(lv_calc_date) = sy-datum.
    CALL FUNCTION 'RP_CALC_DATE_IN_INTERVAL'
      EXPORTING
        date      = sy-datum
        days      = 0
        months    = 6
        signum    = '-'
        years     = 0
      IMPORTING
        calc_date = lv_calc_date.

    s_date[] = VALUE #( ( sign = 'I' option = 'BT' low = lv_calc_date high = sy-datum ) ).
    SELECT * FROM z_ssb_auth_c INTO TABLE @DATA(lt_chg)
      WHERE changed_on IN @s_date.
    IF sy-subrc = 0.
      e_tab1[] = lt_chg[].
      DATA(lv_path_ssb) = p_path && '/' && p_file.
      me->create_file_cdhdr( p_ifile1 = CONV #( lv_path_ssb  )
                           i_tab3 = e_tab1 ).
    ENDIF.
  ENDMETHOD.
  METHOD create_file_ssb.
    me->check_exists( ).
    IF sy-subrc = 0.
      OPEN DATASET p_ifile FOR OUTPUT IN TEXT MODE ENCODING DEFAULT.
      IF sy-subrc = 0.
        CONCATENATE 'App Id'         "header part
                    'Tech Catalog'
                    'Type of tile'
                    'Semantic Object'
                    'Role Name'
                    'Description'
                    INTO DATA(ls_header)
                    SEPARATED BY ','.
        IF sy-subrc = 0.
          TRANSFER ls_header TO p_ifile.
        ENDIF.
        CALL FUNCTION 'SAP_CONVERT_TO_TEX_FORMAT'
          EXPORTING
            i_field_seperator    = ','
          TABLES
            i_tab_sap_data       = i_tab2
          CHANGING
            i_tab_converted_data = lt_text
          EXCEPTIONS
            conversion_failed    = 1
            OTHERS               = 2.
        IF sy-subrc <> 0.
* Implement suitable error handling here
        ENDIF.
        LOOP AT lt_text INTO DATA(ls_conv_tab).
          TRANSFER ls_conv_tab TO p_ifile.
        ENDLOOP.
        CLOSE DATASET p_ifile.
      ENDIF.
    ENDIF.
  ENDMETHOD.
  METHOD create_file_cdhdr.
    me->check_exists( ).
    IF sy-subrc = 0.
      OPEN DATASET p_ifile1 FOR OUTPUT IN TEXT MODE ENCODING DEFAULT.
      IF sy-subrc = 0.
        CONCATENATE 'Role Name'         "header part
                    'Change Number'
                    'Created On'
                    'Changed By'
                    'Changed On'
                    'Class'
                    'Id'
                    'Table'
                    'Key'
                    'Name'
                    'New Value'
                    'Old Value'
                    INTO DATA(ls_header)
                    SEPARATED BY ','.
        IF sy-subrc = 0.
          TRANSFER ls_header TO p_ifile1.
        ENDIF.
        CALL FUNCTION 'SAP_CONVERT_TO_TEX_FORMAT'
          EXPORTING
            i_field_seperator    = ','
          TABLES
            i_tab_sap_data       = i_tab3
          CHANGING
            i_tab_converted_data = lt_text
          EXCEPTIONS
            conversion_failed    = 1
            OTHERS               = 2.
        IF sy-subrc <> 0.
* Implement suitable error handling here
        ENDIF.
        LOOP AT lt_text INTO DATA(ls_conv_tab).
          TRANSFER ls_conv_tab TO p_ifile1.
        ENDLOOP.
        CLOSE DATASET p_ifile1.
      ENDIF.
    ENDIF.
  ENDMETHOD.
ENDCLASS.
