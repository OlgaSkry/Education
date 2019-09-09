/**
 * Created by user on 05.09.2019.
 */

({
  doInit: function(component, event, helper) {
    let action = component.get("c.getInitData");
    action.setCallback(this, function(response) {
      if (response.getState() === "SUCCESS") {
        let initData = response.getReturnValue();
        component.set("v.pagination", initData.pagination);
        component.set("v.filter", initData.filter);
        component.set("v.pageRows", initData.pageRows);
        component.set("v.initialized", true);
      }
    });
    $A.enqueueAction(action);
  },

  doSearch: function(component, event, helper) {
    debugger;
    component.find('spinner').show();
    let action = component.get("c.search");
    action.setParams({
      filter: JSON.stringify(component.get("v.filter")),
      pagination: JSON.stringify(component.get("v.pagination"))
    });
    let currentTerm = component.get('v.filter.accName');
    action.setCallback(this, function(response) {
      if (response.getState() === "SUCCESS") {
        let searchResponce = response.getReturnValue();
        if (component.get("v.filter.accName") === currentTerm) {
          component.set("v.pagination", searchResponce.paginationData);
          component.set("v.pageRows", searchResponce.pageRecords);
          component.find('spinner').hide();
        }

      }
    });
    $A.enqueueAction(action);
  }

});