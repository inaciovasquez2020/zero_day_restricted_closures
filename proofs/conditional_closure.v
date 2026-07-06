Conditional

RequiredClassesSubsetSH(X) :=
  forall i : ZeroDayRequiredK3nHodgeClasses(X).I,
    ZeroDayRequiredK3nHodgeClasses(X).class(i) in SH^(2 * degree(i))(X,Q)

ZeroDayConditionalClosureSurface(X) :=
  required_subset_SH : RequiredClassesSubsetSH(X)
  closure_from_required_subset :
    RequiredClassesSubsetSH(X) -> ZeroDayClosure(X)

Theorem required_classes_subset_SH_implies_zero_day_closure:
  RequiredClassesSubsetSH(X) -> ZeroDayClosure(X)

Boundary:
  not UnconditionalCompletenessSourceForZeroDayRequiredK3nHodgeClasses
