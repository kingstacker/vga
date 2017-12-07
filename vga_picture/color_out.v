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
reg [13:0] address_reg;
wire [13:0] address;
wire [15:0] q;
assign address = address_reg;
always @(posedge clk or negedge rst_n) begin
    if (~rst_n) begin
        address_reg <= 0;
    end //if
    else begin
        if (address_reg == 14'd9999) begin
            address_reg <= 0;
        end 
        else begin
            if (((line_coo >= 10'd1) && (line_coo <= 10'd100))&&((ver_coo >= 10'd1) && (ver_coo <= 10'd100))) begin
                address_reg <= address_reg + 1'b1;
            end //if
            else begin
                address_reg <= address_reg;
            end //else
        end
    end //else
end //always
always @(posedge clk or negedge rst_n) begin
    if (~rst_n) begin
        rgb_o <= 0;
    end //if
    else begin
        if (((line_coo >= 10'd1) && (line_coo <= 10'd100))&&((ver_coo >= 10'd1) && (ver_coo <= 10'd100))) begin
            rgb_o <= q;
        end
        else begin
            rgb_o <= {5'b11111,6'd0,5'd0};
        end
    end //else
end //always
//rom_1 inst;
rom_1  rom_1_u1( 
    .address            (address),
    .clock              (clk),
    .q                  (q)
);


endmodule