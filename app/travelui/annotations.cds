using myTravelCapAppSrv as service from '../../srv/service';

annotate service.Travels with @(
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
                $Type: 'UI.DataField',
                Value: customerID_ID,
                Label: 'Customer',
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
                $Type                  : 'UI.DataField',
                Value                  : overallStatus_ID,
                ![@Common.FieldControl]: #ReadOnly,
            },
            {
                $Type : 'UI.DataFieldForAction',
                Action: 'myTravelCapAppSrv.setTravelStatusToComplete',
                Label : 'Set Complete',
                ID    : 'idSetComplete',
            },
        ],
        Label: 'Travel Overview',
    },
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
            $Type: 'UI.DataField',
            Value: customerID.name,
            Label: 'Customer',
        },
        {
            $Type                  : 'UI.DataField',
            Value                  : overallStatus.statusText,
            Label                  : 'Overall Status',
            ![@Common.FieldControl]: #ReadOnly,
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
            $Type : 'UI.DataFieldForAction',
            Action: 'myTravelCapAppSrv.setTravelStatusToComplete',
            Label : 'Set Complete',
            ID    : 'idSetComplete',
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
        ImageUrl      : 'https://cdn.pixabay.com/photo/2014/10/02/08/30/honey-bee-469560_1280.png',
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
            $Type                  : 'UI.DataField',
            Value                  : bookingStatus.statusText,
            Label                  : 'Booking Status',
            ![@Common.FieldControl]: #ReadOnly,
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
                $Type: 'UI.DataField',
                Value: airlineID_ID,
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
                $Type                  : 'UI.DataField',
                Value                  : bookingStatus_ID,
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
        Common.TextArrangement: #TextOnly
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
