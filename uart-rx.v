module uartRX
    #(
        parameter g_HALF_CLK = 109,
        parameter g_FULL_CLK = 217 
    )
    (input i_Clk,
    input i_UART_RX,

    output o_Segment2_A,
    output o_Segment2_B,
    output o_Segment2_C,
    output o_Segment2_D,
    output o_Segment2_E,
    output o_Segment2_F,
    output o_Segment2_G,

    output o_Segment1_A,
    output o_Segment1_B,
    output o_Segment1_C,
    output o_Segment1_D,
    output o_Segment1_E,
    output o_Segment1_F,
    output o_Segment1_G);

    localparam State1 = 2'd0; //idle state and checking for start bit
    localparam State2 = 2'd1; // stall half a bit for optimal sampling
    localparam State3 = 2'd2; // get next bit and sample 
    localparam State4 = 2'd3; //stopping point 

    reg[1:0] r_State = State1;

    reg [3:0] r_Counter_bit_in_byte = 0; 
    reg [7:0] r_Collected_byte = 0; 
    reg [10:0] r_Clock_counter = 0; 
    reg [10:0] r_Clock_counter2 = 0; // ig i didnt need a second counter
    reg [7:0] r_final_byte = 0;

    reg r_RX_input = 1'b1; // start it as external reg since we cannot reg an input. Idle for UART is high (1)
   // forgot what the purpose of this one was for --> reg [31:0] r_Clock = 0; //arbitrarily chose a large reg size for my clock lol 
    wire w_Segment_A;
    wire w_Segment_B;
    wire w_Segment_C;
    wire w_Segment_D;
    wire w_Segment_E;
    wire w_Segment_F;
    wire w_Segment_G;
    
    wire w_Segment2_A;
    wire w_Segment2_B;
    wire w_Segment2_C;
    wire w_Segment2_D;
    wire w_Segment2_E;
    wire w_Segment2_F;
    wire w_Segment2_G;
    //different states, one per clock cycle so no falling through. 
    always @(posedge i_Clk)
    begin
        r_RX_input <= i_UART_RX;
        case (r_State)
            default:
                r_State <= State1; //safety for unexpected values
            State1:
                begin
                    //did I even need to make an r_rxinput since each case happens in one clk cycle, could I have done without
                    if (r_RX_input == 0)
                        r_State <= State2;
                end
            
            State2:
                begin
                    r_Clock_counter <= r_Clock_counter + 1;
                    if (r_Clock_counter == g_HALF_CLK)
                        begin
                            r_Clock_counter <= 0; //reset
                            r_State <= State3; //move on
                        end
                end

            State3:
                begin
                    r_Clock_counter2 <= r_Clock_counter2 + 1;
                    
                    if (r_Clock_counter2 == g_FULL_CLK)
                        begin
                            r_Collected_byte[r_Counter_bit_in_byte] <= r_RX_input;
                            r_Counter_bit_in_byte <= r_Counter_bit_in_byte + 1;
                            r_Clock_counter2 <= 0;
                        end
                    if(r_Counter_bit_in_byte == 8)
                        begin
                            r_State <= State4;
                            r_Counter_bit_in_byte <= 0;
                            r_Clock_counter2<= 0;
                        end
                end
            
            State4:
                begin
                    r_final_byte <= r_Collected_byte;
                    r_Clock_counter <= r_Clock_counter + 1;
                    if (r_Clock_counter == g_FULL_CLK)
                        begin
                            r_Clock_counter <= 0;
                            r_State <= State1;
                        end
                end
        endcase
    end
    BinaryTo7segment Instance2
                        (.i_Clk(i_Clk),
                        .i_Binary_Num(r_final_byte[3:0]),
                        .i_Binary_Num2(r_final_byte[7:4]),
                        .o_Segment2_A(w_Segment2_A),
                        .o_Segment2_B(w_Segment2_B),
                        .o_Segment2_C(w_Segment2_C),
                        .o_Segment2_D(w_Segment2_D),
                        .o_Segment2_E(w_Segment2_E),
                        .o_Segment2_F(w_Segment2_F),
                        .o_Segment2_G(w_Segment2_G),

                        .o_Segment1_A(w_Segment_A),
                        .o_Segment1_B(w_Segment_B),
                        .o_Segment1_C(w_Segment_C),
                        .o_Segment1_D(w_Segment_D),
                        .o_Segment1_E(w_Segment_E),
                        .o_Segment1_F(w_Segment_F),
                        .o_Segment1_G(w_Segment_G));

                        assign o_Segment2_A = ~w_Segment2_A;
                        assign o_Segment2_B = ~w_Segment2_B;
                        assign o_Segment2_C = ~w_Segment2_C;
                        assign o_Segment2_D = ~w_Segment2_D;
                        assign o_Segment2_E = ~w_Segment2_E;
                        assign o_Segment2_F = ~w_Segment2_F;
                        assign o_Segment2_G = ~w_Segment2_G;
                        
                        assign o_Segment1_A = ~w_Segment_A;
                        assign o_Segment1_B = ~w_Segment_B;
                        assign o_Segment1_C = ~w_Segment_C;
                        assign o_Segment1_D = ~w_Segment_D;
                        assign o_Segment1_E = ~w_Segment_E;
                        assign o_Segment1_F = ~w_Segment_F;
                        assign o_Segment1_G = ~w_Segment_G;
endmodule