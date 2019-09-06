/**
 * Created by user on 06.09.2019.
 */

({
  doShow: function (component) {
    component.set('v.showSpinner', true);
  },
  doHide: function (component) {
    component.set('v.showSpinner', false);
  }
});