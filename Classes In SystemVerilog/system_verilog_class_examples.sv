// Reference : verification guide classes
// ex1 set() and get() in class

class packet;
    int loop_count;  // class property

    task set(int x); // class method
        $display("---- Inside set() ---");
        loop_count=x;
    endtask

    function int get();  // class method
        $display("--- Inside get() ---");
        return loop_count;
    endfunction

endclass

module ex1;
    packet pkt1,pkt2;
    initial begin
        pkt1=new();
        pkt2=new();
        $display("----------------------------------------------");

        $display("---- pkt1.set(100) -----");
        pkt1.set(100);
        $display("--- pkt1.get() = %0d ---",pkt1.get());

        $display("---- pkt2.set(200) -----");
        pkt2.set(200);
        $display("--- pkt2.get() = %0d ---",pkt2.get());
        $display("----------------------------------------------");
    end

endmodule

/* output
# KERNEL: ----------------------------------------------
# KERNEL: ---- pkt1.set(100) -----
# KERNEL: ---- Inside set() ---
# KERNEL: --- Inside get() ---
# KERNEL: --- pkt1.get() = 100 ---
# KERNEL: ---- pkt2.set(200) -----
# KERNEL: ---- Inside set() ---
# KERNEL: --- Inside get() ---
# KERNEL: --- pkt2.get() = 200 ---
# KERNEL: ----------------------------------------------

Link : https://www.edaplayground.com/x/9fwF
*/

// this keyword example : example 2
class packet;
    bit [7:0] addr;
    bit [7:0] data;
    bit       rdn_wr;

    function new(bit[7:0] addr,data,bit rdn_wr);
        this.addr  = addr;
        this.data  = data;
        this.rdn_wr= rdn_wr;
    endfunction

    function void display();
        $display("---------------------------------");
      	$display("\taddr   = %0d",addr);
      	$display("\tdata   = %0d",data);
      	$display("\trdn_wr = %0b",rdn_wr);
        $display("---------------------------------\n");
    endfunction

endclass

module ex2;
    packet pkt1,pkt2;
    initial begin
        pkt1=new(10,20,1);
        pkt2=new(30,40,0);

        $display("----------- pkt1.display() -------");
        pkt1.display();
        $display("----------- pkt2.display() -------");
        pkt2.display();
    end
endmodule

/* output
# KERNEL: ----------- pkt1.display() -------
# KERNEL: ---------------------------------
# KERNEL: 	addr   = 10
# KERNEL: 	data   = 20
# KERNEL: 	rdn_wr = 1
# KERNEL: ---------------------------------
# KERNEL: 
# KERNEL: ----------- pkt2.display() -------
# KERNEL: ---------------------------------
# KERNEL: 	addr   = 30
# KERNEL: 	data   = 40
# KERNEL: 	rdn_wr = 0
# KERNEL: ---------------------------------

Link : https://www.edaplayground.com/x/AkV2
*/

// class constructor : example 3
class packet;
    bit [31:0] addr;
    bit [31:0] data;

    function new();
        addr=100;
        data=25;
    endfunction

    function display();
        $display("----------------------------------");
        $display("\t addr=%0d",addr);
        $display("\t data=%0d",data);
        $display("----------------------------------\n");
    endfunction

endclass

module ex3;
    packet pk1,pk2;
    initial begin
        pk1=new();
        pk2=new();
        $display("---------- pk1.display() ----------");
        pk1.display();
        $display("---------- pk2.display() ----------");
        pk2.display();
    end
endmodule

/* output
# KERNEL: ---------- pk1.display() ---------
# KERNEL: ----------------------------------
# KERNEL: 	 addr=100
# KERNEL: 	 data=25
# KERNEL: ----------------------------------
# KERNEL: 
# KERNEL: ---------- pk2.display() ---------
# KERNEL: ----------------------------------
# KERNEL: 	 addr=100
# KERNEL: 	 data=25
# KERNEL: ----------------------------------

Link : https://www.edaplayground.com/x/TVcz 

*/

// stsatic variable : example 4
class packet;
    static int count_objects;

    function new();
        count_objects++;
    endfunction

    function display();
        $display("No of Objects Created = %0d",count_objects);
    endfunction
endclass

module ex4;
    initial begin
        packet pkt[50];
        $display("---------------------------------");
        foreach(pkt[i])
            begin
                pkt[i]=new();
            end
        pkt[20].display();
        $display("---------------------------------");
    end
endmodule

/*
# KERNEL: ---------------------------------
# KERNEL: No of Objects Created = 50
# KERNEL: ---------------------------------

Link : https://www.edaplayground.com/x/ZhaR 
*/

class packet;
    static int unsigned count_objects;
    int unsigned count_id;

    function new();
        count_id=count_objects;
        count_objects++;
    endfunction

    static function display();
        $display("No of Obj Created = %0d",count_objects);
    endfunction

endclass

module ex4;
    initial begin
        packet pkt[50];
        foreach(pkt[i])
            begin
                $display("Obj pkt[%0d] created",i);
                pkt[i]=new();
            end
        $display("-------- pkt[0-to-49].display() ----------- ");
        pkt[20].display();
        $display("-------- pkt[20].count_id = %0d ----------- ",pkt[20].count_id);
        $display("------------------------------------------- ");

    end
endmodule

/* output
# KERNEL: Obj pkt[0] created
# KERNEL: Obj pkt[1] created
# KERNEL: Obj pkt[2] created
# KERNEL: Obj pkt[3] created
# KERNEL: Obj pkt[4] created
# KERNEL: Obj pkt[5] created
# KERNEL: Obj pkt[6] created
# KERNEL: Obj pkt[7] created
# KERNEL: Obj pkt[8] created
# KERNEL: Obj pkt[9] created
# KERNEL: Obj pkt[10] created
# KERNEL: Obj pkt[11] created
# KERNEL: Obj pkt[12] created
# KERNEL: Obj pkt[13] created
# KERNEL: Obj pkt[14] created
# KERNEL: Obj pkt[15] created
# KERNEL: Obj pkt[16] created
# KERNEL: Obj pkt[17] created
# KERNEL: Obj pkt[18] created
# KERNEL: Obj pkt[19] created
# KERNEL: Obj pkt[20] created
# KERNEL: Obj pkt[21] created
# KERNEL: Obj pkt[22] created
# KERNEL: Obj pkt[23] created
# KERNEL: Obj pkt[24] created
# KERNEL: Obj pkt[25] created
# KERNEL: Obj pkt[26] created
# KERNEL: Obj pkt[27] created
# KERNEL: Obj pkt[28] created
# KERNEL: Obj pkt[29] created
# KERNEL: Obj pkt[30] created
# KERNEL: Obj pkt[31] created
# KERNEL: Obj pkt[32] created
# KERNEL: Obj pkt[33] created
# KERNEL: Obj pkt[34] created
# KERNEL: Obj pkt[35] created
# KERNEL: Obj pkt[36] created
# KERNEL: Obj pkt[37] created
# KERNEL: Obj pkt[38] created
# KERNEL: Obj pkt[39] created
# KERNEL: Obj pkt[40] created
# KERNEL: Obj pkt[41] created
# KERNEL: Obj pkt[42] created
# KERNEL: Obj pkt[43] created
# KERNEL: Obj pkt[44] created
# KERNEL: Obj pkt[45] created
# KERNEL: Obj pkt[46] created
# KERNEL: Obj pkt[47] created
# KERNEL: Obj pkt[48] created
# KERNEL: Obj pkt[49] created
# KERNEL: -------- pkt[0-to-49].display() ----------- 
# KERNEL:          No of Obj Created = 50
# KERNEL: -------- pkt[20].count_id  = 20 ----------- 
# KERNEL: ------------------------------------------- 

Link : https://www.edaplayground.com/x/VPML
*/

//object assignment : example 5

class packet;
    bit [7:0] addr;
    bit [7:0] data;
    bit       rdn_wr;

    function new();
        addr=10;
        data=10;
        rdn_wr=0;
    endfunction

    function void display();
        $display("------------------------------------------");
        $display("\t addr   = %0d",addr);
        $display("\t data   = %0d",data);
        $display("\t rdn_wr = %0b",rdn_wr);
        $display("------------------------------------------");
    endfunction

endclass

module ex5;
    packet pkt_1,pkt_2;
    initial begin
        pkt_1=new();
        $display("--------------- pkt_1.display(); -----------");
        pkt_1.display();
        $display("--------------- pkt_2=pkt_1 ----------------");
        pkt_2=pkt_1;
        $display("--------------- pkt_2.display(); -----------");
        pkt_2.display();
        $display("--------------- pkt_2.addr=20    -----------");
        pkt_2.addr=20;
        $display("--------------- pkt_2.display(); -----------");
        pkt_2.display();
        $display("--------------- pkt_1.display(); -----------");
        pkt_1.display();
    end
endmodule

/* output
# KERNEL: --------------- pkt_1.display(); -----------
# KERNEL: ------------------------------------------
# KERNEL: 		 addr   = 10
# KERNEL: 		 data   = 10
# KERNEL: 		 rdn_wr = 0
# KERNEL: ------------------------------------------
# KERNEL: --------------- pkt_2=pkt_1 ----------------
# KERNEL: --------------- pkt_2.display(); -----------
# KERNEL: ------------------------------------------
# KERNEL: 		 addr   = 10
# KERNEL: 		 data   = 10
# KERNEL: 		 rdn_wr = 0
# KERNEL: ------------------------------------------
# KERNEL: --------------- pkt_2.addr=20    -----------
# KERNEL: --------------- pkt_2.display(); -----------
# KERNEL: ------------------------------------------
# KERNEL: 		 addr   = 20
# KERNEL: 		 data   = 10
# KERNEL: 		 rdn_wr = 0
# KERNEL: ------------------------------------------
# KERNEL: --------------- pkt_1.display(); -----------
# KERNEL: ------------------------------------------
# KERNEL: 		 addr   = 20
# KERNEL: 		 data   = 10
# KERNEL: 		 rdn_wr = 0
# KERNEL: ------------------------------------------

Link ; https://www.edaplayground.com/x/rAAQ 
*/

// parameterised classes : example 8
class packet #(parameter ADDR_WIDTH=8,DATA_WIDTH=8);
    rand bit [ADDR_WIDTH-1:0] addr;
    rand bit [DATA_WIDTH-1:0] data;

    function void display();
      	$display("----------------------------------");
        $display("\t\t ADDR_WIDTH=%0d",ADDR_WIDTH);
        $display("\t\t DATA_WIDTH=%0d",DATA_WIDTH);
        $display("\t\t addr=%0d",addr);
        $display("\t\t data=%0d",data);
      	$display("----------------------------------");
    endfunction

endclass

module ex8;
  packet #(8,8) pkt_1;
  packet #(16,4) pkt_2;
    initial begin
        pkt_1 = new();
        pkt_2 = new();
      	// ----- pkt_1
        $display("------------ pkt_1.randomize() ---");
      	pkt_1.randomize(); // randomize addr and data
        $display("------------ pkt_1.display() -----");
        pkt_1.display();
      	// ----- pkt_2
        $display("------------ pkt_2.randomize() ---");
      	pkt_2.randomize(); // randomize addr and data
        $display("------------ pkt_2.display() -----");
        pkt_2.display();
    end
endmodule

/* output
# KERNEL: ------------ pkt_1.randomize() ---
# KERNEL: ------------ pkt_1.display() -----
# KERNEL: ----------------------------------
# KERNEL: 		 ADDR_WIDTH=8
# KERNEL: 		 DATA_WIDTH=8
# KERNEL: 		 addr=164
# KERNEL: 		 data=78
# KERNEL: ----------------------------------
# KERNEL: ------------ pkt_2.randomize() ---
# KERNEL: ------------ pkt_2.display() -----
# KERNEL: ----------------------------------
# KERNEL: 		 ADDR_WIDTH=16
# KERNEL: 		 DATA_WIDTH=4
# KERNEL: 		 addr=53764
# KERNEL: 		 data=5
# KERNEL: ----------------------------------

Link : https://www.edaplayground.com/x/bhmC 
*/

// inheritance : example 9
class base;
    rand bit [3:0] in;
    rand bit [7:0] addr;
    rand bit       rdn_wr;

    function void display();
        $display("------------- BASE  CLASS -------------");
        $display("\t\t in     = %0d",in);
        $display("\t\t addr   = %0d",addr);
        $display("\t\t rdn_wr = %0b",rdn_wr);
        $display("---------------------------------------");
    endfunction

  	function void print();
      $display("-- Inside print() from base class -------");
  	endfunction
endclass

class derive extends base;
    rand bit [7:0] data;

    function void display();
        $display("------------- DERIVE  CLASS -----------");
        $display("\t\t data   = %0d",data);
        $display("---------------------------------------");
    endfunction

endclass

module ex9;
    base   base_h;
    derive derive_h;
    initial begin
        base_h   = new();
        derive_h = new();
        $display("------------ base_h.randomize() ------");
        base_h.randomize();
        $display("------------ base_h.display() --------");
        base_h.display();
        $display("------------ base_h.print() ----------");
      	base_h.print();
      
        $display("------------ derive_h.randomize() ----");
        derive_h.randomize();
        $display("------------ derive_h.display() ------");
        derive_h.display();
      	$display("------------ derive_h.print() --------");
      	derive_h.print();
      
    end
endmodule

/* output
# KERNEL: ------------ base_h.randomize() ------
# KERNEL: ------------ base_h.display() --------
# KERNEL: ------------- BASE  CLASS -------------
# KERNEL: 		 in     = 8
# KERNEL: 		 addr   = 47
# KERNEL: 		 rdn_wr = 0
# KERNEL: ---------------------------------------
# KERNEL: ------------ base_h.print() ----------
# KERNEL: -- Inside print() from base class -------
# KERNEL: ------------ derive_h.randomize() ----
# KERNEL: ------------ derive_h.display() ------
# KERNEL: ------------- DERIVE  CLASS -----------
# KERNEL: 		 data   = 157
# KERNEL: ---------------------------------------
# KERNEL: ------------ derive_h.print() --------
# KERNEL: -- Inside print() from base class -------

Link : https://www.edaplayground.com/x/cJd2 

*/

// override method ; example 10
class base;
    function void display();
        $display("---------------- BASE ----------");
        $dipslay("**** inside base class *********");
        $display("--------------------------------");
    endfunction
endclass

class derive extends base;
    function void display();
        $display("---------------- DERIVE --------");
        $dipslay("**** inside derive class *******");
        $display("--------------------------------");
    endfunction
endclass

module ex10;
    base   base_h;
    derive derive_h;
    initial begin
        base_h  =new();
        derive_h=new();
        $display("------------ base_h.display() ---");
        base_h.display();
        $display("------------ derive_h.display() -");
        derive_h.display();
    end
endmodule

/* output
# KERNEL: ------------ base_h.display() ---
# KERNEL: ---------------- BASE ----------
# KERNEL: --------------------------------
# KERNEL: ------------ derive_h.display() -
# KERNEL: ---------------- DERIVE --------
# KERNEL: --------------------------------

Link : https://www.edaplayground.com/x/qiXu 
*/

// super keyword : example 11

class base;
    bit [7:0] addr;
    
    function new();
        addr=10;
    endfunction

    function void display();
        $display("--------------BASE--------------");
        $display("\t\t addr=%0d",addr);
        $display("--------------------------------");
    endfunction
endclass

class derive extends base;
    bit [7:0] data;

    function new();
        super.new();
        data=20;
    endfunction

    function void display();
        super.display();
        $display("\t\t data=%0d ",data);
        $display("--------------------------------");
    endfunction

endclass

module ex11;
    derive pkt;
    initial begin
        pkt=new();
        $display("------------ pkt.display() ------");
        pkt.display();
    end
endmodule

/* output
KERNEL: ------------ pkt.display() ------
# KERNEL: --------------BASE--------------
# KERNEL: 		 addr=10
# KERNEL: --------------------------------
# KERNEL: 		 data=20 
# KERNEL: --------------------------------

Link : https://www.edaplayground.com/x/vrwZ 

*/

// data hiding : example 13

class base;
    local int loop_count;
    protected int count;

    function new();
        count=20;
    endfunction

    task set(int x);
        loop_count=x;
    endtask

    function int get();
        return loop_count;
    endfunction

endclass

class derive extends base;

    function void display();
        $display("-------------------------------");
        //$display("\t\t loop_count= %0d",loop_count);
        $display("\t\t count     = %0d",count);
        $display("-------------------------------");
    endfunction
endclass

module ex13;
    derive derive_h;
    initial begin
        derive_h=new();
        derive_h.set(20);
        $display("--------- derive_h.get() = %0d ",derive_h.get());
        $display("--------- derive_h.display() --");
        derive_h.display();
    end
endmodule

/* output
# KERNEL: --------- derive_h.get() = 100 
# KERNEL: --------- derive_h.display() --
# KERNEL: -------------------------------
# KERNEL: 		 count     = 20
# KERNEL: -------------------------------

Link ; https://www.edaplayground.com/x/JSC9  
*/

// virtual class : example 14_1

virtual class base;
    static int count_id;
    pure virtual function void display();
    pure virtual function int  return_count_id();
endclass

class derive extends base;
    function void display();
      	$display("-------------------------------");
      	$display("Object created");
      	$display("-------------------------------");
    endfunction

    function new();
        display();
        count_id++;
    endfunction 

    function int return_count_id();
        return count_id;
    endfunction

endclass

module ex14_1;
    derive derive_h,derive_h1;
    initial begin
        derive_h = new();
      	derive_h1= new();
      	$display("No of obj created = %0d",derive_h.return_count_id());
    end
endmodule
/* output 
# KERNEL: -------------------------------
# KERNEL: Object created
# KERNEL: -------------------------------
# KERNEL: -------------------------------
# KERNEL: Object created
# KERNEL: -------------------------------
# KERNEL: No of obj created = 2

Link : https://www.edaplayground.com/x/tNgg 
*/


// virtual functio/task : example 14_2

class base;
    virtual function void display();
        $display("------------- BASE_CLASS ------------");
        $display("\t Inside base class");
        $display("-------------------------------------");
    endfunction
endclass

class derive extends base;
    virtual function void display();
        $display("------------- DERIVE_CLASS ----------");
        $display("\t Inside derive class");
        $display("-------------------------------------");
    endfunction
endclass

module ex14_2;
    base   base_h;
    derive derive_h;

    initial begin
        derive_h=new();
        base_h=derive_h;
        $display("--------- base_h.display() ----------");
        base_h.display();
    end
endmodule
/* output
# KERNEL: --------- base_h.display() ----------
# KERNEL: ------------- DERIVE_CLASS ----------
# KERNEL: 	 Inside derive class
# KERNEL: -------------------------------------

Link : https://www.edaplayground.com/x/Ws72
*/
// extern keyword : example 15

class packet;
    bit [7:0] addr;

    extern function void display();

endclass
function void packet:: display();
    $display("--------------------------------");
    $display("\t\t addr=%0d",addr);
    $display("--------------------------------");
endfunction

module ex15;
    packet pkt;
    initial begin
        pkt=new();
        pkt.addr=20;
        pkt.display();
    end
endmodule
/* output
# KERNEL: --------------------------------
# KERNEL: 		 addr=20
# KERNEL: --------------------------------

https://www.edaplayground.com/x/rGea
*/