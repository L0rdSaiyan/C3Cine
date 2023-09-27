({
    doInit: function(component, event, helper) {
        var action = component.get("c.getProductNames");
        action.setCallback(this, function(response) {
            var state = response.getState();
            if (state === "SUCCESS") {
                component.set("v.products", response.getReturnValue());
            }
        });
        $A.enqueueAction(action);
    }
})