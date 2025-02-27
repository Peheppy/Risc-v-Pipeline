`timescale 1ns / 1ps

module alu#(
        parameter DATA_WIDTH = 32,
        parameter OPCODE_LENGTH = 4
        )
        (
        input logic [DATA_WIDTH-1:0]    SrcA,
        input logic [DATA_WIDTH-1:0]    SrcB,

        input logic [OPCODE_LENGTH-1:0]    Operation,
        output logic[DATA_WIDTH-1:0] ALUResult
        );
    
        always_comb
        begin
            case(Operation)
            4'b0000:        // AND
                    ALUResult = SrcA & SrcB;
            4'b0001:        // OR
                    ALUResult = SrcA | SrcB;
            4'b1001:        // XOR
                    ALUResult = SrcA ^ SrcB;
            4'b0010:        // ADD
                    ALUResult = $signed(SrcA) + $signed(SrcB);
            4'b0110:        // SUB
                    ALUResult = SrcA - SrcB;
            4'b1000:        // Equal
                    ALUResult = (SrcA == SrcB) ? 1 : 0;
            4'b1110:        // bne
                    ALUResult = (SrcA != SrcB) ? 1 : 0;
            4'b1010:        // BGE
		    ALUResult = (SrcA >= SrcB) ? 1 : 0;
            4'b1100:        //slt e slti
                    ALUResult = (SrcA < SrcB) ? 1 : 0;
	    4'b0100:        // Slli
		    ALUResult = SrcA << SrcB;
            4'b0101:        // Srli
		    ALUResult = SrcA >> SrcB;
            4'b0111:        // Srai
		    ALUResult = $signed(SrcA) >>> SrcB[5-1:0]; // porque o "funct7" de srcb e 01000, assim iria considerar um numero maior
            default:
                    ALUResult = 0;
            endcase
        end
endmodule

