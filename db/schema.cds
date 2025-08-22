namespace myTravelCapApp;
using { cuid, managed , Currency } from '@sap/cds/common';
using { travel.common } from './travelCommons';


@assert.unique: { customerID: [customerID] }
entity Customers : cuid {
  customerID: String(10) @(Common.Label : 'Customer ID') @mandatory;
  name: String(100) @(Common.Label : 'Name');
  address: String(200) @(Common.Label : 'Address');
  phoneNumber: String(15) @(Common.Label : 'Phone Number');
  email: String(100) @(Common.Label : 'Email');
}

@assert.unique: { airlineID: [airlineID] }
entity Carriers : cuid{
  airlineID: String(4) @(Common.Label : 'Airline ID') @mandatory;
  airlineName: String(50) @(Common.Label : 'Airline Name');
  airlineURL: String @(UI.IsImageURL);
}

@assert.unique: { connectionID: [connectionID] }
entity Connections : cuid, common.Amount {
  airlineID: Association To Carriers  @(Common.Label : 'Airline ID');
  connectionID: String(4) @(Common.Label : 'Connection ID') @mandatory;
  departureAirport: String(10) @(Common.Label : 'Airport From');
  destinationAirport: String(10)  @(Common.Label : 'Airport To');
}

@assert.unique: { agencyID: [agencyID] }
entity Agencies : cuid {
  agencyID: String(10) @(Common.Label : 'Agency ID') @mandatory;
  agencyName: String(100) @(Common.Label : 'Agency Name');
  agencyAddress: String(200) @(Common.Label : 'Address');
  agencyPhoneNumber: String(15) @(Common.Label : 'Phone Number');
  agencyEmail: String(100) @(Common.Label : 'Email');
}

@assert.unique: { status: [status] }
entity Statuses : cuid {
  status: String(1) @(Common.Label : 'Status Code') @mandatory;
  statusText: String(20) @(Common.Label : 'Status Text');
}

@assert.unique: { travelID: [travelID] }
entity Travels : cuid, managed {
  travelID: String(10) @(Common.Label : 'Travel ID') @mandatory;
  agencyID: Association to Agencies @(Common.Label : 'Agency ID');
  customerID: Association to Customers @(Common.Label : 'Customer ID');
  beginDate: Date  @(Common.Label : 'Begin Date');
  endDate: Date @(Common.Label : 'End Date');
  bookingFee: Decimal(10,2) @(Common.Label : 'Booking Fee');
  totalPrice: Decimal(10,2) @(Common.Label : 'Total Price');
  currencyCode: Currency @(Common.Label : 'Currency');
  description: String(100) @(Common.Label : 'Description');
  overallStatus: Association to Statuses @(Common.Label : 'Status');
  booking: Composition of many Bookings on booking.travels = $self;
}

entity Bookings : cuid, managed {
  bookingID: String(10) @(Common.Label : 'Booking ID');
  bookingDate: Date @(Common.Label : 'Booking Date') default CURRENT_DATE;
  airlineID: Association to Carriers @(Common.Label : 'Airline ID');
  connectionID: Association to Connections @(Common.Label : 'Connection ID');
  flightDate: Date  @(Common.Label : 'Flight Date');
  flightPrice: Decimal(10,2) @(Common.Label : 'Flight Price');
  currencyCode: Currency @(Common.Label : 'Currency');
  bookingStatus: Association to Statuses @(Common.Label : 'Booking Status');
  travels: Association to Travels @(Common.Label : 'Travel');
}

