enum AutotileCategory
{
	Simple, // 17 tiles
	SimpleDiag, // 16 tiles
	Complex, // 47 tiles
}

enum AutotileDisjunctions
{
	None = 0,
	Up = 1,
	Dw = 2,
	Lt = 4,
	Rt = 8,
	Lu = 16, // extended
	Ru = 32,
	Ld = 64,
	Rd = 128
}

/* Simple
    (0)
    	   ■
    	■ ▦ ■
    	   ■
    (1)	             (2)		             (4)	                  (8)
    	   □        		   ■        	   ■        		   ■
    	■ ▦ ■     		■ ▦ ■     	□ ▦ ■     		■ ▦ □
    	   ■        		   □        	   ■        		   ■
    (3)	            (12)
    	   □        		   ■
    	■ ▦ ■     		□ ▦ □
    	   □        		   ■
    (5)	             (9)		             (6)	                 (10)
    	   □        		   □        	   ■        		   ■
    	□ ▦ ■     		■ ▦ □     	□ ▦ ■     		■ ▦ □
    	   ■        		   ■        	   □        		   □
   (13)	            (14)		             (7)	                 (11)
    	   □        		   ■        	   □        		   □
    	□ ▦ □     		□ ▦ □     	□ ▦ ■     		■ ▦ □
    	   ■        		   □        	   □        		   □
   (15)
    	   □
    	□ ▦ □
    	   □
*/

/* Extended
    (0)
    	■ ■ ■
    	■ ▦ ■
    	■ ■ ■
*/
