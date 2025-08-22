using myTravelCapAppSrv as service from '../../srv/service';

annotate service.Travels with @(
    UI.UpdateHidden: isUpdatable,
    UI.DeleteHidden: isUpdatable,
    UI.FieldGroup #GeneratedGroup: {
        $Type: 'UI.FieldGroupType',
        Data : [
            {
                $Type: 'UI.DataField',
                Value: travelID,
            },
            {
                $Type: 'UI.DataField',
                Value: agencyID_ID,
                Label: 'Agency',
            },
            {
                $Type: 'UI.DataFieldWithUrl',
                Value: customerID.name,
                Label: 'Customer',
                Url: '#/Customers(ID={customerID_ID},IsActiveEntity=true)'
            },
            {
                $Type: 'UI.DataField',
                Value: beginDate,
            },
            {
                $Type: 'UI.DataField',
                Value: endDate,
            },
            {
                $Type        : 'UI.DataField',
                Value        : bookingFee,
                Label        : 'Booking Fee',
                DisplayFormat: 'Currency',
                UnitOfMeasure: currencyCode_code,
            },
            {
                $Type                  : 'UI.DataField',
                Value                  : totalPrice,
                Label                  : 'Total Price',
                DisplayFormat          : 'Currency',
                UnitOfMeasure          : currencyCode_code,
                ![@Common.FieldControl]: #ReadOnly,
            },
            {
                $Type: 'UI.DataField',
                Label: 'Currency',
                Value: currencyCode_code,
            },
            {
                $Type: 'UI.DataField',
                Value: description,
            },
            {
                $Type                    : 'UI.DataField',
                Value                    : overallStatus_ID,
                ![@Common.FieldControl]  : #ReadOnly,
                Criticality              : criticality,
                CriticalityRepresentation: #WithIcon
            }
        ],
        Label: 'Travel Overview',
    },
    UI.Identification : [
        {
            $Type : 'UI.DataFieldForAction',
            Action: 'myTravelCapAppSrv.setTravelStatusToComplete',
            Label : 'Set Complete',
            ID    : 'idSetComplete',
        }
    ],
    UI.Facets                    : [
        {
            $Type : 'UI.ReferenceFacet',
            ID    : 'GeneratedFacet1',
            Label : 'General Information',
            Target: '@UI.FieldGroup#GeneratedGroup',
        },
        {
            $Type : 'UI.ReferenceFacet',
            Target: 'booking/@UI.LineItem',
            Label : 'Booking Info',
            ID    : 'Booking',
        },
    ],
    UI.LineItem                  : [
        {
            $Type: 'UI.DataField',
            Value: travelID,
        },
        {
            $Type: 'UI.DataField',
            Value: agencyID.agencyName,
            Label: 'Agency',
        },
        {
            $Type: 'UI.DataFieldWithUrl',
            Value: customerID.name,
            Label: 'Customer',
            Url: '#/Customers(ID={customerID_ID},IsActiveEntity=true)'
        },
        {
            $Type                    : 'UI.DataField',
            Value                    : overallStatus.statusText,
            Label                    : 'Overall Status',
            ![@Common.FieldControl]  : #ReadOnly,
            Criticality              : criticality,
            CriticalityRepresentation: #WithIcon
        },
        {
            $Type: 'UI.DataField',
            Value: beginDate,
        },
        {
            $Type: 'UI.DataField',
            Value: endDate,
        },
        {
            $Type        : 'UI.DataField',
            Value        : bookingFee,
            Label        : 'Booking Fee',
            DisplayFormat: 'Currency',
            UnitOfMeasure: currencyCode_code,
        },
        {
            $Type                  : 'UI.DataField',
            Value                  : totalPrice,
            Label                  : 'Total Price',
            DisplayFormat          : 'Currency',
            UnitOfMeasure          : currencyCode_code,
            ![@Common.FieldControl]: #ReadOnly,
        },
    ],
    UI.HeaderInfo                : {
        $Type         : 'UI.HeaderInfoType',
        TypeName      : 'Travel',
        TypeNamePlural: 'Travels',
        Title         : {
            $Type: 'UI.DataField',
            Value: description,
        },
        Description   : {
            $Type: 'UI.DataField',
            Value: travelID,
        },
        ImageUrl      : 'https://media.istockphoto.com/id/1137971264/vector/airplane-fly-out-logo-plane-taking-off-stylized-sign.webp?s=1024x1024&w=is&k=20&c=j1SM20pOkldHsg_gMpeMBGqdg6E81hZhFGdtFSPjvpg=',
    },
);

annotate service.Travels with {
    agencyID @Common.ValueList: {
        $Type         : 'Common.ValueListType',
        CollectionPath: 'Agencies',
        Parameters    : [
            {
                $Type            : 'Common.ValueListParameterInOut',
                LocalDataProperty: agencyID_ID,
                ValueListProperty: 'ID',
            },
            {
                $Type            : 'Common.ValueListParameterDisplayOnly',
                ValueListProperty: 'agencyID',
            },
            {
                $Type            : 'Common.ValueListParameterDisplayOnly',
                ValueListProperty: 'agencyName',
            },
            {
                $Type            : 'Common.ValueListParameterDisplayOnly',
                ValueListProperty: 'agencyAddress',
            },
            {
                $Type            : 'Common.ValueListParameterDisplayOnly',
                ValueListProperty: 'agencyPhoneNumber',
            },

        ],
    }
};

annotate service.Travels with {
    customerID @Common.ValueList: {
        $Type         : 'Common.ValueListType',
        CollectionPath: 'Customers',
        Parameters    : [
            {
                $Type            : 'Common.ValueListParameterInOut',
                LocalDataProperty: customerID_ID,
                ValueListProperty: 'ID',
            },
            {
                $Type            : 'Common.ValueListParameterDisplayOnly',
                ValueListProperty: 'customerID',
            },
            {
                $Type            : 'Common.ValueListParameterDisplayOnly',
                ValueListProperty: 'name',
            },
            {
                $Type            : 'Common.ValueListParameterDisplayOnly',
                ValueListProperty: 'address',
            },
            {
                $Type            : 'Common.ValueListParameterDisplayOnly',
                ValueListProperty: 'phoneNumber',
            },
        ],
    }
};

annotate service.Travels with {
    overallStatus @Common.ValueList: {
        $Type         : 'Common.ValueListType',
        CollectionPath: 'Statuses',
        Parameters    : [
            {
                $Type            : 'Common.ValueListParameterInOut',
                LocalDataProperty: overallStatus_ID,
                ValueListProperty: 'ID',
            },
            {
                $Type            : 'Common.ValueListParameterDisplayOnly',
                ValueListProperty: 'status',
            },
            {
                $Type            : 'Common.ValueListParameterDisplayOnly',
                ValueListProperty: 'statusText',
            },

        ],
    }
};

annotate service.Travels with {
    agencyID      @(
        Common.Text           : agencyID.agencyName,
        Common.TextArrangement: #TextOnly
    );
    customerID    @(
        Common.Text           : customerID.name,
        Common.TextArrangement: #TextOnly
    );
    overallStatus @(
        Common.Text           : overallStatus.statusText,
        Common.TextArrangement: #TextOnly
    );
}

annotate service.Bookings with @(
    UI.LineItem                     : [
        {
            $Type: 'UI.DataField',
            Value: airlineID.airlineURL,
            Label: 'Airline'
        },

        {
            $Type                  : 'UI.DataField',
            Value                  : bookingID,
            Label                  : 'Booking ID',
            ![@Common.FieldControl]: #ReadOnly,
        },
        {
            $Type                  : 'UI.DataField',
            Value                  : bookingDate,
            Label                  : 'Booking Date',
            ![@Common.FieldControl]: #ReadOnly,
        },
        {
            $Type                    : 'UI.DataField',
            Value                    : bookingStatus.statusText,
            Label                    : 'Booking Status',
            ![@Common.FieldControl]  : #ReadOnly,
            Criticality              : criticality,
            CriticalityRepresentation: #WithIcon
        },
        {
            $Type: 'UI.DataField',
            Value: airlineID.airlineName,
            Label: 'Airline',
        },
        {
            $Type: 'UI.DataField',
            Value: connectionID.departureAirport,
            Label: 'From Airport',
        },
        {
            $Type: 'UI.DataField',
            Value: connectionID.destinationAirport,
            Label: 'To Airport',
        },
        {
            $Type: 'UI.DataField',
            Value: flightDate,
            Label: 'Flight Date',
        },
        {
            $Type        : 'UI.DataField',
            Value        : flightPrice,
            Label        : 'Flight Price',
            DisplayFormat: 'Currency',
            UnitOfMeasure: currencyCode_code,
        },
        {
            $Type                  : 'UI.DataField',
            Value                  : travels.totalPrice,
            Label                  : 'Total Price',
            DisplayFormat          : 'Currency',
            UnitOfMeasure          : currencyCode_code,
            ![@Common.FieldControl]: #ReadOnly,
        },
        {
            $Type : 'UI.DataFieldForAction',
            Action: 'myTravelCapAppSrv.setBookingStatusConfirm',
            Label : 'Confirm Booking',
            ID    : 'idSetBookingConfirm',
        },
        {
            $Type : 'UI.DataFieldForAction',
            Action: 'myTravelCapAppSrv.setBookingStatusCancel',
            Label : 'Cancel Booking',
            ID    : 'idSetBookingCancel',
        },

    ],
    UI.HeaderInfo                   : {
        $Type         : 'UI.HeaderInfoType',
        TypeName      : 'Booking',
        TypeNamePlural: 'Bookings',
        Title         : {
            $Type: 'UI.DataField',
            Value: bookingID,
        },
        Description   : {
            $Type: 'UI.DataField',
            Value: travels.customerID.name
        },
        ImageUrl      : 'https://cdn.pixabay.com/photo/2014/06/29/12/52/oranges-379375_1280.jpg',
    },
    UI.FieldGroup #BookingFieldGroup: {
        $Type: 'UI.FieldGroupType',
        Data : [
            {
                $Type                  : 'UI.DataField',
                Value                  : bookingID,
                ![@Common.FieldControl]: #ReadOnly,
            },
            {
                $Type                  : 'UI.DataField',
                Value                  : bookingDate,
                ![@Common.FieldControl]: #ReadOnly,
            },
            {
                $Type: 'UI.DataFieldWithUrl',
                Value: airlineID.airlineName,
                Label: 'Airline',
                Url: '#/Carriers(ID={airlineID_ID},IsActiveEntity=true)'
            },
            {
                $Type: 'UI.DataField',
                Value: connectionID_ID,
            },
            {
                $Type: 'UI.DataField',
                Value: flightDate,
            },
            {
                $Type: 'UI.DataField',
                Value: flightPrice,
            },
            {
                $Type                  : 'UI.DataField',
                Value                  : travels.totalPrice,
                Label                  : 'Total Price',
                DisplayFormat          : 'Currency',
                UnitOfMeasure          : currencyCode_code,
                ![@Common.FieldControl]: #ReadOnly,
            },
            {
                $Type                    : 'UI.DataField',
                Value                    : bookingStatus_ID,
                ![@Common.FieldControl]  : #ReadOnly,
                Criticality              : criticality,
                CriticalityRepresentation: #WithIcon
            },
            {
                $Type : 'UI.DataFieldForAction',
                Action: 'myTravelCapAppSrv.setBookingStatusConfirm',
                Label : 'Confirm Booking',
                ShortLabel: 'Confirm',
                ID    : 'idSetBookingConfirm',
            },
            {
                $Type : 'UI.DataFieldForAction',
                Action: 'myTravelCapAppSrv.setBookingStatusCancel',
                Label : 'Cancel Booking',
                ID    : 'idSetBookingCancel',
            },
        ],
        Label: 'Booking Information',
    },
    UI.Facets                       : [{
        $Type : 'UI.ReferenceFacet',
        Label : 'Booking Info',
        ID    : 'BookingInfo',
        Target: '@UI.FieldGroup#BookingFieldGroup',
    }, ],
);

annotate service.Bookings with {
    airlineID     @(
        Common.Text           : airlineID.airlineName,
        Common.TextArrangement: #TextOnly,
        Common.SemanticObject : 'Carriers'
    );
    connectionID  @(
        Common.Text           : {
            $value : connectionID.departureAirport,
            $concat: ' - ',
            $value2: connectionID.destinationAirport
        },
        Common.TextArrangement: #TextOnly
    );
    bookingStatus @(
        Common.Text           : bookingStatus.statusText,
        Common.TextArrangement: #TextOnly
    );
}

annotate service.Bookings with {
    airlineID @Common.ValueList: {
        $Type          : 'Common.ValueListType',
        Parameters     : [
            {
                $Type            : 'Common.ValueListParameterInOut',
                ValueListProperty: 'ID',
                LocalDataProperty: airlineID_ID,
            },
            {
                $Type            : 'Common.ValueListParameterDisplayOnly',
                ValueListProperty: 'airlineID',
            },
            {
                $Type            : 'Common.ValueListParameterDisplayOnly',
                ValueListProperty: 'airlineName',
            },
        ],
        CollectionPath : 'Carriers',
        SearchSupported: true,
        Label          : 'Airline',
    }
};

annotate service.Bookings with {
    connectionID @Common.ValueList: {
        $Type          : 'Common.ValueListType',
        Parameters     : [
            {
                $Type            : 'Common.ValueListParameterInOut',
                ValueListProperty: 'ID',
                LocalDataProperty: connectionID_ID,
            },
            {
                $Type            : 'Common.ValueListParameterInOut',
                ValueListProperty: 'airlineID_ID',
                LocalDataProperty: airlineID_ID,
            },
            {
                $Type            : 'Common.ValueListParameterInOut',
                ValueListProperty: 'flightPrice',
                LocalDataProperty: flightPrice,
            },   
            {
                $Type            : 'Common.ValueListParameterInOut',
                ValueListProperty: 'CURRENCY_code',
                LocalDataProperty: currencyCode_code,
            },            
            {
                $Type            : 'Common.ValueListParameterDisplayOnly',
                ValueListProperty: 'connectionID',
            },
            {
                $Type            : 'Common.ValueListParameterDisplayOnly',
                ValueListProperty: 'departureAirport',
            },
            {
                $Type            : 'Common.ValueListParameterDisplayOnly',
                ValueListProperty: 'destinationAirport',
            },
        ],
        CollectionPath : 'Connections',
        SearchSupported: true,
        Label          : 'Connection',
    }
};

annotate service.Bookings with {
    bookingStatus @Common.ValueList: {
        $Type          : 'Common.ValueListType',
        Parameters     : [
            {
                $Type            : 'Common.ValueListParameterInOut',
                ValueListProperty: 'ID',
                LocalDataProperty: bookingStatus_ID,
            },
            {
                $Type            : 'Common.ValueListParameterDisplayOnly',
                ValueListProperty: 'status',
            },
            {
                $Type            : 'Common.ValueListParameterDisplayOnly',
                ValueListProperty: 'statusText',
            },
        ],
        CollectionPath : 'Statuses',
        SearchSupported: true,
        Label          : 'Booking Status',
    }
};

//annotate Carriers 
//Field Groups

//annotate Carriers
//Field Groups
annotate service.Carriers with @(
    UI.LineItem: [
        {
            $Type: 'UI.DataField',
            Value: airlineID,
        },
        {
            $Type: 'UI.DataField',
            Value: airlineName,
        },
        {
            $Type: 'UI.DataField',
            Value: airlineURL,
        }
    ],
    UI.FieldGroup #CarrierFieldGroup: {
        $Type: 'UI.FieldGroupType',
        Data : [
            {
                $Type: 'UI.DataField',
                Value: airlineID,
            },
            {
                $Type: 'UI.DataField',
                Value: airlineName,
            },
            {
                $Type: 'UI.DataField',
                Value: airlineURL,
            },
        ],
    },
    UI.Facets: [
        {
            $Type: 'UI.ReferenceFacet',
            Label: 'Carrier Information',
            ID: 'CarrierInfo',
            Target: '@UI.FieldGroup#CarrierFieldGroup',
        }
    ],
    UI.HeaderInfo: {
        $Type: 'UI.HeaderInfoType',
        TypeName: 'Carrier',
        Title: {
            $Type: 'UI.DataField',
            Value: airlineName
        },
        Description: {
            $Type: 'UI.DataField',
            Value: airlineID
        }
    }
);

//annotate Connections

annotate service.Customers with @(
  UI.HeaderInfo: {
    $Type: 'UI.HeaderInfoType',
    TypeName: 'Customer',
    TypeNamePlural: 'Customers',
    Title: {
      $Type: 'UI.DataField',
      Value: name
    },
    Description: {
      $Type: 'UI.DataField',
      Value: customerID
    }
  },
  UI.FieldGroup #CustomerDetails: {
    $Type: 'UI.FieldGroupType',
    Data: [
      {
        $Type: 'UI.DataField',
        Value: customerID,
        Label: 'Customer ID'
      },
      {
        $Type: 'UI.DataField',
        Value: name,
        Label: 'Name'
      },
      {
        $Type: 'UI.DataField',
        Value: address,
        Label: 'Address'
      },
      {
        $Type: 'UI.DataField',
        Value: phoneNumber,
        Label: 'Phone Number'
      },
      {
        $Type: 'UI.DataField',
        Value: email,
        Label: 'Email'
      }
    ]
  },
    UI.Facets                       : [{
        $Type : 'UI.ReferenceFacet',
        Label : 'Customer Info',
        ID    : 'CustomerInfo',
        Target: '@UI.FieldGroup#CustomerDetails',
    }, ],  
);
