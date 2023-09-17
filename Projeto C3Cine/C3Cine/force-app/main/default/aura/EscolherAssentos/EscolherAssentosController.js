({
    seatHover: function(component, event, helper) {
        // Use component.find para obter a referência ao elemento com aura:id
        var oppLineItem = event.getSource().get("v.aura:id");
        var cadeira = component.find(oppLineItem);

        // Faça o que você quiser com o elemento "cadeira" aqui
        // Por exemplo, você pode adicionar uma classe CSS ao elemento:
        $A.util.addClass(cadeira, "classeCSS");
    }
})