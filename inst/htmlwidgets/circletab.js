HTMLWidgets.widget({
  name: 'circletab',

  type: 'output',

  factory: function(el, width, height) {
    var instance = {};

    return {
      renderValue: function(x) {
        const container = document.getElementById(el.id)
        while (container.firstChild) {
            container.removeChild(container.firstChild);
        }
        const app = Vue.createApp({})
        app.component('circle-tab', nzhswidgets.CircleTab)
        const nps = document.createElement("circle-tab")
        nps.setAttribute(":data", x.data)
        nps.setAttribute(":max-val", x.maxVal)
        nps.setAttribute("fill-color", x.fillColor)
        nps.setAttribute("stroke-width", x.strokeWidth)
        nps.setAttribute("stroke-color", x.strokeColor)
        container.appendChild(nps)
        this.instance = app.mount(`#${el.id}`)
      },

      resize: function(width, height) {},

      instance: instance
    };
  }
});
