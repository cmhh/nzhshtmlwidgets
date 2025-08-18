HTMLWidgets.widget({
  name: 'linechart',

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
        app.component('line-chart', nzhswidgets.LineChart)
        const nps = document.createElement("line-chart")
        nps.setAttribute(":x", x.x)
        nps.setAttribute(":y", x.y)
        if (x.title) nps.setAttribute("title", x.title)
        if (x.magnitude) nps.setAttribute(":magnitude", x.magnitude)
        if (x.xlab) nps.setAttribute("xlab", x.xlab)
        if (x.ylab) nps.setAttribute("ylab", x.ylab)
        if (x.sourceDescription) nps.setAttribute("source-description", x.sourceDescription)
        if (x.sourceUrl) nps.setAttribute("source-url", x.sourceUrl)
        if (x.height) nps.setAttribute(":height", x.height)
        if (x.width) nps.setAttribute(":width", x.width)
        if (x.palette) nps.setAttribute(":palette", x.palette)
        if (x.linetype) nps.setAttribute(":linetype", x.linetype)
        container.appendChild(nps)
        this.instance = app.mount(`#${el.id}`)
      },

      resize: function(width, height) {},

      instance: instance
    };
  }
});
