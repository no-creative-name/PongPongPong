<CsoundSynthesizer>
<CsOptions>
-odac -d
</CsOptions>
<CsInstruments>

sr = 44100
ksmps = 32
nchnls = 2
0dbfs = 1

giPort OSCinit 12666

giSound1 ftgen 1,0,0,1,"JohnWickSound_A.wav",0,0,0 ;load soundfile



instr master

;OSC
kosc1 init 0
kosc OSClisten giPort, "/pong","i",kosc1

; Controll Values:
kctrl_tension invalue "tension"

; Metro BPS
;kspeed init p4
kspeed invalue "speed"

; Takt
kmetro_full metro kspeed
kmetro_sixteenths metro kspeed*16

if (kmetro_full == 1) then
;	     Make New Speed
; kspeed invalue "speedmult"

					if (kosc1 == 3) then
				 schedkwhen kmetro_full, 0, 0, 4, 0, 1/kspeed, kspeed
					elseif (kosc1 == 2) then
				 schedkwhen kmetro_full, 0, 0, 3, 0, 1/kspeed, kspeed
				elseif (kosc1 == 1) then
				 schedkwhen kmetro_full, 0, 0, 2, 0, 1/kspeed, kspeed
				elseif (kosc1 == 0) then
				 schedkwhen kmetro_full, 0, 0, 1, 0, 1/kspeed, kspeed
				endif
endif


endin




instr 1, 2, 3, 4,5
; Metro BPS
kspeed = p4
; Takt
kmetro_full metro kspeed
kmetro_sixteenths metro kspeed*16

;Counter
kcounter_full init 0
kcounter_sixteenths init 0

; Increment Counter
if (kmetro_full == 1) then
kcounter_full = kcounter_full + 1
endif
if (kmetro_sixteenths == 1) then
kcounter_sixteenths = kcounter_sixteenths +1
endif




; TAKT1
if (p1 == 1) then
	if (kmetro_sixteenths == 1) then
			if (kcounter_sixteenths == 1) then
			schedkwhen kmetro_sixteenths, 0, 0, "sound1", 0, 2
			schedkwhen kmetro_sixteenths, 0, 0, "sound3", 0, 2
			endif
			if (kcounter_sixteenths == 2) then
			schedkwhen kmetro_sixteenths, 0, 0, "sound1", 0, 2
			schedkwhen kmetro_sixteenths, 0, 0, "sound3", 0, 2
			endif
			if (kcounter_sixteenths == 3) then
			schedkwhen kmetro_sixteenths, 0, 0, "sound1", 0, 2
			endif
			if (kcounter_sixteenths == 4) then
			schedkwhen kmetro_sixteenths, 0, 0, "sound1", 0, 2
			endif
			if (kcounter_sixteenths == 5) then
						schedkwhen kmetro_sixteenths, 0, 0, "sound1", 0, 2
			endif
			if (kcounter_sixteenths == 6) then
			schedkwhen kmetro_sixteenths, 0, 0, "sound1", 0, 2
			endif
			if (kcounter_sixteenths == 7) then
			schedkwhen kmetro_sixteenths, 0, 0, "sound1", 0, 2
			schedkwhen kmetro_sixteenths, 0, 0, "sound3", 0, 2
			endif
			if (kcounter_sixteenths == 8) then
			schedkwhen kmetro_sixteenths, 0, 0, "sound1", 0, 2
			schedkwhen kmetro_sixteenths, 0, 0, "sound3", 0, 2
			endif
			if (kcounter_sixteenths == 9) then
			schedkwhen kmetro_sixteenths, 0, 0, "sound1", 0, 2
			endif
			if (kcounter_sixteenths == 10) then
			schedkwhen kmetro_sixteenths, 0, 0, "sound1", 0, 2
			endif
			if (kcounter_sixteenths == 11) then
			schedkwhen kmetro_sixteenths, 0, 0, "sound1", 0, 2
			endif
			if (kcounter_sixteenths == 12) then
			schedkwhen kmetro_sixteenths, 0, 0, "sound1", 0, 2
			endif
			if (kcounter_sixteenths == 13) then
			schedkwhen kmetro_sixteenths, 0, 0, "sound1", 0, 2
			endif
			if (kcounter_sixteenths == 14) then
			schedkwhen kmetro_sixteenths, 0, 0, "sound1", 0, 2
			endif
			if (kcounter_sixteenths == 15) then
			schedkwhen kmetro_sixteenths, 0, 0, "sound1", 0, 2
			endif
			if (kcounter_sixteenths == 16) then
			schedkwhen kmetro_sixteenths, 0, 0, "sound1", 0, 2
			endif
	endif
endif

; TAKT2
if (p1 == 2) then
	if (kmetro_sixteenths == 1) then
			if (kcounter_sixteenths == 1) then
			schedkwhen kmetro_sixteenths, 0, 0, "sound1", 0, 2
			schedkwhen kmetro_sixteenths, 0, 0, "sound3", 0, 2
			schedkwhen kmetro_sixteenths, 0, 0, "sound2", 0, 1/(kspeed*1.3), 3
			endif
			if (kcounter_sixteenths == 2) then
			schedkwhen kmetro_sixteenths, 0, 0, "sound1", 0, 2
			schedkwhen kmetro_sixteenths, 0, 0, "sound3", 0, 2
			endif
			if (kcounter_sixteenths == 3) then
			schedkwhen kmetro_sixteenths, 0, 0, "sound1", 0, 2
			endif
			if (kcounter_sixteenths == 4) then
			schedkwhen kmetro_sixteenths, 0, 0, "sound1", 0, 2
			endif
			if (kcounter_sixteenths == 5) then
						schedkwhen kmetro_sixteenths, 0, 0, "sound1", 0, 2			
			endif
			if (kcounter_sixteenths == 6) then
			schedkwhen kmetro_sixteenths, 0, 0, "sound1", 0, 2
			endif
			if (kcounter_sixteenths == 7) then
			schedkwhen kmetro_sixteenths, 0, 0, "sound1", 0, 2
			schedkwhen kmetro_sixteenths, 0, 0, "sound3", 0, 2
			endif
			if (kcounter_sixteenths == 8) then
			schedkwhen kmetro_sixteenths, 0, 0, "sound1", 0, 2
			schedkwhen kmetro_sixteenths, 0, 0, "sound3", 0, 2
			endif
			if (kcounter_sixteenths == 9) then
			schedkwhen kmetro_sixteenths, 0, 0, "sound1", 0, 2
			endif
			if (kcounter_sixteenths == 10) then
			schedkwhen kmetro_sixteenths, 0, 0, "sound1", 0, 2
			endif
			if (kcounter_sixteenths == 11) then
			schedkwhen kmetro_sixteenths, 0, 0, "sound1", 0, 2
			endif
			if (kcounter_sixteenths == 12) then
			schedkwhen kmetro_sixteenths, 0, 0, "sound1", 0, 2
			endif
			if (kcounter_sixteenths == 13) then
			schedkwhen kmetro_sixteenths, 0, 0, "sound1", 0, 2

			endif
			if (kcounter_sixteenths == 14) then
			schedkwhen kmetro_sixteenths, 0, 0, "sound1", 0, 2
			endif
			if (kcounter_sixteenths == 15) then
			schedkwhen kmetro_sixteenths, 0, 0, "sound1", 0, 2
			endif
			if (kcounter_sixteenths == 16) then
			schedkwhen kmetro_sixteenths, 0, 0, "sound1", 0, 2
			endif
	endif
endif

; TAKT3
if (p1 == 3) then
	if (kmetro_sixteenths == 1) then
			if (kcounter_sixteenths == 1) then
			schedkwhen kmetro_sixteenths, 0, 0, "sound1", 0, 2
			schedkwhen kmetro_sixteenths, 0, 0, "sound3", 0, 2
			schedkwhen kmetro_sixteenths, 0, 0, "sound2", 0, 1/(kspeed*1.6), 0
			endif
			if (kcounter_sixteenths == 2) then
			schedkwhen kmetro_sixteenths, 0, 0, "sound1", 0, 2
			schedkwhen kmetro_sixteenths, 0, 0, "sound3", 0, 2
			endif
			if (kcounter_sixteenths == 3) then
			schedkwhen kmetro_sixteenths, 0, 0, "sound1", 0, 2
			endif
			if (kcounter_sixteenths == 4) then
			schedkwhen kmetro_sixteenths, 0, 0, "sound1", 0, 2
			endif
			if (kcounter_sixteenths == 5) then
						schedkwhen kmetro_sixteenths, 0, 0, "sound1", 0, 2			
			endif
			if (kcounter_sixteenths == 6) then
			schedkwhen kmetro_sixteenths, 0, 0, "sound1", 0, 2
			endif
			if (kcounter_sixteenths == 7) then
			schedkwhen kmetro_sixteenths, 0, 0, "sound1", 0, 2
			schedkwhen kmetro_sixteenths, 0, 0, "sound3", 0, 2
			endif
			if (kcounter_sixteenths == 8) then
			schedkwhen kmetro_sixteenths, 0, 0, "sound1", 0, 2
			schedkwhen kmetro_sixteenths, 0, 0, "sound3", 0, 2
			endif
			if (kcounter_sixteenths == 9) then
			schedkwhen kmetro_sixteenths, 0, 0, "sound1", 0, 2
			schedkwhen kmetro_sixteenths, 0, 0, "sound2", 0, 1/(kspeed*1.7), 1
			endif
			if (kcounter_sixteenths == 10) then
			schedkwhen kmetro_sixteenths, 0, 0, "sound1", 0, 2
			endif
			if (kcounter_sixteenths == 11) then
			schedkwhen kmetro_sixteenths, 0, 0, "sound1", 0, 2
			endif
			if (kcounter_sixteenths == 12) then
			schedkwhen kmetro_sixteenths, 0, 0, "sound1", 0, 2
			endif
			if (kcounter_sixteenths == 13) then
			schedkwhen kmetro_sixteenths, 0, 0, "sound1", 0, 2

			endif
			if (kcounter_sixteenths == 14) then
			schedkwhen kmetro_sixteenths, 0, 0, "sound1", 0, 2
			endif
			if (kcounter_sixteenths == 15) then
			schedkwhen kmetro_sixteenths, 0, 0, "sound1", 0, 2
			endif
			if (kcounter_sixteenths == 16) then
			schedkwhen kmetro_sixteenths, 0, 0, "sound1", 0, 2
			endif
	endif
endif

; TAKT4
if (p1 == 4) then
	if (kmetro_sixteenths == 1) then
			if (kcounter_sixteenths == 1) then
			schedkwhen kmetro_sixteenths, 0, 0, "sound1", 0, 2
			schedkwhen kmetro_sixteenths, 0, 0, "sound3", 0, 2
			schedkwhen kmetro_sixteenths, 0, 0, "sound2", 0, 1/(kspeed*1.6), 0
			endif
			if (kcounter_sixteenths == 2) then
			schedkwhen kmetro_sixteenths, 0, 0, "sound1", 0, 2
			endif
			if (kcounter_sixteenths == 3) then
			schedkwhen kmetro_sixteenths, 0, 0, "sound1", 0, 2
			endif
			if (kcounter_sixteenths == 4) then
			schedkwhen kmetro_sixteenths, 0, 0, "sound1", 0, 2
			endif
			if (kcounter_sixteenths == 5) then
						schedkwhen kmetro_sixteenths, 0, 0, "sound1", 0, 2			
			endif
			if (kcounter_sixteenths == 6) then
			schedkwhen kmetro_sixteenths, 0, 0, "sound1", 0, 2
			endif
			if (kcounter_sixteenths == 7) then
			schedkwhen kmetro_sixteenths, 0, 0, "sound1", 0, 2
			schedkwhen kmetro_sixteenths, 0, 0, "sound3", 0, 2
			endif
			if (kcounter_sixteenths == 8) then
			schedkwhen kmetro_sixteenths, 0, 0, "sound1", 0, 2

			endif
			if (kcounter_sixteenths == 9) then
			schedkwhen kmetro_sixteenths, 0, 0, "sound1", 0, 2
			schedkwhen kmetro_sixteenths, 0, 0, "sound2", 0, 1/(kspeed*1.7), 1
						schedkwhen kmetro_sixteenths, 0, 0, "sound3", 0, 2
			endif
			if (kcounter_sixteenths == 10) then
			schedkwhen kmetro_sixteenths, 0, 0, "sound1", 0, 2
						schedkwhen kmetro_sixteenths, 0, 0, "sound3", 0, 2
			endif
			if (kcounter_sixteenths == 11) then
			schedkwhen kmetro_sixteenths, 0, 0, "sound1", 0, 2
			endif
			if (kcounter_sixteenths == 12) then
			schedkwhen kmetro_sixteenths, 0, 0, "sound1", 0, 2
			endif
			if (kcounter_sixteenths == 13) then
			schedkwhen kmetro_sixteenths, 0, 0, "sound1", 0, 2

			endif
			if (kcounter_sixteenths == 14) then
			schedkwhen kmetro_sixteenths, 0, 0, "sound1", 0, 2
			endif
			if (kcounter_sixteenths == 15) then
			schedkwhen kmetro_sixteenths, 0, 0, "sound1", 0, 2
			endif
			if (kcounter_sixteenths == 16) then
			schedkwhen kmetro_sixteenths, 0, 0, "sound1", 0, 2
			endif
	endif
endif

endin

;pong
instr sound1

itime = 0.3

; GenPink
apink  pinkish 1
asig1 resonr apink, 110, 10


; sine
isine ftgenonce 0, 0, 8192, 10, 1
asig2 oscil 1, 360, isine

;add Pink
asig2 = asig2 + 0.01*asig1

;linenv
aenv1 linseg 0,itime*0.01, 0.1, itime*0.01, 1, itime*0.05 , 0.1, itime*0.5, 0

asig2 = asig2*aenv1 * 0.4

asig2 reverb asig2, 0.1

;asig2 lowpass2 asig2, 300, 10


out asig2,asig2

endin




;JohnWick
instr sound2
;kPhs    phasor 1/p3 ;clock

asig poscil 1,1/p3,giSound1,1 


if(p4 == 0) then
outs asig*0,asig
elseif(p4 == 1) then
outs asig,asig*0
else
outs asig,asig
endif
endin




;Drum
instr sound4

; 580 - 640 ; 540 - 580

itime = 0.8

; GenPink
apink  pinkish 1
asig1 resonr apink, 110, 10


; sine
isine ftgenonce 0, 0, 8192, 10, 1
asig2 oscil 1, 180, isine

;add Pink
asig2 = asig2 + 0.05*asig1

;linenv
aenv1 linseg 0,itime*0.01, 0.1, itime*0.01, 1, itime*0.05 , 0.1, itime*0.5, 0

asig2 = asig2*aenv1 * 2

;asig2 reverb asig2, 1

;asig2 lowpass2 asig2, 300, 10


out asig2,asig2

endin

;Drum
instr sound3

; 580 - 640 ; 540 - 580

itime = 0.8

; GenPink
apink  pinkish 1
asig1 resonr apink, 110, 100


; sine
isine ftgenonce 0, 0, 8192, 10, 1
asig2 oscil 1, 180, isine

;add Pink
asig2 = asig2 + 0.2*asig1

;linenv
aenv1 linseg 0,itime*0.01, 0.1, itime*0.01, 1, itime*0.05 , 0.1, itime*0.5, 0

asig2 = asig2*aenv1 * 2

;asig2 reverb asig2, 1

;asig2 lowpass2 asig2, 300, 10


out asig2,asig2

endin


</CsInstruments>
<CsScore>

i "master" 0 70000 0.3

</CsScore>
</CsoundSynthesizer>
<bsbPanel>
 <label>Widgets</label>
 <objectName/>
 <x>0</x>
 <y>0</y>
 <width>100</width>
 <height>172</height>
 <visible>true</visible>
 <uuid/>
 <bgcolor mode="nobackground">
  <r>255</r>
  <g>255</g>
  <b>255</b>
 </bgcolor>
 <bsbObject type="BSBVSlider" version="2">
  <objectName>tension</objectName>
  <x>61</x>
  <y>153</y>
  <width>20</width>
  <height>100</height>
  <uuid>{bd979e19-d3a5-45cb-9435-d6b75f7fa3e6}</uuid>
  <visible>true</visible>
  <midichan>0</midichan>
  <midicc>0</midicc>
  <minimum>0.00000000</minimum>
  <maximum>4.00000000</maximum>
  <value>4.00000000</value>
  <mode>lin</mode>
  <mouseControl act="jump">continuous</mouseControl>
  <resolution>-1.00000000</resolution>
  <randomizable group="0">false</randomizable>
 </bsbObject>
 <bsbObject type="BSBVSlider" version="2">
  <objectName>speed</objectName>
  <x>141</x>
  <y>152</y>
  <width>20</width>
  <height>100</height>
  <uuid>{d377b91d-4268-4e2b-b98a-58e65a0fb089}</uuid>
  <visible>true</visible>
  <midichan>0</midichan>
  <midicc>0</midicc>
  <minimum>0.00000000</minimum>
  <maximum>1.00000000</maximum>
  <value>0.25000000</value>
  <mode>lin</mode>
  <mouseControl act="jump">continuous</mouseControl>
  <resolution>-1.00000000</resolution>
  <randomizable group="0">false</randomizable>
 </bsbObject>
 <bsbObject type="BSBLabel" version="2">
  <objectName/>
  <x>62</x>
  <y>253</y>
  <width>80</width>
  <height>25</height>
  <uuid>{946248d9-4fe2-4d8c-91c4-f17b705057e2}</uuid>
  <visible>true</visible>
  <midichan>0</midichan>
  <midicc>-3</midicc>
  <label>Tension</label>
  <alignment>left</alignment>
  <font>Arial</font>
  <fontsize>10</fontsize>
  <precision>3</precision>
  <color>
   <r>0</r>
   <g>0</g>
   <b>0</b>
  </color>
  <bgcolor mode="nobackground">
   <r>255</r>
   <g>255</g>
   <b>255</b>
  </bgcolor>
  <bordermode>noborder</bordermode>
  <borderradius>1</borderradius>
  <borderwidth>1</borderwidth>
 </bsbObject>
 <bsbObject type="BSBLabel" version="2">
  <objectName/>
  <x>141</x>
  <y>252</y>
  <width>80</width>
  <height>25</height>
  <uuid>{a34ceb9d-6033-410d-9003-ee557419bd52}</uuid>
  <visible>true</visible>
  <midichan>0</midichan>
  <midicc>-3</midicc>
  <label>Speed</label>
  <alignment>left</alignment>
  <font>Arial</font>
  <fontsize>10</fontsize>
  <precision>3</precision>
  <color>
   <r>0</r>
   <g>0</g>
   <b>0</b>
  </color>
  <bgcolor mode="nobackground">
   <r>255</r>
   <g>255</g>
   <b>255</b>
  </bgcolor>
  <bordermode>noborder</bordermode>
  <borderradius>1</borderradius>
  <borderwidth>1</borderwidth>
 </bsbObject>
</bsbPanel>
<bsbPresets>
</bsbPresets>
