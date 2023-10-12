module fixed_point_sigmoid #(parameter
DATA_WIDTH = 32,
INTEGER = 10,
FRACTION = 22
) ( ///////// INPUT/OUTPUT PORTS DECLARATION
input wire                   sigmoid_enable,
input wire  [DATA_WIDTH-1:0] in,
output wire [DATA_WIDTH-1:0] out
);
/// INTERNAL SIGNALS
wire sign_bit;
wire  [DATA_WIDTH-1:0]  out_reg_for_positive_number ;
wire  [DATA_WIDTH-1:0]  twos_comp_for_out_reg_for_positive_number ;
wire  [DATA_WIDTH-1:0]  one_with_zero_fraction ; // 1.0000
wire  [DATA_WIDTH-1:0]  out_reg ;

////////////////assignment statements ///////////////////////////////////////////////////////
assign sign_bit = in [DATA_WIDTH-1] ;
assign one_with_zero_fraction = { 1'b1 ,  {FRACTION{1'b0}}} ;   
assign out_reg = (sign_bit)  ? (one_with_zero_fraction + twos_comp_for_out_reg_for_positive_number) : out_reg_for_positive_number ;
assign out = (sigmoid_enable) ? out_reg : in ;

/////////////////////////////////////////////////////////////////////////////////////////////

///////////instantiations////////////

fixed_point_sigmoid_for_positive_number #(
.DATA_WIDTH(DATA_WIDTH),
.INTEGER(INTEGER),
.FRACTION(FRACTION)
) 
fixed_point_sigmoid_for_positive_number_insta 
(
.in(in),
.out_reg_for_positive_number(out_reg_for_positive_number)
);

twos_comp #(.DATA_WIDTH(DATA_WIDTH)) twos_comp_inst (
.x(out_reg_for_positive_number),
.twos_comp_x(twos_comp_for_out_reg_for_positive_number)
);


endmodule