# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

# .on "page:change",

w = 500
h = 100
padding = 1

#dataset = [ 1, 2, 3, 4, 5 ]

$ ->
  $.ajax(url: "/api/prices/1").done (json) ->
    $("#fart").append JSON.stringify(json)
    

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
        (d) -> d.price
      )

    console.log(json[0].price)

    #rects.attr("x", 
    #  (d, i) -> i * ( w / dataset.length )
    #)
    #.attr("y", 
    #  (d) -> alert d.id  # h - d[2]
#
 #   )
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
  