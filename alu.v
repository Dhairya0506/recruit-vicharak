module ALU (
    input [18:0] r2, r3,
    input [4:0] opcode,
    output reg [18:0] r1
);
    always @(*) begin
        case (opcode)
            5'b00000: r1 = r2 + r3;        
            5'b00001: r1 = r2 - r3;        
            5'b00010: r1 = r2 * r3;        
            5'b00011: r1 = r2 / r3;        
            5'b00100: r1 = r2 & r3;        
            5'b00101: r1 = r2 | r3;        
            5'b00110: r1 = r2 ^ r3;        
            5'b00111: r1 = ~r2;            
            5'b01000: r1 = r2 + 1;         
            5'b01001: r1 = r2 - 1;        
            
            5'b11110: r1 = encrypt(r2);    
            5'b11111: r1 = decrypt(r2);    
            default: r1 = 19'b0;
        endcase
    end

    function [18:0] encrypt(input [18:0] data);
        
        encrypt = data ^ 19'h1A2B3;
    endfunction

    function [18:0] decrypt(input [18:0] data);
        
        decrypt = data ^ 19'h1A2B3;
    endfunction
endmodule
