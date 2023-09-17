({
  navigate: function (component, event, helper) {
      event.preventDefault();

      var cadeiraSelecionada = component.get("v.cadeiraSelecionada");
      const fields = event.getParam("fields");
      var valorDoAssento = fields.Valor_do_Ingresso__c;
      component.set("v.valorAssento",valorDoAssento)
      fields.teste_assento__c = cadeiraSelecionada; // Defina o campo com o valor calculado

      // Submeta o formulário
      component.find("myRecordForm").submit(fields);
     

  },

  criarNovoAssento : function(component,event,helper){
    var recordId = event.getParam("id")
    


    var cadeiraSelecionada = component.get("v.cadeiraSelecionada");
    var action = component.get("c.criarAssento");
    action.setParams({ name: cadeiraSelecionada, id: recordId});
    action.setCallback(this, function(response) {
        var result = response.getReturnValue();

        if (response.getState() === "SUCCESS") {
           
          var toastEvent = $A.get("e.force:showToast");
              // Dispare o evento do toast
              toastEvent.setParams({
                  "title": "Sucesso!!",
                  "message": "Assento criado! ingresso: "+recordId,
                  "type": "success"
              });
              toastEvent.fire();
          

        }else{

               
          var toastEvent = $A.get("e.force:showToast");
          // Dispare o evento do toast
          toastEvent.setParams({
              "title": "deu merda!!",
              "message": "cagou o codigo"+result,
              "type": "success"
          });
          toastEvent.fire();

        }
    });

    var urlEvent = $A.get("e.force:navigateToURL");
    urlEvent.setParams({
        url: "/lightning/r/ingressos__c/"+recordId+"/view"
    });
    urlEvent.fire();

    $A.enqueueAction(action);

  },

  setCadeira: function (component, event, helper) {
      var clickedElement = event.currentTarget;
      var index = clickedElement.getAttribute('data-index');
      var listName = clickedElement.getAttribute('data-list');
      var list = component.get("v." + listName);
      var oppLineItemValue = list[index];

      // Atualize o atributo relacionado à lista com base no índice
      component.set("v.cadeiraSelecionada", oppLineItemValue);

      var aoba = component.get("v.cadeiraSelecionada")

      var toastEvent = $A.get("e.force:showToast");
      if (toastEvent) {
          // Dispare o evento do toast
          toastEvent.setParams({
              "title": "Sucesso!!",
              "message": "Cadeira selecionada: " + oppLineItemValue,
              "type": "success"
          });
          toastEvent.fire();
      }
  },

  cancelForm: function (component, event, helper) {
      var urlEvent = $A.get("e.force:navigateToURL");
      urlEvent.setParams({
          url: "/lightning/o/ingressos__c/list?filterName=00B8b00000L0PeHEAV"
      });
      urlEvent.fire();
  },
});
