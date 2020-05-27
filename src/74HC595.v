`timescale 1 ns/1 ps
module hc595(
    output  wire    [7:0]   Q,  //数据并行输出
    output  wire    DH,         //数据串行输出
    input   wire    ST_CP,      //输出锁存
    input   wire    OE,         //输出使能
    input   wire    DS,         //数据串行输入
    input   wire    MR,         //复位（低电平有效)
    input   wire    SH_CP       //时钟
);

reg [7:0] shift;
assign DH = DS;



always @(posedge SH_CP or negedge MR)
begin
    if (!MR)
    begin
        shift <= 8'h0;
    end
    else
    begin
        if (ST_CP)
        begin
            shift <= {shift[6:0], DS};
        end
    end
end

assign Q = (OE) ? shift : Q;   

endmodule // 74hc595