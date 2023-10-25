@AbapCatalog.sqlViewName: 'ZKS_001_EXMP'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Eğitim örnek CDS'
define view zks_001_cds_example
  as select from    ekko
    inner join      ekpo on ekpo.ebeln = ekko.ebeln
    inner join      lfa1 on lfa1.lifnr = ekko.lifnr
    left outer join makt on  makt.matnr = ekpo.matnr
                         and makt.spras = $session.system_language
{
  key ekpo.ebeln,
  key ekpo.ebelp,
      ekpo.matnr,
      makt.maktx,
      ekpo.werks,
      ekpo.lgort,
      ekpo.meins,
      lfa1.lifnr,
      lfa1.name1,
      concat_with_space(lfa1.stras, lfa1.mcod3, 1) as satici_adresi
}
