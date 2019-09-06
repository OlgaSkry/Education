/**
 * Created by user on 05.09.2019.
 */

({
  doInit: function(component, event, helper) {
    component.set('v.filter', {
      status: '',
      studyTitleTerm: ''
    });
    component.set('v.pagination', {
      currentPage: 1,
      pagesCount: 10
    })
  },
  updateTable: function(component, event, helper) {
    alert('Update table action');
  }
});