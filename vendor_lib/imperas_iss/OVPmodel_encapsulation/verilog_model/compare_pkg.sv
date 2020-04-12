/*
 * Copyright (c) 2005-2020 Imperas Software Ltd., www.imperas.com
 * Copyright (C) EM Microelectronic US Inc.
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *   http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND,
 * either express or implied.
 *
 * See the License for the specific language governing permissions and
 * limitations under the License.
 *
 */

package compare_pkg;

   function void compare_pc(virtual pc_if pc_if_i);
      int iss_pc;
      logic [31:0] riscy_pc; 

      riscy_pc = pc_if_i.insn_pc;
      iss_pc = pc_if_i.iss_pc;
      if (iss_pc !== riscy_pc)
        $display("%0t: ERROR: PC ISS=0x%8h and RISCY=0x%8h", $time, iss_pc, riscy_pc);
      `ifdef DEBUG
      else
        $display("%0t: SUCCESS: PC=0x%8h", $time, iss_pc);
      `endif    
   endfunction
   
   
endpackage // compare_pkg
   