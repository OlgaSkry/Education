/**
 * Created by user on 05.09.2019.
 */

({
  processChanges: function(component, event, helper) {
    component.getEvent('onchange').fire();
  }
});