module fixed_point_sigmoid_for_positive_number #(parameter
DATA_WIDTH = 10,
INTEGER = 4,
FRACTION = 6
) (
    /// INPUT/OUTPUT PORTS DECLARATION
input  wire  [DATA_WIDTH-1:0] in,
output reg   [DATA_WIDTH-1:0] out_reg_for_positive_number
);
//// Internal signals///////////
wire [DATA_WIDTH-1:0] abs_x ; // |x|
wire [DATA_WIDTH-1:0] one_with_zero_fraction ; // 1.000...
wire [DATA_WIDTH-1:0] five_with_zero_fraction ; // 5.000...
wire [DATA_WIDTH-1:0] two_with_fraction ;  //2.375000...

/////////////////////////assignment & always blocks/////

assign one_with_zero_fraction =  { 1'b1 ,  {FRACTION{1'b0}}} ;  
assign five_with_zero_fraction = {3'b101,{FRACTION{1'b0}}} ;
assign two_with_fraction = {5'b10011,{(FRACTION-3){1'b0}}} ;

always @ (*)
begin
if (abs_x >= two_with_fraction && abs_x < five_with_zero_fraction )  /// 2.375<=|x|<5
    begin
out_reg_for_positive_number = ( (abs_x) >> 3'b101 ) +  { {INTEGER{1'b0}} , 5'b11011 , {(FRACTION-5){1'b0}} } ;
    end
else if (abs_x >= one_with_zero_fraction && abs_x < two_with_fraction ) /// 1<=|x|<2.375
    begin
out_reg_for_positive_number = ( (abs_x) >> 2'b11 ) +  { {INTEGER{1'b0}} , 3'b101 , {(FRACTION-3){1'b0}} } ;
    end
else if (abs_x < one_with_zero_fraction && abs_x >= 'b0)         /// 0<=|x|<1
    begin
out_reg_for_positive_number = ( (abs_x) >> 2'b10 ) +  { {INTEGER{1'b0}} , 1'b1 , {(FRACTION-1){1'b0}} } ;
    end
else // |x|>=5
    begin
out_reg_for_positive_number = one_with_zero_fraction ;
    end
    end

////////////////////////////////////////////
////////////// INSTANTIATIONS //////////////

fixed_point_absolute #(.DATA_WIDTH(DATA_WIDTH)) fixed_point_absolute_inst (
.x(in),
.abs_x(abs_x)
);

endmodule