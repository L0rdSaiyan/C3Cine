({
    setGame : function(component, event, helper) {
        var clickedElement = event.currentTarget;
        var gameValue = clickedElement.getAttribute('data-value');

        component.set("v.clicado", gameValue);
    }
})