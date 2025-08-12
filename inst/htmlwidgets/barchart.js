HTMLWidgets.widget({
  name: 'barchart',

  type: 'output',

  factory: function(el, width, height) {
    const container = document.getElementById(el.id)

    const app = Vue.createApp({})
    app.component('bar-chart', nzhswidgets.BarChart)

    const nps = document.createElement("bar-chart")
    container.appendChild(nps)

    return {
      renderValue: function(x) {
        nps.setAttribute(":series", x.series)
        nps.setAttribute(":categories", x.categories)
        if (x.title) nps.setAttribute("title", x.title)
        if (x.magnitude) nps.setAttribute(":magnitude", x.magnitude)
        if (x.xlab) nps.setAttribute("xlab", x.xlab)
        if (x.ylab) nps.setAttribute("ylab", y.xlab)
        if (x.sourceDescription) nps.setAttribute("source-description", x.sourceDescription)
        if (x.sourceUrl) nps.setAttribute("source-url", x.sourceUrl)
        if (x.height) nps.setAttribute(":height", x.height)
        if (x.width) nps.setAttribute(":width", x.width)
        if (x.palette) nps.setAttribute(":palette", x.palette)
        if (x.patterns) nps.setAttribute(":patterns", x.patterns)
        
        app.mount(`#${el.id}`)
      },

      resize: function(width, height) {},

      app: app
    };
  }
});
