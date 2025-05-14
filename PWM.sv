module PWM (
input logic 		i_clk,
input logic		i_rst_n,
input logic 	[3:0]	i_duty,

output logic		o_pwm
);

reg [4:0] counter;

localparam low  = 16;

assign high = i_duty;

always @(posedge i_clk or negedge i_rst_n) begin
   if (!i_rst_n) begin
		counter <= 0;
		o_pwm   <= 0;
	end else begin
		counter <= counter+1;

		if (i_duty == 0) begin
			o_pwm   <= 0;
			counter <= 0;
		end else if (counter == i_duty-1) begin
			o_pwm   <= 0;
		end else if (counter == 15) begin
			o_pwm   <= 1;
			counter <= 0;
		end
	end
end

endmodule
