// example1 : randomization 
class packet;

    rand  bit [3:0] data;
    randc bit [3:0] addr;
    randc bit     rdn_wr;

    function void print(); // prints data,addr,rdn_wr
        $display("\t data=%4b addr=%4b rdn_wr=%0b",data,addr,rdn_wr);
    endfunction

endclass

module ex1;
    packet pkt;
    initial begin
        pkt=new();
        $display("---------------------------------------------");
        repeat(20) begin
            pkt.randomize(); //randomize variable declare as rand or randc
            pkt.print();     //print values of variables
        end
        $display("---------------------------------------------");
    end
endmodule

/* output
# KERNEL: ---------------------------------------------
9# KERNEL: 	 data=1001 addr=1100 rdn_wr=1
# KERNEL: 	 data=1101 addr=0110 rdn_wr=0
# KERNEL: 	 data=1011 addr=1010 rdn_wr=1
# KERNEL: 	 data=0000 addr=1001 rdn_wr=0
# KERNEL: 	 data=0001 addr=0101 rdn_wr=1
# KERNEL: 	 data=1011 addr=0111 rdn_wr=0
# KERNEL: 	 data=0101 addr=0001 rdn_wr=1
# KERNEL: 	 data=1101 addr=1101 rdn_wr=0
# KERNEL: 	 data=0011 addr=1110 rdn_wr=1
# KERNEL: 	 data=1001 addr=1000 rdn_wr=0
# KERNEL: 	 data=0000 addr=0100 rdn_wr=0
# KERNEL: 	 data=1000 addr=1011 rdn_wr=1
# KERNEL: 	 data=0000 addr=1111 rdn_wr=1
# KERNEL: 	 data=1101 addr=0011 rdn_wr=0
# KERNEL: 	 data=0101 addr=0010 rdn_wr=1
# KERNEL: 	 data=0011 addr=0000 rdn_wr=0
# KERNEL: 	 data=0001 addr=0010 rdn_wr=1
# KERNEL: 	 data=1011 addr=1100 rdn_wr=0
# KERNEL: 	 data=0000 addr=0001 rdn_wr=0
# KERNEL: 	 data=1011 addr=0000 rdn_wr=1
# KERNEL: ---------------------------------------------

Link : https://www.edaplayground.com/x/CN2Z 
*/

// example 2: rand_mode() -> disable rrandomization
class packet;

    rand  bit [3:0] data;
    randc bit [3:0] addr;
    randc bit     rdn_wr;

    function void print(); // prints data,addr,rdn_wr
        $display("\t data=%4b addr=%4b rdn_wr=%0b",data,addr,rdn_wr);
    endfunction

endclass

module ex1;
    packet pkt;
    initial begin
        pkt=new();
        pkt.addr.rand_mode(0);

        $display("pkt.data.rand_mode() status   = %0b",pkt.data.rand_mode());
        $display("pkt.addr.rand_mode() status   = %0b",pkt.addr.rand_mode());
        $display("pkt.rdn_wr.rand_mode() status = %0b \n",pkt.rdn_wr.rand_mode());
        
        $display("---------------------------------------------");
        repeat(20) begin
            pkt.randomize(); //randomize variable declare as rand or randc
            pkt.print();     //print values of variables
        end
        $display("---------------------------------------------");
    end
endmodule
/* output
# KERNEL: pkt.data.rand_mode() status   = 1
# KERNEL: pkt.addr.rand_mode() status   = 0
# KERNEL: pkt.rdn_wr.rand_mode() status = 1 
# KERNEL: 
# KERNEL: ---------------------------------------------
# KERNEL: 	 data=1001 addr=0000 rdn_wr=0
# KERNEL: 	 data=1101 addr=0000 rdn_wr=1
# KERNEL: 	 data=1101 addr=0000 rdn_wr=1
# KERNEL: 	 data=1111 addr=0000 rdn_wr=0
# KERNEL: 	 data=0000 addr=0000 rdn_wr=1
# KERNEL: 	 data=0001 addr=0000 rdn_wr=0
# KERNEL: 	 data=1011 addr=0000 rdn_wr=1
# KERNEL: 	 data=1101 addr=0000 rdn_wr=0
# KERNEL: 	 data=1101 addr=0000 rdn_wr=1
# KERNEL: 	 data=1111 addr=0000 rdn_wr=0
# KERNEL: 	 data=1001 addr=0000 rdn_wr=0
# KERNEL: 	 data=1000 addr=0000 rdn_wr=1
# KERNEL: 	 data=1000 addr=0000 rdn_wr=0
# KERNEL: 	 data=1111 addr=0000 rdn_wr=1
# KERNEL: 	 data=1101 addr=0000 rdn_wr=1
# KERNEL: 	 data=0111 addr=0000 rdn_wr=0
# KERNEL: 	 data=0011 addr=0000 rdn_wr=1
# KERNEL: 	 data=1101 addr=0000 rdn_wr=0
# KERNEL: 	 data=1011 addr=0000 rdn_wr=0
# KERNEL: 	 data=1110 addr=0000 rdn_wr=1
# KERNEL: ---------------------------------------------

Link  : https://www.edaplayground.com/x/fMxs
*/

// example 3: pre_randomize() and post_randomize() methods
class packet;

    rand  bit [3:0] data;
    randc bit [3:0] addr;
    randc bit     rdn_wr;

    function void pre_randomize();
        $display("=============================================");
        $display("\tdata.rand_mode() status   = %0b",  data.rand_mode());
        $display("\taddr.rand_mode() status   = %0b",  addr.rand_mode());
        $display("\trdn_wr.rand_mode() status = %0b",rdn_wr.rand_mode());
        $display("=============================================");
    endfunction

    function void post_randomize(); // prints data,addr,rdn_wr
        $display("\t data=%4b addr=%4b rdn_wr=%0b\n",data,addr,rdn_wr);
    endfunction

endclass

module ex1;
    packet pkt;
    int loop_count=10;
    initial begin
        pkt=new();
        $display("---------------------------------------------");
        for(int i=0;i<loop_count;i++) begin
            pkt.randomize(); //randomize variable declare as rand or randc
            if(i>5) begin
                pkt.rand_mode(0); //disable randomization
            end
        end
        $display("---------------------------------------------");
    end
endmodule

/*output
# KERNEL: ---------------------------------------------
# KERNEL: =============================================
# KERNEL: 	data.rand_mode() status   = 1
# KERNEL: 	addr.rand_mode() status   = 1
# KERNEL: 	rdn_wr.rand_mode() status = 1
# KERNEL: =============================================
# KERNEL: 	 data=1001 addr=1100 rdn_wr=1
# KERNEL: 
# KERNEL: =============================================
# KERNEL: 	data.rand_mode() status   = 1
# KERNEL: 	addr.rand_mode() status   = 1
# KERNEL: 	rdn_wr.rand_mode() status = 1
# KERNEL: =============================================
# KERNEL: 	 data=1101 addr=0110 rdn_wr=0
# KERNEL: 
# KERNEL: =============================================
# KERNEL: 	data.rand_mode() status   = 1
# KERNEL: 	addr.rand_mode() status   = 1
# KERNEL: 	rdn_wr.rand_mode() status = 1
# KERNEL: =============================================
# KERNEL: 	 data=1011 addr=1010 rdn_wr=1
# KERNEL: 
# KERNEL: =============================================
# KERNEL: 	data.rand_mode() status   = 1
# KERNEL: 	addr.rand_mode() status   = 1
# KERNEL: 	rdn_wr.rand_mode() status = 1
# KERNEL: =============================================
# KERNEL: 	 data=0000 addr=1001 rdn_wr=0
# KERNEL: 
# KERNEL: =============================================
# KERNEL: 	data.rand_mode() status   = 1
# KERNEL: 	addr.rand_mode() status   = 1
# KERNEL: 	rdn_wr.rand_mode() status = 1
# KERNEL: =============================================
# KERNEL: 	 data=0001 addr=0101 rdn_wr=1
# KERNEL: 
# KERNEL: =============================================
# KERNEL: 	data.rand_mode() status   = 1
# KERNEL: 	addr.rand_mode() status   = 1
# KERNEL: 	rdn_wr.rand_mode() status = 1
# KERNEL: =============================================
# KERNEL: 	 data=1011 addr=0111 rdn_wr=0
# KERNEL: 
# KERNEL: =============================================
# KERNEL: 	data.rand_mode() status   = 1
# KERNEL: 	addr.rand_mode() status   = 1
# KERNEL: 	rdn_wr.rand_mode() status = 1
# KERNEL: =============================================
# KERNEL: 	 data=0101 addr=0001 rdn_wr=1
# KERNEL: 
# KERNEL: =============================================
# KERNEL: 	data.rand_mode() status   = 0
# KERNEL: 	addr.rand_mode() status   = 0
# KERNEL: 	rdn_wr.rand_mode() status = 0
# KERNEL: =============================================
# KERNEL: 	 data=0101 addr=0001 rdn_wr=1
# KERNEL: 
# KERNEL: =============================================
# KERNEL: 	data.rand_mode() status   = 0
# KERNEL: 	addr.rand_mode() status   = 0
# KERNEL: 	rdn_wr.rand_mode() status = 0
# KERNEL: =============================================
# KERNEL: 	 data=0101 addr=0001 rdn_wr=1
# KERNEL: 
# KERNEL: =============================================
# KERNEL: 	data.rand_mode() status   = 0
# KERNEL: 	addr.rand_mode() status   = 0
# KERNEL: 	rdn_wr.rand_mode() status = 0
# KERNEL: =============================================
# KERNEL: 	 data=0101 addr=0001 rdn_wr=1
# KERNEL: 
# KERNEL: ---------------------------------------------

Link : https://www.edaplayground.com/x/JrNC
*/

// example 4 : basic constraint example

class packet;

    rand  bit [3:0] data;
    rand  bit [3:0] addr;
    randc bit     rdn_wr;

    function void print();           // prints data,addr,rdn_wr
        $display("\t data=%4b addr=%4b rdn_wr=%0b",data,addr,rdn_wr);
    endfunction

    constraint data_range{data>5;    // on randomization value of data is between 6 and 11
                          data<12;
                         }
    constraint addr_range{addr<10;}  // on randomization value of addr will always <10

endclass

module ex1;
    packet pkt;
    initial begin
        pkt=new();
        $display("---------------------------------------------");
        repeat(20) begin
            pkt.randomize();         // randomize variable declare as rand or randc
            pkt.print();             // print values of variables
        end
        $display("---------------------------------------------");
    end
endmodule

/* output
# KERNEL: ---------------------------------------------
# KERNEL: 	 data=1000 addr=0100 rdn_wr=1
# KERNEL: 	 data=0110 addr=0100 rdn_wr=0
# KERNEL: 	 data=0110 addr=1000 rdn_wr=1
# KERNEL: 	 data=1001 addr=0010 rdn_wr=0
# KERNEL: 	 data=0110 addr=0101 rdn_wr=1
# KERNEL: 	 data=0111 addr=0011 rdn_wr=0
# KERNEL: 	 data=1010 addr=0000 rdn_wr=0
# KERNEL: 	 data=1010 addr=0011 rdn_wr=1
# KERNEL: 	 data=1011 addr=0011 rdn_wr=0
# KERNEL: 	 data=0111 addr=0000 rdn_wr=1
# KERNEL: 	 data=1010 addr=1001 rdn_wr=0
# KERNEL: 	 data=0110 addr=1001 rdn_wr=1
# KERNEL: 	 data=1001 addr=0111 rdn_wr=0
# KERNEL: 	 data=0110 addr=0101 rdn_wr=1
# KERNEL: 	 data=1000 addr=0001 rdn_wr=1
# KERNEL: 	 data=0111 addr=0011 rdn_wr=0
# KERNEL: 	 data=1001 addr=0100 rdn_wr=1
# KERNEL: 	 data=1001 addr=0011 rdn_wr=0
# KERNEL: 	 data=1001 addr=1000 rdn_wr=0
# KERNEL: 	 data=0110 addr=0101 rdn_wr=1
# KERNEL: ---------------------------------------------

Link : https://www.edaplayground.com/x/8h3H
*/

// example 4 : constraint inheritance , constraint overriding

class base_packet;

    rand  bit [3:0] data;
    rand  bit [3:0] addr;
    randc bit     rdn_wr;

    function void print();           // prints data,addr,rdn_wr
        $display("\t data=%d addr=%d rdn_wr=%0b",data,addr,rdn_wr);
    endfunction

    constraint addr_range{addr<8;}  // on randomization value of addr will always < 8

endclass

class child_packet extends base_packet;

    
    function void print();           // prints data,addr,rdn_wr
        $display("\t data=%d addr=%d rdn_wr=%0b",data,addr,rdn_wr);
    endfunction

    constraint addr_range{addr>8;}  // on randomization value of addr will always > 8

endclass

module ex1;
    base_packet  pkt1;
    child_packet pkt2;
    initial begin
        pkt1=new();
        pkt2=new();
        $display("---------------------------------------------");
        repeat(10) begin
            pkt1.randomize();         // randomize variable declare as rand or randc
            pkt1.print();             // print values of variables
        end
        $display("\n---------------------------------------------\n");
        repeat(10) begin
            pkt2.randomize();         // randomize variable declare as rand or randc
            pkt2.print();             // print values of variables
        end
        $display("---------------------------------------------");
    end
endmodule

/* output
# KERNEL: ---------------------------------------------
# KERNEL: 	 data= 0 addr= 4 rdn_wr=1
# KERNEL: 	 data=11 addr= 6 rdn_wr=0
# KERNEL: 	 data= 0 addr= 7 rdn_wr=1
# KERNEL: 	 data=11 addr= 0 rdn_wr=0
# KERNEL: 	 data=13 addr= 2 rdn_wr=1
# KERNEL: 	 data=15 addr= 1 rdn_wr=0
# KERNEL: 	 data= 0 addr= 4 rdn_wr=0
# KERNEL: 	 data= 0 addr= 4 rdn_wr=1
# KERNEL: 	 data=13 addr= 7 rdn_wr=1
# KERNEL: 	 data= 3 addr= 3 rdn_wr=0
# KERNEL: 
# KERNEL: ---------------------------------------------
# KERNEL: 
# KERNEL: 	 data=14 addr=11 rdn_wr=1
# KERNEL: 	 data= 4 addr=11 rdn_wr=0
# KERNEL: 	 data=13 addr=15 rdn_wr=0
# KERNEL: 	 data= 6 addr=13 rdn_wr=1
# KERNEL: 	 data= 4 addr=15 rdn_wr=0
# KERNEL: 	 data=10 addr=13 rdn_wr=1
# KERNEL: 	 data=10 addr=10 rdn_wr=1
# KERNEL: 	 data= 8 addr=12 rdn_wr=0
# KERNEL: 	 data=11 addr=11 rdn_wr=1
# KERNEL: 	 data= 6 addr=10 rdn_wr=0
# KERNEL: ---------------------------------------------

Link : https://www.edaplayground.com/x/kPWC

*/

// example 5 : inside operator
class packet;

    rand  bit [3:0] data;
    randc bit [3:0] addr;
    randc bit     rdn_wr;

    function void print();                        // prints data,addr,rdn_wr
        $display("\t data=%d addr=%d rdn_wr=%0b",data,addr,rdn_wr);
    endfunction

    constraint addr_range {addr inside{[10:15]};} // on randomization value of addr remains between 10 and 15
    constraint data_range {data inside{[1:5]};  } // on randomization value of data remains between 1 and 5
endclass

module ex1;
    packet pkt;
    initial begin
        pkt=new();
        $display("---------------------------------------------");
        repeat(10) begin
            pkt.randomize();                      // randomize variable declare as rand or randc
            pkt.print();                          // print values of variables
        end
        $display("---------------------------------------------");
    end
endmodule
/* output
# KERNEL: ---------------------------------------------
# KERNEL: 	 data= 2 addr=12 rdn_wr=1
# KERNEL: 	 data= 2 addr=11 rdn_wr=0
# KERNEL: 	 data= 2 addr=15 rdn_wr=1
# KERNEL: 	 data= 2 addr=13 rdn_wr=0
# KERNEL: 	 data= 1 addr=10 rdn_wr=1
# KERNEL: 	 data= 3 addr=14 rdn_wr=0
# KERNEL: 	 data= 1 addr=11 rdn_wr=1
# KERNEL: 	 data= 1 addr=12 rdn_wr=0
# KERNEL: 	 data= 5 addr=15 rdn_wr=0
# KERNEL: 	 data= 3 addr=13 rdn_wr=1
# KERNEL: ---------------------------------------------

Link :https://www.edaplayground.com/x/8pAv
*/

// example 6 : if else constraint
class packet;

    rand  bit [3:0] data;
    randc bit [3:0] addr;
    randc bit     rdn_wr;
    string         range;

    function void print();                        // prints data,addr,rdn_wr
        $display("\t range=%s data=%d addr=%d rdn_wr=%0b",range,data,addr,rdn_wr);
    endfunction

    // addr_range :: if range is low then addr<8
    //               if range is high then addr>8
    //               else addr is between 5 and 9

    constraint addr_range {if(range=="low")
                                addr<8;
                           else{
                               if(range=="high")
                                    addr>8;
                                else{
                                    addr inside{[5:9]};
                                    }
                                }
                           } 
endclass

module ex1;
    packet pkt1,pkt2;
    initial begin
        pkt1=new();
        pkt2=new();
        pkt1.range  =  "low";
        pkt2.range  = "high";
        $display("---------------------------------------------");
        repeat(10) begin
            pkt1.randomize();                      // randomize variable declare as rand or randc
            pkt1.print();                          // print values of variables
        end
        $display("\n---------------------------------------------\n");
        repeat(10) begin
            pkt2.randomize();                      // randomize variable declare as rand or randc
            pkt2.print();                          // print values of variables
        end
        $display("---------------------------------------------");
    end
endmodule

/* output
---------------------------------------------
 | range=low | data= 9 addr= 2 rdn_wr=1
 | range=low | data=11 addr= 3 rdn_wr=0
 | range=low | data=10 addr= 6 rdn_wr=1
 | range=low | data= 7 addr= 4 rdn_wr=0
 | range=low | data= 0 addr= 7 rdn_wr=1
 | range=low | data= 3 addr= 5 rdn_wr=0
 | range=low | data=10 addr= 1 rdn_wr=0
 | range=low | data= 3 addr= 0 rdn_wr=1
 | range=low | data= 0 addr= 5 rdn_wr=0
 | range=low | data= 9 addr= 3 rdn_wr=1

---------------------------------------------

 | range=high | data= 7 addr=12 rdn_wr=0
 | range=high | data= 2 addr=15 rdn_wr=1
 | range=high | data=14 addr=11 rdn_wr=0
 | range=high | data= 9 addr= 9 rdn_wr=1
 | range=high | data= 6 addr=13 rdn_wr=0
 | range=high | data= 4 addr=14 rdn_wr=1
 | range=high | data= 5 addr=10 rdn_wr=0
 | range=high | data=15 addr=13 rdn_wr=1
 | range=high | data= 5 addr=11 rdn_wr=0
 | range=high | data=11 addr=10 rdn_wr=1
---------------------------------------------

Note : Aldec Rivia Pro gives error so use VCS
Link : https://www.edaplayground.com/x/eSwx
*/

// example 7 : foreach constraint-> array in assending order
// elements of array1 should increment by 1 
// elements of array2 should increment by 2
class packet;

    rand int array1[];
    rand int array2[];

    constraint array1_size {array1.size == 10;}
    constraint array2_size {array2.size == 15;}

    constraint order_array1 {foreach(array1[i]){
                                if(i==0){
                                    array1[i] inside{[1:5]};
                                    }
                                else{
                                    array1[i]==array1[i-1]+1;
                                }
                            }
                        }

    constraint order_array2 {foreach(array2[i]){
                                if(i==0){
                                    array2[i] inside{[1:5]};
                                    }
                                else{
                                    array2[i]==array2[i-1]+2;
                                }
                            }
                        }

    function void print(); 
        $display("\t array1=%p ",array1);
        $display("\t array2=%p ",array2);
    endfunction

endclass

module ex1;
    packet pkt;
    initial begin
        pkt=new();
        $display("---------------------------------------------");
        repeat(5) begin
            pkt.randomize(); //randomize variable declare as rand or randc
            pkt.print();     //print values of variables
        end
        $display("---------------------------------------------");
    end
endmodule

/* output
# KERNEL: ----------------------------------------------------------------------------
# KERNEL: 	 array1='{4, 5, 6, 7, 8, 9, 10, 11, 12, 13} 
# KERNEL: 	 array2='{3, 5, 7, 9, 11, 13, 15, 17, 19, 21, 23, 25, 27, 29, 31} 
# KERNEL: 	 array1='{3, 4, 5, 6, 7, 8, 9, 10, 11, 12} 
# KERNEL: 	 array2='{1, 3, 5, 7, 9, 11, 13, 15, 17, 19, 21, 23, 25, 27, 29} 
# KERNEL: 	 array1='{5, 6, 7, 8, 9, 10, 11, 12, 13, 14} 
# KERNEL: 	 array2='{2, 4, 6, 8, 10, 12, 14, 16, 18, 20, 22, 24, 26, 28, 30} 
# KERNEL: 	 array1='{5, 6, 7, 8, 9, 10, 11, 12, 13, 14} 
# KERNEL: 	 array2='{2, 4, 6, 8, 10, 12, 14, 16, 18, 20, 22, 24, 26, 28, 30} 
# KERNEL: 	 array1='{2, 3, 4, 5, 6, 7, 8, 9, 10, 11} 
# KERNEL: 	 array2='{1, 3, 5, 7, 9, 11, 13, 15, 17, 19, 21, 23, 25, 27, 29} 
# KERNEL: ----------------------------------------------------------------------------

Link : https://www.edaplayground.com/x/rrNV
Interview question link : https://www.edaplayground.com/x/VAs4
*/
// example 8 : constraint_mode()
class packet;

    rand  bit [3:0] data;
    randc bit [3:0] addr;
    randc bit     rdn_wr;

    constraint addr_range{addr inside{2,4,8};}
    constraint data_range{data inside{2,4,8};}
    constraint           rdn_wr_cb{rdn_wr==0;}

    function void print(); // prints data,addr,rdn_wr
        $display("\t data=%d addr=%d rdn_wr=%0b",data,addr,rdn_wr);
    endfunction

    function void constraint_status();
        $display("---------------------------------------------");
        $display("\tconstraint :: addr_range=%0b",addr_range.constraint_mode());
        $display("\tconstraint :: data_range=%0b",data_range.constraint_mode());
        $display("\tconstraint :: rdn_wr_cb =%0b", rdn_wr_cb.constraint_mode());
        $display("---------------------------------------------");
    endfunction

endclass

module ex1;
    packet pkt;
    initial begin
        pkt=new();
        pkt.constraint_status();
        
        $display("---------------------------------------------");
        
        repeat(5) begin
            pkt.randomize(); //randomize variable declare as rand or randc
            pkt.print();     //print values of variables
        end
        
        pkt.addr_range.constraint_mode(0);
        pkt.rdn_wr_cb.constraint_mode(0);
        pkt.constraint_status();
        
        repeat(5) begin
            pkt.randomize(); //randomize variable declare as rand or randc
            pkt.print();     //print values of variables
        end

        $display("---------------------------------------------");
    end
endmodule
/* output
# KERNEL: ---------------------------------------------
# KERNEL: 	constraint :: addr_range=1
# KERNEL: 	constraint :: data_range=1
# KERNEL: 	constraint :: rdn_wr_cb =1
# KERNEL: ---------------------------------------------
# KERNEL: ---------------------------------------------
# KERNEL: 	 data= 2 addr= 8 rdn_wr=0
# KERNEL: 	 data= 2 addr= 2 rdn_wr=0
# KERNEL: 	 data= 4 addr= 4 rdn_wr=0
# KERNEL: 	 data= 4 addr= 8 rdn_wr=0
# KERNEL: 	 data= 4 addr= 4 rdn_wr=0
# KERNEL: ---------------------------------------------
# KERNEL: 	constraint :: addr_range=0
# KERNEL: 	constraint :: data_range=1
# KERNEL: 	constraint :: rdn_wr_cb =0
# KERNEL: ---------------------------------------------
# KERNEL: 	 data= 2 addr=15 rdn_wr=1
# KERNEL: 	 data= 8 addr= 4 rdn_wr=0
# KERNEL: 	 data= 2 addr= 9 rdn_wr=1
# KERNEL: 	 data= 2 addr= 5 rdn_wr=0
# KERNEL: 	 data= 8 addr=12 rdn_wr=0
# KERNEL: ---------------------------------------------

Link : https://www.edaplayground.com/x/8pJz
*/

// example 9 : static constraint 
class packet;

    rand  bit [7:0] data;
    randc bit [7:0] addr;
    randc bit     rdn_wr;

    static constraint data_range {data inside{2,4,8,16,32,64,128};}
    static constraint addr_range {addr inside{2,4,8,16,32,64,128};}
    static constraint rdn_wr_cb  {rdn_wr==1;}
    
    function void print(); // prints data,addr,rdn_wr
        $display("\t data=%d addr=%d rdn_wr=%0b",data,addr,rdn_wr);
    endfunction

    function void constraint_status();
        $display("---------------------------------------------");
        $display("\tconstraint :: addr_range=%0b",addr_range.constraint_mode());
        $display("\tconstraint :: data_range=%0b",data_range.constraint_mode());
        $display("\tconstraint :: rdn_wr_cb =%0b", rdn_wr_cb.constraint_mode());
        $display("---------------------------------------------");
    endfunction


endclass

module ex1;
    packet pkt1,pkt2;
    initial begin
        pkt1=new();
        pkt2=new();
        pkt1.constraint_status();
        
        $display("---------------------------------------------");
        repeat(5) begin
            pkt1.randomize(); //randomize variable declare as rand or randc
            pkt1.print();     //print values of variables
        end

        pkt1.constraint_mode(0);
        pkt2.constraint_status();

        repeat(5) begin
            pkt1.randomize(); //randomize variable declare as rand or randc
            pkt1.print();     //print values of variables
        end
        $display("---------------------------------------------");
    end
endmodule

/* output
# KERNEL: ---------------------------------------------
# KERNEL: 	constraint :: addr_range=1
# KERNEL: 	constraint :: data_range=1
# KERNEL: 	constraint :: rdn_wr_cb =1
# KERNEL: ---------------------------------------------
# KERNEL: ---------------------------------------------
# KERNEL: 	 data= 32 addr=  4 rdn_wr=1
# KERNEL: 	 data=  2 addr=  2 rdn_wr=1
# KERNEL: 	 data= 64 addr=128 rdn_wr=1
# KERNEL: 	 data=  2 addr=  8 rdn_wr=1
# KERNEL: 	 data=  8 addr= 32 rdn_wr=1
# KERNEL: 	 ---- pkt1.constraint_mode(0) -------
# KERNEL: ---------------------------------------------
# KERNEL: 	constraint :: addr_range=0
# KERNEL: 	constraint :: data_range=0
# KERNEL: 	constraint :: rdn_wr_cb =0
# KERNEL: ---------------------------------------------
# KERNEL: 	 data=206 addr= 44 rdn_wr=0
# KERNEL: 	 data= 77 addr= 59 rdn_wr=1
# KERNEL: 	 data= 99 addr=229 rdn_wr=0
# KERNEL: 	 data=120 addr=254 rdn_wr=1
# KERNEL: 	 data=207 addr= 24 rdn_wr=1
# KERNEL: ---------------------------------------------

Link : https://www.edaplayground.com/x/Ymku
*/
 
// exaxmple 10 : inline constraint
class packet;

    rand  bit [3:0] data;
    randc bit [3:0] addr;
    randc bit     rdn_wr;

    function void print(); // prints data,addr,rdn_wr
        $display("\t data=%d addr=%d rdn_wr=%0b",data,addr,rdn_wr);
    endfunction

    constraint data_range {data inside{10:15};}
    constraint addr_range {addr<10;}

endclass

module ex1;
    packet pkt;
    initial begin
        pkt=new();
        $display("---------------------------------------------");
        repeat(10) begin
            //randomize variable declare as rand or randc
            pkt.randomize()with{pkt.addr<4; pkt.data==12; pkt.rdn_wr==1;}; 
            pkt.print();     //print values of variables
        end
        $display("---------------------------------------------");
    end
endmodule
/* output
# KERNEL: ---------------------------------------------
# KERNEL: 	 data=12 addr= 0 rdn_wr=1
# KERNEL: 	 data=12 addr= 1 rdn_wr=1
# KERNEL: 	 data=12 addr= 2 rdn_wr=1
# KERNEL: 	 data=12 addr= 3 rdn_wr=1
# KERNEL: 	 data=12 addr= 3 rdn_wr=1
# KERNEL: 	 data=12 addr= 1 rdn_wr=1
# KERNEL: 	 data=12 addr= 0 rdn_wr=1
# KERNEL: 	 data=12 addr= 2 rdn_wr=1
# KERNEL: 	 data=12 addr= 1 rdn_wr=1
# KERNEL: 	 data=12 addr= 0 rdn_wr=1
# KERNEL: ---------------------------------------------

Link : https://www.edaplayground.com/x/Ud5f

*/

// example 11  : function inside constrtaint
// description : if enable==1 then data should increment by 2 
//               continously  , else data should increment by 1
//               continously 
class packet;

    rand  bit [7:0] data;
    randc bit     enable;

    constraint data_range{data == f_enable(enable);}

    function bit[7:0] f_enable(bit enable);      
        static int unsigned count1=0;
        static int unsigned count2=2;
        if(enable==1) begin
              f_enable=count2+2;
              count2=count2+2;
        end
          else begin
              f_enable=count1+1;
              count1++;
          end
    endfunction:f_enable

    function void print(); // prints data,addr,rdn_wr
        $display("\t data=%d enable=%0b",data,enable);
    endfunction

endclass

module ex1;
    packet pkt;
    initial begin
        pkt=new();
        $display("---------------------------------------------");
        repeat(20) begin
            pkt.randomize(); //randomize variable declare as rand or randc
            pkt.print();     //print values of variables
        end
        $display("---------------------------------------------");
    end
endmodule
/* output
# KERNEL: ---------------------------------------------
# KERNEL: 	 data=  4 enable=1
# KERNEL: 	 data=  1 enable=0
# KERNEL: 	 data=  2 enable=0
# KERNEL: 	 data=  6 enable=1
# KERNEL: 	 data=  8 enable=1
# KERNEL: 	 data=  3 enable=0
# KERNEL: 	 data= 10 enable=1
# KERNEL: 	 data=  4 enable=0
# KERNEL: 	 data= 12 enable=1
# KERNEL: 	 data=  5 enable=0
# KERNEL: 	 data= 14 enable=1
# KERNEL: 	 data=  6 enable=0
# KERNEL: 	 data=  7 enable=0
# KERNEL: 	 data= 16 enable=1
# KERNEL: 	 data= 18 enable=1
# KERNEL: 	 data=  8 enable=0
# KERNEL: 	 data= 20 enable=1
# KERNEL: 	 data=  9 enable=0
# KERNEL: 	 data= 22 enable=1
# KERNEL: 	 data= 10 enable=0
# KERNEL: ---------------------------------------------

Link : https://www.edaplayground.com/x/tCd_
*/

// example 12 : soft constraint
class packet;

    rand  bit [7:0] data;
    randc bit [7:0] addr;
    randc bit     rdn_wr;

    constraint data_addr {soft data==addr;}
    constraint rdn_wr_cb {soft rdn_wr==1;}

    function void print(); // prints data,addr,rdn_wr
        $display("\t data=%d addr=%d rdn_wr=%0b",data,addr,rdn_wr);
    endfunction

endclass

module ex1;
    packet pkt;
    initial begin
        pkt=new();
        $display("---------------------------------------------");
        repeat(10) begin
            pkt.randomize();     //randomize variable declare as rand or randc 
            pkt.print();         //print values of variables
        end
        $display("overriding constraints");
        $display("---------------------------------------------");
        repeat(10) begin
              //randomize variable declare as rand or randc
            pkt.randomize()with{pkt.rdn_wr==0; pkt.addr==pkt.data+1;}; 
            pkt.print();     //print values of variables
        end
        $display("---------------------------------------------");
    end
endmodule

/* output
# KERNEL: ---------------------------------------------
# KERNEL: 	 data=188 addr=188 rdn_wr=1
# KERNEL: 	 data=151 addr=151 rdn_wr=1
# KERNEL: 	 data=110 addr=110 rdn_wr=1
# KERNEL: 	 data=158 addr=158 rdn_wr=1
# KERNEL: 	 data=192 addr=192 rdn_wr=1
# KERNEL: 	 data=162 addr=162 rdn_wr=1
# KERNEL: 	 data=221 addr=221 rdn_wr=1
# KERNEL: 	 data=238 addr=238 rdn_wr=1
# KERNEL: 	 data= 19 addr= 19 rdn_wr=1
# KERNEL: 	 data= 56 addr= 56 rdn_wr=1
# KERNEL: 	overriding constraints
# KERNEL: ---------------------------------------------
# KERNEL: 	 data=215 addr=216 rdn_wr=0
# KERNEL: 	 data=  6 addr=  7 rdn_wr=0
# KERNEL: 	 data=107 addr=108 rdn_wr=0
# KERNEL: 	 data= 30 addr= 31 rdn_wr=0
# KERNEL: 	 data= 66 addr= 67 rdn_wr=0
# KERNEL: 	 data=228 addr=229 rdn_wr=0
# KERNEL: 	 data= 13 addr= 14 rdn_wr=0
# KERNEL: 	 data= 59 addr= 60 rdn_wr=0
# KERNEL: 	 data= 46 addr= 47 rdn_wr=0
# KERNEL: 	 data=224 addr=225 rdn_wr=0
# KERNEL: ---------------------------------------------

Link : https://www.edaplayground.com/x/ZNwG

*/

// example 13 : unique constraints

class packet;

    rand int unsigned array1[];
    rand int unsigned array2[];

    constraint array1_size{array1.size==10;}
    constraint array2_size{array2.size==10;}

    constraint c_array1{unique{array1};
                        foreach(array1[i])
                            array1[i]<10;
                        }
  
  	constraint c_array2{foreach(array2[i])
                            array2[i]<10;
                        }
  
    function void print();
      $display("\t array1[Unique]=%p",array1);
      $display("\t array2[Normal]=%p",array2);
    endfunction

endclass

module ex13;
    packet pkt;
    initial begin
        pkt=new();
        repeat(10) begin
            pkt.randomize(); // randomize variable
            pkt.print();     // print array
        end
    end

endmodule

/* output
# KERNEL: 	 array1[Unique]='{2, 9, 0, 7, 3, 8, 1, 5, 6, 4}
# KERNEL: 	 array2[Normal]='{7, 1, 8, 3, 0, 5, 9, 8, 8, 7}
# KERNEL: 	 array1[Unique]='{9, 4, 7, 5, 1, 8, 3, 6, 0, 2}
# KERNEL: 	 array2[Normal]='{4, 1, 6, 3, 6, 5, 2, 5, 7, 7}
# KERNEL: 	 array1[Unique]='{6, 9, 2, 3, 0, 5, 8, 4, 1, 7}
# KERNEL: 	 array2[Normal]='{9, 6, 8, 3, 0, 2, 3, 1, 1, 7}
# KERNEL: 	 array1[Unique]='{8, 9, 1, 2, 6, 5, 7, 3, 4, 0}
# KERNEL: 	 array2[Normal]='{6, 5, 5, 0, 1, 1, 2, 1, 6, 8}
# KERNEL: 	 array1[Unique]='{8, 9, 1, 5, 7, 2, 0, 6, 4, 3}
# KERNEL: 	 array2[Normal]='{7, 5, 9, 6, 5, 5, 6, 5, 3, 0}
# KERNEL: 	 array1[Unique]='{9, 8, 2, 5, 4, 3, 7, 6, 1, 0}
# KERNEL: 	 array2[Normal]='{3, 1, 8, 5, 8, 4, 3, 6, 3, 7}
# KERNEL: 	 array1[Unique]='{2, 5, 3, 9, 7, 6, 8, 0, 1, 4}
# KERNEL: 	 array2[Normal]='{2, 2, 5, 5, 1, 0, 9, 3, 6, 9}
# KERNEL: 	 array1[Unique]='{1, 7, 6, 0, 9, 5, 8, 2, 3, 4}
# KERNEL: 	 array2[Normal]='{6, 8, 2, 9, 2, 0, 9, 8, 5, 0}
# KERNEL: 	 array1[Unique]='{9, 8, 2, 7, 3, 6, 0, 4, 1, 5}
# KERNEL: 	 array2[Normal]='{2, 6, 4, 5, 5, 8, 7, 3, 2, 8}
# KERNEL: 	 array1[Unique]='{9, 0, 6, 7, 8, 4, 1, 5, 3, 2}
# KERNEL: 	 array2[Normal]='{7, 4, 0, 7, 5, 3, 1, 9, 0, 2}

Link : https://www.edaplayground.com/x/nQ_W
*/

// example 14 : bidirectional constraint
class example;
    rand bit a;
    rand bit b;

    constraint c_block{if(a==1) b==0;
                        else b==1;
                      }
    function void print();
        $display("\t a=%0b b=%0b",a,b);
    endfunction
endclass

module ex14;
    example pkt;
    initial begin
        pkt=new();
        $display("---------------------------------------");
        repeat(10) begin
            pkt.randomize();
            pkt.print();
        end
        $display("---------------------------------------");
        repeat(10) begin
          pkt.randomize()with{pkt.b==0;};
            pkt.print();
        end
        $display("---------------------------------------");
    end
endmodule

/* output
# KERNEL: ---------------------------------------
# KERNEL: 	 a=1 b=0
# KERNEL: 	 a=1 b=0
# KERNEL: 	 a=0 b=1
# KERNEL: 	 a=0 b=1
# KERNEL: 	 a=1 b=0
# KERNEL: 	 a=1 b=0
# KERNEL: 	 a=0 b=1
# KERNEL: 	 a=0 b=1
# KERNEL: 	 a=1 b=0
# KERNEL: 	 a=0 b=1
# KERNEL: ---------------------------------------
# KERNEL: 	 a=1 b=0
# KERNEL: 	 a=1 b=0
# KERNEL: 	 a=1 b=0
# KERNEL: 	 a=1 b=0
# KERNEL: 	 a=1 b=0
# KERNEL: 	 a=1 b=0
# KERNEL: 	 a=1 b=0
# KERNEL: 	 a=1 b=0
# KERNEL: 	 a=1 b=0
# KERNEL: 	 a=1 b=0
# KERNEL: ---------------------------------------
Link : https://www.edaplayground.com/x/JvNG
*/

// example 15 : solve before
class packet;
    rand bit       a;
    rand bit [3:0] b;
   
    constraint sab { solve a before b;}
    constraint a_b { (a == 1) -> b == 0;}
  endclass
   
module inline_constr;
    initial begin
      packet pkt;
      pkt = new();
      repeat(10) begin
        pkt.randomize();
        $display("\tValue of a = %0d, b = %0d",pkt.a,pkt.b);
      end
    end
endmodule
// me before you : movie
//-----------------------------------------
//constraint my_life {solve me before you;}
//-----------------------------------------

// interview questions
// generate even sequence (0,2,4,6,8...) without using array or queue

class packet;

    rand bit [7:0]addr;
    bit is_even;

    function void print();
        $display("\t Addr=%0d",addr);
    endfunction

    constraint constraint_addr_even{ addr==addr_even();}

    function bit[7:0] addr_even();
        static int unsigned count=0; // fro odd sequence make count=1;
        addr_even=count;
        count=count+2;
    endfunction

endclass

module tb;
    packet pkt;
    initial begin
        pkt=new();
        $display("---------------------------------------");
        repeat(10) begin
            pkt.randomize();
            pkt.print();
        end
        $display("---------------------------------------");
    end
endmodule

/* output
# KERNEL: ---------------------------------------
# KERNEL: 	 Addr=0
# KERNEL: 	 Addr=2
# KERNEL: 	 Addr=4
# KERNEL: 	 Addr=6
# KERNEL: 	 Addr=8
# KERNEL: 	 Addr=10
# KERNEL: 	 Addr=12
# KERNEL: 	 Addr=14
# KERNEL: 	 Addr=16
# KERNEL: 	 Addr=18
# KERNEL: ---------------------------------------

Link : https://www.edaplayground.com/x/8ssn
*/

/* you have constraint called addr_range in class packet
as shown below, give me 3 ways in which you can make 
addr < 100.

class packet;
    rand bit[7:0] addr;

    constraint addr_range{addr>100;}

endclass

*/
// ----------------------------- 1st way -----------------
class packet;
    rand bit[7:0] addr;

    constraint addr_range{addr>100;}

    function void print();
        $display("\t Adrr=%0d",addr);
    endfunction

endclass

class child_packet extends packet;
    constraint addr_range{addr<100;}
endclass

module tb;
    child_packet pkt;
    initial begin
        pkt=new();
        $display("---------------------------------------");
        repeat(10) begin
            pkt.randomize();
            pkt.print();
        end
        $display("---------------------------------------");
    end

endmodule
/* output
# KERNEL: ---------------------------------------
# KERNEL: 	 Adrr=70
# KERNEL: 	 Adrr=22
# KERNEL: 	 Adrr=57
# KERNEL: 	 Adrr=80
# KERNEL: 	 Adrr=89
# KERNEL: 	 Adrr=58
# KERNEL: 	 Adrr=92
# KERNEL: 	 Adrr=20
# KERNEL: 	 Adrr=67
# KERNEL: 	 Adrr=73
# KERNEL: ---------------------------------------

Link : https://www.edaplayground.com/x/R2Ca
*/

// ----------------------------- 2nd way -----------------

class packet;
    rand bit[7:0] addr;

    constraint addr_range{soft addr>100;}

    function void print();
        $display("\t Adrr=%0d",addr);
    endfunction

endclass

module tb;
    packet pkt;
    initial begin
        pkt=new();
        $display("---------------------------------------");
        repeat(10) begin
            pkt.randomize()with{addr<100};
            pkt.print();
        end
        $display("---------------------------------------");
    end

endmodule
/* output
# KERNEL: ---------------------------------------
# KERNEL: 	 Adrr=70
# KERNEL: 	 Adrr=22
# KERNEL: 	 Adrr=57
# KERNEL: 	 Adrr=80
# KERNEL: 	 Adrr=89
# KERNEL: 	 Adrr=58
# KERNEL: 	 Adrr=92
# KERNEL: 	 Adrr=20
# KERNEL: 	 Adrr=67
# KERNEL: 	 Adrr=73
# KERNEL: ---------------------------------------

Link ; https://www.edaplayground.com/x/R2Ca

*/

// --------------------------- 3rd way ---------------------
class packet;
    rand bit[7:0] addr;

    constraint addr_range{addr>100;}

    function void print();
        $display("\t Adrr=%0d",addr);
    endfunction

endclass

module tb;
    packet pkt;
    initial begin
        pkt=new();
        $display("Disable constraint : pkt.addr_range.constraint_mode(0) ");
        pkt.addr_range.constraint_mode(0);
        $display("---------------------------------------");
        repeat(10) begin
          pkt.randomize()with{pkt.addr<100;};
            pkt.print();
        end
        $display("---------------------------------------");
    end

endmodule
/* output
# KERNEL: Disable constraint : pkt.addr_range.constraint_mode(0) 
# KERNEL: ---------------------------------------
# KERNEL: 	 Adrr=70
# KERNEL: 	 Adrr=22
# KERNEL: 	 Adrr=57
# KERNEL: 	 Adrr=80
# KERNEL: 	 Adrr=89
# KERNEL: 	 Adrr=58
# KERNEL: 	 Adrr=92
# KERNEL: 	 Adrr=20
# KERNEL: 	 Adrr=67
# KERNEL: 	 Adrr=73
# KERNEL: ---------------------------------------

Link : https://www.edaplayground.com/x/R2Ca

*/

// generate 10 unique numbers in array size of 10
class packet;
    rand bit[7:0] array[];

    constraint array_size{array.size==10;};
    constraint unique_array{unique{array};
                            foreach(array[i]){
                                array[i]<10;
                            }
                           };

    function void print();
        $display("\t array=%p",array);
    endfunction

endclass

module tb;
    packet pkt;
    initial begin
        pkt=new();
      	$display("-------------------------------------------------");
        repeat(5) begin
          pkt.randomize();
            pkt.print();
        end
      	$display("-------------------------------------------------");
    end

endmodule

/* output
# KERNEL: -------------------------------------------------
# KERNEL: 	 array='{3, 9, 8, 6, 4, 0, 1, 2, 7, 5}
# KERNEL: 	 array='{1, 4, 2, 7, 8, 0, 6, 3, 9, 5}
# KERNEL: 	 array='{7, 9, 2, 0, 5, 1, 8, 6, 3, 4}
# KERNEL: 	 array='{9, 8, 1, 7, 6, 5, 3, 4, 0, 2}
# KERNEL: 	 array='{7, 8, 9, 3, 1, 6, 2, 4, 5, 0}
# KERNEL: -------------------------------------------------

Link : https://www.edaplayground.com/x/aFWa 

*/