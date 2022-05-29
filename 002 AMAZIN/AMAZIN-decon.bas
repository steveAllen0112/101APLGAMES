AMAZIN←{
	⎕IO←0
	NL←⎕UCS 10

	W←V←0⍴⍨25 103                      ⍝ initialize lef/right (W) and up/down (V) tracking arrays



	2≠⍴∊⍵:'MUST BE 2D'                 ⍝ desired maze size will be a 2-length vector as ⍵
	(∊⍵)≡1 1:'MEANINGLESS DIMENSIONS'  ⍝ sanity check the given dimensions: 1x1 not allowed

	(V H)←∊⍵

	⍞←2/NL                             ⍝ begin printing the maze after some vertical space



    R←1?H
    ⍞←(':' NL),⍨∊(':--' ':  ')[1+R=⍳H]  ⍝ print the first row of the maze, with the entrance at a random spot

	⍝ some variable initialization
	W[R;S]=C←S←1
	C←C+1

	nextNonZero←{⍺ {(1 1)+(⍴⍺)⊤⍵-1} (≢s)|r+⊃⍸(s←,⍺)⌽⍨r←1-⍨⍺ {1+(⍴⍺)⊥⍵-1} ⍵}
	L210:(R S)←W nextNonZero R S
	L250:→(W[R;S]=0)/L210

	L260:→((O=R-1)∨0≠W(R-1,S))/L530        ⍝ If we are at the left wall, or there is a NON-zero to the left of the current spot
	L270:→((0=S-1)∨0≠W(R,S-1))/L390        ⍝ If we are at the top wall, or there is a NON-zero to the top of the current spot
	L290:→((R=H)∨0≠W(R+1,S))/L330

	L310:→(L790 L820 L860)[1?3]

	L330:→(S≠V)/L340
	→(Z=1)/L370
	Q←Q+1 ⋄ →L350

	L340:→(0≠W[R,S+1])/L370

	L350:→(L790 L820 L910)[1?3]
	L370:→(L790 L820 L470)[1?3]

	L400:→(0≠W[R+1,S])/L470
	→(S≠V)/L420
	→(Z=1)/L450
	Q←1 ⋄ →L430

	L420:→(0≠W[R;S-1])/L450

	L430:→(L790 L860 L910)[1?3]
	L450:→(L790 L860)[1?2]

	L470:→(S≠V)/L490
	→(Z=1)/L520
	Q←1 ⋄ →L500

	L490:→(0≠W[R;S+1])/L520

	L500:→(L790 L910)[1?2]

	L520:→L790

	L530:→((0=S-1)∨0≠W[R;S-1])/L670
	→((R=H)∨0≠W[R+1,S])/L610
	→(S≠V)/L560
	→(Z=1)/L590
	Q←1 ⋄ →L570

	L560:→(0≠W[R;S+1])/L590

	L570:→(L820 L860 L920)/[1?3]
	L590:→(L920 L860)[1?2]

	L610:→(S≠V)/L630
	→(Z=1)/L660
	Q←1 ⋄ →L640

	L630:→(0≠W[R;S+1])/L660

	L640:→(L820 L910)[1?2]

	L660:→L820

	L670:→((R=H)∨0≠W[R+1;S])/L740
	→(S≠V)/L700
	→(Z=1)/L730
	Q←1 ⋄ L830

	L700:→(0≠W[R;S+1])/L370

	→(L860 L910)[1?2]

	L730:→L860

	L740:→(S<>V)/L760
	→(Z=1)/L780
	Q←1 ⋄ ←L770

	L760:→(0≠W[R;S+1])/L780

	L770:→L910
	L780:→L1000

	L790:W[R-1;S]←C
	C←C+1
	V[R-1;S]←2
	R←R-1

	→(C=1+H×V)/L1010
	Q←0 ⋄ →L260

	L820:W[R;S-1]←C
	L830:C←C+1
	V[R;S-1]←1
	S←S-1

	→(C=1+H×V)/L1010
	Q←0 ⋄ →L260

	L860:W[R+1;S]←C
	C←C+1
	→(0=V[R;S])/L880
	V[R;S]←3 ⋄ →L890

	L880:V[R;S]←2

	L890:R←R+1
	→(C=1+H×V)/L1010
	→L530

	L910:→(Q=1)/L960
	L920:W[R;S+1]←C
	C←C+1
	→(0=V[R;S])/L940

	V[R;S]←3 ⋄ →L950

	L940:V[R;S]←1

	L950:S←S+1
	→(C=1+H×V)/L1010
	→L260

	L960:Z←1
	→(0=V[R;S])/L980
	V[R;S]←3
	Q←0 ⋄ →L1000

	L980:V[R;S]←1
	Q←0 ⋄ R←S←1

	L991:→L250

	L1000→L210

	O←':--' ':  ' ':--'
	E←'  I' '  I' '   '

	oR←(∊⍤1)':',⍨O[1+V]
	eR←(∊⍤1)'I',E[1+V]

	⍞←eR{(⊂⍋⍵⍳∘≢¨⍺ ⍵)⌷⍺⍪⍵}oR
