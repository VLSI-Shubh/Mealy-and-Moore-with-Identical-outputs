//This is the first code that is for Mealy sequence detector of sequence 1011
module mealy_1011 ( 
    input in, clk, rst,
    output reg out
);
    parameter [1:0] s0=2'b00, s1 = 2'b01, s2=2'b10, s3=2'b11; 
    reg [1:0] ps,ns;

    //Now comes the state transition logic for the detector
always@(*) begin
    case (ps)
        s0: if (in) begin
            ns = s1;
        end else begin
            ns = s0;
        end
        s1: if (in) begin
            ns = s1;
        end else begin
            ns = s2;
        end
        s2: if (in) begin
            ns = s3;
        end else begin
            ns = s0;
        end
        s3: if (in) begin
            ns = s1;
        end else begin
            ns = s2;
        end
        default: ns = s0; 
    endcase
end

// Now we write the state memory 
always @(posedge clk, posedge rst ) begin
    if (rst) begin
        ps <= s0;
    end else begin
        ps <= ns;
    end
    
end

// Now its time to write the output logic which is the main difference between mealy and moore 

always@(*) begin
    case (ps)
        s0: out = 1'b0;
        s1: out = 1'b0;
        s2: out = 1'b0;
        s3: if (in) begin
            out = 1'b1;
        end else begin
            out = 1'b0; 
        end
        default: out = 1'b0;
    endcase
end

endmodule