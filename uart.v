module uart(
	input clk_50M,	//50 MHz clock
	output tx		//UART transmit output
);
reg[7:0] temp_tx;
  parameter CLKS_PER_BIT = 434;
  
  localparam IDLE_1         = 4'b0000;
  localparam TX_START_BIT_1 = 4'b0001;
  localparam TX_DATA_BITS_1 = 4'b0010;
  localparam TX_STOP_BIT_1  = 4'b0011;
  localparam IDLE_2         = 4'b0100;
  localparam TX_START_BIT_2 = 4'b0101;
  localparam TX_DATA_BITS_2 = 4'b0110;
  localparam TX_STOP_BIT_2  = 4'b0111;
  localparam IDLE_3         = 4'b1000;
  localparam TX_START_BIT_3 = 4'b1001;
  localparam TX_DATA_BITS_3 = 4'b1010;
  localparam TX_STOP_BIT_3  = 4'b1011;
  localparam IDLE_4         = 4'b1100;
  localparam TX_START_BIT_4 = 4'b1101;
  localparam TX_DATA_BITS_4 = 4'b1110;
  localparam TX_STOP_BIT_4  = 4'b1111;
  
  reg [3:0] r_SM_Main = 0;
  reg [7*4:0] r_Clock_Count = 0;
  reg [2:0] r_Bit_Ind = 0;
  reg [7:0] r_TX_Data_1 = "S";
  reg [7:0] r_TX_Data_2 = "B";
  reg [7:0] r_TX_Data_3 = "3";
  reg [7:0] r_TX_Data_4 = "7";
  reg       o_TX_Act =0;
  reg       o_TX_Do = 0;
  
  always @(posedge clk_50M)
    begin

     case (r_SM_Main)
	  
      IDLE_1 :
        begin
          temp_tx  <= 1'b1;    			 
          if (r_Clock_Count < CLKS_PER_BIT-1)
          begin
            r_Clock_Count <= r_Clock_Count + 1;
            r_SM_Main     <= IDLE_1;
          end
          else
          begin
            r_Clock_Count <= 0;
            r_SM_Main     <= TX_START_BIT_1;
          end
        end 
			 
		 
      TX_START_BIT_1 :
        begin
          temp_tx <= 1'b0;
          if (r_Clock_Count < CLKS_PER_BIT-1)
          begin
            r_Clock_Count <= r_Clock_Count + 1;
            r_SM_Main     <= TX_START_BIT_1;
          end
          else
          begin
            r_Clock_Count <= 0;
            r_SM_Main     <= TX_DATA_BITS_1;
          end
        end 
		  
		       
      TX_DATA_BITS_1 :
        begin
          temp_tx <= r_TX_Data_1[r_Bit_Ind];
          if (r_Clock_Count < CLKS_PER_BIT-1)
          begin
            r_Clock_Count <= r_Clock_Count + 1;
            r_SM_Main     <= TX_DATA_BITS_1;
          end
          else
          begin
            r_Clock_Count <= 0;
			   if (r_Bit_Ind < 7)
            begin
              r_Bit_Ind <= r_Bit_Ind + 1;
              r_SM_Main   <= TX_DATA_BITS_1;
            end
            else
            begin
              r_Bit_Ind <= 0;
              r_SM_Main   <= TX_STOP_BIT_1;
            end
          end 
        end 
		  
		  
      TX_STOP_BIT_1 :
        begin
          temp_tx <= 1'b1;
          if (r_Clock_Count < CLKS_PER_BIT-1)
          begin
            r_Clock_Count <= r_Clock_Count + 1;
            r_SM_Main     <= TX_STOP_BIT_1;
          end
          else
          begin
            r_Clock_Count <= 0;
				r_SM_Main     <= IDLE_2;
          end 
        end 
		  
       IDLE_2 :
        begin
          temp_tx  <= 1'b1;    			 
          if (r_Clock_Count < CLKS_PER_BIT-1)
          begin
            r_Clock_Count <= r_Clock_Count + 1;
            r_SM_Main     <= IDLE_2;
          end
          else
          begin
            r_Clock_Count <= 0;
            r_SM_Main     <= TX_START_BIT_2;
          end
        end 
			 
		 
      TX_START_BIT_2 :
        begin
          temp_tx <= 1'b0;
          if (r_Clock_Count < CLKS_PER_BIT-1)
          begin
            r_Clock_Count <= r_Clock_Count + 1;
            r_SM_Main     <= TX_START_BIT_2;
          end
          else
          begin
            r_Clock_Count <= 0;
            r_SM_Main     <= TX_DATA_BITS_2;
          end
        end 
		  
		       
      TX_DATA_BITS_2 :
        begin
          temp_tx <= r_TX_Data_2[r_Bit_Ind];
          if (r_Clock_Count < CLKS_PER_BIT-1)
          begin
            r_Clock_Count <= r_Clock_Count + 1;
            r_SM_Main     <= TX_DATA_BITS_2;
          end
          else
          begin
            r_Clock_Count <= 0;
			   if (r_Bit_Ind < 7)
            begin
              r_Bit_Ind <= r_Bit_Ind + 1;
              r_SM_Main   <= TX_DATA_BITS_2;
            end
            else
            begin
              r_Bit_Ind <= 0;
              r_SM_Main   <= TX_STOP_BIT_2;
            end

          end 
        end 
		  
		  
      TX_STOP_BIT_2 :
        begin
          temp_tx <= 1'b1;
          if (r_Clock_Count < CLKS_PER_BIT-1)
          begin
            r_Clock_Count <= r_Clock_Count + 1;
            r_SM_Main     <= TX_STOP_BIT_2;
          end
          else
          begin
            r_Clock_Count <= 0;
				r_SM_Main     <= IDLE_3;
          end 
        end 
		  
		 IDLE_3 :
        begin
          temp_tx  <= 1'b1;    			 
          if (r_Clock_Count < CLKS_PER_BIT-1)
          begin
            r_Clock_Count <= r_Clock_Count + 1;
            r_SM_Main     <= IDLE_3;
          end
          else
          begin
            r_Clock_Count <= 0;
            r_SM_Main     <= TX_START_BIT_3;
          end
        end 
			 
		 
      TX_START_BIT_3 :
        begin
          temp_tx <= 1'b0;
          if (r_Clock_Count < CLKS_PER_BIT-1)
          begin
            r_Clock_Count <= r_Clock_Count + 1;
            r_SM_Main     <= TX_START_BIT_3;
          end
          else
          begin
            r_Clock_Count <= 0;
            r_SM_Main     <= TX_DATA_BITS_3;
          end
        end 
		  
		       
      TX_DATA_BITS_3 :
        begin
          temp_tx <= r_TX_Data_3[r_Bit_Ind];
          if (r_Clock_Count < CLKS_PER_BIT-1)
          begin
            r_Clock_Count <= r_Clock_Count + 1;
            r_SM_Main     <= TX_DATA_BITS_3;
          end
          else
          begin
            r_Clock_Count <= 0;
			   if (r_Bit_Ind < 7)
            begin
              r_Bit_Ind <= r_Bit_Ind + 1;
              r_SM_Main   <= TX_DATA_BITS_3;
            end
            else
            begin
              r_Bit_Ind <= 0;
              r_SM_Main   <= TX_STOP_BIT_3;
            end
          end 
        end 
		  
		  
      TX_STOP_BIT_3 :
        begin
          temp_tx <= 1'b1;
          if (r_Clock_Count < CLKS_PER_BIT-1)
          begin
            r_Clock_Count <= r_Clock_Count + 1;
            r_SM_Main     <= TX_STOP_BIT_3;
          end
          else
          begin
            r_Clock_Count <= 0;
				r_SM_Main     <= IDLE_4;
          end 
        end 
		 IDLE_4 :
        begin
          temp_tx  <= 1'b1;    			 
			 
			 
          if (r_Clock_Count < CLKS_PER_BIT-1)
          begin
            r_Clock_Count <= r_Clock_Count + 1;
            r_SM_Main     <= IDLE_4;
          end
          else
          begin
            r_Clock_Count <= 0;
            r_SM_Main     <= TX_START_BIT_4;
          end
        end 
			 
		 
      TX_START_BIT_4 :
        begin
          temp_tx <= 1'b0;
          if (r_Clock_Count < CLKS_PER_BIT-1)
          begin
            r_Clock_Count <= r_Clock_Count + 1;
            r_SM_Main     <= TX_START_BIT_4;
          end
          else
          begin
            r_Clock_Count <= 0;
            r_SM_Main     <= TX_DATA_BITS_4;
          end
        end 
		  
		         
      TX_DATA_BITS_4 :
        begin
          temp_tx <= r_TX_Data_4[r_Bit_Ind];
          if (r_Clock_Count < CLKS_PER_BIT-1)
          begin
            r_Clock_Count <= r_Clock_Count + 1;
            r_SM_Main     <= TX_DATA_BITS_4;
          end
          else
          begin
            r_Clock_Count <= 0;
			   if (r_Bit_Ind < 7)
            begin
              r_Bit_Ind <= r_Bit_Ind + 1;
              r_SM_Main   <= TX_DATA_BITS_4;
            end
            else
            begin
              r_Bit_Ind <= 0;
              r_SM_Main   <= TX_STOP_BIT_4;
            end

          end 
        end 
		  
		  
      TX_STOP_BIT_4 :
        begin
          temp_tx <= 1'b1;
          if (r_Clock_Count < CLKS_PER_BIT-1)
          begin
            r_Clock_Count <= r_Clock_Count + 1;
            r_SM_Main     <= TX_STOP_BIT_4;
          end
          else
          begin
				o_TX_Do       <= 1'b1;
            r_Clock_Count <= 0;
            o_TX_Act      <= 1'b0;
          end 
        end 
		  		  
      default :
        r_SM_Main <= IDLE_4;
       
    endcase
    end   
	assign tx = temp_tx;	  
