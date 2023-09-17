({
	HandleClick : function(component, event, helper) {
		var btn = event.getSource();
        var msg = btn.get("v.labell");
        component.set("v.mensagem",msg);
	},
    doInit : function(component, event, helper){
    	component.set("v.mensagem","Button Click");
        component.set("v.mensagem", "button clicked");
}
})