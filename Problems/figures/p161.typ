#import "@preview/cetz:0.2.2"


#cetz.canvas(length: 10pt, {
  import cetz.draw: *

  line(
    stroke: black, fill: green, close: true,
    (0, 1), (8, 1), (8, 0), (10, 0), (10, 3), (6, 3), (6, 8), (0, 8)
  )
})
