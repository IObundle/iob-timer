   //
   // TIMER
   //
   iob_timer timer
     (
      .clk      (clk),
      .rst      (reset),

      //cpu interface
      .valid(slaves_req[`valid(`TIMER)]),
      .address(slaves_req[`address(`TIMER,`TIMER_ADDR_W+2)-2]),
      .wdata(slaves_req[`wdata(`TIMER)]),
      .wstrb(slaves_req[`wstrb(`TIMER)]),
      .rdata(slaves_resp[`rdata(`TIMER)]),
      .ready(slaves_resp[`ready(`TIMER)])
      );

