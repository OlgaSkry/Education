/**
 * Created by user on 06.09.2019.
 */

({
  doPrevious: function(component, event, helper) {
    var pagination = component.get('v.pagination')
    if (pagination.currentPage > 1) pagination.currentPage -= 1;
    component.set('v.pagination', pagination);
    component.getEvent('onchange').fire();
  },

  doNext: function(component, event, helper) {
    var pagination = component.get('v.pagination')
    if (pagination.currentPage < pagination.pagesCount) pagination.currentPage += 1;
    component.set('v.pagination', pagination);
    component.getEvent('onchange').fire();
  }
});