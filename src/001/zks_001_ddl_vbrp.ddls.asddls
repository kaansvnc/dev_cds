@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'VBRP CDS Ödev 1'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
define view entity ZKS_001_DDL_VBRP as select from vbrp
                                                         inner join vbrk on vbrk.vbeln = vbrp.vbeln
                                                         inner join mara on mara.matnr = vbrp.matnr
                                                         left outer join vbak on vbak.vbeln = vbrp.aubel
                                                         left outer join kna1 on kna1.kunnr = vbak.kunnr
                                                         left outer join makt on makt.matnr = mara.matnr
                                                                              and makt.spras = $session.system_language
{   
    key vbrp.vbeln as InvoiceNumber,
    key vbrp.posnr as InvoiceItem,
    vbrp.aubel as OrderNumber,
    vbrp.aupos as OrderItem,
    vbak.kunnr as Customer,
    concat_with_space(kna1.name1,kna1.name2,1) as CustomerFullName,
    @Semantics.amount.currencyCode: 'Currency'
    vbrp.netwr as Amount,
    @Semantics.amount.currencyCode: 'Currency'
    currency_conversion( amount=>vbrp.netwr, source_currency=>vbrk.waerk, target_currency=>cast('EUR' as abap.cuky( 5 )) , exchange_rate_date=>vbrk.fkdat ) as EurAmount,
    vbrk.waerk as Currency,
    left(vbak.kunnr,3) as CustomerLeft3,
    length(vbrp.matnr) as MaterialNrLength,
    case vbrk.fkart when 'FAS' then 'Peşinat Talebi İptali'
                    when 'FAZ' then 'Peşinat Talebi'
                    else 'Fatura' end as InvoiceType,
    vbrk.fkdat as InvoiceDate,
    vbrk.inco2_l as IncotermsLocation
}
