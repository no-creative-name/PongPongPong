<CsoundSynthesizer>
<CsOptions>
</CsOptions>
<CsInstruments>

sr = 44100
ksmps = 128
nchnls = 2
0dbfs = 1.0

giPort OSCinit 12001

instr 1
kI1,kI2,kI3 init 0

nxtmsg:
kk OSClisten giPort, "/pong","iii",kI1,kI2,kI3
if (kk == 0) goto ex
  kTrig changed kI3
  if ((kTrig == 1) && (kI1 != 0)) then
    schedkwhen kTrig, 0, 0, 3, 0, 0.2, kI1*kI2*kI3/2
  endif
  kgoto nxtmsg
ex:  
endin

instr 3
aOut oscil3 0.001, 100*p4, -1
aEnv linsegr 0, 0.1, 0.5, 0.1, 0
out aOut*aEnv
endin

</CsInstruments>
<CsScore>
i 1 0 3600
</CsScore>
</CsoundSynthesizer>
<bsbPanel>
 <label>Widgets</label>
 <objectName/>
 <x>100</x>
 <y>188</y>
 <width>320</width>
 <height>240</height>
 <visible>true</visible>
 <uuid/>
 <bgcolor mode="nobackground">
  <r>255</r>
  <g>255</g>
  <b>255</b>
 </bgcolor>
</bsbPanel>
<bsbPresets>
</bsbPresets>
