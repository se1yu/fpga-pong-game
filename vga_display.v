module vga_display
// in top module, only names in PCF are here for top module's inputs and outputs
(
    input i_Clk,
    // input i_HSync,
    // input i_VSync,
   
    output o_VGA_HSync,
    output o_VGA_VSync,
    output o_VGA_Red_0,
    output o_VGA_Red_1,
    output o_VGA_Red_2,
    output o_VGA_Grn_0,
    output o_VGA_Grn_1,
    output o_VGA_Grn_2,
    output o_VGA_Blu_0,
    output o_VGA_Blu_1,
    output o_VGA_Blu_2
);

// Making wires to hold module-shared outputs that don't go directly into pins yet. 
// Then they can go into pins at assignment, or go into inputs of others
wire [9:0] w_col_counter;
wire [9:0] w_row_counter;
wire hsync;
wire vsync;

//hsync and vsync get shared between 2 modules. So we feed a new wire for the 2nd output 
wire hsync2;
wire vsync2;
wire [2:0] vga_red;
wire [2:0] vga_grn;
wire [2:0] vga_blu;

// Placing modules 
VGA_Sync_Pulses 
Pulse_Inst //whatever name I want 
(
    .i_Clk(i_Clk),
    .o_HSync(hsync),
    .o_VSync(vsync),
    .r_Column_Counter(w_col_counter),
    .r_Row_Counter(w_row_counter)
);

//2nd placed module
pattern_generator
Pattern_Inst
(
    .i_Clk(i_Clk),
    .i_Pattern_Select(1'b1), //placeholder while I try only red
    .i_HSync(hsync),
    .i_VSync(vsync),
    .i_Col(w_col_counter),
    .i_Row(w_row_counter),

    .o_VGA_HSync(hsync2),
    .o_VGA_VSync(vsync2),
    .o_VGA_Red(vga_red),
    .o_VGA_Grn(vga_grn),
    .o_VGA_Blu(vga_blu)
);

assign o_VGA_HSync = hsync2;
assign o_VGA_VSync = vsync2;

assign o_VGA_Red_0 = vga_red[0];
assign o_VGA_Red_1 = vga_red[1];
assign o_VGA_Red_2 = vga_red[2];

assign o_VGA_Grn_0 = vga_grn[0];
assign o_VGA_Grn_1 = vga_grn[1];
assign o_VGA_Grn_2 = vga_grn[2];

assign o_VGA_Blu_0 = vga_blu[0];
assign o_VGA_Blu_1 = vga_blu[1];
assign o_VGA_Blu_2 = vga_blu[2];

endmodule