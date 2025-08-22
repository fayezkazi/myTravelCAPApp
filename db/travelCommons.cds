namespace travel.common;
using { Currency } from '@sap/cds/common';

type AmountT : Decimal(10,2)@(
    Semantics.amount.currencyCode: 'CURRENCY_CODE',
    sap.unit:'CURRENCY_CODE'
);

aspect Amount : {
    CURRENCY: Currency;
    flightPrice: AmountT @Common.Label: 'Flight Price'
};