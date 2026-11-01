//figure out what was wrong with my code (debug it by hand- later)

module BinaryTo7segment
    (input i_Clk,
    input [3:0] i_Binary_Num,
    input [3:0] i_Binary_Num2,
    output o_Segment1_A,
    output o_Segment1_B,
    output o_Segment1_C,
    output o_Segment1_D,
    output o_Segment1_E,
    output o_Segment1_F,
    output o_Segment1_G,
    output o_Segment2_A, 
    output o_Segment2_B,
    output o_Segment2_C,
    output o_Segment2_D,
    output o_Segment2_E,
    output o_Segment2_F,
    output o_Segment2_G);

reg[6:0] r_Hex_Encoding = 7'h00; 
reg[6:0] r_Hex_Encoding2 = 7'h00; 

parameter HIGHEST_NUM = 4'h09;
// how can u do this without the clk? why do u need clk? 
//LUT based on the input
always @(posedge i_Clk)
    begin
        case (i_Binary_Num)
            4'b0000 : r_Hex_Encoding <= 7'h7E; // 7 bits wide, ' means type is after the ' | h is hexa 
            4'b0001 : r_Hex_Encoding <= 7'h30; 
            4'b0010 : r_Hex_Encoding <= 7'h6D; 
            4'b0011 : r_Hex_Encoding <= 7'h79;
            4'b0100 : r_Hex_Encoding <= 7'h33;
            4'b0101 : r_Hex_Encoding <= 7'h5B;
            4'b0110 : r_Hex_Encoding <= 7'h5F;
            4'b0111 : r_Hex_Encoding <= 7'h70;
            4'b1000 : r_Hex_Encoding <= 7'h7F;
            4'b1001 : r_Hex_Encoding <= 7'h7B;
            4'b1010 : r_Hex_Encoding <= 7'h77;
            4'b1011 : r_Hex_Encoding <= 7'h1F;
            4'b1100 : r_Hex_Encoding <= 7'h4E;
            4'b1101 : r_Hex_Encoding <= 7'h3D;
            4'b1110 : r_Hex_Encoding <= 7'h4F;
            4'b1111 : r_Hex_Encoding <= 7'h47;
        endcase
        case (i_Binary_Num2)
            4'b0000 : r_Hex_Encoding2 <= 7'h7E; // 7 bits wide, ' means type is after the ' | h is hexa 
            4'b0001 : r_Hex_Encoding2 <= 7'h30; 
            4'b0010 : r_Hex_Encoding2 <= 7'h6D; 
            4'b0011 : r_Hex_Encoding2 <= 7'h79;
            4'b0100 : r_Hex_Encoding2 <= 7'h33;
            4'b0101 : r_Hex_Encoding2 <= 7'h5B;
            4'b0110 : r_Hex_Encoding2 <= 7'h5F;
            4'b0111 : r_Hex_Encoding2 <= 7'h70;
            4'b1000 : r_Hex_Encoding2 <= 7'h7F;
            4'b1001 : r_Hex_Encoding2 <= 7'h7B;
            4'b1010 : r_Hex_Encoding2 <= 7'h77;
            4'b1011 : r_Hex_Encoding2 <= 7'h1F;
            4'b1100 : r_Hex_Encoding2 <= 7'h4E;
            4'b1101 : r_Hex_Encoding2 <= 7'h3D;
            4'b1110 : r_Hex_Encoding2 <= 7'h4F;
            4'b1111 : r_Hex_Encoding2 <= 7'h47;
        endcase
    end 

//r_hex_encoding[7] unused
assign o_Segment2_A = r_Hex_Encoding[6];
assign o_Segment2_B = r_Hex_Encoding[5];
assign o_Segment2_C = r_Hex_Encoding[4];
assign o_Segment2_D = r_Hex_Encoding[3];
assign o_Segment2_E = r_Hex_Encoding[2];
assign o_Segment2_F = r_Hex_Encoding[1];
assign o_Segment2_G = r_Hex_Encoding[0];

assign o_Segment1_A = r_Hex_Encoding2[6];
assign o_Segment1_B = r_Hex_Encoding2[5];
assign o_Segment1_C = r_Hex_Encoding2[4];
assign o_Segment1_D = r_Hex_Encoding2[3];
assign o_Segment1_E = r_Hex_Encoding2[2];
assign o_Segment1_F = r_Hex_Encoding2[1];
assign o_Segment1_G = r_Hex_Encoding2[0];

endmodule  