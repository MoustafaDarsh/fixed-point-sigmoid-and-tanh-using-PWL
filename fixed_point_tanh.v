module fixed_point_tanh #(parameter
DATA_WIDTH = 12,
INTEGER = 6,
FRACTION = 6
) (
input wire                   tanh_enable,
input wire  [DATA_WIDTH-1:0] in,
output wire [DATA_WIDTH-1:0] out   //// tanhx = 2f(2x) -1 ,, where f(x) = sigmoid (x)
);
////////////////////// internal signals
wire [DATA_WIDTH-1:0] out_from_fixed_point_sigmoid ; // f(2x)
wire [DATA_WIDTH-1:0] multiplied_input_by_two ; //2x
wire [DATA_WIDTH-1:0] multiplied_out_from_fixed_point_sigmoid ; // 2f(2x)
wire [DATA_WIDTH-1:0] minus_one_with_zero_fraction ;
////////////////////////////////////////////////////////////

/////////////assignments////////////



assign multiplied_input_by_two = in << 1'b1 ;
assign multiplied_out_from_fixed_point_sigmoid = out_from_fixed_point_sigmoid << 1'b1 ; 
assign minus_one_with_zero_fraction =  { {INTEGER{1'b1}} , {FRACTION{1'b0}} } ;   
assign out = (tanh_enable) ? multiplied_out_from_fixed_point_sigmoid + minus_one_with_zero_fraction :  in ;

/////////////////////////////////////////////////////////////////////////////////
//////// INSTANTIATIONS //////////////////////////

fixed_point_sigmoid #(
.DATA_WIDTH(DATA_WIDTH),
.INTEGER(INTEGER),
.FRACTION(FRACTION)
) fixed_point_sigmoid_inst (
.sigmoid_enable(tanh_enable),
.in(multiplied_input_by_two),
.out(out_from_fixed_point_sigmoid)
);
//////////////////////////////////////////////


























endmodule