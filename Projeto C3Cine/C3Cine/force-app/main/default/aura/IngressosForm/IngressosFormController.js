({
    navigate: function (component, event, helper) {
        event.preventDefault();

        var cadeiraSelecionada = component.get("v.cadeiraSelecionada");
        const fields = event.getParam("fields");
        var valorDoAssento = fields.Valor_do_Ingresso__c;
        var nomeDaSala = fields.Sala__c;
        component.set("v.valorAssento", valorDoAssento);
        fields.teste_assento__c = cadeiraSelecionada;

        var action = component.get("c.validarAssentoDisponivelParaSala");
        action.setParams({ nomeAssento: cadeiraSelecionada, nomeSala: nomeDaSala });
        action.setCallback(this, function (response) {
            var result = response.getReturnValue();
            if (response.getState() === "SUCCESS") {
                if (result === true) {
                    var toastEvent = $A.get("e.force:showToast");
                    // Dispare o evento do toast
                    toastEvent.setParams({
                        "title": "Não foi possível criar o assento.",
                        "message": "Já existe um assento reservado para a mesma sala.",
                        "type": "error"
                    });
                    toastEvent.fire();
                } else {
                    component.find("myRecordForm").submit(fields);
                }
            } else {
                // Trate os erros de forma adequada
                var toastEvent = $A.get("e.force:showToast");
                toastEvent.setParams({
                    "title": "Erro na chamada do servidor.",
                    "message": "Ocorreu um erro ao validar o assento.",
                    "type": "error"
                });
                toastEvent.fire();
            }
        });

        $A.enqueueAction(action);
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
              "title": "Error",
              "message": "a classe apex de criação de registro não funcionou."+result,
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

  
  validaCadeira: function (component, event, helper) {
    var action = component.get("c.selecionarTodosAssentos");
    action.setCallback(this, function (response) {
        if (response.getState() === "SUCCESS") {
            var result = response.getReturnValue();

            result.forEach(function (nomeAssento) {

                var elements = document.getElementsByClassName("custom-box");

                for (var i = 0; i < elements.length; i++) {
                    var element = elements[i];


                    var dataId = element.getAttribute('data-id');

                    if (dataId == nomeAssento) {

                        var isOccupied = $A.util.hasClass(element, "assentoOcupado");

                        if (!isOccupied) {
                            $A.util.addClass(element, "assentoOcupado");
                            $A.util.removeClass(element, "custom-box")
                        } else {

                            $A.util.removeClass(element, "assentoOcupado");
                            $A.util.addClass(element, "custom-box");

                        }

                    
                    }
                }
            });
        }
    });
    $A.enqueueAction(action);
}



})