({
    doInit: function (component, event, helper) {

        //Chama o método de saudação
        var action = component.get("c.greetings");
        action.setCallback(this, function (response) {
            var state = response.getState();
            if (state === "SUCCESS") {
                component.set("v.mensagem", response.getReturnValue());
            }
        });

        //Chama o método que verifica o horário atual
        var action2 = component.get("c.getTime");
        action2.setCallback(this, function (response2) { 
            var state2 = response2.getState();
            if (state2 === "SUCCESS") { 
                component.set("v.tempo", response2.getReturnValue()); 
            }
        });

        $A.enqueueAction(action);
        $A.enqueueAction(action2);

    }
})