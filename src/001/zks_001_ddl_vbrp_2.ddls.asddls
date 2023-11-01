@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'VBRP CDS Ödev 2'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
define view entity ZKS_001_DDL_VBRP_2 as select from ZKS_001_DDL_VBRP as cds1
{
    key InvoiceNumber,
    @Semantics.amount.currencyCode: 'Currency'
    sum(EurAmount) as TotalEurAmount,
    Currency,
    CustomerFullName,
    count(*) as TotalItems,
    division(cast(sum(Amount) as abap.dec(17,2)), count(*), 2) as AverageAmount,
    left( InvoiceDate, 4) as InvoiceYear,
    substring( InvoiceDate, 5, 2) as InvoiceMonth,
    substring( InvoiceDate, 7, 2) as InvoiceDay,
    substring( IncotermsLocation, 1, 3 ) as IncotermsLocLeft3
    
}
group by InvoiceNumber, Currency, CustomerFullName, InvoiceDate, IncotermsLocation
