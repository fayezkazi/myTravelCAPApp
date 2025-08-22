const cds = require('@sap/cds');

module.exports = cds.service.impl(async function () {

    const { Travels, Bookings, Statuses } = this.entities;

    //At Travel Create, set the overallStatus to '1' (New) and Copy the bookingFee to totalPrice
    this.before('CREATE', 'Travels', async (req) => {
        debugger;

        //Find the ID for the Status 1 from Statuses
        const status = await SELECT.one.from(Statuses).where({ status: '1' });
        if (status) {
            req.data.overallStatus_ID = status.ID;
        }

        req.data.totalPrice = req.data.bookingFee;

        // Handle deep insert - set booking status for any bookings created with travel
        if (req.data.booking && Array.isArray(req.data.booking)) {
            console.log('Deep insert detected - setting booking status for', req.data.booking.length, 'bookings');
            const bookingStatus = await SELECT.one.from(Statuses).where({ status: '6' });
            if (bookingStatus) {
                req.data.booking.forEach(booking => {
                    if (!booking.bookingStatus_ID) {
                        booking.bookingStatus_ID = bookingStatus.ID;
                        console.log('Set booking status in deep insert:', booking.bookingID);
                    }
                });
            }
        }
    });

    // ...existing code...

    this.before('UPDATE', 'Travels', async (req, next, results) => {
        // Get the parent Travel ID
        console.log("Travel UPDATE triggered");
        var maxBooking = 0;
        var aBookings = [];
        var sBookings = {};
        
        const travelID = req.data.ID;

        if (!travelID) {
            console.error('No Travel ID found');
            return;
        }

        // Find the max bookingID for this travel
        for (const booking of req.data.booking || []) {
            if (booking.bookingID) {
                maxBooking = booking.bookingID;
                aBookings.push(booking);
            } else {
                maxBooking = Number(maxBooking) + 1;
                sBookings = booking;
                sBookings.bookingID = maxBooking;
                aBookings.push(sBookings);
            }
        }

        if (aBookings.length > 0) {
            console.log('New bookings to be created:', aBookings);
            req.data.booking = aBookings;
        }
        return req;
    });

    // Add calculated field for button availability
    this.after('READ', 'Travels', async (results) => {
        console.log('Handling READ for Travels:', results);
        if (!Array.isArray(results)) results = [results];

        for (let travel of results) {
            if (travel) {
                if (travel.overallStatus) {
                    // Get status details
                    const status = await SELECT.one.from(Statuses).where({ ID: travel.overallStatus.ID });
                    // Set canSetComplete to true only for status 1 or 2
                    debugger;
                    travel.canSetComplete = status && (status.status === '1' || status.status === '2');
                    travel.isUpdatable = status && status.status == '4'; // Disable edit/delete for status '4'
                    console.log(travel.canSetComplete, 'Status:', status, 'Travel:', travel.travelID);

                    // Set criticality for status highlighting
                    if (status) {
                        switch (status.status) {
                            case '1': // New
                                travel.criticality = 0; // Grey
                                break;
                            case '3': // Confirmed
                                travel.criticality = 3; // Green
                                break;
                            case '4': // Completed
                                travel.criticality = 3; // Green
                                break;    
                            case '5': // Canceled
                                travel.criticality = 1; // Red
                                break;                                                             
                            default:
                                travel.criticality = 0; // Neutral
                                break;
                        }
                    }
                }
            }
        }
    });

    // set flag Booking canBookingStatusChange
    this.after('READ', 'Bookings', async (results) => {
        console.log('Handling READ for Bookings:', results);
        if (!Array.isArray(results)) results = [results];

        for (let booking of results) {
            if (booking) {
                if (booking.bookingStatus) {
                    // Get status details
                    const status = await SELECT.one.from(Statuses).where({ ID: booking.bookingStatus.ID });
                    // Set canBookingStatusChange to true only for status is 6
                    booking.canBookingStatusChange = status && (status.status === '6');
                    console.log(booking.canBookingStatusChange, 'Status:', status, 'Booking:', booking.bookingID);

                   if (status) {
                        switch (status.status) {
                            case '1': // New
                                booking.criticality = 0; // Grey
                                break;
                            case '3': // Confirmed
                                booking.criticality = 3; // Green
                                break;
                            case '4': // Completed
                                booking.criticality = 3; // Green
                                break;    
                            case '5': // Canceled
                                booking.criticality = 1; // Red
                                break;                                                             
                            default:
                                booking.criticality = 0; // Neutral
                                break;
                        }
                    }                    
                }
            }
        }
    });

    // Action handler for setTravelStatusToComplete
    this.on('setTravelStatusToComplete', async (req) => {

        debugger;
        const travelKey = req.params[0].ID;

        try {
            console.log('Updating travel with ID:', travelKey);

            // Check if travel exists first
            const travel = await SELECT.one.from(Travels).where({ ID: travelKey });

            if (!travel) {
                req.error(404, `Travel with ID ${travelKey} not found`);
                return;
            }

            console.log('Found travel:', travel.travelID, 'Current Status:', travel.overallStatus_ID);

            //Now find the Status Code and Status Text
            const travelStatus = await SELECT.one.from(Statuses).where({ ID: travel.overallStatus_ID });

            if (!travelStatus) {
                req.error(404, `Status with ID ${travel.overallStatus_ID} not found`);
                return;
            }

            console.log('Current status details:', travelStatus);

            // Check if the travel is in a valid status to be set to Complete
            if (travelStatus.status !== '1' && travelStatus.status !== '2') {
                req.error(400, `Travel cannot be set to Complete. Current status: ${travelStatus.statusText} (${travelStatus.status})`);
                return;
            }

            // Find the "Complete" status (status code '4')
            const completeStatus = await SELECT.one.from(Statuses).where({ status: '4' });

            if (!completeStatus) {
                req.error(500, 'Complete status not found in system');
                return;
            }

            // Update the status to Complete
            const result = await UPDATE(Travels)
                .set({ overallStatus_ID: completeStatus.ID })
                .where({ ID: travelKey });

            console.log('Update result:', result);

            if (result === 0) {
                req.error(500, 'Failed to update travel status');
                return;
            }

            req.info('Travel status updated to Complete');

            // Return the updated travel
            const updatedTravel = await SELECT.one.from(Travels).where({ ID: travelKey });
            console.log('Updated travel:', updatedTravel);

            return updatedTravel;

        } catch (error) {
            console.error('Error updating travel status:', error);
            req.error(500, `Error updating travel status: ${error.message}`);
        }
    });

    this.on('setBookingStatusConfirm', async (req) => {
        debugger;
        try {


            // get the Booking Key
            const bookingKey = req.params[1].ID;

            // Retrieve the Booking entity based on the Key
            const booking = await SELECT.one.from(Bookings).where({ ID: bookingKey });

            // Check if the Booking exists
            if (!booking) {
                req.error(404, `Booking with ID ${bookingKey} not found`);
                return;
            }

            // Find the Booking status
            const bookingStatus = await SELECT.one.from(Statuses).where({ ID: booking.bookingStatus_ID });
            // Check if the Booking status is valid
            if (!bookingStatus) {
                req.error(404, `Status with ID ${booking.bookingStatus_ID} not found`);
                return;
            }

            // Check if the Booking status is Pending, then only go for update
            if (bookingStatus.status !== '6') {
                req.error(400, `Booking cannot be updated. Current status: ${bookingStatus.statusText} (${bookingStatus.status})`);
                return;
            }

            //Now find the "Confirmed" status (status code '3')
            const confirmedStatus = await SELECT.one.from(Statuses).where({ status: '3' });

            if (!confirmedStatus) {
                req.error(500, 'Confirmed status not found in system');
                return;
            }

            // Update the Booking status
            const result = await UPDATE(Bookings)
                .set({ bookingStatus_ID: confirmedStatus.ID })
                .where({ ID: bookingKey });

            if (result === 0) {
                req.error(500, 'Failed to update booking status');
                return;
            }

            req.info('Booking status updated successfully');

            // Once the confirmed status is set, then update Travels Total Price
            const travel = await SELECT.one.from(Travels).where({ ID: booking.travels_ID });
            if (travel) {
                const result = await SELECT`sum(flightPrice) as totalPrice`.from(Bookings).where({ travels_ID: travel.ID, bookingStatus_ID: confirmedStatus.ID });
                var totalPrice = result[0]?.totalPrice || 0;
                totalPrice += travel.bookingFee;
                await UPDATE(Travels)
                    .set({ totalPrice: totalPrice })
                    .where({ ID: travel.ID });
            }

            // Return the updated booking with expanded travel info
            const updatedBooking = await SELECT.one.from(Bookings, booking => {
                booking`*`,
                    booking.travels(travel => travel`*`)
            }).where({ ID: bookingKey });

            //set flag canBookingStatusChange
            updatedBooking.canBookingStatusChange = false;
            console.log('Updated booking:', updatedBooking);

            return updatedBooking;
        } catch (error) {
            console.error('Error confirming booking status:', error);
            req.error(500, `Error confirming booking status: ${error.message}`);
        }

    });

    //Booking Cancellation
    this.on('setBookingStatusCancel', async (req) => {
        try {
            // get the Booking Key
            const bookingKey = req.params[1].ID;

            // Retrieve the Booking entity based on the Key
            const booking = await SELECT.one.from(Bookings).where({ ID: bookingKey });

            // Check if the Booking exists
            if (!booking) {
                req.error(404, `Booking with ID ${bookingKey} not found`);
                return;
            }

            // Find the Booking status
            const bookingStatus = await SELECT.one.from(Statuses).where({ ID: booking.bookingStatus_ID });

            // Check if the Booking status is valid
            if (!bookingStatus) {
                req.error(404, `Status with ID ${booking.bookingStatus_ID} not found`);
                return;
            }

            // Check if the Booking status is Pending, then only go for update
            if (bookingStatus.status !== '6') {
                req.error(400, `Booking cannot be updated. Current status: ${bookingStatus.statusText} (${bookingStatus.status})`);
                return;
            }

            //Now find the "Cancelled" status (status code '5')
            const cancelledStatus = await SELECT.one.from(Statuses).where({ status: '5' });

            if (!cancelledStatus) {
                req.error(500, 'Cancelled status not found in system');
                return;
            }

            // Update the Booking status
            const result = await UPDATE(Bookings)
                .set({ bookingStatus_ID: cancelledStatus.ID })
                .where({ ID: bookingKey });

            if (result === 0) {
                req.error(500, 'Failed to update booking status');
                return;
            }

            req.info('Booking status updated to Cancelled');

            //find the "Confirmed" status (status code '3')
            const confirmedStatus = await SELECT.one.from(Statuses).where({ status: '3' });

            // Once the cancelled status is set, then update Travels Total Price where status is Confirmed only
            const travel = await SELECT.one.from(Travels).where({ ID: booking.travels_ID });
            if (travel) {
                const result = await SELECT`sum(flightPrice) as totalPrice`.from(Bookings).where({ travels_ID: travel.ID, bookingStatus_ID: confirmedStatus.ID });
                var totalPrice = result[0]?.totalPrice || 0;
                totalPrice += travel.bookingFee;
                await UPDATE(Travels)
                    .set({ totalPrice: totalPrice })
                    .where({ ID: travel.ID });
            }

            // Return the updated booking with expanded travel info
            const updatedBooking = await SELECT.one.from(Bookings, booking => {
                booking`*`,
                    booking.travels(travel => travel`*`)
            }).where({ ID: bookingKey });

            //set flag canBookingStatusChange
            updatedBooking.canBookingStatusChange = false;
            console.log('Updated booking:', updatedBooking);

            return updatedBooking;
        } catch (error) {
            console.error('Error cancelling booking status:', error);
            req.error(500, `Error cancelling booking status: ${error.message}`);
        }

    });

    // Action handler for setBookingDefaults
    this.on('setBookingDefaults', async (req) => {

        // Set booking status to '6' (Pending)
        const status = await SELECT.one.from(this.entities.Statuses).where({ status: '6' });

        return {
            bookingStatus_ID: status ? status.ID : null,
            bookingDate: new Date().toISOString().split('T')[0],
            currencyCode: 'USD'
        };
    });

});