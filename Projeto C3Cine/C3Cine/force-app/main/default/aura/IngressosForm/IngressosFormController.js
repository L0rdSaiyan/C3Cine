({
    navigate: function (component, event, helper) {
       helper.enviarFormulario(component,event)
    },

  criarNovoAssento : function(component,event,helper){
   helper.criarAssento(component,event)

  },

  setCadeira: function (component, event, helper) {
    helper.validarCadeira(component,event)
  },

  cancelForm: function (component, event, helper) {
    helper.redirecionarParaListaDeExibicao();
  },

  
  validaCadeira: function (component, event, helper) {
    helper.buscarERenderizarCadeirasOcupadas(component)

}



})