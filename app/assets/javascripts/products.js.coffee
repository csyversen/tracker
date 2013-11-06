# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/


w = 800
h = 500
padding = 30

$ ->
  json = gon.prices
  svg = d3.select("svg")
  svg.attr("width", w)
     .attr("height", h)


  y_scale = d3.scale.linear()
  y_scale.domain( [gon.min_price, gon.max_price] )
  y_scale.range( [h - padding, padding] ) # smaller prices will appear at the bottom 

  x_scale = d3.scale.linear()
  x_scale.domain( [0, json.length] )
  x_scale.range( [padding, w - padding] )

  x_axis = d3.svg.axis()
  x_axis.scale(x_scale)
  x_axis.orient("bottom")

  y_axis = d3.svg.axis()
    .scale(y_scale)
    .orient("left")


  svg.append("g")
    .attr("class", "axis")
    .attr("transform", "translate(0, " + (h - padding) + ")")
    .call(x_axis)

  svg.append("g")
    .attr("class", "axis")
    .attr("transform", "translate(" + padding + ", 0)")
    .call(y_axis)

  circ = svg.selectAll("circle")
    .data( json )
    .enter()
    .append("circle")
    
  circAttr = circ
    .attr("cx",
      (d, i) -> x_scale(i)     #i * ( w / json.length )
    )
    .attr("cy",
      (d) -> y_scale(d.price)
    )
    .attr("r", 5)

  svg.selectAll("text")
    .data( json )
    .enter()
    .append("text")
    .text( (d) -> 
      "$" + d.price
    )
    .attr("x", (d, i) -> x_scale(i))
    .attr("y", (d) -> y_scale(d.price))
    .attr("font-family", "sans-serif")
    .attr("font-size", "11px") 

  console.log(json[0].price)

  