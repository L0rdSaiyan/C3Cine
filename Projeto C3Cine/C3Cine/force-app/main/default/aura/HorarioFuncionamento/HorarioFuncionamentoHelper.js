({
    helperMethod: function (component, event, helper) {
        var action = component.get("c.retornarHorarioFuncionamento");
        action.setCallback(this, function (response) {
            if (response.getState() === "SUCCESS") {
                var result = response.getReturnValue();
                component.set("v.funcionando", result);
            }
        });
        $A.enqueueAction(action);
    }
})