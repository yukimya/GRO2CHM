GRO2CHM
=======
__version 1.0__

-----------------------------------------
 This is the CRO2CHM software package. 
 GRO2CHM can translate .gro file from a one force field to another force field.
 This program is written in perl script.

__GRO2CHM was developed by Naoyuki Miyashita__

-----------------------------------------
#### Announcement
 contact e-mail <yukimya+gro2chm@gmail.com>

__GRO2CHM is free software__
You can redistribute it and/or modify it under the terms of the GNU 
General Public License as published by the Free Software Foundation, 
either version 3 of the License, or (at your option) any later version.


GRO2CHM is distributed in the hope that it will be useful, but WITHOUT 
ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or 
FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License 
for more details. You should have received a copy of the GNU General 
Public License along with GRO2CHM.  
If not, see [web site of GNU](http://www.gnu.org/licenses/).

----------------------------------------------------------------------

you need psfgen (NAMD) program 

    #!/bin/sh
    #Step 1: modifying the atom name on gro file 
    perl namemap_gro2chm.pl namedata.db fg_popc_G53a6_md_free.gro > out.gro
    #Step 2: translate gro to pdb
    perl gro2pdb.pl out.gro > out.pdb
    #Step 3: splitting the pdb file
    perl split_pdb.pl P out.pdb > out_p.pdb
    perl split_pdb.pl L out.pdb > out_l.pdb
    perl split_pdb.pl W out.pdb > out_w.pdb
    perl split_pdb.pl I out.pdb > out_i.pdb
    #Step 4: create psf file ; please modify psfgen.sh as you like
    sh psfgen.sh
