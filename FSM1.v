//Fsm1
module fsm1(
    input clk,
    input areset,    
    input in,
    output out); 

    parameter A=0, B=1; 
    reg state, next_state;

    always @(*) begin   
        case(state)
            A: next_state = (in==1'b0) ? B : A;
            B: next_state = (in==1'b0) ? A : B;
        endcase
    end
    always @(posedge clk, posedge areset) begin    
        if(areset)begin
            state <= B;
        end
        else begin
            state <= next_state;
        end
    end

    assign out = (state == B);

endmodule

//Fsm1s
module fsm1s(clk, reset, in, out);
    input clk;
    input reset;    
    input in;
    output out; 
    reg out;

    reg present_state, next_state;
    parameter A=0,B=1;

    always @(posedge clk) begin
        if (reset) begin
            present_state = B; 
            out = 1'b1;
        end else begin
            case (present_state)
                A: next_state = (in == 1'b0) ? B : A;
                B: next_state = (in == 1'b0) ? A : B;
            endcase

            present_state = next_state; 

            case (present_state)
                A: out = 1'b0;
                B: out = 1'b1;
            endcase
        end
    end

endmodule

//Fsm2
module fsm2(
    input clk,
    input areset,    
    input j,
    input k,
    output out);  

    parameter OFF=0, ON=1; 
    reg state, next_state;

    always @(*) begin
        case(state)
            OFF: next_state = (j == 0) ? OFF : ON;
            ON: next_state = (k == 0) ? ON : OFF;
        endcase
    end

    always @(posedge clk, posedge areset) begin
        if(areset)begin
            state <= OFF;
        end
        else begin
            state <= next_state;  
        end
    end

    assign out = (state == ON);

endmodule

//Fsm2s
module fsm2s(
    input clk,
    input reset,    
    input j,
    input k,
    output out);  

    parameter OFF=0, ON=1; 
    reg state, next_state;

    always @(*) begin
       case(state)
            OFF: next_state = (j == 0) ? OFF : ON;
            ON: next_state = (k == 0) ? ON : OFF;
       endcase
    end

    always @(posedge clk) begin
        if(reset)begin
            state <= OFF;
        end
        else begin
            state <= next_state;
        end
    end

    assign out = (state == ON);

endmodule

//Fsm3comb
module fsm3comb(
    input in,
    input [1:0] state,
    output [1:0] next_state,
    output out); 

    parameter A=0, B=1, C=2, D=3;
    
    always @(*) begin
        case(state)
            A: next_state = (in == 0)?A:B;
            B: next_state = (in == 0)?C:B;
            C: next_state = (in == 0)?A:D;
            D: next_state = (in == 0)?C:B;
        endcase
    end
    
    assign out = (state == D);
        
endmodule

//Fsm3onehot
module fsm3onehot(
    input in,
    input [3:0] state,
    output [3:0] next_state,
    output out); 

    parameter A=0, B=1, C=2, D=3;

    assign next_state[A] = state[A]&~in|state[C]&~in;
    assign next_state[B] = state[A]&in|state[B]&in|state[D]&in;
    assign next_state[C] = state[B]&~in|state[D]&~in;
    assign next_state[D] = state[C]&in;

    assign out = state[D];

endmodule

//Fsm3
module fsm3(
    input clk,
    input in,
    input areset,
    output out); 
    parameter A=2'b00,B=2'b01,C=2'b10,D=2'b11;
    reg [1:0]state,next_state;
    always @(*) begin
        case (state)
            A: next_state = (in == 0) ? A : B;
            B: next_state = (in == 0) ? C : B;
            C: next_state = (in == 0) ? A : D;
            D: next_state = (in == 0) ? C : B;
        endcase
    end
    always @(posedge clk , posedge areset) begin
        if(areset)begin
            state <= A;
        end
        else begin
            state <= next_state;
        end
    end
    
    assign out = (state == D);

endmodule

//Fsm3s
module fsm3s(
    input clk,
    input in,
    input reset,
    output out); 
    parameter A=2'b00,B=2'b01,C=2'b10,D=2'b11;
    reg [1:0]state,next_state;
    always @(*) begin
        case (state)
            A: next_state = (in == 0) ? A : B;
            B: next_state = (in == 0) ? C : B;
            C: next_state = (in == 0) ? A : D;
            D: next_state = (in == 0) ? C : B;
        endcase
    end
    always @(posedge clk) begin
        if(reset)begin
            state <= A;
        end
        else begin
            state <= next_state;
        end
    end
    
    assign out = (state == D);

endmodule
