sap.ui.require(
    [
        'sap/fe/test/JourneyRunner',
        'td/travelui/test/integration/FirstJourney',
		'td/travelui/test/integration/pages/TravelsList',
		'td/travelui/test/integration/pages/TravelsObjectPage',
		'td/travelui/test/integration/pages/BookingsObjectPage'
    ],
    function(JourneyRunner, opaJourney, TravelsList, TravelsObjectPage, BookingsObjectPage) {
        'use strict';
        var JourneyRunner = new JourneyRunner({
            // start index.html in web folder
            launchUrl: sap.ui.require.toUrl('td/travelui') + '/index.html'
        });

       
        JourneyRunner.run(
            {
                pages: { 
					onTheTravelsList: TravelsList,
					onTheTravelsObjectPage: TravelsObjectPage,
					onTheBookingsObjectPage: BookingsObjectPage
                }
            },
            opaJourney.run
        );
    }
);