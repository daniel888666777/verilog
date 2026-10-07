//Exams/ece241 2013 q4
module moorefsm (
    input clk,
    input reset,
    input [3:1] s,
    output reg fr3,
    output reg fr2,
    output reg fr1,
    output reg dfr
);

    parameter BELOW = 0, UP12 = 1, DN12 = 2, UP23 = 3, DN23 = 4, ABOVE = 5;
    reg [2:0] state, next_state;

    always @(posedge clk) begin
        if (reset)
            state <= BELOW; 
        else
            state <= next_state;
    end

    always @(*) begin
        case (state)
            BELOW: next_state = (s == 3'b001) ? UP12 : BELOW;
            UP12: if (s == 3'b011) next_state = UP23;
                  else if (s == 3'b000) next_state = BELOW;
                  else next_state = UP12;
            DN12: if (s == 3'b011) next_state = UP23;
                  else if (s == 3'b000) next_state = BELOW;
                  else next_state = DN12;
            UP23: if (s == 3'b111) next_state = ABOVE;
                  else if (s == 3'b001) next_state = DN12;
                  else next_state = UP23;
            DN23: if (s == 3'b111) next_state = ABOVE;
                  else if (s == 3'b001) next_state = DN12;
                  else next_state = DN23;
            ABOVE: next_state = (s == 3'b011) ? DN23 : ABOVE;
            default: next_state = BELOW;
        endcase
    end

    always @(*) begin
        case (state)
            BELOW: begin fr3 = 1'b1; fr2 = 1'b1; fr1 = 1'b1; dfr = 1'b1;
            end
            UP12: begin fr3 = 1'b0; fr2 = 1'b1; fr1 = 1'b1; dfr = 1'b0;
            end
            DN12: begin fr3 = 1'b0; fr2 = 1'b1; fr1 = 1'b1; dfr = 1'b1;
            end
            UP23: begin fr3 = 1'b0; fr2 = 1'b0; fr1 = 1'b1; dfr = 1'b0;
            end
            DN23: begin fr3 = 1'b0; fr2 = 1'b0; fr1 = 1'b1; dfr = 1'b1;
            end
            ABOVE: begin fr3 = 1'b0; fr2 = 1'b0; fr1 = 1'b0; dfr = 1'b0;
            end
            default: begin fr3 = 1'b0; fr2 = 1'b0; fr1 = 1'b0; dfr = 1'b0;
            end
        endcase
    end

endmodule

//Lemmings1
module Lemmings1(
    input clk,
    input areset,   
    input bump_left,
    input bump_right,
    output walk_left,
    output walk_right);  

    parameter LEFT = 0,RIGHT =1;
    reg state, next_state;

    always @(*) begin
        case(state)
            LEFT: next_state = (bump_left) ? RIGHT : LEFT;
            RIGHT: next_state = (bump_right) ? LEFT : RIGHT;
        endcase
    end

    always @(posedge clk, posedge areset) begin
        if(areset)
            state <= LEFT;
        else
            state <= next_state;
    end

    assign walk_left = (state == LEFT);
    assign walk_right = (state == RIGHT);

endmodule

//Lemmings2
module Lemmings2(
    input clk,
    input areset,    
    input bump_left,
    input bump_right,
    input ground,
    output walk_left,
    output walk_right,
    output aaah); 

    parameter L = 0, R = 1, FALL_L = 2, FALL_R = 3;

    reg [1:0] state, next_state;

    always @(*) begin
        case (state)
           L: if (!ground) 
                   next_state = FALL_L;      
              else if (bump_left) 
                   next_state = R;       
              else 
                   next_state = L;            
           R: if (!ground) 
                   next_state = FALL_R;
              else if (bump_right) 
                   next_state = L;
              else 
                   next_state = R;     
           FALL_L:  if (ground) 
                      next_state = L;          
                    else 
                      next_state = FALL_L;   
           FALL_R:  if (ground) 
                      next_state = R;                   
                    else 
                      next_state = FALL_R;
           default: next_state = L;
        endcase
    end

    always @(posedge clk , posedge areset) begin
        if (areset)
            state <= L;  
        else 
            state <= next_state;
    end

    assign walk_left  = (state == L);
    assign walk_right = (state == R);
    assign aaah = (state == FALL_L) || (state == FALL_R);

endmodule

//Lemmings3
module Lemmings3(
    input clk,
    input areset,    
    input bump_left,
    input bump_right,
    input ground,
    input dig,
    output walk_left,
    output walk_right,
    output aaah,
    output digging
); 

    parameter L = 0, R = 1, FALL_L = 2, FALL_R = 3, DIG_L = 4, DIG_R = 5;

    reg [2:0] state, next_state;

    always @(*) begin
        case (state)
            L: if (!ground)             
                   next_state = FALL_L;      
               else if (dig)            
                   next_state = DIG_L;       
               else if (bump_left)    
                   next_state = R;        
               else 
                   next_state = L;            
                   
            R: if (!ground) 
                   next_state = FALL_R;
               else if (dig) 
                   next_state = DIG_R;
               else if (bump_right) 
                   next_state = L;
               else 
                   next_state = R;      
                   
            DIG_L: if (!ground)         
                       next_state = FALL_L;
                   else             
                       next_state = DIG_L;
                       
            DIG_R: if (!ground) 
                       next_state = FALL_R;
                   else 
                       next_state = DIG_R;
                       
            FALL_L:  if (ground) 
                       next_state = L;          
                     else 
                       next_state = FALL_L;   
                       
            FALL_R:  if (ground) 
                       next_state = R;                    
                     else 
                       next_state = FALL_R;
                       
            default: next_state = L;
        endcase
    end

    always @(posedge clk , posedge areset) begin
        if (areset)
            state <= L;  
        else 
            state <= next_state;
    end

    assign walk_left  = (state == L);
    assign walk_right = (state == R);
    assign aaah       = (state == FALL_L) || (state == FALL_R);
    assign digging    = (state == DIG_L)  || (state == DIG_R);

endmodule

//Lemmings4
module Lemmings4(
    input clk,
    input areset,    
    input bump_left,
    input bump_right,
    input ground,
    input dig,
    output walk_left,
    output walk_right,
    output aaah,
    output digging
); 

    parameter L = 0, R = 1, FALL_L = 2, FALL_R = 3, DIG_L = 4, DIG_R = 5, SPLAT = 6;

    reg [2:0] state, next_state;
    reg [4:0] count; 

    always @(posedge clk or posedge areset) begin
        if (areset)
            count <= 0;
        else if (state == FALL_L || state == FALL_R) begin
            if (count < 21) 
                count <= count + 1;
        end
        else
            count <= 0;
    end

    always @(*) begin
        case (state)
            L: if (!ground)             
                   next_state = FALL_L;      
               else if (dig)            
                   next_state = DIG_L;       
               else if (bump_left)      
                   next_state = R;        
               else 
                   next_state = L;            
                   
            R: if (!ground) 
                   next_state = FALL_R;
               else if (dig) 
                   next_state = DIG_R;
               else if (bump_right) 
                   next_state = L;
               else 
                   next_state = R;      
                   
            DIG_L: if (!ground)         
                       next_state = FALL_L;
                   else                 
                       next_state = DIG_L;
                       
            DIG_R: if (!ground) 
                       next_state = FALL_R;
                   else 
                       next_state = DIG_R;
                       
            FALL_L: if (ground) begin
                    if (count > 19)       
                            next_state = SPLAT;
                        else                   
                            next_state = L;
                    end 
                    else 
                        next_state = FALL_L;   
                       
            FALL_R: if (ground) begin
                    if (count > 19)
                            next_state = SPLAT;
                        else
                            next_state = R;
                    end 
                    else
                        next_state = FALL_R;

            SPLAT: next_state = SPLAT;         
                       
            default: next_state = L;
        endcase
    end

    always @(posedge clk or posedge areset) begin
        if (areset)
            state <= L;  
        else 
            state <= next_state;
    end

    assign walk_left = (state == L);
    assign walk_right = (state == R);
    assign aaah = (state == FALL_L) || (state == FALL_R);
    assign digging = (state == DIG_L)  || (state == DIG_R);

endmodule

//Fsm onehot
module onehot(
    input in,
    input [9:0] state,
    output [9:0] next_state,
    output out1,
    output out2);
    
    assign next_state[0] = (state[0] & ~in) | (state[1] & ~in) | (state[2] & ~in) | (state[3] & ~in) | (state[4] & ~in) | (state[7] & ~in) | (state[8] & ~in) | (state[9] & ~in);
    assign next_state[1] = (state[0] & in) | (state[8] & in) | (state[9] & in);
    assign next_state[2] = state[1] & in;
    assign next_state[3] = state[2] & in;
    assign next_state[4] = state[3] & in;
    assign next_state[5] = state[4] & in;
    assign next_state[6] = state[5] & in;
    assign next_state[7] = (state[6] & in) | (state[7] & in);
    assign next_state[8] = state[5] & ~in;
    assign next_state[9] = state[6] & ~in;
    assign out1 = state[8] | state[9];
    assign out2 = state[7] | state[9];

endmodule

//Fsm ps2
module ps2(
    input clk,
    input [7:0]in,
    input reset,   
    output done);
    
    parameter B1 = 0,B2 = 1,B3 = 2,D = 3; 
    
    reg [1:0] state,next_state;
    
    always @(*) begin
        case(state)
            B1: next_state = (in[3]) ? B2 : B1;
            B2: next_state = B3;
            B3: next_state = D;
            D : next_state = (in[3]) ? B2 : B1;
            default: next_state = B1;
        endcase
    end

    always @(posedge clk) begin
        if(reset)
            state <= B1;
        else
            state <= next_state;
    end
 
    assign done = (state == D);

endmodule

//Fsm ps2data
module ps2data(
    input clk,
    input [7:0] in,
    input reset,   
    output [23:0] out_bytes,
    output done); 

    parameter B1 = 0,B2 = 1,B3 = 2,D = 3; 
    
    reg [1:0] state,next_state;
    
    always @(*) begin
        case(state)
            B1: next_state = (in[3]) ? B2 : B1;
            B2: next_state = B3;
            B3: next_state = D;
            D : next_state = (in[3]) ? B2 : B1;
            default: next_state = B1;
        endcase
    end

    always @(posedge clk) begin
        if(reset)
            state <= B1;
        else begin
            state <= next_state;
            out_bytes <= {out_bytes[15:0],in};
        end
    end
 
    assign done = (state == D);

endmodule

//Fsm serial
module serial(
    input clk,
    input in,
    input reset,   
    output done
); 

    parameter START = 0, S1 = 1, S2 = 2, S3 = 3, S4 = 4, S5 = 5, S6 = 6, S7 = 7, S8 = 8,STOP = 9, DONE = 10, ERROR = 11;

    reg [3:0] state, next_state;

    always @(*) begin
        case (state)
            START: next_state = (in) ? START : S1;  
            S1: next_state = S2;
            S2: next_state = S3;
            S3: next_state = S4;
            S4: next_state = S5;
            S5: next_state = S6;
            S6: next_state = S7;
            S7: next_state = S8;
            S8: next_state = STOP;
            STOP: next_state = (in) ? DONE : ERROR;
            DONE: next_state = (in) ? START : S1;  
            ERROR: next_state = (in) ? START : ERROR; 
            default: next_state = START;
        endcase
    end

    always @(posedge clk) begin
        if (reset)
            state <= START;
        else
            state <= next_state;
    end

    assign done = (state == DONE);

endmodule

//Fsm serialdata
module serialdata(
    input clk,
    input in,
    input reset,   
    output [7:0] out_byte,
    output done
); 

    parameter START = 0, S1 = 1, S2 = 2, S3 = 3, S4 = 4, S5 = 5, S6 = 6, S7 = 7, S8 = 8, STOP = 9, DONE = 10, ERROR = 11;

    reg [3:0] state, next_state;

    always @(*) begin
        case (state)
            START: next_state = (in) ? START : S1;  
            S1: next_state = S2;
            S2: next_state = S3;
            S3: next_state = S4;
            S4: next_state = S5;
            S5: next_state = S6;
            S6: next_state = S7;
            S7: next_state = S8;
            S8: next_state = STOP;
            STOP: next_state = (in) ? DONE : ERROR;
            DONE: next_state = (in) ? START : S1;  
            ERROR: next_state = (in) ? START : ERROR; 
            default: next_state = START;
        endcase
    end

    always @(posedge clk) begin
        if (reset) begin
            state <= START;
        end else begin
            state <= next_state;
            if (state >= S1 && state <= S8) begin
                out_byte <= {in, out_byte[7:1]}; 
            end
        end
    end

    assign done = (state == DONE);

endmodule

//Fsm serialdp
module serialdp(
    input clk,
    input in,
    input reset,  
    output [7:0] out_byte,
    output done
); 

    parameter START = 0, S1 = 1, S2 = 2, S3 = 3, S4 = 4, S5 = 5, S6 = 6, S7 = 7, S8 = 8, S9 = 9, STOP = 10, DONE = 11, ERROR = 12;

    reg [3:0] state, next_state;

    wire odd;
    wire pr;

    always @(*) begin
        case (state)
            START: next_state = (in) ? START : S1;
            S1:    next_state = S2;
            S2:    next_state = S3;
            S3:    next_state = S4;
            S4:    next_state = S5;
            S5:    next_state = S6;
            S6:    next_state = S7;
            S7:    next_state = S8;
            S8:    next_state = S9; 
            S9:    next_state = STOP; 
            STOP:  if (in) 
                     next_state = (odd) ? DONE : START; 
                   else 
                     next_state = ERROR;
            DONE:  next_state = (in) ? START : S1;
            ERROR: next_state = (in) ? START : ERROR;
            default: next_state = START;
        endcase
    end

    always @(posedge clk) begin
        if (reset)
            state <= START;
        else begin
            state <= next_state;
            if (state >= S1 && state <= S8) begin
                out_byte <= {in, out_byte[7:1]};
            end
        end
    end
    
    assign done = (state == DONE);
    assign pr = (reset || (state == START) || (state == DONE) || (state == ERROR));

    parity p1(.clk(clk),.reset(pr),.in(in),.odd(odd));

endmodule

//Fsm hdlc
module hdlc(
    input clk,
    input reset,    
    input in,
    output disc,
    output flag,
    output err);
    
    parameter NONE = 0, ONE = 1, TWO = 2, THREE = 3, FOUR = 4, FIVE = 5, SIX = 6, DISCARD = 7, FLAG = 8, ERROR = 9;

    reg [3:0] state, next_state;

    always @(*) begin
        case (state)
            NONE: next_state = (in) ? ONE : NONE;
            ONE: next_state = (in) ? TWO : NONE;
            TWO: next_state = (in) ? THREE : NONE;
            THREE: next_state = (in) ? FOUR : NONE;
            FOUR: next_state = (in) ? FIVE : NONE;
            FIVE: next_state = (in) ? SIX : DISCARD;  
            SIX: next_state = (in) ? ERROR : FLAG; 
            DISCARD: next_state = (in) ? ONE : NONE;
            FLAG: next_state = (in) ? ONE : NONE;
            ERROR: next_state = (in) ? ERROR : NONE;   
            default: next_state = NONE;
        endcase
    end
    
    always @(posedge clk) begin
        if (reset)
            state <= NONE;
        else
            state <= next_state;
    end

    assign disc = (state == DISCARD);
    assign flag = (state == FLAG);
    assign err  = (state == ERROR);

endmodule

//Exams/ece241 2013 q8
module mealy (
    input clk,
    input aresetn,   
    input x,
    output z ); 

    parameter S0 = 0, S1 = 1, S2 = 2;
    reg [1:0] state, next_state;

    always @(*) begin
        case (state)
            S0: next_state = x ? S1 : S0;  
            S1: next_state = x ? S1 : S2;  
            S2: next_state = x ? S1 : S0;  
            default: next_state = S0;
        endcase
    end

    always @(posedge clk or negedge aresetn) begin
        if (!aresetn) 
            state <= S0;
        else 
            state <= next_state;
    end
   
    assign z = (state == S2) && (x == 1'b1);

endmodule

//Exams/ece241 2014 q5a
module q5a (
    input clk,
    input areset,   
    input x,
    output z
); 

    parameter S0 = 0, S1 = 1, S2 = 2;
    reg [1:0] state, next_state;

    always @(*) begin
        case (state)
            S0: next_state = x ? S1 : S0;  
            S1: next_state = x ? S2 : S1;  
            S2: next_state = x ? S2 : S1;  
            default: next_state = S0;
        endcase
    end

    always @(posedge clk , posedge areset) begin
        if (areset)
            state <= S0;
        else
            state <= next_state;
    end

    assign z = (state == S1);

endmodule

//Exams/ece241 2014 q5b
module q5b (
    input clk,
    input areset,
    input x,
    output z
); 
    
    reg [1:0]state,next_state;
    
    assign next_state[0] = ~x & state[0];
    assign next_state[1] = x & state[0] | state[1];
    
    always @(posedge clk , posedge areset)begin
        if(areset)
            state <= 2'b01;
        else
            state <= next_state;
    end
    
    assign z = (~x & state[1]) | (x & state[0]);
  
endmodule

//Exams/2014 q3fsm
module q3fsm (
    input clk,
    input reset,
    input s,
    input w,
    output reg z
);

    parameter A = 0, B1 = 1, B2 = 2, B3 = 3;
    reg [1:0] state, next_state;
    reg [1:0] count; 

    always @(*) begin
        case (state)
            A:  next_state = s ? B1 : A; 
            B1: next_state = B2;        
            B2: next_state = B3;        
            B3: next_state = B1;        
            default: next_state = A;
        endcase
    end

    always @(posedge clk) begin
        if (reset)
            state <= A;
        else
            state <= next_state;
    end

    always @(posedge clk) begin
        if (reset) begin
            count <= 0;
            z <= 0;
        end else begin
            case (state)
                A: begin
                    count <= 0;
                    z <= 0;
                end
                B1: begin
                    count <= w;  
                    z <= 0;      
                end
                B2: begin
                    count <= count + w; 
                    z <= 0;
                end
                B3: begin
                    if (count + w == 2) 
                        z <= 1;  
                    else
                        z <= 0;
                end
            endcase
        end
    end

endmodule

//Exams/2014 q3bfsm
module q3bfsm (
    input clk,
    input reset,  
    input x,
    output z
);

    parameter S0 = 0, S1 = 1, S2 = 2, S3 = 3, S4 = 4;

    reg [2:0] state, next_state;

    always @(*) begin
        case (state)
            S0: next_state = x ? S1 : S0;  
            S1: next_state = x ? S4 : S1;  
            S2: next_state = x ? S1 : S2;  
            S3: next_state = x ? S2 : S1;  
            S4: next_state = x ? S4 : S3;  
            default: next_state = S0;
        endcase
    end

    always @(posedge clk) begin
        if (reset)
            state <= S0;  
        else
            state <= next_state;
    end

    assign z = (state == S3) || (state == S4);

endmodule

//Exams/2014 q3c
module q3c (
    input clk,          
    input [2:0] y,     
    input x,
    output Y0,
    output z
);

    assign z = (y == 3'b011) | (y == 3'b100);

    assign Y0 = ((y == 3'b000) & x) |
                ((y == 3'b001) & ~x) |
                ((y == 3'b010) & x) |
                ((y == 3'b011) & ~x) |
                ((y == 3'b100) & ~x);

endmodule

//Exams/m2014 q6b
module q6b (
    input [3:1] y,
    input w,
    output Y2);

    assign Y2 = (y == 3'b001) | 
                ((y == 3'b010) & w) | 
                ((y == 3'b100) & w) | 
                (y == 3'b101);

endmodule

//Exams/m2014 q6c
module q6c (
    input [6:1] y,
    input w,
    output Y2,
    output Y4);

    assign Y2 = y[1] & ~w;
    assign Y4 = (y[2] & w) | (y[3] & w) | (y[5] & w) | (y[6] & w);

endmodule

//Exams/m2014 q6
module q6 (
    input clk,
    input reset,     
    input w,
    output z);

    parameter A = 0, B = 1, C = 2, D = 3, E = 4, F = 5;
    reg [2:0] state, next_state;

    always @(*) begin
        case (state)
            A: next_state = w ? A : B;
            B: next_state = w ? D : C;
            C: next_state = w ? D : E;
            D: next_state = w ? A : F;
            E: next_state = w ? D : E;
            F: next_state = w ? D : C;
            default: next_state = A;
        endcase
    end

    always @(posedge clk) begin
        if (reset)
            state <= A;
        else
            state <= next_state;
    end
   
    assign z = (state == E) | (state == F);

endmodule

//Exams/2012 q2fsm
module q2fsm (
    input clk,
    input reset,
    input w,
    output z
);

    parameter A = 0, B = 1, C = 2, D = 3, E = 4, F = 5;
    reg [2:0] state, next_state;

    always @(*) begin
        case (state)
            A: next_state = w ? B : A;
            B: next_state = w ? C : D;
            C: next_state = w ? E : D;
            D: next_state = w ? F : A;
            E: next_state = w ? E : D;
            F: next_state = w ? C : D;
            default: next_state = A;
        endcase
    end

    always @(posedge clk) begin
        if (reset)
            state <= A;
        else
            state <= next_state;
    end

    assign z = (state == E) | (state == F);

endmodule

//Exams/2012 q2b
module top_module (
    input [5:0] y,
    input w,
    output Y1,
    output Y3
);
    
    assign Y1 = y[0] & w;
    assign Y3 = (y[1] & ~w) | (y[2] & ~w) | (y[4] & ~w) | (y[5] & ~w);

endmodule

//Exams/2013 q2afsm
module q2afsm (
    input clk,
    input resetn,    
    input [3:1] r,   
    output [3:1] g   
);

    parameter A = 0, B = 1, C = 2, D = 3;
    reg [1:0] state, next_state;

    always @(*) begin
        case (state)
            A: begin
                if (r[1])
                    next_state = B;
                else if (r[2])
                    next_state = C;
                else if (r[3])
                    next_state = D;
                else
                    next_state = A;
            end
            B: next_state = r[1] ? B : A; 
            C: next_state = r[2] ? C : A;
            D: next_state = r[3] ? D : A;
            default: next_state = A;
        endcase
    end

    always @(posedge clk) begin
        if (!resetn)    
            state <= A;
        else
            state <= next_state;
    end

    assign g[1] = (state == B);
    assign g[2] = (state == C);
    assign g[3] = (state == D);

endmodule

//Exams/2013 q2bfsm
module q2bfsm (
    input clk,
    input resetn,   
    input x,
    input y,
    output f,
    output g
);

    parameter A = 0, B = 1;
    parameter Wait1 = 2, Got1 = 3, Got10 = 4;
    parameter Timer1 = 5, Timer2 = 6;
    parameter Perm_G1 = 7, Perm_G0 = 8;
    
    reg [3:0] state, next_state;

    always @(*) begin
        case (state)
            A: next_state = B;
            B: next_state = Wait1;
            Wait1: next_state = x ? Got1 : Wait1;
            Got1: next_state = x ? Got1 : Got10;
            Got10: next_state = x ? Timer1 : Wait1;           
            Timer1: next_state = y ? Perm_G1 : Timer2;
            Timer2: next_state = y ? Perm_G1 : Perm_G0;            
            Perm_G1: next_state = Perm_G1;
            Perm_G0: next_state = Perm_G0;            
            default: next_state = A;
        endcase
    end

    always @(posedge clk) begin
        if (!resetn)
            state <= A;
        else
            state <= next_state;
    end

    assign f = (state == B);
    assign g = (state == Timer1) | (state == Timer2) | (state == Perm_G1);

endmodule
