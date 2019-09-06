/**
 * Created by user on 05.09.2019.
 */

({
  doInit: function(component, event, helper) {
    let action = component.get('c.getInitData');
    action.setCallback(this, function(response) {
      if (response.getState() === 'SUCCESS' ) {
        let initData = response.getReturnValue();
        component.set('v.pagination', initData.pagination);
        component.set('v.filter', initData.filter);
        component.set('v.pageRows', initData.pageRows);
        component.set('v.initialized', true);
      }
    });
    $A.enqueueAction(action);
  },
  updateTable: function(component, event, helper) {
    alert('Update table action');
  }

});