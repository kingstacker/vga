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
    input    wire    [WIDTH+1:0]  line_cnt,
    input    wire    [WIDTH+1:0]  ver_cnt,
    //output;
    output   reg     [7:0]        rgb_o   
);
 localparam HTA = 11'd128,  //sync pulse;
            HTB = 11'd88,  //back porch;
            HTC = 11'd800, //visible area;
            HTD = 11'd40,   //front porch;
            VTA = 11'd4,    //sync pulse;
           VTB = 11'd23,   //back porch;
            VTC = 11'd600,  //visible area;
            VTD = 11'd1,    //front porch;
            line_cnt_rMAX = HTA+HTB+HTC+HTD-1'b1, //max line count;
            ver_cnt_rMAX  = VTA+VTB+VTC+VTD-1'b1, //max ver  count;
            HSTART = HTA+HTB,
            VSTART = VTA+VTB;
always @(posedge clk or negedge rst_n) begin
    if (~rst_n) begin
        rgb_o <= 8'd0;
    end //if
    else begin
        if((line_cnt >= HSTART)&&(line_cnt < HSTART + HTC)&&(ver_cnt >=VSTART)&&(ver_cnt < VSTART + VTC)) begin
            if (line_cnt >= HSTART + 11'd200 && line_cnt <= HSTART + 11'd400 && ver_cnt >= VSTART + 11'd200 && ver_cnt <= VSTART + 11'd400 ) begin
                rgb_o <= {3'b111,3'b000,2'b00};
            end
            else begin
                rgb_o <= {3'b000,3'b111,2'b00};
            end
        end 
        else begin
            rgb_o <= 8'd0;
        end
    end //else
end //always


endmodule


