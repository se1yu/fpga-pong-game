// takes input clock from fpga and outputs HSYNC and VSYNC (includes those signals being high for the front and back porches). 
// also outputs a col_counter and row_counter that other modules can use
module VGA_Sync_Pulses 
    #(
        parameter ACTIVE_COL = 640,
        parameter ACTIVE_ROW = 480,
        parameter WIDTH_COLS = 800, //total columns
        parameter HEIGHT_ROWS = 525, // total rows
        parameter H_FRONT_PORCH = 18,
        parameter H_BACK_PORCH = 50,
        parameter V_FRONT_PORCH = 10,
        parameter V_BACK_PORCH = 33
    )
    //sync not top module, names dont need to match pcf
    // Generate free-running HSync and VSync that downstream modules can use to know where they are in the frame
    (input i_Clk,
    output reg o_HSync,
    output reg o_VSync,
    output reg [9:0] r_Column_Counter = 0,
    output reg [9:0] r_Row_Counter= 0);
  
    //sweeping 
    always @(posedge i_Clk)
    begin
        if (r_Column_Counter == WIDTH_COLS - 1) // if x-axis is at end
        begin
            if (r_Row_Counter == HEIGHT_ROWS - 1) // if y axis @ end
            begin
                r_Row_Counter <= 0; // reset to top left
                r_Column_Counter <= 0;
            end

            else begin //if y axis not at end...
                r_Row_Counter <= r_Row_Counter + 1; // increase y axis
                r_Column_Counter <= 0; // reset x axis 
            end 
        end 
        else // if x axis not at the end, just keep going right 
            r_Column_Counter <= r_Column_Counter + 1;
        
        o_VSync <= (r_Row_Counter < ACTIVE_ROW + V_FRONT_PORCH ) || (r_Row_Counter > HEIGHT_ROWS - V_BACK_PORCH - 1);
        o_HSync <= (r_Column_Counter < ACTIVE_COL + H_FRONT_PORCH) || (r_Column_Counter > WIDTH_COLS - H_BACK_PORCH - 1);
    end
endmodule