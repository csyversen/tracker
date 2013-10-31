# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

# .on "page:change",

w = 500
h = 100
padding = 1

#dataset = [ 1, 2, 3, 4, 5 ]

$ ->
  $.ajax(url: "/api/prices/1").done (html) ->
    $("#fart").append JSON.stringify(html)
    dataset = JSON.stringify(html)


    svg = d3.select("svg")
    svg.attr("width", w)
       .attr("height", h)

    rects = svg.selectAll("rect")
      .data(dataset)
      .enter()
      .append("rect")

    rects.attr("x", 
      (d, i) -> i * ( w / dataset.length )
    )
    .attr("y", 
      (d) -> alert d[2]  # h - d[2]

    )
    #.attr("width", w / dataset.length - padding)
    #.attr("height", 
    #  (d) -> d[2] * 4
    #)
    #.text((d) -> d[3])
    #.attr("x", 
    #  (d, i) -> i * (w / dataset.length) 
    #).attr("y", (d) -> 
    #  h - (d * 4)
    #)
  