module CPU (
    input clk, reset,
    input [18:0] instruction,
    output reg [18:0] pc
);
    reg [18:0] registers [15:0]; 
    reg [18:0] memory [255:0];   
    wire [18:0] alu_out;
    wire [4:0] opcode = instruction[18:14];
    wire [3:0] r1 = instruction[13:10];
    wire [3:0] r2 = instruction[9:6];
    wire [3:0] r3 = instruction[5:2];
    wire [5:0] addr = instruction[5:0];

    ALU alu(.r2(registers[r2]), .r3(registers[r3]), .opcode(opcode), .r1(alu_out));

    always @(posedge clk or posedge reset) begin
        if (reset)
            pc <= 19'b0;
        else begin
            case (opcode)
                5'b00000: registers[r1] <= alu_out; 
                5'b00001: registers[r1] <= alu_out;  
                5'b00010: registers[r1] <= alu_out;  
                5'b00011: registers[r1] <= alu_out;  
                5'b00100: registers[r1] <= alu_out; 
                5'b00101: registers[r1] <= alu_out; 
                5'b00110: registers[r1] <= alu_out; 
                5'b00111: registers[r1] <= alu_out;  
                5'b01000: registers[r1] <= alu_out;  
                5'b01001: registers[r1] <= alu_out;  
                5'b10000: registers[r1] <= memory[addr];
                5'b10001: memory[addr] <= registers[r1]; 
                5'b11000: pc <= addr;                  
                5'b11001: if (registers[r1] == registers[r2]) pc <= addr; 
                5'b11010: if (registers[r1] != registers[r2]) pc <= addr; 
                5'b11011:begin                        
                    memory[registers[15]] <= pc;       
                    registers[15] <= registers[15] - 1; 
                    pc <= addr;
                end
                5'b11100: begin                         
                    registers[15] <= registers[15] + 1; 
                    pc <= memory[registers[15]];        
                end
                5'b11110: registers[r1] <= alu_out;  
                5'b11111: registers[r1] <= alu_out;    
                default: pc <= pc + 1;
            endcase
        end
    end
endmodule