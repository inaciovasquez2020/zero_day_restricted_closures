# LLV/Markman-Nearby Input Insufficiency Receipt

BOUNDARY := not UnconditionalCompletenessSourceForZeroDayRequiredK3nHodgeClasses

Negative receipt:

LLVMarkmanNearbyInputInsufficiencyReceipt :=
  {
    llv_markman_nearby_input : LLVMarkmanNearbyInputSurface,
    missing_bridge :
      not ProvenFrom LLVMarkmanNearbyInputSurface
        (forall X, RequiredClassesSubsetSH(X)),
    preserved_boundary :
      not UnconditionalCompletenessSourceForZeroDayRequiredK3nHodgeClasses
  }

This receipt does not assert a counterexample class. It records only the weaker structural insufficiency:
LLVMarkmanNearbyInputSurface does not by itself prove forall X, RequiredClassesSubsetSH(X).
