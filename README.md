# Assembly Traffic Liht

An assembly program controls the traffic jam.

 ![one](https://user-images.githubusercontent.com/32064166/80270605-f5c51280-868f-11ea-9b83-f7baa8bad9a7.PNG)              
![two](https://user-images.githubusercontent.com/32064166/80270608-fb225d00-868f-11ea-8903-d8fdfb0cb99a.PNG)

![three](https://user-images.githubusercontent.com/32064166/80270609-feb5e400-868f-11ea-8b8e-09c505fac461.PNG)           
![four](https://user-images.githubusercontent.com/32064166/80270610-037a9800-8690-11ea-8d93-15e2be2b0d9f.PNG)

## Getting Started

To run and test the application, you basically need to install the EMU8086 and have their own license.

### Prerequisites

Import the library traffict, use the following code:

```
#start=Traffic_Lights.exe#
name "traffic"     
```

### How works?

Our apllication needs controling 12 lights, in order to otimized the system, we storage each sequence of light into a DS (Data segment), like this:

```
    TABLE_LIGHT     DW 0000100001100001B                          
                    DW 0000010001010001B                     
                    DW 0000001010001010B                                         
                    DW 0000001100001100B   
                    DW 0000000000000000B        
```

After that, we ned to set an interval of time to keep the light in the same state.  To do that, we call 'PAUSE_5':

```
PAUSE_5:                   
    PUSH AX
    PUSH CX
    PUSH DX
    ; wait 5 seconds (5 million microseconds in cx e dx)
    mov     cx, 4Ch    ;    004C4B40h = 5,000,000
    mov     dx, 4B40h  ; each number in hexa has 4 bits
    mov     ah, 86h
    int     15h     
    POP DX
    POP CX
    POP AX
    ret 
```

The PUSH an POP were used just to prevent if someday we'll use the registers cx, dx or ah. So we put the informatition into stack segment, after that we restore it.

Now, we need find someway to storage the 'TABLE_LIGHT', so we will use a memory to indicate the offset table_light: 

```
MOV SI, OFFSET TABLE_LIGHT
```

Then it's possible read the information and show at display:

```
MOV AX, [SI] 
OUT 4, AX      
CALL PAUSE_5
```
 By the wat, the coding above just will show the first line of Table_light. We need to do a loop, and for each loop add too SI one more position.
 
Important: We're using an a 8bits memory. If each line of Table_light has 16 bits, we can't add 1 at SI, but 2:

```
 ADD SI, 2 
 JMP repeat
```
To control when we are at last line of Table_light we compare and restart the SI value.

## Built With

* Assembly


This project looks great, - it's time to merge! :shipit:


