`timescale 1ns/1ps

module PWM_tb;

  // Inputs
  logic i_clk;
  logic i_rst_n;
  logic [3:0] i_duty;

  // Output
  logic o_pwm;

  // Instantiate the DUT
  PWM dut (
    .i_clk(i_clk),
    .i_rst_n(i_rst_n),
    .i_duty(i_duty),
    .o_pwm(o_pwm)
  );

  // Clock Generation
  initial begin
    i_clk = 0;
    forever #10 i_clk = ~i_clk; // 100MHz clock (period = 10ns)
  end

  // Test sequence
  initial begin
    // Initialize
    i_rst_n = 0;
    i_duty = 4'd0;
    #20;
    i_rst_n = 1;

    // Test with 25% duty (4/16)
    #10;
    i_duty = 4'd4;
    #1600;

    // Test with 50% duty (8/16)
    i_duty = 4'd8;
    #1600;

    // Test with 75% duty (12/16)
    i_duty = 4'd12;
    #1550;

    // Test with 0% duty (always LOW)
    i_duty = 4'd0;
    #600;

    // Test with 100% duty (should be mostly HIGH at counter wrap)
    i_duty = 4'd15;
    #1600;
    #100
    // Finish simulation
    $stop;
  end



endmodule
