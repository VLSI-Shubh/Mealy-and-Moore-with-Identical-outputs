module moore_1011 (
    input in, clk, rst, 
    output reg out
);
// Here the #states aris more than required in mealy, here it is 5, hence we need 3 bits to define states
parameter[2:0] s0=3'b000,s1=3'b001,s2=3'b010,s3=3'b011,s4=3'b100;
reg[2:0] ps, ns;

// Now we write the state transition logic here 

always @(*) begin
    case (ps)
        s0: if (in) begin
            ns = s1;
        end else begin
            ns = s0;
        end 
        s1: if (in) begin
            ns = s1;
        end else begin
            ns= s2;
        end
        s2: if (in) begin
            ns = s3;
        end else begin
            ns = s0;
        end
        s3: if (in) begin
            ns = s4;
        end else begin
            ns = s2;
        end
        s4: if (in) begin
            ns = s1;
        end else begin
            ns = s2;
        end
        default: ns = s0;
    endcase
end

// here we end the state transition logic
//Now we write the state memory logic 
always @(posedge clk, posedge rst) begin
    if (rst) begin
        ps <= s0;
    end else begin
        ps <= ns;
    end
end
// Now comes the output logic, unlike mealy where in the last state the output depended on Input, here all outputs are well defined
always @(*) begin
    case (ps)
        s0: out = 1'b0;
        s1: out = 1'b0;
        s2: out = 1'b0;
        s3: out = 1'b0;
        s4: out = 1'b1; 
        default: out = 1'b0; 
    endcase
    
end

endmodule