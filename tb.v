module testbench;
    reg clk, reset;
    wire [18:0] pc;
    reg [18:0] instruction;

    CPU cpu(.clk(clk), .reset(reset), .instruction(instruction), .pc(pc));

    initial begin
        clk = 0;
        reset = 1;
        #5 reset = 0;
        #500 $stop;
    end

    always #5 clk = ~clk;

    always @(posedge clk) begin
        case(pc)
            19'd0: instruction = 19'b00000_0001_0010_0011_0000;
            19'd1: instruction = 19'b00001_0001_0010_0011_0001; 
            19'd2: instruction = 19'b00010_0001_0010_0011_0010; 
            
            default: instruction = 19'b00000_0000_0000_0000_0000; 
        endcase
    end
endmodule