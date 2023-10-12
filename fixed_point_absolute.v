module fixed_point_absolute #(parameter
DATA_WIDTH = 4
) 
(
    ///////////// INPUT/OUTPUT PORTS DECLARATION
input  wire [DATA_WIDTH-1:0] x,
output wire [DATA_WIDTH-1:0] abs_x
);
///////////////// INTERNAL SIGNALS ///////////////
wire                  sign_bit ;
wire [DATA_WIDTH-1:0] twos_comp_x ;

//////////////////////////////////////////////assignment statements//////////////////
assign sign_bit = x [DATA_WIDTH-1] ;
assign abs_x = sign_bit ? twos_comp_x : x ;
/////////////////////////////////////////////////////////////
////////////// instantiations////////////////////

twos_comp #(.DATA_WIDTH(DATA_WIDTH)) twos_comp_insta
(
.x(x),
.twos_comp_x(twos_comp_x)
) ;


endmodule