@AbapCatalog.sqlViewName: 'Z_SSB_AUTH_CV'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'cds view for ssb auth'
define view Z_Ssb_Auth_C
  as select from Z_Ssb_Auth_B
{
  key agr_name   as role,
  key changenr   as change_doc,
      create_dat as creation,
      username,
      udate      as changed_on,
      _cdpos.objectclas,
      _cdpos.objectid,
      _cdpos.tabname,
      _cdpos.tabkey,
      _cdpos.fname,
      _cdpos.value_new,
      _cdpos.value_old
}
where
      mandt    = $session.client
  and changenr is not null
