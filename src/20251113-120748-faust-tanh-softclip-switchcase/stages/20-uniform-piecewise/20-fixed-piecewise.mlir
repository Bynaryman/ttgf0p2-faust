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
    %8 = fixed_pt_arith.extract <0, -2, signed> from %arg0 : <0, -7, signed>
    %9 = fixed_pt_arith.get_int from %8 : <0, -2, signed>
    %10 = arith.index_cast %9 : i3 to index
    %11:11 = scf.index_switch %10 -> !fixed_pt_arith.fixedpt<26, -9, signed>, !fixed_pt_arith.fixedpt<24, -9, signed>, !fixed_pt_arith.fixedpt<20, -9, signed>, !fixed_pt_arith.fixedpt<17, -9, signed>, !fixed_pt_arith.fixedpt<14, -9, signed>, !fixed_pt_arith.fixedpt<11, -9, signed>, !fixed_pt_arith.fixedpt<8, -9, signed>, !fixed_pt_arith.fixedpt<4, -9, signed>, !fixed_pt_arith.fixedpt<2, -9, signed>, !fixed_pt_arith.fixedpt<-2, -9, signed>, !fixed_pt_arith.fixedpt<-2, -9, signed> 
    case 0 {
      %74 = fixed_pt_arith.const <5640589127, !fixed_pt_arith.fixedpt<26, -9, signed>>
      %75 = fixed_pt_arith.const <5510525043, !fixed_pt_arith.fixedpt<24, -9, signed>>
      %76 = fixed_pt_arith.const <-191490613, !fixed_pt_arith.fixedpt<20, -9, signed>>
      %77 = fixed_pt_arith.const <-57922167, !fixed_pt_arith.fixedpt<17, -9, signed>>
      %78 = fixed_pt_arith.const <4256867, !fixed_pt_arith.fixedpt<14, -9, signed>>
      %79 = fixed_pt_arith.const <682179, !fixed_pt_arith.fixedpt<11, -9, signed>>
      %80 = fixed_pt_arith.const <-78970, !fixed_pt_arith.fixedpt<8, -9, signed>>
      %81 = fixed_pt_arith.const <-7314, !fixed_pt_arith.fixedpt<4, -9, signed>>
      %82 = fixed_pt_arith.const <1454, !fixed_pt_arith.fixedpt<2, -9, signed>>
      %83 = fixed_pt_arith.const <46, !fixed_pt_arith.fixedpt<-2, -9, signed>>
      %84 = fixed_pt_arith.const <-78, !fixed_pt_arith.fixedpt<-2, -9, signed>>
      scf.yield %74, %75, %76, %77, %78, %79, %80, %81, %82, %83, %84 : !fixed_pt_arith.fixedpt<26, -9, signed>, !fixed_pt_arith.fixedpt<24, -9, signed>, !fixed_pt_arith.fixedpt<20, -9, signed>, !fixed_pt_arith.fixedpt<17, -9, signed>, !fixed_pt_arith.fixedpt<14, -9, signed>, !fixed_pt_arith.fixedpt<11, -9, signed>, !fixed_pt_arith.fixedpt<8, -9, signed>, !fixed_pt_arith.fixedpt<4, -9, signed>, !fixed_pt_arith.fixedpt<2, -9, signed>, !fixed_pt_arith.fixedpt<-2, -9, signed>, !fixed_pt_arith.fixedpt<-2, -9, signed>
    }
    case 1 {
      %74 = fixed_pt_arith.const <15516601493, !fixed_pt_arith.fixedpt<26, -9, signed>>
      %75 = fixed_pt_arith.const <4223255025, !fixed_pt_arith.fixedpt<24, -9, signed>>
      %76 = fixed_pt_arith.const <-403714128, !fixed_pt_arith.fixedpt<20, -9, signed>>
      %77 = fixed_pt_arith.const <-10898984, !fixed_pt_arith.fixedpt<17, -9, signed>>
      %78 = fixed_pt_arith.const <5772921, !fixed_pt_arith.fixedpt<14, -9, signed>>
      %79 = fixed_pt_arith.const <-308104, !fixed_pt_arith.fixedpt<11, -9, signed>>
      %80 = fixed_pt_arith.const <-49374, !fixed_pt_arith.fixedpt<8, -9, signed>>
      %81 = fixed_pt_arith.const <7594, !fixed_pt_arith.fixedpt<4, -9, signed>>
      %82 = fixed_pt_arith.const <157, !fixed_pt_arith.fixedpt<2, -9, signed>>
      %83 = fixed_pt_arith.const <-79, !fixed_pt_arith.fixedpt<-2, -9, signed>>
      %84 = fixed_pt_arith.const <-43, !fixed_pt_arith.fixedpt<-2, -9, signed>>
      scf.yield %74, %75, %76, %77, %78, %79, %80, %81, %82, %83, %84 : !fixed_pt_arith.fixedpt<26, -9, signed>, !fixed_pt_arith.fixedpt<24, -9, signed>, !fixed_pt_arith.fixedpt<20, -9, signed>, !fixed_pt_arith.fixedpt<17, -9, signed>, !fixed_pt_arith.fixedpt<14, -9, signed>, !fixed_pt_arith.fixedpt<11, -9, signed>, !fixed_pt_arith.fixedpt<8, -9, signed>, !fixed_pt_arith.fixedpt<4, -9, signed>, !fixed_pt_arith.fixedpt<2, -9, signed>, !fixed_pt_arith.fixedpt<-2, -9, signed>, !fixed_pt_arith.fixedpt<-2, -9, signed>
    }
    case 2 {
      %74 = fixed_pt_arith.const <22341360500, !fixed_pt_arith.fixedpt<26, -9, signed>>
      %75 = fixed_pt_arith.const <2631506039, !fixed_pt_arith.fixedpt<24, -9, signed>>
      %76 = fixed_pt_arith.const <-362196303, !fixed_pt_arith.fixedpt<20, -9, signed>>
      %77 = fixed_pt_arith.const <19014169, !fixed_pt_arith.fixedpt<17, -9, signed>>
      %78 = fixed_pt_arith.const <1627380, !fixed_pt_arith.fixedpt<14, -9, signed>>
      %79 = fixed_pt_arith.const <-374569, !fixed_pt_arith.fixedpt<11, -9, signed>>
      %80 = fixed_pt_arith.const <22615, !fixed_pt_arith.fixedpt<8, -9, signed>>
      %81 = fixed_pt_arith.const <1614, !fixed_pt_arith.fixedpt<4, -9, signed>>
      %82 = fixed_pt_arith.const <-503, !fixed_pt_arith.fixedpt<2, -9, signed>>
      %83 = fixed_pt_arith.const <2, !fixed_pt_arith.fixedpt<-2, -9, signed>>
      %84 = fixed_pt_arith.const <45, !fixed_pt_arith.fixedpt<-2, -9, signed>>
      scf.yield %74, %75, %76, %77, %78, %79, %80, %81, %82, %83, %84 : !fixed_pt_arith.fixedpt<26, -9, signed>, !fixed_pt_arith.fixedpt<24, -9, signed>, !fixed_pt_arith.fixedpt<20, -9, signed>, !fixed_pt_arith.fixedpt<17, -9, signed>, !fixed_pt_arith.fixedpt<14, -9, signed>, !fixed_pt_arith.fixedpt<11, -9, signed>, !fixed_pt_arith.fixedpt<8, -9, signed>, !fixed_pt_arith.fixedpt<4, -9, signed>, !fixed_pt_arith.fixedpt<2, -9, signed>, !fixed_pt_arith.fixedpt<-2, -9, signed>, !fixed_pt_arith.fixedpt<-2, -9, signed>
    }
    case 3 {
      %74 = fixed_pt_arith.const <26323307783, !fixed_pt_arith.fixedpt<26, -9, signed>>
      %75 = fixed_pt_arith.const <1437684793, !fixed_pt_arith.fixedpt<24, -9, signed>>
      %76 = fixed_pt_arith.const <-233149324, !fixed_pt_arith.fixedpt<20, -9, signed>>
      %77 = fixed_pt_arith.const <20961951, !fixed_pt_arith.fixedpt<17, -9, signed>>
      %78 = fixed_pt_arith.const <-667214, !fixed_pt_arith.fixedpt<14, -9, signed>>
      %79 = fixed_pt_arith.const <-97947, !fixed_pt_arith.fixedpt<11, -9, signed>>
      %80 = fixed_pt_arith.const <17378, !fixed_pt_arith.fixedpt<8, -9, signed>>
      %81 = fixed_pt_arith.const <-1237, !fixed_pt_arith.fixedpt<4, -9, signed>>
      %82 = fixed_pt_arith.const <-81, !fixed_pt_arith.fixedpt<2, -9, signed>>
      %83 = fixed_pt_arith.const <21, !fixed_pt_arith.fixedpt<-2, -9, signed>>
      %84 = fixed_pt_arith.const <28, !fixed_pt_arith.fixedpt<-2, -9, signed>>
      scf.yield %74, %75, %76, %77, %78, %79, %80, %81, %82, %83, %84 : !fixed_pt_arith.fixedpt<26, -9, signed>, !fixed_pt_arith.fixedpt<24, -9, signed>, !fixed_pt_arith.fixedpt<20, -9, signed>, !fixed_pt_arith.fixedpt<17, -9, signed>, !fixed_pt_arith.fixedpt<14, -9, signed>, !fixed_pt_arith.fixedpt<11, -9, signed>, !fixed_pt_arith.fixedpt<8, -9, signed>, !fixed_pt_arith.fixedpt<4, -9, signed>, !fixed_pt_arith.fixedpt<2, -9, signed>, !fixed_pt_arith.fixedpt<-2, -9, signed>, !fixed_pt_arith.fixedpt<-2, -9, signed>
    }
    case 4 {
      %74 = fixed_pt_arith.const <28420921397, !fixed_pt_arith.fixedpt<26, -9, signed>>
      %75 = fixed_pt_arith.const <730237859, !fixed_pt_arith.fixedpt<24, -9, signed>>
      %76 = fixed_pt_arith.const <-127859351, !fixed_pt_arith.fixedpt<20, -9, signed>>
      %77 = fixed_pt_arith.const <13829771, !fixed_pt_arith.fixedpt<17, -9, signed>>
      %78 = fixed_pt_arith.const <-923200, !fixed_pt_arith.fixedpt<14, -9, signed>>
      %79 = fixed_pt_arith.const <19631, !fixed_pt_arith.fixedpt<11, -9, signed>>
      %80 = fixed_pt_arith.const <4014, !fixed_pt_arith.fixedpt<8, -9, signed>>
      %81 = fixed_pt_arith.const <-603, !fixed_pt_arith.fixedpt<4, -9, signed>>
      %82 = fixed_pt_arith.const <-108, !fixed_pt_arith.fixedpt<2, -9, signed>>
      %83 = fixed_pt_arith.const <2, !fixed_pt_arith.fixedpt<-2, -9, signed>>
      %84 = fixed_pt_arith.const <59, !fixed_pt_arith.fixedpt<-2, -9, signed>>
      scf.yield %74, %75, %76, %77, %78, %79, %80, %81, %82, %83, %84 : !fixed_pt_arith.fixedpt<26, -9, signed>, !fixed_pt_arith.fixedpt<24, -9, signed>, !fixed_pt_arith.fixedpt<20, -9, signed>, !fixed_pt_arith.fixedpt<17, -9, signed>, !fixed_pt_arith.fixedpt<14, -9, signed>, !fixed_pt_arith.fixedpt<11, -9, signed>, !fixed_pt_arith.fixedpt<8, -9, signed>, !fixed_pt_arith.fixedpt<4, -9, signed>, !fixed_pt_arith.fixedpt<2, -9, signed>, !fixed_pt_arith.fixedpt<-2, -9, signed>, !fixed_pt_arith.fixedpt<-2, -9, signed>
    }
    case 5 {
      %74 = fixed_pt_arith.const <29466637868, !fixed_pt_arith.fixedpt<26, -9, signed>>
      %75 = fixed_pt_arith.const <357306231, !fixed_pt_arith.fixedpt<24, -9, signed>>
      %76 = fixed_pt_arith.const <-64863632, !fixed_pt_arith.fixedpt<20, -9, signed>>
      %77 = fixed_pt_arith.const <7587834, !fixed_pt_arith.fixedpt<17, -9, signed>>
      %78 = fixed_pt_arith.const <-617278, !fixed_pt_arith.fixedpt<14, -9, signed>>
      %79 = fixed_pt_arith.const <32999, !fixed_pt_arith.fixedpt<11, -9, signed>>
      %80 = fixed_pt_arith.const <-698, !fixed_pt_arith.fixedpt<8, -9, signed>>
      %81 = fixed_pt_arith.const <-171, !fixed_pt_arith.fixedpt<4, -9, signed>>
      %82 = fixed_pt_arith.const <208, !fixed_pt_arith.fixedpt<2, -9, signed>>
      %83 = fixed_pt_arith.const <27, !fixed_pt_arith.fixedpt<-2, -9, signed>>
      %84 = fixed_pt_arith.const <-78, !fixed_pt_arith.fixedpt<-2, -9, signed>>
      scf.yield %74, %75, %76, %77, %78, %79, %80, %81, %82, %83, %84 : !fixed_pt_arith.fixedpt<26, -9, signed>, !fixed_pt_arith.fixedpt<24, -9, signed>, !fixed_pt_arith.fixedpt<20, -9, signed>, !fixed_pt_arith.fixedpt<17, -9, signed>, !fixed_pt_arith.fixedpt<14, -9, signed>, !fixed_pt_arith.fixedpt<11, -9, signed>, !fixed_pt_arith.fixedpt<8, -9, signed>, !fixed_pt_arith.fixedpt<4, -9, signed>, !fixed_pt_arith.fixedpt<2, -9, signed>, !fixed_pt_arith.fixedpt<-2, -9, signed>, !fixed_pt_arith.fixedpt<-2, -9, signed>
    }
    case 6 {
      %74 = fixed_pt_arith.const <29973630845, !fixed_pt_arith.fixedpt<26, -9, signed>>
      %75 = fixed_pt_arith.const <171648628, !fixed_pt_arith.fixedpt<24, -9, signed>>
      %76 = fixed_pt_arith.const <-31696380, !fixed_pt_arith.fixedpt<20, -9, signed>>
      %77 = fixed_pt_arith.const <3841501, !fixed_pt_arith.fixedpt<17, -9, signed>>
      %78 = fixed_pt_arith.const <-337945, !fixed_pt_arith.fixedpt<14, -9, signed>>
      %79 = fixed_pt_arith.const <22091, !fixed_pt_arith.fixedpt<11, -9, signed>>
      %80 = fixed_pt_arith.const <-946, !fixed_pt_arith.fixedpt<8, -9, signed>>
      %81 = fixed_pt_arith.const <27, !fixed_pt_arith.fixedpt<4, -9, signed>>
      %82 = fixed_pt_arith.const <-39, !fixed_pt_arith.fixedpt<2, -9, signed>>
      %83 = fixed_pt_arith.const <-8, !fixed_pt_arith.fixedpt<-2, -9, signed>>
      %84 = fixed_pt_arith.const <14, !fixed_pt_arith.fixedpt<-2, -9, signed>>
      scf.yield %74, %75, %76, %77, %78, %79, %80, %81, %82, %83, %84 : !fixed_pt_arith.fixedpt<26, -9, signed>, !fixed_pt_arith.fixedpt<24, -9, signed>, !fixed_pt_arith.fixedpt<20, -9, signed>, !fixed_pt_arith.fixedpt<17, -9, signed>, !fixed_pt_arith.fixedpt<14, -9, signed>, !fixed_pt_arith.fixedpt<11, -9, signed>, !fixed_pt_arith.fixedpt<8, -9, signed>, !fixed_pt_arith.fixedpt<4, -9, signed>, !fixed_pt_arith.fixedpt<2, -9, signed>, !fixed_pt_arith.fixedpt<-2, -9, signed>, !fixed_pt_arith.fixedpt<-2, -9, signed>
    }
    case 7 {
      %74 = fixed_pt_arith.const <30216113779, !fixed_pt_arith.fixedpt<26, -9, signed>>
      %75 = fixed_pt_arith.const <81733304, !fixed_pt_arith.fixedpt<24, -9, signed>>
      %76 = fixed_pt_arith.const <-15214840, !fixed_pt_arith.fixedpt<20, -9, signed>>
      %77 = fixed_pt_arith.const <1874477, !fixed_pt_arith.fixedpt<17, -9, signed>>
      %78 = fixed_pt_arith.const <-170708, !fixed_pt_arith.fixedpt<14, -9, signed>>
      %79 = fixed_pt_arith.const <12014, !fixed_pt_arith.fixedpt<11, -9, signed>>
      %80 = fixed_pt_arith.const <-477, !fixed_pt_arith.fixedpt<8, -9, signed>>
      %81 = fixed_pt_arith.const <65, !fixed_pt_arith.fixedpt<4, -9, signed>>
      %82 = fixed_pt_arith.const <-206, !fixed_pt_arith.fixedpt<2, -9, signed>>
      %83 = fixed_pt_arith.const <-18, !fixed_pt_arith.fixedpt<-2, -9, signed>>
      %84 = fixed_pt_arith.const <83, !fixed_pt_arith.fixedpt<-2, -9, signed>>
      scf.yield %74, %75, %76, %77, %78, %79, %80, %81, %82, %83, %84 : !fixed_pt_arith.fixedpt<26, -9, signed>, !fixed_pt_arith.fixedpt<24, -9, signed>, !fixed_pt_arith.fixedpt<20, -9, signed>, !fixed_pt_arith.fixedpt<17, -9, signed>, !fixed_pt_arith.fixedpt<14, -9, signed>, !fixed_pt_arith.fixedpt<11, -9, signed>, !fixed_pt_arith.fixedpt<8, -9, signed>, !fixed_pt_arith.fixedpt<4, -9, signed>, !fixed_pt_arith.fixedpt<2, -9, signed>, !fixed_pt_arith.fixedpt<-2, -9, signed>, !fixed_pt_arith.fixedpt<-2, -9, signed>
    }
    default {
      %74 = fixed_pt_arith.const <5640589127, !fixed_pt_arith.fixedpt<26, -9, signed>>
      %75 = fixed_pt_arith.const <5510525043, !fixed_pt_arith.fixedpt<24, -9, signed>>
      %76 = fixed_pt_arith.const <-191490613, !fixed_pt_arith.fixedpt<20, -9, signed>>
      %77 = fixed_pt_arith.const <-57922167, !fixed_pt_arith.fixedpt<17, -9, signed>>
      %78 = fixed_pt_arith.const <4256867, !fixed_pt_arith.fixedpt<14, -9, signed>>
      %79 = fixed_pt_arith.const <682179, !fixed_pt_arith.fixedpt<11, -9, signed>>
      %80 = fixed_pt_arith.const <-78970, !fixed_pt_arith.fixedpt<8, -9, signed>>
      %81 = fixed_pt_arith.const <-7314, !fixed_pt_arith.fixedpt<4, -9, signed>>
      %82 = fixed_pt_arith.const <1454, !fixed_pt_arith.fixedpt<2, -9, signed>>
      %83 = fixed_pt_arith.const <46, !fixed_pt_arith.fixedpt<-2, -9, signed>>
      %84 = fixed_pt_arith.const <-78, !fixed_pt_arith.fixedpt<-2, -9, signed>>
      scf.yield %74, %75, %76, %77, %78, %79, %80, %81, %82, %83, %84 : !fixed_pt_arith.fixedpt<26, -9, signed>, !fixed_pt_arith.fixedpt<24, -9, signed>, !fixed_pt_arith.fixedpt<20, -9, signed>, !fixed_pt_arith.fixedpt<17, -9, signed>, !fixed_pt_arith.fixedpt<14, -9, signed>, !fixed_pt_arith.fixedpt<11, -9, signed>, !fixed_pt_arith.fixedpt<8, -9, signed>, !fixed_pt_arith.fixedpt<4, -9, signed>, !fixed_pt_arith.fixedpt<2, -9, signed>, !fixed_pt_arith.fixedpt<-2, -9, signed>, !fixed_pt_arith.fixedpt<-2, -9, signed>
    }
    %12 = fixed_pt_arith.extract <-3, -7, signed> from %arg0 : <0, -7, signed>
    %13 = fixed_pt_arith.rescale_2pow %12 : <-3, -7, signed> shift by -2
    %14 = fixed_pt_arith.extend %13 : <-5, -9, signed> to <-3, -9, signed>
    %15 = fixed_pt_arith.mul %11#10 : <-2, -9, signed>, %14 : <-3, -9, signed>
    %16 = fixed_pt_arith.rescale_2pow %15 : <-4, -18, signed> shift by 6
    %17 = fixed_pt_arith.extract <-2, -12, signed> from %16 : <2, -12, signed>
    %18 = fixed_pt_arith.add %17 : <-2, -12, signed>, %11#9 : <-2, -9, signed> -> <-2, -12, signed>
    %19 = fixed_pt_arith.rescale_2pow %12 : <-3, -7, signed> shift by -5
    %20 = fixed_pt_arith.extend %19 : <-8, -12, signed> to <-3, -12, signed>
    %21 = fixed_pt_arith.mul %18 : <-2, -12, signed>, %20 : <-3, -12, signed>
    %22 = fixed_pt_arith.rescale_2pow %21 : <-4, -24, signed> shift by 12
    %23 = fixed_pt_arith.extract <2, -12, signed> from %22 : <8, -12, signed>
    %24 = fixed_pt_arith.add %23 : <2, -12, signed>, %11#8 : <2, -9, signed> -> <2, -12, signed>
    %25 = fixed_pt_arith.rescale_2pow %12 : <-3, -7, signed> shift by -5
    %26 = fixed_pt_arith.extend %25 : <-8, -12, signed> to <-3, -12, signed>
    %27 = fixed_pt_arith.mul %24 : <2, -12, signed>, %26 : <-3, -12, signed>
    %28 = fixed_pt_arith.rescale_2pow %27 : <0, -24, signed> shift by 12
    %29 = fixed_pt_arith.extract <5, -12, signed> from %28 : <12, -12, signed>
    %30 = fixed_pt_arith.add %29 : <5, -12, signed>, %11#7 : <4, -9, signed> -> <5, -12, signed>
    %31 = fixed_pt_arith.rescale_2pow %12 : <-3, -7, signed> shift by -5
    %32 = fixed_pt_arith.extend %31 : <-8, -12, signed> to <-3, -12, signed>
    %33 = fixed_pt_arith.mul %30 : <5, -12, signed>, %32 : <-3, -12, signed>
    %34 = fixed_pt_arith.rescale_2pow %33 : <3, -24, signed> shift by 12
    %35 = fixed_pt_arith.extract <8, -12, signed> from %34 : <15, -12, signed>
    %36 = fixed_pt_arith.add %35 : <8, -12, signed>, %11#6 : <8, -9, signed> -> <8, -12, signed>
    %37 = fixed_pt_arith.rescale_2pow %12 : <-3, -7, signed> shift by -5
    %38 = fixed_pt_arith.extend %37 : <-8, -12, signed> to <-3, -12, signed>
    %39 = fixed_pt_arith.mul %36 : <8, -12, signed>, %38 : <-3, -12, signed>
    %40 = fixed_pt_arith.rescale_2pow %39 : <6, -24, signed> shift by 12
    %41 = fixed_pt_arith.extract <11, -12, signed> from %40 : <18, -12, signed>
    %42 = fixed_pt_arith.add %41 : <11, -12, signed>, %11#5 : <11, -9, signed> -> <11, -12, signed>
    %43 = fixed_pt_arith.rescale_2pow %12 : <-3, -7, signed> shift by -5
    %44 = fixed_pt_arith.extend %43 : <-8, -12, signed> to <-3, -12, signed>
    %45 = fixed_pt_arith.mul %42 : <11, -12, signed>, %44 : <-3, -12, signed>
    %46 = fixed_pt_arith.rescale_2pow %45 : <9, -24, signed> shift by 12
    %47 = fixed_pt_arith.extract <14, -12, signed> from %46 : <21, -12, signed>
    %48 = fixed_pt_arith.add %47 : <14, -12, signed>, %11#4 : <14, -9, signed> -> <14, -12, signed>
    %49 = fixed_pt_arith.rescale_2pow %12 : <-3, -7, signed> shift by -5
    %50 = fixed_pt_arith.extend %49 : <-8, -12, signed> to <-3, -12, signed>
    %51 = fixed_pt_arith.mul %48 : <14, -12, signed>, %50 : <-3, -12, signed>
    %52 = fixed_pt_arith.rescale_2pow %51 : <12, -24, signed> shift by 12
    %53 = fixed_pt_arith.extract <17, -12, signed> from %52 : <24, -12, signed>
    %54 = fixed_pt_arith.add %53 : <17, -12, signed>, %11#3 : <17, -9, signed> -> <17, -12, signed>
    %55 = fixed_pt_arith.rescale_2pow %12 : <-3, -7, signed> shift by -5
    %56 = fixed_pt_arith.extend %55 : <-8, -12, signed> to <-3, -12, signed>
    %57 = fixed_pt_arith.mul %54 : <17, -12, signed>, %56 : <-3, -12, signed>
    %58 = fixed_pt_arith.rescale_2pow %57 : <15, -24, signed> shift by 12
    %59 = fixed_pt_arith.extract <20, -12, signed> from %58 : <27, -12, signed>
    %60 = fixed_pt_arith.add %59 : <20, -12, signed>, %11#2 : <20, -9, signed> -> <20, -12, signed>
    %61 = fixed_pt_arith.rescale_2pow %12 : <-3, -7, signed> shift by -5
    %62 = fixed_pt_arith.extend %61 : <-8, -12, signed> to <-3, -12, signed>
    %63 = fixed_pt_arith.mul %60 : <20, -12, signed>, %62 : <-3, -12, signed>
    %64 = fixed_pt_arith.rescale_2pow %63 : <18, -24, signed> shift by 12
    %65 = fixed_pt_arith.extract <24, -12, signed> from %64 : <30, -12, signed>
    %66 = fixed_pt_arith.add %65 : <24, -12, signed>, %11#1 : <24, -9, signed> -> <24, -12, signed>
    %67 = fixed_pt_arith.rescale_2pow %12 : <-3, -7, signed> shift by -5
    %68 = fixed_pt_arith.extend %67 : <-8, -12, signed> to <-3, -12, signed>
    %69 = fixed_pt_arith.mul %66 : <24, -12, signed>, %68 : <-3, -12, signed>
    %70 = fixed_pt_arith.rescale_2pow %69 : <22, -24, signed> shift by 12
    %71 = fixed_pt_arith.extract <26, -12, signed> from %70 : <34, -12, signed>
    %72 = fixed_pt_arith.add %71 : <26, -12, signed>, %11#0 : <26, -9, signed> -> <26, -12, signed>
    %73 = fixed_pt_arith.extract <0, -7, signed> from %72 : <26, -12, signed>
    return %73 : !fixed_pt_arith.fixedpt<0, -7, signed>
  }
}

