using { myTravelCapApp as my } from '../db/schema.cds';

@path: '/service/myTravelCapApp'
@requires: 'authenticated-user'
service myTravelCapAppSrv {

  function setBookingDefaults() returns Bookings;

  @odata.draft.enabled
  entity Customers as projection on my.Customers;
  @odata.draft.enabled
  entity Carriers as projection on my.Carriers;
  @odata.draft.enabled
  entity Connections as projection on my.Connections;
  @odata.draft.enabled
  entity Agencies as projection on my.Agencies;
  @odata.draft.enabled
  entity Statuses as projection on my.Statuses;
  @odata.draft.enabled
  entity Travels as projection on my.Travels {
    *,
    virtual null as canSetComplete : Boolean,
    virtual null as criticality : Integer
  } actions {
    @Core.OperationAvailable : {$edmJson: {$Eq: [{$Path: 'canSetComplete'}, true]}}
    @UI.Button: { Icon: 'sap-icon://accept' }
    action setTravelStatusToComplete() returns Travels;
  };
  entity Bookings @(Common.DefaultValuesFunction: 'setBookingDefaults')
  as projection on my.Bookings 
  {
    *,
    virtual null as canBookingStatusChange : Boolean,
    virtual null as criticality : Integer
  } actions {
    @(
      Core.OperationAvailable : {$edmJson: {$Eq: [{$Path: 'canBookingStatusChange'}, true]}},
      Common.SideEffects : {
        TargetEntities : ['travels'],
        TargetProperties : ['travels/totalPrice']
      }
    )
    action setBookingStatusConfirm() returns Bookings;
    @(
      Core.OperationAvailable : {$edmJson: {$Eq: [{$Path: 'canBookingStatusChange'}, true]}},
      Common.SideEffects : {
        TargetEntities : ['travels'],
        TargetProperties : ['travels/totalPrice']
      }
    )
    action setBookingStatusCancel() returns Bookings;
  };
}