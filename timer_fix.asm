include "x.inc"

org 0x1438867C
                ldr     r4, off_Alarm_Hook 
                bx      r4              
off_Alarm_Hook  dw Alarm_Hook_NewCode+1 
Alarm_Hook_Return:                      



org 0x154EDF40                  
                ldr     r4, Timer_Hook 
                bx      r4              
Timer_Hook      dw Timer_Hook_NewCode+1 
                nop
Timer_Hook_Return:                              


org 0x15E7A690
Alarm_Hook_NewCode:                                                             
                add     r3, r6, 0       
                mov     r1, 0xE 
                bl      Function_SetText        
                ldr     r4, off_Alarm_Hook_Return 
                bx      r4              
off_Alarm_Hook_Return   dw Alarm_Hook_Return+1  



Timer_Hook_NewCode:                                                     
                ldr     r2, Timer_IMAGEID 
                ldr     r0, [r6,0x18]   
                mov     r1, 0xF
                bl      Function_SetText        
                ldr     r4, off_Timer_Hook_Return 
                bx      r4              
                align 4
Timer_IMAGEID   dw 0xF825               
off_Timer_Hook_Return   dw Timer_Hook_Return+1  


Function_SetText:;( GUI*gui, int item, wchar_t iid, int sid );  
                push    {r0,r1,r4,r5,lr} 
                mov     r4, r0
                mov     r0, r2
                ldr     r2, _EMPTY_TEXTID 
                mov     r5, r1
                cmp     r3, r2          
                beq     IF_EMPTY_TEXTID 
                movl    r1, 0x78000000
                add     r0, r0, r1      ;iid+0x78000000
                str     r0, [sp] 
                str     r3, [sp,4] 
                mov     r0, 0           
                push    {r0}            
                mov     r3, 0           
                mov     r2, 2           
                mov     r1, 5           
                add     r0, sp, 4
                bl      j_TextID_Create 
                mov     r2, r0  
                mov     r1, r5          
                mov     r0, r4          
                bl      j_StatusIndication_SetItemText 
                add     sp, sp, 4       
                pop     {r2-r5,pc}      
IF_EMPTY_TEXTID:                                
                mov     r0, r4
                bl      j_StatusIndication_SetItemText 
                pop     {r2-r5,pc}      
                align 4
_EMPTY_TEXTID   dw 0x6FFFFFFF           

j_TextID_Create:                                
                push    {r3}            
                ldr     r3, TextID_Create 
                mov     r12, r3         
                pop     {r3}            
                bx      r12             
                nop 
TextID_Create   dw 0x142D8380+1 

j_StatusIndication_SetItemText:                                 
                ldr     r3, StatusIndication_SetItemText 
                bx      r3              
StatusIndication_SetItemText    dw 0x1434F614+1