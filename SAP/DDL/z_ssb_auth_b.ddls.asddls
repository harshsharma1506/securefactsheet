@AbapCatalog.sqlViewName: 'Z_SSB_AUTH_BV'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'cds view for ssb auth'
define view Z_Ssb_Auth_B
  as select from agr_define
  association [1..*] to cdhdr as _cdhdr on agr_define.agr_name = _cdhdr.objectid
  association [1..*] to cdpos as _cdpos on _cdhdr.changenr = _cdpos.changenr
{
  key agr_define.agr_name,
  key _cdhdr[1:inner].changenr,
      agr_define.create_dat,
      _cdhdr[1:inner].tcode,
      _cdhdr[1:inner].username,
      _cdhdr[1:inner].udate,
      _cdpos[1:inner], //exposing the associations
      _cdhdr[1:inner]
}
where
  mandt = $session.client
