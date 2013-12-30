# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

margin = { top: 20, right: 20, bottom: 20, left: 20 }

w = 960 - margin.left - margin.right
h = 500 - margin.top - margin.bottom

$ ->
  prices = gon.prices
  max_price = gon.max_price
  min_price = gon.min_price
  parseDate = d3.time.format("%Y-%m-%dT%H:%M:%S.%LZ").parse

  x = d3.time.scale().range([0, w])
  y = d3.scale.linear().range([h, 0])

  x_axis = d3.svg.axis().scale(x).orient("bottom")
  y_axis = d3.svg.axis().scale(y).ticks(4).orient("right")

  line = d3.svg.line()
    .x( (d) -> x(parseDate(d.created_at)))
    .y( (d) -> y(+d.price))

  svg = d3.select("svg")
    .attr("width", w + margin.left + margin.right)
    .attr("height", h + margin.top + margin.bottom)
    .append("g")
      .attr("transform", "translate(" + margin.left + "," + margin.top + ")")


  x.domain(d3.extent(prices, (d) -> parseDate(d.created_at)))
  y.domain(d3.extent(prices, (d) -> +d.price))

  svg.append("g")
    .attr("class", "x axis")
    .attr("transform", "translate(0, " + h + ")")
    .call(x_axis)  

  svg.append("g")
    .attr("class", "y axis")
    .call(y_axis)
    .append("text")
      .attr("transform", "rotate(-90)")
      .attr("y", 6)
      .attr("dy", ".71em")
      .style("text-anchor", "end")
      .text("Price ($)")

  svg.append("path")
    .attr("d", line(prices))
    .attr("class", "line")
    .attr("stroke", "blue")
    .attr("fill", "none")


  console.log(prices[0].created_at)