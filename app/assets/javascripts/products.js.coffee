# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

# .on "page:change",

w = 500
h = 50

dataset = [ 2, 5, 9, 1, 15 ]

$ ->
  svg = d3.select("svg")
  svg.attr("width", w)
     .attr("height", h)

  circles = svg.selectAll("circle")
    .data(dataset)
    .enter()
    .append("circle")

  circles.attr("cx", 
    (d, i) -> (i * 50) + 25
  ).attr("cy", h/2)
  .attr("r", 
    (d) -> d
  )