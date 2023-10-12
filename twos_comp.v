module twos_comp #(parameter
DATA_WIDTH = 4
)(
input  wire [DATA_WIDTH-1:0] x,
output wire [DATA_WIDTH-1:0] twos_comp_x
);
reg  [DATA_WIDTH-1:0] ones_comp_x ;
integer i;
always @ (*)
    begin
for (i=0 ; i< DATA_WIDTH ; i = i + 1 )
    begin
ones_comp_x [i] = !x[i] ;
    end
    end
assign twos_comp_x = ones_comp_x + 'b1 ;
endmodule