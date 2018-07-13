<CsoundSynthesizer>
<CsOptions>
;-odac -d
-odac1 -b 2048 -B 8192 -+rtaudio=portaudio
</CsOptions>

<CsInstruments>

sr = 44100
ksmps = 256
nchnls = 2
0dbfs = 1

giPort OSCinit 16000
maxalloc 1,5
maxalloc 2,5
maxalloc 3,5

instr main

k1, k2, k3 init 0
kBrick OSClisten giPort, "/csound", "iii" , k1, k2, k3
ktrig changed k3

if(ktrig == 1) then

	if(k1 == 0) then ; gameOver
			schedkwhen ktrig, 0, 0, 2, 0, 1 ,550
	elseif(k1 == 2) then ;PaddleCOllision
			schedkwhen ktrig, 0, 0, 1, 0, 0.5 ,330, 1
	elseif(k1 == 3) then ;Bricksound 
		schedkwhen ktrig, 0, 0, 3, 0, 0.5 ,1240, 1
	endif
endif

endin

instr 1 ; PaddleHit
; Parameters:
idur = 0.06
ifreq = p4
irandAmp = p5
; Make Hull Curve:

kenv linseg 0, 0.05*idur , 0.462 , 0.05*idur , 0.825 , 0.05*idur , 1 , 0.05*idur , 0.986, 0.05*idur , 0.867 , 0.05*idur , 0.678 , 0.05*idur , 0.517 , 0.05*idur , 0.427, 0.05*idur , 0.35 , 0.05*idur , 0.252, 0.05*idur , 0.283 , 0.05*idur , 0.175, 0.05*idur , 0.145 , 0.05*idur , 0.119, 0.05*idur , 0.958, 0.05*idur , 0.091 , 0.05*idur , 0.916, 0.05*idur , 0.056 , 0.05*idur , 0, 0.05*idur , 0

	;Sin
asin oscili 1, ifreq
asin1 oscili 1, ifreq *2
asin2 oscili 1, ifreq *3
asin = asin + asin1 +asin2
aout = asin *a(kenv)
aoutRev reverb aout, 1
out (aout * 0.3 + aoutRev*0.04 )* irandAmp 
;out aout * 0.3* irandAmp 
endin


instr 2 ; Death
; Parameters:
idur = 0.06
ifreq = p4

; Make Hull Curve:
/*
kenv linseg 0, 0.05*idur , 0.923 , 0.05*idur , 0.294 , 0.05*idur , 0.804 , 0.05*idur , 0.266, 0.05*idur , 0.706 , 0.05*idur , 0.329 , 0.05*idur , 0.664 , 0.05*idur , 0.287, 0.05*idur , 0.531 , 0.05*idur , 0.238, 0.05*idur , 0.503 , 0.05*idur , 0.201, 0.05*idur , 0.434 , 0.05*idur , 0.133, 0.05*idur , 0.322, 0.05*idur , 0.105 , 0.05*idur , 0.21, 0.05*idur , 0 , 0.05*idur , 0, 0.05*idur , 0
*/
kenv linseg 0, 0.05*idur , 0.881 , 0.05*idur , 0.797 , 0.05*idur , 0.594 , 0.05*idur , 0.51, 0.05*idur , 0.455 , 0.05*idur , 0.434 , 0.05*idur , 0.469 , 0.05*idur , 0.441, 0.05*idur , 0.427 , 0.05*idur , 0.448, 0.05*idur , 0.462 , 0.05*idur , 0.615, 0.05*idur , 0.811 , 0.05*idur , 0.93, 0.05*idur , 0.895, 0.05*idur , 0.734 , 0.05*idur , 0.476, 0.05*idur , 0.238 , 0.05*idur , 0, 0.05*idur , 0

asig1 oscili 1, ifreq * kenv
asig2 vco2 1, ifreq*1.025 * kenv, 0
asig3 vco2 1, ifreq*1.015 * kenv, 10
asig1 = asig1 + 0.5 * asig2 + 0.3 * asig3
aout = asig1 *a(kenv)
;aoutRev reverb aout, 1
;out (aout * 0.3 + aoutRev*0.1 )* irandAmp 
out aout * 0.1
endin



instr 3 ; Collision
; Parameters:
idur = 0.25
ifreq = p4
ifreq2 = p4*1.3
irandAmp = p5
kphs phasor 1/idur
; Make Hull Curve:
kenv linseg 0, 0.05*idur , 0.881 , 0.05*idur , 0.797 , 0.05*idur , 0.594 , 0.05*idur , 0.51, 0.05*idur , 0.455 , 0.05*idur , 0.434 , 0.05*idur , 0.469 , 0.05*idur , 0.441, 0.05*idur , 0.427 , 0.05*idur , 0.448, 0.05*idur , 0.462 , 0.05*idur , 0.615, 0.05*idur , 0.811 , 0.05*idur , 0.93, 0.05*idur , 0.895, 0.05*idur , 0.734 , 0.05*idur , 0.476, 0.05*idur , 0.238 , 0.05*idur , 0, 0.05*idur , 0
kfreq = ifreq
	;Sin
if(kphs > 0.35) then
kfreq = ifreq2
endif
asin1 oscili 1, kfreq
asin2 oscili 1, kfreq*7
asin3 oscili 1, kfreq*9
asin1 = asin1 + 0.5*asin2 -0.2*asin3
aout = asin1 *kenv
aoutRev reverb aout, 1.5
out (aout * 0.3 + aoutRev*0.04 )* irandAmp 
endin

</CsInstruments>
<CsScore>

;i1 0 2 330 1
;i2 0 4 220 2
;i3 0 4 1240 1

i"main" 0 36000
</CsScore>
</CsoundSynthesizer>
<bsbPanel>
 <label>Widgets</label>
 <objectName/>
 <x>336</x>
 <y>147</y>
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
