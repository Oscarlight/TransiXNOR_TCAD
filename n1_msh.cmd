Title ""

Controls {
}

Definitions {
	Constant "P.NSemi" {
		Species = "PhosphorusActiveConcentration"
		Value = 1e+19
	}
	Constant "P.PSemi" {
		Species = "BoronActiveConcentration"
		Value = 1e+19
	}
	Refinement "Ref.Semi" {
		MaxElementSize = ( 0.00025 0.00025 99 )
		MinElementSize = ( 0.00025 0.00025 66 )
	}
	Refinement "Ref.Box" {
		MaxElementSize = ( 0.00025 0.00025 99 )
		MinElementSize = ( 0.00025 0.00025 66 )
	}
	Refinement "Ref.Tox" {
		MaxElementSize = ( 0.00025 0.00025 99 )
		MinElementSize = ( 0.00025 0.00025 66 )
	}
}

Placements {
	Constant "P.NSemi" {
		Reference = "P.NSemi"
		EvaluateWindow {
			Element = Rectangle [(0.015 0.0005) (0.02 0.0015)]
		}
	}
	Constant "P.PSemi" {
		Reference = "P.PSemi"
		EvaluateWindow {
			Element = Rectangle [(0 0.0005) (0.005 0.0015)]
		}
	}
	Refinement "Ref.Semi" {
		Reference = "Ref.Semi"
		RefineWindow = Rectangle [(0 0.0005) (0.02 0.0015)]
	}
	Refinement "Ref.Box" {
		Reference = "Ref.Box"
		RefineWindow = Rectangle [(0.005 0) (0.015 0.0005)]
	}
	Refinement "Ref.Tox" {
		Reference = "Ref.Tox"
		RefineWindow = Rectangle [(0.005 0.0015) (0.015 0.002)]
	}
}

