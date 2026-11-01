// takes in hsync and vsync as inputs with clock and outputs updated delayed hsync and vsync, as well as RGB for top module
module pattern_generator
    #(
        parameter ACTIVE_COL = 640,
        parameter ACTIVE_ROW = 480
    )
    (input i_Clk,
    input i_Pattern_Select,
    input i_HSync,
    input i_VSync,
    input [9:0] i_Col,
    input [9:0] i_Row,

    output reg o_VGA_HSync, //these two must be reg because theyre used in clocked always blcok below
    output reg o_VGA_VSync,
    output reg [2:0] o_VGA_Red,
    output reg [2:0] o_VGA_Grn,
    output reg [2:0] o_VGA_Blu
    );

    always @(posedge i_Clk)
    begin
        o_VGA_HSync <= i_HSync;
        o_VGA_VSync <= i_VSync;
        if (i_Col < ACTIVE_COL && i_Row < ACTIVE_ROW) // if in active region
        begin
            if (i_Col < 640/6)        // 1/6
            begin
                o_VGA_Red <= 3'b111;
                o_VGA_Grn <= 0;
                o_VGA_Blu <= 0;
            end
            else if (i_Col < (640/6 * 2))      //2/6
            begin
                o_VGA_Red <= 3'b111;
                o_VGA_Grn <= 3'b010;
                o_VGA_Blu <= 0;
            end
        
            else if (i_Col < (640/6 * 3))      // 3/6
            begin
                o_VGA_Red <= 3'b111;
                o_VGA_Grn <= 3'b111;
                o_VGA_Blu <= 0;
            end
        
            else if (i_Col < (640/6 * 4))      // 4/6
            begin
                o_VGA_Red <= 0;
                o_VGA_Grn <= 3'b111;
                o_VGA_Blu <= 0;
            end
        
            else if (i_Col < (640/6 * 5))      // 5/6
            begin
                o_VGA_Red <= 0;
                o_VGA_Grn <= 0;
                o_VGA_Blu <= 3'b111;
            end
            else if (i_Col < 640)     // 6/6
            begin
                o_VGA_Red <= 3'b010;
                o_VGA_Grn <= 0;
                o_VGA_Blu <= 3'b010;
            end
        end

        else
        begin
            o_VGA_Red <= 0;
            o_VGA_Grn <= 0;
            o_VGA_Blu <= 0;
        end 

    end
endmodule