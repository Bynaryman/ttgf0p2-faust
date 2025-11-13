module {
  faust.graph @process(inputs: 1, outputs: 1) {
    %0 = faust.real(3.000000e+00 : f32)
    %1 = faust.tanh(%0 : !faust.rconst)
    %2 = faust.input(0 : ui32)
    %3 = faust.real(3.000000e+00 : f32)
    %4 = faust.mul(%3 : !faust.rconst, %2 : !faust.real)
    %5 = faust.tanh(%4 : !faust.real)
    %6 = faust.div(%5 : !faust.real, %1 : !faust.rconst)
    faust.output(%6 : !faust.real)
  }
}
