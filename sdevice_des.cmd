Electrode{
   { Name="source"      Voltage=  0.0  }
   { Name="drain"       Voltage=  0.0  }
   { Name="topGate"       Voltage=  0.0  Schottky Barrier = 0.02 }
   { Name="bottomGate"    Voltage=  0.0  Schottky Barrier = 0.02 }
}

File{
   Grid= "@tdr@"    
   Current= "@plot@"       
   Output= "@log@"
   Plot= "@tdrdat@"        
   Parameter= "@parameter@"        
}

Physics( Material="InGaAs"){
   MoleFraction( xFraction= 0.2 Grading= 0)
   ### for quantum confinement of InGaAs
   * LayerThickness(Thickness=0.003)
   * Multivalley(
   *     MLDA
   *     ThinLayer
   * )
}

Physics {
   Recombination(
     Band2Band(
       Model = NonLocalPath
     )
   )                           
   EffectiveIntrinsicDensity( NoBandGapNarrowing )

   * Recombination(
   *	SRH
   *	Auger		
   * )
   * Fermi ### Use Fermi Distribution: Has huge impact on the current
   * Thermionic
   * hBarrierTunneling "NLM_source"
   * eBarrierTunneling "NLM_drain"
}



Plot{
   eDensity hDensity
   TotalCurrent/Vector eCurrent/Vector hCurrent/Vector
   eMobility hMobility
   eVelocity hVelocity
   eQuasiFermi hQuasiFermi
   eBarrierTunneling
   hBarrierTunneling
   ElectricField/Vector Potential SpaceCharge
   Doping DonorConcentration AcceptorConcentration
   eGradQuasiFermi/Vector hGradQuasiFermi/Vector
   eEparallel hEparalllel
   BandGap 
   Affinity
   ConductionBand ValenceBand
   xMoleFraction
}

Math{
   RelErrControl
   ErrRef(Electron)=1e5
   ErrRef(Hole)=1e5
   Extrapolate
   Digits= 4
   Notdamped= 100
   Iterations= 3
   NumberOfThreads=16
   * RelTermMinDensity= 1e4
   * RelTermMinDensityZero= 1e7     
}

* Math {
*   	NonLocal "NLM_source" (
*		Electrode="source"
*		Digits= 4
*		Length= 5e-9
*		EnergyResolution= 1e-3
**		Direction=(0 -1 0) 
*	)
*	NonLocal "NLM_drain" (
*		Electrode="drain"
*		Digits= 4
*		Length= 5e-9
*		EnergyResolution= 1e-3
*		Direction=(0 1 0) 
*	)
* }


Solve{
*- Initial Solution:
   Coupled( Iterations= 100 ){ Poisson }
   Coupled{ Poisson Electron Hole }

#----------------------------------------------------------------------#
#- Plots
#----------------------------------------------------------------------#

Quasistationary( InitialStep= 5e-2 Increment= 1.25 
 Minstep= 1e-8 MaxStep= 0.015
 Goal{ Name="drain" Voltage = 0.4 }) 
 { Coupled{ Poisson Electron Hole } }
Quasistationary( InitialStep= 5e-2 Increment= 1.25 
 Minstep= 1e-8 MaxStep= 0.015
 Goal{ Name="bottomGate" Voltage = 0.0 }) 
 { Coupled{ Poisson Electron Hole } }
NewCurrentFile="IV_Vds_0.4_Vbg_0.0_"
Quasistationary( InitialStep= 5e-2 Increment= 1.25 
 Minstep= 1e-8 MaxStep= 0.015
 Goal{ Name="topGate"  Voltage= 0.4 }) 
 { Coupled{ Poisson Electron Hole } }


Quasistationary( InitialStep= 5e-2 Increment= 1.25 
 Minstep= 1e-8 MaxStep= 0.015 
 Goal{ Name="drain" Voltage = 0.4 }) 
 { Coupled{ Poisson Electron Hole } }
Quasistationary( InitialStep= 5e-2 Increment= 1.25 
 Minstep= 1e-8 MaxStep= 0.015
 Goal{ Name="bottomGate" Voltage = 0.4 }) 
 { Coupled{ Poisson Electron Hole } }
NewCurrentFile="IV_Vds_0.4_Vbg_0.4_"
Quasistationary( InitialStep= 5e-2 Increment= 1.25 
 Minstep= 1e-8 MaxStep= 0.015
 Goal{ Name="topGate"  Voltage= 0.0 }) 
 { Coupled{ Poisson Electron Hole } }


Quasistationary( InitialStep= 5e-2 Increment= 1.25 
 Minstep= 1e-8 MaxStep= 0.015 
 Goal{ Name="drain" Voltage = 0.4 }) 
 { Coupled{ Poisson Electron Hole } }
Quasistationary( InitialStep= 5e-2 Increment= 1.25 
 Minstep= 1e-8 MaxStep= 0.015 
 Goal{ Name="bottomGate" Voltage = 0.2 }) 
 { Coupled{ Poisson Electron Hole } }
NewCurrentFile="IV_Vds_0.4_Vbg_0.2_"
Quasistationary( InitialStep= 5e-2 Increment= 1.25 
 Minstep= 1e-8 MaxStep= 0.015
 Goal{ Name="topGate"  Voltage= 0.4 }) 
 { Coupled{ Poisson Electron Hole } }


}
