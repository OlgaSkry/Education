/**
 * Created by user on 09.09.2019.
 */

({
  processChanges: function(component, event, helper) {
    component.getEvent('onchange').fire();
  }
});