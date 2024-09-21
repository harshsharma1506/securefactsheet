CLASS zcl_ssb_tf DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
    INTERFACES: if_amdp_marker_hdb.
    CLASS-METHODS: fetch_data FOR TABLE FUNCTION z_ssb_auth_tf.
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.

CLASS zcl_ssb_tf IMPLEMENTATION.
  METHOD fetch_data BY DATABASE FUNCTION FOR HDB LANGUAGE SQLSCRIPT
                    OPTIONS READ-ONLY USING
                                  /ssb/allapps
                                  agr_buffi
                                  agr_hiert.
    lt_first  = select mandt,
                      fiori_id,
                     cast( catalog_id as varchar( 100 ) ) as catalog_id ,
                      TYPE as tile_type,
                      semantic_object as semantic_obj
                      FROM "/SSB/ALLAPPS";

     lt_final = SELECT a.* ,
                       b.agr_name,
                       c.text as role_text
                       from :lt_first as a
                       left outer join agr_buffi as b
                       on a.catalog_id = b.url
                       left outer join agr_hiert as c on b.agr_name = c.agr_name;
     return select mandt,
                   fiori_id,
                   catalog_id,
                   tile_type,
                   semantic_obj,
                   agr_name,
                   role_text
                   from :lt_final;
  endmethod.

ENDCLASS.
