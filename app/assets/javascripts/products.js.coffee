# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/


w = 800
h = 500
padding = 20

$ ->
  json = gon.prices
  svg = d3.select("svg")
  svg.attr("width", w)
     .attr("height", h)

  scale = d3.scale.linear()
  scale.domain([gon.min_price, gon.max_price])
  scale.range([0, h])


  rects = svg.selectAll("circle")
    .data( json )
    .enter()
    .append("circle")
    
  rectAttr = rects
    .attr("cx",
      (d, i) -> i * ( w / json.length )
    )
    .attr("cy",
      (d) -> scale(d.price)
    )
    .attr("r", 5)
    #.attr("width", w / json.length - padding)
    #.attr("height", 
    #  (d) -> d.price
    #)

  console.log(json[0].price)

  