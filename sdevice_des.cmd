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


Physics {
   Recombination(
     Band2Band(
       Model = NonLocalPath
     )
   )                           
   EffectiveIntrinsicDensity( NoBandGapNarrowing )
}


Physics( Material="InGaAs"){
   MoleFraction( xFraction= 0.2 Grading= 0)
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
   Extrapolate
   Digits= 4
   Notdamped= 100
   Iterations= 15
   RelErrControl
   ErrRef(Electron) = 1e7
   ErrRef(Hole)     = 1e7
   RelTermMinDensity= 1e4
   RelTermMinDensityZero= 1e7     
}

Solve{
*- Initial Solution:
   Coupled( Iterations= 100 ){ Poisson }
   Coupled{ Poisson Electron Hole }

#----------------------------------------------------------------------#
#- Plots
#----------------------------------------------------------------------#

Quasistationary( InitialStep= 5e-2 Increment= 1.25 
 Minstep= 1e-5 MaxStep= 0.30 
 Goal{ Name="drain" Voltage = 0.4 }) 
 { Coupled{ Poisson Electron Hole } }
Quasistationary( InitialStep= 5e-2 Increment= 1.25 
 Minstep= 1e-5 MaxStep= 0.30 
 Goal{ Name="bottomGate" Voltage = 0.0 }) 
 { Coupled{ Poisson Electron Hole } }
NewCurrentFile="IV_Vds_0.4_Vbg_0.0_"
Quasistationary( InitialStep= 5e-2 Increment= 1.25 
 Minstep= 1e-5 MaxStep= 0.015
 Goal{ Name="topGate"  Voltage= 0.4 }) 
 { Coupled{ Poisson Electron Hole } }
Quasistationary( InitialStep= 5e-2 Increment= 1.25 
 Minstep= 1e-5 MaxStep= 0.40 
 Goal{ Name="topGate" Voltage = 0.0 }) 
 { Coupled{ Poisson Electron Hole } }


Quasistationary( InitialStep= 5e-2 Increment= 1.25 
 Minstep= 1e-5 MaxStep= 0.30 
 Goal{ Name="drain" Voltage = 0.4 }) 
 { Coupled{ Poisson Electron Hole } }
Quasistationary( InitialStep= 5e-2 Increment= 1.25 
 Minstep= 1e-5 MaxStep= 0.30 
 Goal{ Name="bottomGate" Voltage = 0.4 }) 
 { Coupled{ Poisson Electron Hole } }
NewCurrentFile="IV_Vds_0.4_Vbg_0.4_"
Quasistationary( InitialStep= 5e-2 Increment= 1.25 
 Minstep= 1e-5 MaxStep= 0.015
 Goal{ Name="topGate"  Voltage= 0.4 }) 
 { Coupled{ Poisson Electron Hole } }
Quasistationary( InitialStep= 5e-2 Increment= 1.25 
 Minstep= 1e-5 MaxStep= 0.40 
 Goal{ Name="topGate" Voltage = 0.0 }) 
 { Coupled{ Poisson Electron Hole } }

Quasistationary( InitialStep= 5e-2 Increment= 1.25 
 Minstep= 1e-5 MaxStep= 0.30 
 Goal{ Name="drain" Voltage = 0.4 }) 
 { Coupled{ Poisson Electron Hole } }
Quasistationary( InitialStep= 5e-2 Increment= 1.25 
 Minstep= 1e-5 MaxStep= 0.30 
 Goal{ Name="bottomGate" Voltage = 0.2 }) 
 { Coupled{ Poisson Electron Hole } }
NewCurrentFile="IV_Vds_0.4_Vbg_0.2_"
Quasistationary( InitialStep= 5e-2 Increment= 1.25 
 Minstep= 1e-5 MaxStep= 0.015
 Goal{ Name="topGate"  Voltage= 0.4 }) 
 { Coupled{ Poisson Electron Hole } }
Quasistationary( InitialStep= 5e-2 Increment= 1.25 
 Minstep= 1e-5 MaxStep= 0.40 
 Goal{ Name="topGate" Voltage = 0.0 }) 
 { Coupled{ Poisson Electron Hole } }

}
