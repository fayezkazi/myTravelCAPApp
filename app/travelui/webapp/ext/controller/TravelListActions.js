sap.ui.define([
    "sap/m/MessageToast"
], function(MessageToast) {
    'use strict';

    return {
        // This controller extension is no longer needed
        // The action is now handled server-side via CAP action handler
        
        /* Original approach - commented out
        setTravelStatus: function(oEvent) {
            MessageToast.show("Custom handler invoked.");
            
            debugger;

            //Get the button context
            var oButton = oEvent.getSource();
            var oContext = oButton.getBindingContext();
            
            //Get the Model from the Context
            var oModel = oContext.getModel();
            var sPath = oContext.getPath();

            //Set the Travel Status Complete
            oModel.setProperty(sPath + "/overallStatus_ID", "4");
            
            MessageToast.show("Travel status set to Complete!");
        }
        */
    };
});
