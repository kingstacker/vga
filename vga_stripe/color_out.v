//************************************************
//  Filename      : color_out.v                             
//  Author        : kingstacker                  
//  Company       : School                       
//  Email         : kingstacker_work@163.com     
//  Device        : Altera cyclone4 ep4ce6f17c8  
//  Description   :                              
//************************************************
module  color_out #(parameter WIDTH = 10)(
    //input;
    input    wire    clk,
    input    wire    rst_n,
    input    wire    [WIDTH-1:0]  line_coo,
    input    wire    [WIDTH-1:0]  ver_coo,
    //output;
    output   reg     [15:0]        rgb_o   
);
always @(posedge clk or negedge rst_n) begin
    if (~rst_n) begin
        rgb_o <= 16'd0;
    end //if
    else begin
        if(ver_coo < 10'd255) begin
            rgb_o <= {5'b11111,6'd0,5'd0};
        end 
        else begin
            if (ver_coo < 10'd511) begin
                rgb_o <= {5'd0,6'b111111,5'd0};
            end
            else begin
                rgb_o <= {5'd0,6'd0,5'b11111};
            end
        end 
    end //else
end //always

endmodule