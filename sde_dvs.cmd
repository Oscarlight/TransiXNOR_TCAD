;----------------------------------------------------------------------
; Definitions
;----------------------------------------------------------------------

(define  chLength     0.010) ; 10 nm
(define  sdLength     0.005) ; 5 nm
(define  chThickness  0.001) ; 1 nm 
(define  tOxThickness 0.0005) ; 1 nm
(define  bOxThickness 0.0005) ; 1 nm
(define  x_step       0.00025); 0.25 nm
(define  y_step       0.00025); 0.25 nm

;----------------------------------------------------------------------
; Derived Quantities
;---------------------------------------------------------------------- 

(define chLengthHalf (/ chLength 2))
(define chThicknessHalf (/ chThickness 2))
(define sdLengthHalf (/ sdLength 2))
 
(define s_x1  0.0)
(define s_y1  bOxThickness)
(define s_x2  sdLength)
(define s_y2  (+ s_y1 chThickness))

(define ch_x1 s_x2)
(define ch_y1 s_y1)
(define ch_x2 (+ s_x2 chLength))
(define ch_y2 s_y2)

(define d_x1  ch_x2)
(define d_y1  ch_y1)
(define d_x2  (+ ch_x2 sdLength))
(define d_y2  ch_y2)

(define box_x1 ch_x1)
(define box_y1 0.0)
(define box_x2 ch_x2)
(define box_y2 ch_y1)

(define tox_x1 ch_x1)
(define tox_y1 ch_y2)
(define tox_x2 ch_x2)
(define tox_y2 (+ ch_y2 tOxThickness))

(define source_x s_x1)
(define source_y (+ s_y1 chThicknessHalf))
(define drain_x  d_x2)
(define drain_y  (- d_y2 chThicknessHalf))
(define tGate_x  (- tox_x2 chLengthHalf))
(define tGate_y  tox_y2)
(define bGate_x  (+ box_x1 chLengthHalf))
(define bGate_y 0.0)

(define max_x d_x2)
(define max_y (+ d_y2 tOxThickness))

;----------------------------------------------------------------------
; Layer System
;----------------------------------------------------------------------


(sdegeo:create-rectangle 
 (position ch_x1 ch_y1 0) 
 (position ch_x2 ch_y2 0) "InGaAs" "Channel")

(sdegeo:create-rectangle 
 (position d_x1 d_y1 0) 
 (position d_x2 d_y2 0) "InGaAs" "Drain")

(sdegeo:create-rectangle 
 (position box_x1 box_y1 0) 
 (position box_x2 box_y2 0) "SiO2" "TopOx")

(sdegeo:create-rectangle 
 (position tox_x1 tox_y1 0) 
 (position tox_x2 tox_y2 0) "SiO2" "BottomOx")

(sdegeo:create-rectangle 
 (position s_x1 s_y1 0) 
 (position s_x2 s_y2 0) "InGaAs" "Source")

; --------------------------------------------------------------------------------
; Doping
; --------------------------------------------------------------------------------
(sdedr:define-refinement-window "Pl.NSemi" "Rectangle" (position d_x1 d_y1 0)  (position d_x2 d_y2 0))
(sdedr:define-constant-profile "P.NSemi" "PhosphorusActiveConcentration" 1E19)
(sdedr:define-constant-profile-placement "P.NSemi" "P.NSemi" "Pl.NSemi")

(sdedr:define-refinement-window "Pl.PSemi" "Rectangle" (position s_x1 s_y1 0)  (position s_x2 s_y2 0))
(sdedr:define-constant-profile "P.PSemi" "BoronActiveConcentration" 1E19)
(sdedr:define-constant-profile-placement "P.PSemi" "P.PSemi" "Pl.PSemi")

; --------------------------------------------------------------------------------
; Create and place all electrodes
; --------------------------------------------------------------------------------

(sdegeo:define-contact-set "source"       4.0 (color:rgb 1.0 0.0 0.0 ) "##" )
(sdegeo:define-contact-set "drain"        4.0 (color:rgb 0.0 1.0 0.0 ) "##" )
(sdegeo:define-contact-set "topGate"      4.0 (color:rgb 0.0 0.0 1.0 ) "##" )
(sdegeo:define-contact-set "bottomGate"   4.0 (color:rgb 1.0 1.0 0.0 ) "##" )

(sdegeo:define-2d-contact (find-edge-id (position source_x source_y 0)) "source")
;(sdegeo:define-2d-contact (find-edge-id 
;   (position (+ source_x sdLengthHalf) (+ source_y chThicknessHalf) 0)) "source")
;(sdegeo:define-2d-contact (find-edge-id 
;   (position (+ source_x sdLengthHalf) (- source_y chThicknessHalf) 0)) "source")

(sdegeo:define-2d-contact (find-edge-id (position drain_x drain_y 0)) "drain")
;(sdegeo:define-2d-contact (find-edge-id 
;   (position (- drain_x sdLengthHalf) (+ drain_y chThicknessHalf) 0)) "drain")
;(sdegeo:define-2d-contact (find-edge-id 
;   (position (- drain_x sdLengthHalf) (- drain_y chThicknessHalf) 0)) "drain")

(sdegeo:define-2d-contact (find-edge-id (position tGate_x tGate_y 0)) "topGate")
(sdegeo:define-2d-contact (find-edge-id (position bGate_x bGate_y 0)) "bottomGate")

;----------------------------------------------------------------------
; Meshing
;----------------------------------------------------------------------

(sdedr:define-refinement-window "Pl.Semi" "Rectangle" 
  (position s_x1 s_y1 0) 
  (position d_x2 d_y2 0))
(sdedr:define-refinement-size "Ref.Semi" x_step y_step 99 x_step y_step 66 )
(sdedr:define-refinement-placement "Ref.Semi" "Ref.Semi" "Pl.Semi" )

(sdedr:define-refinement-window "Pl.Box" "Rectangle" 
  (position box_x1 box_y1 0) 
  (position box_x2 box_y2 0))
(sdedr:define-refinement-size "Ref.Box" x_step y_step 99 x_step y_step 66 )
(sdedr:define-refinement-placement "Ref.Box" "Ref.Box" "Pl.Box" )

(sdedr:define-refinement-window "Pl.Tox" "Rectangle" 
  (position tox_x1 tox_y1 0) 
  (position tox_x2 tox_y2 0))
(sdedr:define-refinement-size "Ref.Tox" x_step y_step 99 x_step y_step 66 )
(sdedr:define-refinement-placement "Ref.Tox" "Ref.Tox" "Pl.Tox" )

;----------------------------------------------------------------------
; Build Mesh 
;----------------------------------------------------------------------
(sde:build-mesh "snmesh" "" "n@node@_msh")



