# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/


w = 500
h = 100
padding = 1


$ ->
  json = gon.prices
  svg = d3.select("svg")
  svg.attr("width", w)
     .attr("height", h)

  rects = svg.selectAll("rect")
    .data( json )
    .enter()
    .append("rect")
    
  rectAttr = rects
    .attr("x",
      (d, i) -> i * ( w / json.length )
    )
    .attr("y",
      (d) -> h - d.price
    )
    .attr("width", w / json.length - padding)
    .attr("height", 
      (d) -> d.price
    )

  console.log(json[0].price)

  