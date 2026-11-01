module debounce_switch // keep in mind we implemented a counter this way, and WITHOUT a for loop, because those wont work as intended for this purpose
(input i_Clk,
input i_Switch,
output o_Switch);
// params are constants, set once and not changed
parameter DEBOUNCE_LIMIT = 250000; // 10 ms @ 25mHz

reg r_State = 1'b0;
reg [17:0] r_Count = 0; //created an 18 bit counter

always @(posedge i_Clk)
    begin //i_Switch is unfiltered, r_count is filtered version

        //input is diff from internal state. We didn't wait enough time, so keep waiting for a set period.
        if (i_Switch != r_State && r_Count < DEBOUNCE_LIMIT)
            r_Count <= r_Count + 1; // counter
// begin end only if theres more than one line 

        //end of counter reached, switch is stable. Register it, reset counter 
        else if (r_Count == DEBOUNCE_LIMIT)
            begin
                r_Count<= 0;
                r_State<= i_Switch;
            end
        // switches are same state, reset the counter
        else
            r_Count<= 0;           
    end
assign o_Switch = r_State;
endmodule