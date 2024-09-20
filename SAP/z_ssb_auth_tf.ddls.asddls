@EndUserText.label: 'Table function SSB~AGR_HIER~AGR_HIERT'
@ClientHandling.type: #CLIENT_DEPENDENT
@ClientHandling.algorithm: #SESSION_VARIABLE
define table function Z_SSB_AUTH_TF
  with parameters
   @Environment.systemField: #CLIENT 
   p_clnt : abap.clnt
returns
{
  MANDT        : abap.clnt;
  fiori_id     : /ssb/fiori_id;
  catalog_id   : char35;
  tile_type    : /ssb/tile_type;
  semantic_obj : /ssb/semantic_object30;
  agr_name     : agr_name;
  role_text    : ssm_title;
}
implemented by method
  zcl_ssb_tf=>fetch_data;
