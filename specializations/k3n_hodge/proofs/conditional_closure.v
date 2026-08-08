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


Theorem BottiniK3TwoTypeVerbitskyExhaustion:
  IsK3TwoType(X) ->
  H^*(X,Q) = SH(X,Q)

Proof:
  Let X be of K3^[2]-type.

  Start from the K3 Betti numbers
      (b_0,b_1,b_2,b_3,b_4) = (1,0,22,0,1).

  Applying the Göttsche Hilbert-scheme Poincare-polynomial
  generating formula and extracting the q^2 coefficient gives
      P_X(t)
        = 1 + 23 t^2 + 276 t^4 + 23 t^6 + t^8.

  Therefore
      dim_Q H^0(X,Q) = 1,
      dim_Q H^2(X,Q) = 23,
      dim_Q H^4(X,Q) = 276,
      dim_Q H^6(X,Q) = 23,
      dim_Q H^8(X,Q) = 1,
  and the odd rational cohomology groups vanish.

  By Verbitsky's theorem, specialized to n = 2,
      SH^0(X,Q) ~= Sym^0 H^2(X,Q),
      SH^2(X,Q) ~= Sym^1 H^2(X,Q),
      SH^4(X,Q) ~= Sym^2 H^2(X,Q),
      SH^6(X,Q) ~= Sym^1 H^2(X,Q),
      SH^8(X,Q) ~= Sym^0 H^2(X,Q).

  Since dim_Q H^2(X,Q) = 23,
      dim Sym^0 H^2 = 1,
      dim Sym^1 H^2 = 23,
      dim Sym^2 H^2 = 23 * 24 / 2 = 276.

  Hence SH(X,Q) and H^*(X,Q) have equal dimension in every
  cohomological degree.

  By definition SH(X,Q) is a graded subalgebra of H^*(X,Q).
  Each graded inclusion is therefore an inclusion of
  finite-dimensional Q-vector spaces of equal dimension and is
  consequently an equality.

  Thus
      H^*(X,Q) = SH(X,Q).
Qed.

Sources:
  Göttsche Hilbert-scheme Poincare-polynomial formula.
  Verbitsky theorem as stated in Bottini,
  The Looijenga-Lunts-Verbitsky Algebra and Verbitsky's Theorem,
  Definition 4.4, Theorem 5.1, Corollary 5.3.

Boundary:
  Bottini Example 5.4 is no longer imported as the exhaustion result
  the exhaustion conclusion is derived from Göttsche plus Verbitsky
  the underlying Göttsche and Verbitsky theorems remain external inputs
  no K3^[n]-type exhaustion for n >= 3 is claimed

Theorem k3_three_type_degree_four_SH_obstruction:
  For X of K3^[3]-type,
    dim_Q H^4(X,Q) = 299
    and dim_Q SH^4(X,Q) = 276
    and dim_Q (H^4(X,Q) / SH^4(X,Q)) = 23
    and H^*(X,Q) != SH(X,Q)

Proof:
  Let X be of K3^[3]-type.

  Applying the Göttsche Hilbert-scheme Poincare-polynomial
  generating formula and extracting the q^3 coefficient gives
      P_X(t)
        = 1
          + 23 t^2
          + 299 t^4
          + 2554 t^6
          + 299 t^8
          + 23 t^10
          + t^12.

  Therefore
      dim_Q H^2(X,Q) = 23
  and
      dim_Q H^4(X,Q) = 299.

  By Verbitsky's theorem, since 2 <= 3,
      SH^4(X,Q) ~= Sym^2 H^2(X,Q).

  Hence
      dim_Q SH^4(X,Q)
        = dim_Q Sym^2(Q^23)
        = 23 * 24 / 2
        = 276.

  By definition
      SH^4(X,Q) subset H^4(X,Q).

  Therefore
      dim_Q (H^4(X,Q) / SH^4(X,Q))
        = 299 - 276
        = 23.

  In particular SH^4(X,Q) is a proper subspace of H^4(X,Q),
  so
      H^*(X,Q) != SH(X,Q).
Qed.

Boundary:
  exact first obstruction to Verbitsky-component exhaustion occurs at K3^[3] degree 4
  the missing quotient has rational dimension exactly 23
  H^*(X,Q) = SH(X,Q) is abandoned as the closure route for n >= 3
  future n >= 3 work must test required classes against SH and its complement directly


K3ThreeTypeDegreeFourInputSurface(X) :=
  type : IsK3ThreeType(X)
  ambient : H^4(X,Q)
  verbitzky_component : SH^4(X,Q)
  quotient : H^4(X,Q) / SH^4(X,Q)
  ambient_dimension : dim_Q H^4(X,Q) = 299
  verbitzky_dimension : dim_Q SH^4(X,Q) = 276
  quotient_dimension : dim_Q (H^4(X,Q) / SH^4(X,Q)) = 23

Boundary:
  no required class is selected
  no quotient projection of a required class is asserted
  no basis of the 23-dimensional quotient is chosen
  this surface records only the exact ambient degree-four obstruction data


K3ThreeTypeDegreeFourRequiredClassSelection(X) :=
  I4 :=
    { i : ZeroDayRequiredK3nHodgeClasses(X).I
      // degree(i) = 2 }
  selected_class :
    forall i : I4,
      H^4(X,Q)
  selected_class(i) :=
    ZeroDayRequiredK3nHodgeClasses(X).class(i.val)

SelectionRule:
  select exactly those existing required-class indices whose degree is 2

Boundary:
  does not assert I4 is nonempty
  does not introduce a new required class
  does not choose an arbitrary element of H^4(X,Q)
  does not assert selected_class(i) lies outside SH^4(X,Q)
  does not define or evaluate any quotient projection



Theorem k3_two_type_one_required_class_in_SH:
  IsK3TwoType(X) ->
  forall i : ZeroDayRequiredK3nHodgeClasses(X).I,
    ZeroDayRequiredK3nHodgeClasses(X).class(i)
      in SH^(2 * degree(i))(X,Q)

Proof:
  Let X be of K3^[2]-type.
  Let i : ZeroDayRequiredK3nHodgeClasses(X).I.

  By ZeroDayRequiredK3nHodgeClasses.class,
      ZeroDayRequiredK3nHodgeClasses(X).class(i)
        in H^(2 * degree(i))(X,Q).

  By BottiniK3TwoTypeVerbitskyExhaustion(X),
      H^*(X,Q) = SH(X,Q).

  Taking the degree-(2 * degree(i)) graded component gives
      H^(2 * degree(i))(X,Q)
        = SH^(2 * degree(i))(X,Q).

  Therefore
      ZeroDayRequiredK3nHodgeClasses(X).class(i)
        in SH^(2 * degree(i))(X,Q).
Qed.

Boundary:
  one arbitrary required-class membership only
  RequiredClassesSubsetSH(X) not yet derived
  K3^[n]-type with n >= 3 not discharged


Theorem k3_two_type_required_classes_subset_SH:
  IsK3TwoType(X) ->
  RequiredClassesSubsetSH(X)

Proof:
  Let X be of K3^[2]-type.
  Unfold RequiredClassesSubsetSH(X).
  Let i : ZeroDayRequiredK3nHodgeClasses(X).I.
  Apply k3_two_type_one_required_class_in_SH(X,i).
Qed.

Boundary:
  this is only forall-i closure of the proved one-class membership
  depends on BottiniK3TwoTypeVerbitskyExhaustion(X)
  K3^[n]-type with n >= 3 is not discharged
  ZeroDayClosure(X) is not invoked


Theorem k3_two_type_zero_day_closure:
  IsK3TwoType(X) ->
  ZeroDayClosure(X)

Proof:
  Let X be of K3^[2]-type.
  Apply required_classes_subset_SH_implies_zero_day_closure(X).
  Apply k3_two_type_required_classes_subset_SH(X).
Qed.

Boundary:
  K3^[2]-type closure depends on BottiniK3TwoTypeVerbitskyExhaustion(X)
  the Bottini result is imported from external literature
  no K3^[n]-type closure for n >= 3 is claimed
  not UnconditionalCompletenessSourceForZeroDayRequiredK3nHodgeClasses
