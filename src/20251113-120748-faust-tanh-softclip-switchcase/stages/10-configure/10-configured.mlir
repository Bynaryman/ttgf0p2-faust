module {
  func.func @process(%arg0: !fixed_pt_arith.fixedpt<0, -7, signed> {r_arith.input_domain = [-1.000000e+00, 1.000000e+00]}) -> !fixed_pt_arith.fixedpt<0, -7, signed> {
    %0 = r_arith.constant(3.000000e+00 : f32)
    %1 = r_arith.constant(0.14112000805986721 : f64)
    %2 = r_arith.constant(3.000000e+00 : f32)
    %3 = r_arith.mul(%2 : !r_arith.r_const, %arg0 : !fixed_pt_arith.fixedpt<0, -7, signed>)
    %4 = r_arith.tanh(%3 : !r_arith.r_expr)
    %5 = r_arith.div(%4 : !r_arith.r_expr, %1 : !r_arith.r_const)
    %6 = r_arith.constant(8388607 : i64)
    %7 = r_arith.mul(%5 : !r_arith.r_expr, %6 : !r_arith.r_const)
    %8 = r_arith.machine_repr of %7 : !r_arith.r_expr as !fixed_pt_arith.fixedpt<0, -7, signed>
    return %8 : !fixed_pt_arith.fixedpt<0, -7, signed>
  }
}

