
C
global_step/initial_valueConst*
dtype0*
value	B : 
W
global_step
VariableV2*
	container *
dtype0*
shape: *
shared_name 
�
global_step/AssignAssignglobal_stepglobal_step/initial_value*
T0*
_class
loc:@global_step*
use_locking(*
validate_shape(
R
global_step/readIdentityglobal_step*
T0*
_class
loc:@global_step
;
steps_to_incrementPlaceholder*
dtype0*
shape: 
9
AddAddglobal_step/readsteps_to_increment*
T0
t
AssignAssignglobal_stepAdd*
T0*
_class
loc:@global_step*
use_locking(*
validate_shape(
L
vector_observationPlaceholder*
dtype0*
shape:���������
w
%normalization_steps/Initializer/zerosConst*&
_class
loc:@normalization_steps*
dtype0*
value	B : 
�
normalization_steps
VariableV2*&
_class
loc:@normalization_steps*
	container *
dtype0*
shape: *
shared_name 
�
normalization_steps/AssignAssignnormalization_steps%normalization_steps/Initializer/zeros*
T0*&
_class
loc:@normalization_steps*
use_locking(*
validate_shape(
j
normalization_steps/readIdentitynormalization_steps*
T0*&
_class
loc:@normalization_steps
p
running_mean/Initializer/zerosConst*
_class
loc:@running_mean*
dtype0*
valueB*    
}
running_mean
VariableV2*
_class
loc:@running_mean*
	container *
dtype0*
shape:*
shared_name 
�
running_mean/AssignAssignrunning_meanrunning_mean/Initializer/zeros*
T0*
_class
loc:@running_mean*
use_locking(*
validate_shape(
U
running_mean/readIdentityrunning_mean*
T0*
_class
loc:@running_mean
w
!running_variance/Initializer/onesConst*#
_class
loc:@running_variance*
dtype0*
valueB*  �?
�
running_variance
VariableV2*#
_class
loc:@running_variance*
	container *
dtype0*
shape:*
shared_name 
�
running_variance/AssignAssignrunning_variance!running_variance/Initializer/ones*
T0*#
_class
loc:@running_variance*
use_locking(*
validate_shape(
a
running_variance/readIdentityrunning_variance*
T0*#
_class
loc:@running_variance
;
ShapeShapevector_observation*
T0*
out_type0
A
strided_slice/stackConst*
dtype0*
valueB: 
C
strided_slice/stack_1Const*
dtype0*
valueB:
C
strided_slice/stack_2Const*
dtype0*
valueB:
�
strided_sliceStridedSliceShapestrided_slice/stackstrided_slice/stack_1strided_slice/stack_2*
Index0*
T0*

begin_mask *
ellipsis_mask *
end_mask *
new_axis_mask *
shrink_axis_mask
>
Add_1Addnormalization_steps/readstrided_slice*
T0
:
SubSubvector_observationrunning_mean/read*
T0
;
CastCastAdd_1*

DstT0*

SrcT0*
Truncate( 
&
truedivRealDivSubCast*
T0
?
Sum/reduction_indicesConst*
dtype0*
value	B : 
P
SumSumtruedivSum/reduction_indices*
T0*

Tidx0*
	keep_dims( 
/
add_2AddV2running_mean/readSum*
T0
0
Sub_1Subvector_observationadd_2*
T0

mulMulSub_1Sub*
T0
A
Sum_1/reduction_indicesConst*
dtype0*
value	B : 
P
Sum_1SummulSum_1/reduction_indices*
T0*

Tidx0*
	keep_dims( 
5
add_3AddV2running_variance/readSum_1*
T0
z
Assign_1Assignrunning_meanadd_2*
T0*
_class
loc:@running_mean*
use_locking(*
validate_shape(
�
Assign_2Assignrunning_varianceadd_3*
T0*#
_class
loc:@running_variance*
use_locking(*
validate_shape(
�
Assign_3Assignnormalization_stepsAdd_1*
T0*&
_class
loc:@normalization_steps*
use_locking(*
validate_shape(
L
moments/mean/reduction_indicesConst*
dtype0*
valueB: 
n
moments/meanMeanvector_observationmoments/mean/reduction_indices*
T0*

Tidx0*
	keep_dims(
;
moments/StopGradientStopGradientmoments/mean*
T0
a
moments/SquaredDifferenceSquaredDifferencevector_observationmoments/StopGradient*
T0
P
"moments/variance/reduction_indicesConst*
dtype0*
valueB: 
}
moments/varianceMeanmoments/SquaredDifference"moments/variance/reduction_indices*
T0*

Tidx0*
	keep_dims(
H
moments/SqueezeSqueezemoments/mean*
T0*
squeeze_dims
 
N
moments/Squeeze_1Squeezemoments/variance*
T0*
squeeze_dims
 
�
Assign_4Assignrunning_meanmoments/Squeeze*
T0*
_class
loc:@running_mean*
use_locking(*
validate_shape(
4
add_4/yConst*
dtype0*
valueB
 *���3
3
add_4AddV2moments/Squeeze_1add_4/y*
T0
=
Cast_1CastAdd_1*

DstT0*

SrcT0*
Truncate( 
$
mul_1Muladd_4Cast_1*
T0
�
Assign_5Assignrunning_variancemul_1*
T0*#
_class
loc:@running_variance*
use_locking(*
validate_shape(
3

group_depsNoOp	^Assign_3	^Assign_4	^Assign_5
5
group_deps_1NoOp	^Assign_1	^Assign_2	^Assign_3
<
sub_2Subvector_observationrunning_mean/read*
T0
P
Cast_2Castnormalization_steps/read*

DstT0*

SrcT0*
Truncate( 
4
add_5/yConst*
dtype0*
valueB
 *  �?
(
add_5AddV2Cast_2add_5/y*
T0
;
	truediv_1RealDivrunning_variance/readadd_5*
T0
 
SqrtSqrt	truediv_1*
T0
*
	truediv_2RealDivsub_2Sqrt*
T0
G
normalized_state/Minimum/yConst*
dtype0*
valueB
 *  �@
S
normalized_state/MinimumMinimum	truediv_2normalized_state/Minimum/y*
T0
?
normalized_state/yConst*
dtype0*
valueB
 *  ��
R
normalized_stateMaximumnormalized_state/Minimumnormalized_state/y*
T0
5

batch_sizePlaceholder*
dtype0*
shape:
:
sequence_lengthPlaceholder*
dtype0*
shape:
;
masksPlaceholder*
dtype0*
shape:���������
A
epsilonPlaceholder*
dtype0*
shape:���������
=
Cast_3Castmasks*

DstT0*

SrcT0*
Truncate( 
M
#is_continuous_control/initial_valueConst*
dtype0*
value	B :
a
is_continuous_control
VariableV2*
	container *
dtype0*
shape: *
shared_name 
�
is_continuous_control/AssignAssignis_continuous_control#is_continuous_control/initial_value*
T0*(
_class
loc:@is_continuous_control*
use_locking(*
validate_shape(
p
is_continuous_control/readIdentityis_continuous_control*
T0*(
_class
loc:@is_continuous_control
M
#trainer_major_version/initial_valueConst*
dtype0*
value	B : 
a
trainer_major_version
VariableV2*
	container *
dtype0*
shape: *
shared_name 
�
trainer_major_version/AssignAssigntrainer_major_version#trainer_major_version/initial_value*
T0*(
_class
loc:@trainer_major_version*
use_locking(*
validate_shape(
p
trainer_major_version/readIdentitytrainer_major_version*
T0*(
_class
loc:@trainer_major_version
M
#trainer_minor_version/initial_valueConst*
dtype0*
value	B :
a
trainer_minor_version
VariableV2*
	container *
dtype0*
shape: *
shared_name 
�
trainer_minor_version/AssignAssigntrainer_minor_version#trainer_minor_version/initial_value*
T0*(
_class
loc:@trainer_minor_version*
use_locking(*
validate_shape(
p
trainer_minor_version/readIdentitytrainer_minor_version*
T0*(
_class
loc:@trainer_minor_version
M
#trainer_patch_version/initial_valueConst*
dtype0*
value	B : 
a
trainer_patch_version
VariableV2*
	container *
dtype0*
shape: *
shared_name 
�
trainer_patch_version/AssignAssigntrainer_patch_version#trainer_patch_version/initial_value*
T0*(
_class
loc:@trainer_patch_version*
use_locking(*
validate_shape(
p
trainer_patch_version/readIdentitytrainer_patch_version*
T0*(
_class
loc:@trainer_patch_version
F
version_number/initial_valueConst*
dtype0*
value	B :
Z
version_number
VariableV2*
	container *
dtype0*
shape: *
shared_name 
�
version_number/AssignAssignversion_numberversion_number/initial_value*
T0*!
_class
loc:@version_number*
use_locking(*
validate_shape(
[
version_number/readIdentityversion_number*
T0*!
_class
loc:@version_number
C
memory_size/initial_valueConst*
dtype0*
value	B : 
W
memory_size
VariableV2*
	container *
dtype0*
shape: *
shared_name 
�
memory_size/AssignAssignmemory_sizememory_size/initial_value*
T0*
_class
loc:@memory_size*
use_locking(*
validate_shape(
R
memory_size/readIdentitymemory_size*
T0*
_class
loc:@memory_size
K
!action_output_shape/initial_valueConst*
dtype0*
value	B :
_
action_output_shape
VariableV2*
	container *
dtype0*
shape: *
shared_name 
�
action_output_shape/AssignAssignaction_output_shape!action_output_shape/initial_value*
T0*&
_class
loc:@action_output_shape*
use_locking(*
validate_shape(
j
action_output_shape/readIdentityaction_output_shape*
T0*&
_class
loc:@action_output_shape
�
Fpolicy/main_graph_0/hidden_0/kernel/Initializer/truncated_normal/shapeConst*6
_class,
*(loc:@policy/main_graph_0/hidden_0/kernel*
dtype0*
valueB"   @   
�
Epolicy/main_graph_0/hidden_0/kernel/Initializer/truncated_normal/meanConst*6
_class,
*(loc:@policy/main_graph_0/hidden_0/kernel*
dtype0*
valueB
 *    
�
Gpolicy/main_graph_0/hidden_0/kernel/Initializer/truncated_normal/stddevConst*6
_class,
*(loc:@policy/main_graph_0/hidden_0/kernel*
dtype0*
valueB
 *��M?
�
Ppolicy/main_graph_0/hidden_0/kernel/Initializer/truncated_normal/TruncatedNormalTruncatedNormalFpolicy/main_graph_0/hidden_0/kernel/Initializer/truncated_normal/shape*
T0*6
_class,
*(loc:@policy/main_graph_0/hidden_0/kernel*
dtype0*
seed�?*
seed2 
�
Dpolicy/main_graph_0/hidden_0/kernel/Initializer/truncated_normal/mulMulPpolicy/main_graph_0/hidden_0/kernel/Initializer/truncated_normal/TruncatedNormalGpolicy/main_graph_0/hidden_0/kernel/Initializer/truncated_normal/stddev*
T0*6
_class,
*(loc:@policy/main_graph_0/hidden_0/kernel
�
@policy/main_graph_0/hidden_0/kernel/Initializer/truncated_normalAddDpolicy/main_graph_0/hidden_0/kernel/Initializer/truncated_normal/mulEpolicy/main_graph_0/hidden_0/kernel/Initializer/truncated_normal/mean*
T0*6
_class,
*(loc:@policy/main_graph_0/hidden_0/kernel
�
#policy/main_graph_0/hidden_0/kernel
VariableV2*6
_class,
*(loc:@policy/main_graph_0/hidden_0/kernel*
	container *
dtype0*
shape
:@*
shared_name 
�
*policy/main_graph_0/hidden_0/kernel/AssignAssign#policy/main_graph_0/hidden_0/kernel@policy/main_graph_0/hidden_0/kernel/Initializer/truncated_normal*
T0*6
_class,
*(loc:@policy/main_graph_0/hidden_0/kernel*
use_locking(*
validate_shape(
�
(policy/main_graph_0/hidden_0/kernel/readIdentity#policy/main_graph_0/hidden_0/kernel*
T0*6
_class,
*(loc:@policy/main_graph_0/hidden_0/kernel
�
3policy/main_graph_0/hidden_0/bias/Initializer/zerosConst*4
_class*
(&loc:@policy/main_graph_0/hidden_0/bias*
dtype0*
valueB@*    
�
!policy/main_graph_0/hidden_0/bias
VariableV2*4
_class*
(&loc:@policy/main_graph_0/hidden_0/bias*
	container *
dtype0*
shape:@*
shared_name 
�
(policy/main_graph_0/hidden_0/bias/AssignAssign!policy/main_graph_0/hidden_0/bias3policy/main_graph_0/hidden_0/bias/Initializer/zeros*
T0*4
_class*
(&loc:@policy/main_graph_0/hidden_0/bias*
use_locking(*
validate_shape(
�
&policy/main_graph_0/hidden_0/bias/readIdentity!policy/main_graph_0/hidden_0/bias*
T0*4
_class*
(&loc:@policy/main_graph_0/hidden_0/bias
�
#policy/main_graph_0/hidden_0/MatMulMatMulnormalized_state(policy/main_graph_0/hidden_0/kernel/read*
T0*
transpose_a( *
transpose_b( 
�
$policy/main_graph_0/hidden_0/BiasAddBiasAdd#policy/main_graph_0/hidden_0/MatMul&policy/main_graph_0/hidden_0/bias/read*
T0*
data_formatNHWC
^
$policy/main_graph_0/hidden_0/SigmoidSigmoid$policy/main_graph_0/hidden_0/BiasAdd*
T0
|
 policy/main_graph_0/hidden_0/MulMul$policy/main_graph_0/hidden_0/BiasAdd$policy/main_graph_0/hidden_0/Sigmoid*
T0
�
Fpolicy/main_graph_0/hidden_1/kernel/Initializer/truncated_normal/shapeConst*6
_class,
*(loc:@policy/main_graph_0/hidden_1/kernel*
dtype0*
valueB"@   @   
�
Epolicy/main_graph_0/hidden_1/kernel/Initializer/truncated_normal/meanConst*6
_class,
*(loc:@policy/main_graph_0/hidden_1/kernel*
dtype0*
valueB
 *    
�
Gpolicy/main_graph_0/hidden_1/kernel/Initializer/truncated_normal/stddevConst*6
_class,
*(loc:@policy/main_graph_0/hidden_1/kernel*
dtype0*
valueB
 *6�>
�
Ppolicy/main_graph_0/hidden_1/kernel/Initializer/truncated_normal/TruncatedNormalTruncatedNormalFpolicy/main_graph_0/hidden_1/kernel/Initializer/truncated_normal/shape*
T0*6
_class,
*(loc:@policy/main_graph_0/hidden_1/kernel*
dtype0*
seed�?*
seed2
�
Dpolicy/main_graph_0/hidden_1/kernel/Initializer/truncated_normal/mulMulPpolicy/main_graph_0/hidden_1/kernel/Initializer/truncated_normal/TruncatedNormalGpolicy/main_graph_0/hidden_1/kernel/Initializer/truncated_normal/stddev*
T0*6
_class,
*(loc:@policy/main_graph_0/hidden_1/kernel
�
@policy/main_graph_0/hidden_1/kernel/Initializer/truncated_normalAddDpolicy/main_graph_0/hidden_1/kernel/Initializer/truncated_normal/mulEpolicy/main_graph_0/hidden_1/kernel/Initializer/truncated_normal/mean*
T0*6
_class,
*(loc:@policy/main_graph_0/hidden_1/kernel
�
#policy/main_graph_0/hidden_1/kernel
VariableV2*6
_class,
*(loc:@policy/main_graph_0/hidden_1/kernel*
	container *
dtype0*
shape
:@@*
shared_name 
�
*policy/main_graph_0/hidden_1/kernel/AssignAssign#policy/main_graph_0/hidden_1/kernel@policy/main_graph_0/hidden_1/kernel/Initializer/truncated_normal*
T0*6
_class,
*(loc:@policy/main_graph_0/hidden_1/kernel*
use_locking(*
validate_shape(
�
(policy/main_graph_0/hidden_1/kernel/readIdentity#policy/main_graph_0/hidden_1/kernel*
T0*6
_class,
*(loc:@policy/main_graph_0/hidden_1/kernel
�
3policy/main_graph_0/hidden_1/bias/Initializer/zerosConst*4
_class*
(&loc:@policy/main_graph_0/hidden_1/bias*
dtype0*
valueB@*    
�
!policy/main_graph_0/hidden_1/bias
VariableV2*4
_class*
(&loc:@policy/main_graph_0/hidden_1/bias*
	container *
dtype0*
shape:@*
shared_name 
�
(policy/main_graph_0/hidden_1/bias/AssignAssign!policy/main_graph_0/hidden_1/bias3policy/main_graph_0/hidden_1/bias/Initializer/zeros*
T0*4
_class*
(&loc:@policy/main_graph_0/hidden_1/bias*
use_locking(*
validate_shape(
�
&policy/main_graph_0/hidden_1/bias/readIdentity!policy/main_graph_0/hidden_1/bias*
T0*4
_class*
(&loc:@policy/main_graph_0/hidden_1/bias
�
#policy/main_graph_0/hidden_1/MatMulMatMul policy/main_graph_0/hidden_0/Mul(policy/main_graph_0/hidden_1/kernel/read*
T0*
transpose_a( *
transpose_b( 
�
$policy/main_graph_0/hidden_1/BiasAddBiasAdd#policy/main_graph_0/hidden_1/MatMul&policy/main_graph_0/hidden_1/bias/read*
T0*
data_formatNHWC
^
$policy/main_graph_0/hidden_1/SigmoidSigmoid$policy/main_graph_0/hidden_1/BiasAdd*
T0
|
 policy/main_graph_0/hidden_1/MulMul$policy/main_graph_0/hidden_1/BiasAdd$policy/main_graph_0/hidden_1/Sigmoid*
T0
�
3policy/mu/kernel/Initializer/truncated_normal/shapeConst*#
_class
loc:@policy/mu/kernel*
dtype0*
valueB"@      
�
2policy/mu/kernel/Initializer/truncated_normal/meanConst*#
_class
loc:@policy/mu/kernel*
dtype0*
valueB
 *    
�
4policy/mu/kernel/Initializer/truncated_normal/stddevConst*#
_class
loc:@policy/mu/kernel*
dtype0*
valueB
 *��h<
�
=policy/mu/kernel/Initializer/truncated_normal/TruncatedNormalTruncatedNormal3policy/mu/kernel/Initializer/truncated_normal/shape*
T0*#
_class
loc:@policy/mu/kernel*
dtype0*
seed�?*
seed2
�
1policy/mu/kernel/Initializer/truncated_normal/mulMul=policy/mu/kernel/Initializer/truncated_normal/TruncatedNormal4policy/mu/kernel/Initializer/truncated_normal/stddev*
T0*#
_class
loc:@policy/mu/kernel
�
-policy/mu/kernel/Initializer/truncated_normalAdd1policy/mu/kernel/Initializer/truncated_normal/mul2policy/mu/kernel/Initializer/truncated_normal/mean*
T0*#
_class
loc:@policy/mu/kernel
�
policy/mu/kernel
VariableV2*#
_class
loc:@policy/mu/kernel*
	container *
dtype0*
shape
:@*
shared_name 
�
policy/mu/kernel/AssignAssignpolicy/mu/kernel-policy/mu/kernel/Initializer/truncated_normal*
T0*#
_class
loc:@policy/mu/kernel*
use_locking(*
validate_shape(
a
policy/mu/kernel/readIdentitypolicy/mu/kernel*
T0*#
_class
loc:@policy/mu/kernel
t
 policy/mu/bias/Initializer/zerosConst*!
_class
loc:@policy/mu/bias*
dtype0*
valueB*    
�
policy/mu/bias
VariableV2*!
_class
loc:@policy/mu/bias*
	container *
dtype0*
shape:*
shared_name 
�
policy/mu/bias/AssignAssignpolicy/mu/bias policy/mu/bias/Initializer/zeros*
T0*!
_class
loc:@policy/mu/bias*
use_locking(*
validate_shape(
[
policy/mu/bias/readIdentitypolicy/mu/bias*
T0*!
_class
loc:@policy/mu/bias
�
policy_1/mu/MatMulMatMul policy/main_graph_0/hidden_1/Mulpolicy/mu/kernel/read*
T0*
transpose_a( *
transpose_b( 
g
policy_1/mu/BiasAddBiasAddpolicy_1/mu/MatMulpolicy/mu/bias/read*
T0*
data_formatNHWC
�
8policy/log_std/kernel/Initializer/truncated_normal/shapeConst*(
_class
loc:@policy/log_std/kernel*
dtype0*
valueB"@      
�
7policy/log_std/kernel/Initializer/truncated_normal/meanConst*(
_class
loc:@policy/log_std/kernel*
dtype0*
valueB
 *    
�
9policy/log_std/kernel/Initializer/truncated_normal/stddevConst*(
_class
loc:@policy/log_std/kernel*
dtype0*
valueB
 *��h<
�
Bpolicy/log_std/kernel/Initializer/truncated_normal/TruncatedNormalTruncatedNormal8policy/log_std/kernel/Initializer/truncated_normal/shape*
T0*(
_class
loc:@policy/log_std/kernel*
dtype0*
seed�?*
seed2
�
6policy/log_std/kernel/Initializer/truncated_normal/mulMulBpolicy/log_std/kernel/Initializer/truncated_normal/TruncatedNormal9policy/log_std/kernel/Initializer/truncated_normal/stddev*
T0*(
_class
loc:@policy/log_std/kernel
�
2policy/log_std/kernel/Initializer/truncated_normalAdd6policy/log_std/kernel/Initializer/truncated_normal/mul7policy/log_std/kernel/Initializer/truncated_normal/mean*
T0*(
_class
loc:@policy/log_std/kernel
�
policy/log_std/kernel
VariableV2*(
_class
loc:@policy/log_std/kernel*
	container *
dtype0*
shape
:@*
shared_name 
�
policy/log_std/kernel/AssignAssignpolicy/log_std/kernel2policy/log_std/kernel/Initializer/truncated_normal*
T0*(
_class
loc:@policy/log_std/kernel*
use_locking(*
validate_shape(
p
policy/log_std/kernel/readIdentitypolicy/log_std/kernel*
T0*(
_class
loc:@policy/log_std/kernel
~
%policy/log_std/bias/Initializer/zerosConst*&
_class
loc:@policy/log_std/bias*
dtype0*
valueB*    
�
policy/log_std/bias
VariableV2*&
_class
loc:@policy/log_std/bias*
	container *
dtype0*
shape:*
shared_name 
�
policy/log_std/bias/AssignAssignpolicy/log_std/bias%policy/log_std/bias/Initializer/zeros*
T0*&
_class
loc:@policy/log_std/bias*
use_locking(*
validate_shape(
j
policy/log_std/bias/readIdentitypolicy/log_std/bias*
T0*&
_class
loc:@policy/log_std/bias
�
policy_1/log_std/MatMulMatMul policy/main_graph_0/hidden_1/Mulpolicy/log_std/kernel/read*
T0*
transpose_a( *
transpose_b( 
v
policy_1/log_std/BiasAddBiasAddpolicy_1/log_std/MatMulpolicy/log_std/bias/read*
T0*
data_formatNHWC
M
 policy_1/clip_by_value/Minimum/yConst*
dtype0*
valueB
 *   @
n
policy_1/clip_by_value/MinimumMinimumpolicy_1/log_std/BiasAdd policy_1/clip_by_value/Minimum/y*
T0
E
policy_1/clip_by_value/yConst*
dtype0*
valueB
 *  ��
d
policy_1/clip_by_valueMaximumpolicy_1/clip_by_value/Minimumpolicy_1/clip_by_value/y*
T0
4
policy_1/ExpExppolicy_1/clip_by_value*
T0
E
policy_1/ShapeShapepolicy_1/mu/BiasAdd*
T0*
out_type0
H
policy_1/random_normal/meanConst*
dtype0*
valueB
 *    
J
policy_1/random_normal/stddevConst*
dtype0*
valueB
 *  �?
�
+policy_1/random_normal/RandomStandardNormalRandomStandardNormalpolicy_1/Shape*
T0*
dtype0*
seed�?*
seed2
v
policy_1/random_normal/mulMul+policy_1/random_normal/RandomStandardNormalpolicy_1/random_normal/stddev*
T0
_
policy_1/random_normalAddpolicy_1/random_normal/mulpolicy_1/random_normal/mean*
T0
B
policy_1/mulMulpolicy_1/Exppolicy_1/random_normal*
T0
A
policy_1/addAddV2policy_1/mu/BiasAddpolicy_1/mul*
T0
?
policy_1/subSubpolicy_1/addpolicy_1/mu/BiasAdd*
T0
=
policy_1/add_1/yConst*
dtype0*
valueB
 *�7�5
@
policy_1/add_1AddV2policy_1/Exppolicy_1/add_1/y*
T0
B
policy_1/truedivRealDivpolicy_1/subpolicy_1/add_1*
T0
;
policy_1/pow/yConst*
dtype0*
valueB
 *   @
>
policy_1/powPowpolicy_1/truedivpolicy_1/pow/y*
T0
=
policy_1/mul_1/xConst*
dtype0*
valueB
 *   @
H
policy_1/mul_1Mulpolicy_1/mul_1/xpolicy_1/clip_by_value*
T0
>
policy_1/add_2AddV2policy_1/powpolicy_1/mul_1*
T0
=
policy_1/add_3/yConst*
dtype0*
valueB
 *�?�?
B
policy_1/add_3AddV2policy_1/add_2policy_1/add_3/y*
T0
=
policy_1/mul_2/xConst*
dtype0*
valueB
 *   �
@
policy_1/mul_2Mulpolicy_1/mul_2/xpolicy_1/add_3*
T0
,
policy_1/TanhTanhpolicy_1/add*
T0
=
policy_1/pow_1/yConst*
dtype0*
valueB
 *   @
?
policy_1/pow_1Powpolicy_1/Tanhpolicy_1/pow_1/y*
T0
=
policy_1/sub_1/xConst*
dtype0*
valueB
 *  �?
@
policy_1/sub_1Subpolicy_1/sub_1/xpolicy_1/pow_1*
T0
=
policy_1/add_4/yConst*
dtype0*
valueB
 *�7�5
B
policy_1/add_4AddV2policy_1/sub_1policy_1/add_4/y*
T0
,
policy_1/LogLogpolicy_1/add_4*
T0
<
policy_1/sub_2Subpolicy_1/mul_2policy_1/Log*
T0
H
policy_1/Sum/reduction_indicesConst*
dtype0*
value	B :
i
policy_1/SumSumpolicy_1/sub_2policy_1/Sum/reduction_indices*
T0*

Tidx0*
	keep_dims(
=
policy_1/Log_1/xConst*
dtype0*
valueB
 *���A
0
policy_1/Log_1Logpolicy_1/Log_1/x*
T0
=
policy_1/mul_3/xConst*
dtype0*
valueB
 *   @
H
policy_1/mul_3Mulpolicy_1/mul_3/xpolicy_1/clip_by_value*
T0
@
policy_1/add_5AddV2policy_1/Log_1policy_1/mul_3*
T0
C
policy_1/ConstConst*
dtype0*
valueB"       
[
policy_1/MeanMeanpolicy_1/add_5policy_1/Const*
T0*

Tidx0*
	keep_dims( 
=
policy_1/mul_4/xConst*
dtype0*
valueB
 *   ?
?
policy_1/mul_4Mulpolicy_1/mul_4/xpolicy_1/Mean*
T0
Q
policy_1/strided_slice/stackConst*
dtype0*
valueB"        
S
policy_1/strided_slice/stack_1Const*
dtype0*
valueB"       
S
policy_1/strided_slice/stack_2Const*
dtype0*
valueB"      
�
policy_1/strided_sliceStridedSlicepolicy_1/mu/BiasAddpolicy_1/strided_slice/stackpolicy_1/strided_slice/stack_1policy_1/strided_slice/stack_2*
Index0*
T0*

begin_mask*
ellipsis_mask *
end_mask*
new_axis_mask *
shrink_axis_mask
M
policy_1/Reshape/shapeConst*
dtype0*
valueB:
���������
b
policy_1/ReshapeReshapepolicy_1/strided_slicepolicy_1/Reshape/shape*
T0*
Tshape0
L
policy_1/ones_like/ShapeShapepolicy_1/Reshape*
T0*
out_type0
E
policy_1/ones_like/ConstConst*
dtype0*
valueB
 *  �?
i
policy_1/ones_likeFillpolicy_1/ones_like/Shapepolicy_1/ones_like/Const*
T0*

index_type0
B
policy_1/mul_5Mulpolicy_1/ones_likepolicy_1/mul_4*
T0
*
actionIdentitypolicy_1/Tanh*
T0
-
StopGradientStopGradientaction*
T0
1
action_probsIdentitypolicy_1/sub_2*
T0
�
initNoOp^action_output_shape/Assign^global_step/Assign^is_continuous_control/Assign^memory_size/Assign^normalization_steps/Assign^policy/log_std/bias/Assign^policy/log_std/kernel/Assign)^policy/main_graph_0/hidden_0/bias/Assign+^policy/main_graph_0/hidden_0/kernel/Assign)^policy/main_graph_0/hidden_1/bias/Assign+^policy/main_graph_0/hidden_1/kernel/Assign^policy/mu/bias/Assign^policy/mu/kernel/Assign^running_mean/Assign^running_variance/Assign^trainer_major_version/Assign^trainer_minor_version/Assign^trainer_patch_version/Assign^version_number/Assign
4
PlaceholderPlaceholder*
dtype0*
shape: 
~
Assign_6Assignglobal_stepPlaceholder*
T0*
_class
loc:@global_step*
use_locking(*
validate_shape(
6
Placeholder_1Placeholder*
dtype0*
shape: 
�
Assign_7Assignnormalization_stepsPlaceholder_1*
T0*&
_class
loc:@normalization_steps*
use_locking(*
validate_shape(
:
Placeholder_2Placeholder*
dtype0*
shape:
�
Assign_8Assignrunning_meanPlaceholder_2*
T0*
_class
loc:@running_mean*
use_locking(*
validate_shape(
:
Placeholder_3Placeholder*
dtype0*
shape:
�
Assign_9Assignrunning_variancePlaceholder_3*
T0*#
_class
loc:@running_variance*
use_locking(*
validate_shape(
6
Placeholder_4Placeholder*
dtype0*
shape: 
�
	Assign_10Assignis_continuous_controlPlaceholder_4*
T0*(
_class
loc:@is_continuous_control*
use_locking(*
validate_shape(
6
Placeholder_5Placeholder*
dtype0*
shape: 
�
	Assign_11Assigntrainer_major_versionPlaceholder_5*
T0*(
_class
loc:@trainer_major_version*
use_locking(*
validate_shape(
6
Placeholder_6Placeholder*
dtype0*
shape: 
�
	Assign_12Assigntrainer_minor_versionPlaceholder_6*
T0*(
_class
loc:@trainer_minor_version*
use_locking(*
validate_shape(
6
Placeholder_7Placeholder*
dtype0*
shape: 
�
	Assign_13Assigntrainer_patch_versionPlaceholder_7*
T0*(
_class
loc:@trainer_patch_version*
use_locking(*
validate_shape(
6
Placeholder_8Placeholder*
dtype0*
shape: 
�
	Assign_14Assignversion_numberPlaceholder_8*
T0*!
_class
loc:@version_number*
use_locking(*
validate_shape(
6
Placeholder_9Placeholder*
dtype0*
shape: 
�
	Assign_15Assignmemory_sizePlaceholder_9*
T0*
_class
loc:@memory_size*
use_locking(*
validate_shape(
7
Placeholder_10Placeholder*
dtype0*
shape: 
�
	Assign_16Assignaction_output_shapePlaceholder_10*
T0*&
_class
loc:@action_output_shape*
use_locking(*
validate_shape(
?
Placeholder_11Placeholder*
dtype0*
shape
:@
�
	Assign_17Assign#policy/main_graph_0/hidden_0/kernelPlaceholder_11*
T0*6
_class,
*(loc:@policy/main_graph_0/hidden_0/kernel*
use_locking(*
validate_shape(
;
Placeholder_12Placeholder*
dtype0*
shape:@
�
	Assign_18Assign!policy/main_graph_0/hidden_0/biasPlaceholder_12*
T0*4
_class*
(&loc:@policy/main_graph_0/hidden_0/bias*
use_locking(*
validate_shape(
?
Placeholder_13Placeholder*
dtype0*
shape
:@@
�
	Assign_19Assign#policy/main_graph_0/hidden_1/kernelPlaceholder_13*
T0*6
_class,
*(loc:@policy/main_graph_0/hidden_1/kernel*
use_locking(*
validate_shape(
;
Placeholder_14Placeholder*
dtype0*
shape:@
�
	Assign_20Assign!policy/main_graph_0/hidden_1/biasPlaceholder_14*
T0*4
_class*
(&loc:@policy/main_graph_0/hidden_1/bias*
use_locking(*
validate_shape(
?
Placeholder_15Placeholder*
dtype0*
shape
:@
�
	Assign_21Assignpolicy/mu/kernelPlaceholder_15*
T0*#
_class
loc:@policy/mu/kernel*
use_locking(*
validate_shape(
;
Placeholder_16Placeholder*
dtype0*
shape:
�
	Assign_22Assignpolicy/mu/biasPlaceholder_16*
T0*!
_class
loc:@policy/mu/bias*
use_locking(*
validate_shape(
?
Placeholder_17Placeholder*
dtype0*
shape
:@
�
	Assign_23Assignpolicy/log_std/kernelPlaceholder_17*
T0*(
_class
loc:@policy/log_std/kernel*
use_locking(*
validate_shape(
;
Placeholder_18Placeholder*
dtype0*
shape:
�
	Assign_24Assignpolicy/log_std/biasPlaceholder_18*
T0*&
_class
loc:@policy/log_std/bias*
use_locking(*
validate_shape(
C
Variable/initial_valueConst*
dtype0*
valueB
 *  �?
T
Variable
VariableV2*
	container *
dtype0*
shape: *
shared_name 
�
Variable/AssignAssignVariableVariable/initial_value*
T0*
_class
loc:@Variable*
use_locking(*
validate_shape(
I
Variable/readIdentityVariable*
T0*
_class
loc:@Variable
<
Assign_25/valueConst*
dtype0*
valueB
 *    
}
	Assign_25AssignVariableAssign_25/value*
T0*
_class
loc:@Variable*
use_locking( *
validate_shape(
>
sac_sequence_lengthPlaceholder*
dtype0*
shape:
�
Gcritic/value/encoder/hidden_0/kernel/Initializer/truncated_normal/shapeConst*7
_class-
+)loc:@critic/value/encoder/hidden_0/kernel*
dtype0*
valueB"   @   
�
Fcritic/value/encoder/hidden_0/kernel/Initializer/truncated_normal/meanConst*7
_class-
+)loc:@critic/value/encoder/hidden_0/kernel*
dtype0*
valueB
 *    
�
Hcritic/value/encoder/hidden_0/kernel/Initializer/truncated_normal/stddevConst*7
_class-
+)loc:@critic/value/encoder/hidden_0/kernel*
dtype0*
valueB
 *��M?
�
Qcritic/value/encoder/hidden_0/kernel/Initializer/truncated_normal/TruncatedNormalTruncatedNormalGcritic/value/encoder/hidden_0/kernel/Initializer/truncated_normal/shape*
T0*7
_class-
+)loc:@critic/value/encoder/hidden_0/kernel*
dtype0*
seed�?*
seed2
�
Ecritic/value/encoder/hidden_0/kernel/Initializer/truncated_normal/mulMulQcritic/value/encoder/hidden_0/kernel/Initializer/truncated_normal/TruncatedNormalHcritic/value/encoder/hidden_0/kernel/Initializer/truncated_normal/stddev*
T0*7
_class-
+)loc:@critic/value/encoder/hidden_0/kernel
�
Acritic/value/encoder/hidden_0/kernel/Initializer/truncated_normalAddEcritic/value/encoder/hidden_0/kernel/Initializer/truncated_normal/mulFcritic/value/encoder/hidden_0/kernel/Initializer/truncated_normal/mean*
T0*7
_class-
+)loc:@critic/value/encoder/hidden_0/kernel
�
$critic/value/encoder/hidden_0/kernel
VariableV2*7
_class-
+)loc:@critic/value/encoder/hidden_0/kernel*
	container *
dtype0*
shape
:@*
shared_name 
�
+critic/value/encoder/hidden_0/kernel/AssignAssign$critic/value/encoder/hidden_0/kernelAcritic/value/encoder/hidden_0/kernel/Initializer/truncated_normal*
T0*7
_class-
+)loc:@critic/value/encoder/hidden_0/kernel*
use_locking(*
validate_shape(
�
)critic/value/encoder/hidden_0/kernel/readIdentity$critic/value/encoder/hidden_0/kernel*
T0*7
_class-
+)loc:@critic/value/encoder/hidden_0/kernel
�
4critic/value/encoder/hidden_0/bias/Initializer/zerosConst*5
_class+
)'loc:@critic/value/encoder/hidden_0/bias*
dtype0*
valueB@*    
�
"critic/value/encoder/hidden_0/bias
VariableV2*5
_class+
)'loc:@critic/value/encoder/hidden_0/bias*
	container *
dtype0*
shape:@*
shared_name 
�
)critic/value/encoder/hidden_0/bias/AssignAssign"critic/value/encoder/hidden_0/bias4critic/value/encoder/hidden_0/bias/Initializer/zeros*
T0*5
_class+
)'loc:@critic/value/encoder/hidden_0/bias*
use_locking(*
validate_shape(
�
'critic/value/encoder/hidden_0/bias/readIdentity"critic/value/encoder/hidden_0/bias*
T0*5
_class+
)'loc:@critic/value/encoder/hidden_0/bias
�
$critic/value/encoder/hidden_0/MatMulMatMulnormalized_state)critic/value/encoder/hidden_0/kernel/read*
T0*
transpose_a( *
transpose_b( 
�
%critic/value/encoder/hidden_0/BiasAddBiasAdd$critic/value/encoder/hidden_0/MatMul'critic/value/encoder/hidden_0/bias/read*
T0*
data_formatNHWC
`
%critic/value/encoder/hidden_0/SigmoidSigmoid%critic/value/encoder/hidden_0/BiasAdd*
T0

!critic/value/encoder/hidden_0/MulMul%critic/value/encoder/hidden_0/BiasAdd%critic/value/encoder/hidden_0/Sigmoid*
T0
�
Gcritic/value/encoder/hidden_1/kernel/Initializer/truncated_normal/shapeConst*7
_class-
+)loc:@critic/value/encoder/hidden_1/kernel*
dtype0*
valueB"@   @   
�
Fcritic/value/encoder/hidden_1/kernel/Initializer/truncated_normal/meanConst*7
_class-
+)loc:@critic/value/encoder/hidden_1/kernel*
dtype0*
valueB
 *    
�
Hcritic/value/encoder/hidden_1/kernel/Initializer/truncated_normal/stddevConst*7
_class-
+)loc:@critic/value/encoder/hidden_1/kernel*
dtype0*
valueB
 *6�>
�
Qcritic/value/encoder/hidden_1/kernel/Initializer/truncated_normal/TruncatedNormalTruncatedNormalGcritic/value/encoder/hidden_1/kernel/Initializer/truncated_normal/shape*
T0*7
_class-
+)loc:@critic/value/encoder/hidden_1/kernel*
dtype0*
seed�?*
seed2
�
Ecritic/value/encoder/hidden_1/kernel/Initializer/truncated_normal/mulMulQcritic/value/encoder/hidden_1/kernel/Initializer/truncated_normal/TruncatedNormalHcritic/value/encoder/hidden_1/kernel/Initializer/truncated_normal/stddev*
T0*7
_class-
+)loc:@critic/value/encoder/hidden_1/kernel
�
Acritic/value/encoder/hidden_1/kernel/Initializer/truncated_normalAddEcritic/value/encoder/hidden_1/kernel/Initializer/truncated_normal/mulFcritic/value/encoder/hidden_1/kernel/Initializer/truncated_normal/mean*
T0*7
_class-
+)loc:@critic/value/encoder/hidden_1/kernel
�
$critic/value/encoder/hidden_1/kernel
VariableV2*7
_class-
+)loc:@critic/value/encoder/hidden_1/kernel*
	container *
dtype0*
shape
:@@*
shared_name 
�
+critic/value/encoder/hidden_1/kernel/AssignAssign$critic/value/encoder/hidden_1/kernelAcritic/value/encoder/hidden_1/kernel/Initializer/truncated_normal*
T0*7
_class-
+)loc:@critic/value/encoder/hidden_1/kernel*
use_locking(*
validate_shape(
�
)critic/value/encoder/hidden_1/kernel/readIdentity$critic/value/encoder/hidden_1/kernel*
T0*7
_class-
+)loc:@critic/value/encoder/hidden_1/kernel
�
4critic/value/encoder/hidden_1/bias/Initializer/zerosConst*5
_class+
)'loc:@critic/value/encoder/hidden_1/bias*
dtype0*
valueB@*    
�
"critic/value/encoder/hidden_1/bias
VariableV2*5
_class+
)'loc:@critic/value/encoder/hidden_1/bias*
	container *
dtype0*
shape:@*
shared_name 
�
)critic/value/encoder/hidden_1/bias/AssignAssign"critic/value/encoder/hidden_1/bias4critic/value/encoder/hidden_1/bias/Initializer/zeros*
T0*5
_class+
)'loc:@critic/value/encoder/hidden_1/bias*
use_locking(*
validate_shape(
�
'critic/value/encoder/hidden_1/bias/readIdentity"critic/value/encoder/hidden_1/bias*
T0*5
_class+
)'loc:@critic/value/encoder/hidden_1/bias
�
$critic/value/encoder/hidden_1/MatMulMatMul!critic/value/encoder/hidden_0/Mul)critic/value/encoder/hidden_1/kernel/read*
T0*
transpose_a( *
transpose_b( 
�
%critic/value/encoder/hidden_1/BiasAddBiasAdd$critic/value/encoder/hidden_1/MatMul'critic/value/encoder/hidden_1/bias/read*
T0*
data_formatNHWC
`
%critic/value/encoder/hidden_1/SigmoidSigmoid%critic/value/encoder/hidden_1/BiasAdd*
T0

!critic/value/encoder/hidden_1/MulMul%critic/value/encoder/hidden_1/BiasAdd%critic/value/encoder/hidden_1/Sigmoid*
T0
�
Dcritic/value/extrinsic_value/kernel/Initializer/random_uniform/shapeConst*6
_class,
*(loc:@critic/value/extrinsic_value/kernel*
dtype0*
valueB"@      
�
Bcritic/value/extrinsic_value/kernel/Initializer/random_uniform/minConst*6
_class,
*(loc:@critic/value/extrinsic_value/kernel*
dtype0*
valueB
 *����
�
Bcritic/value/extrinsic_value/kernel/Initializer/random_uniform/maxConst*6
_class,
*(loc:@critic/value/extrinsic_value/kernel*
dtype0*
valueB
 *���>
�
Lcritic/value/extrinsic_value/kernel/Initializer/random_uniform/RandomUniformRandomUniformDcritic/value/extrinsic_value/kernel/Initializer/random_uniform/shape*
T0*6
_class,
*(loc:@critic/value/extrinsic_value/kernel*
dtype0*
seed�?*
seed2
�
Bcritic/value/extrinsic_value/kernel/Initializer/random_uniform/subSubBcritic/value/extrinsic_value/kernel/Initializer/random_uniform/maxBcritic/value/extrinsic_value/kernel/Initializer/random_uniform/min*
T0*6
_class,
*(loc:@critic/value/extrinsic_value/kernel
�
Bcritic/value/extrinsic_value/kernel/Initializer/random_uniform/mulMulLcritic/value/extrinsic_value/kernel/Initializer/random_uniform/RandomUniformBcritic/value/extrinsic_value/kernel/Initializer/random_uniform/sub*
T0*6
_class,
*(loc:@critic/value/extrinsic_value/kernel
�
>critic/value/extrinsic_value/kernel/Initializer/random_uniformAddBcritic/value/extrinsic_value/kernel/Initializer/random_uniform/mulBcritic/value/extrinsic_value/kernel/Initializer/random_uniform/min*
T0*6
_class,
*(loc:@critic/value/extrinsic_value/kernel
�
#critic/value/extrinsic_value/kernel
VariableV2*6
_class,
*(loc:@critic/value/extrinsic_value/kernel*
	container *
dtype0*
shape
:@*
shared_name 
�
*critic/value/extrinsic_value/kernel/AssignAssign#critic/value/extrinsic_value/kernel>critic/value/extrinsic_value/kernel/Initializer/random_uniform*
T0*6
_class,
*(loc:@critic/value/extrinsic_value/kernel*
use_locking(*
validate_shape(
�
(critic/value/extrinsic_value/kernel/readIdentity#critic/value/extrinsic_value/kernel*
T0*6
_class,
*(loc:@critic/value/extrinsic_value/kernel
�
3critic/value/extrinsic_value/bias/Initializer/zerosConst*4
_class*
(&loc:@critic/value/extrinsic_value/bias*
dtype0*
valueB*    
�
!critic/value/extrinsic_value/bias
VariableV2*4
_class*
(&loc:@critic/value/extrinsic_value/bias*
	container *
dtype0*
shape:*
shared_name 
�
(critic/value/extrinsic_value/bias/AssignAssign!critic/value/extrinsic_value/bias3critic/value/extrinsic_value/bias/Initializer/zeros*
T0*4
_class*
(&loc:@critic/value/extrinsic_value/bias*
use_locking(*
validate_shape(
�
&critic/value/extrinsic_value/bias/readIdentity!critic/value/extrinsic_value/bias*
T0*4
_class*
(&loc:@critic/value/extrinsic_value/bias
�
#critic/value/extrinsic_value/MatMulMatMul!critic/value/encoder/hidden_1/Mul(critic/value/extrinsic_value/kernel/read*
T0*
transpose_a( *
transpose_b( 
�
$critic/value/extrinsic_value/BiasAddBiasAdd#critic/value/extrinsic_value/MatMul&critic/value/extrinsic_value/bias/read*
T0*
data_formatNHWC
c
critic/value/Mean/inputPack$critic/value/extrinsic_value/BiasAdd*
N*
T0*

axis 
M
#critic/value/Mean/reduction_indicesConst*
dtype0*
value	B : 
}
critic/value/MeanMeancritic/value/Mean/input#critic/value/Mean/reduction_indices*
T0*

Tidx0*
	keep_dims( 
L
external_action_inPlaceholder*
dtype0*
shape:���������
>
concat/axisConst*
dtype0*
valueB :
���������
c
concatConcatV2normalized_stateexternal_action_inconcat/axis*
N*
T0*

Tidx0
@
concat_1/axisConst*
dtype0*
valueB :
���������
[
concat_1ConcatV2normalized_stateactionconcat_1/axis*
N*
T0*

Tidx0
�
Rcritic/q/q1_encoding/q1_encoder/hidden_0/kernel/Initializer/truncated_normal/shapeConst*B
_class8
64loc:@critic/q/q1_encoding/q1_encoder/hidden_0/kernel*
dtype0*
valueB"   @   
�
Qcritic/q/q1_encoding/q1_encoder/hidden_0/kernel/Initializer/truncated_normal/meanConst*B
_class8
64loc:@critic/q/q1_encoding/q1_encoder/hidden_0/kernel*
dtype0*
valueB
 *    
�
Scritic/q/q1_encoding/q1_encoder/hidden_0/kernel/Initializer/truncated_normal/stddevConst*B
_class8
64loc:@critic/q/q1_encoding/q1_encoder/hidden_0/kernel*
dtype0*
valueB
 *d'?
�
\critic/q/q1_encoding/q1_encoder/hidden_0/kernel/Initializer/truncated_normal/TruncatedNormalTruncatedNormalRcritic/q/q1_encoding/q1_encoder/hidden_0/kernel/Initializer/truncated_normal/shape*
T0*B
_class8
64loc:@critic/q/q1_encoding/q1_encoder/hidden_0/kernel*
dtype0*
seed�?*
seed2
�
Pcritic/q/q1_encoding/q1_encoder/hidden_0/kernel/Initializer/truncated_normal/mulMul\critic/q/q1_encoding/q1_encoder/hidden_0/kernel/Initializer/truncated_normal/TruncatedNormalScritic/q/q1_encoding/q1_encoder/hidden_0/kernel/Initializer/truncated_normal/stddev*
T0*B
_class8
64loc:@critic/q/q1_encoding/q1_encoder/hidden_0/kernel
�
Lcritic/q/q1_encoding/q1_encoder/hidden_0/kernel/Initializer/truncated_normalAddPcritic/q/q1_encoding/q1_encoder/hidden_0/kernel/Initializer/truncated_normal/mulQcritic/q/q1_encoding/q1_encoder/hidden_0/kernel/Initializer/truncated_normal/mean*
T0*B
_class8
64loc:@critic/q/q1_encoding/q1_encoder/hidden_0/kernel
�
/critic/q/q1_encoding/q1_encoder/hidden_0/kernel
VariableV2*B
_class8
64loc:@critic/q/q1_encoding/q1_encoder/hidden_0/kernel*
	container *
dtype0*
shape
:@*
shared_name 
�
6critic/q/q1_encoding/q1_encoder/hidden_0/kernel/AssignAssign/critic/q/q1_encoding/q1_encoder/hidden_0/kernelLcritic/q/q1_encoding/q1_encoder/hidden_0/kernel/Initializer/truncated_normal*
T0*B
_class8
64loc:@critic/q/q1_encoding/q1_encoder/hidden_0/kernel*
use_locking(*
validate_shape(
�
4critic/q/q1_encoding/q1_encoder/hidden_0/kernel/readIdentity/critic/q/q1_encoding/q1_encoder/hidden_0/kernel*
T0*B
_class8
64loc:@critic/q/q1_encoding/q1_encoder/hidden_0/kernel
�
?critic/q/q1_encoding/q1_encoder/hidden_0/bias/Initializer/zerosConst*@
_class6
42loc:@critic/q/q1_encoding/q1_encoder/hidden_0/bias*
dtype0*
valueB@*    
�
-critic/q/q1_encoding/q1_encoder/hidden_0/bias
VariableV2*@
_class6
42loc:@critic/q/q1_encoding/q1_encoder/hidden_0/bias*
	container *
dtype0*
shape:@*
shared_name 
�
4critic/q/q1_encoding/q1_encoder/hidden_0/bias/AssignAssign-critic/q/q1_encoding/q1_encoder/hidden_0/bias?critic/q/q1_encoding/q1_encoder/hidden_0/bias/Initializer/zeros*
T0*@
_class6
42loc:@critic/q/q1_encoding/q1_encoder/hidden_0/bias*
use_locking(*
validate_shape(
�
2critic/q/q1_encoding/q1_encoder/hidden_0/bias/readIdentity-critic/q/q1_encoding/q1_encoder/hidden_0/bias*
T0*@
_class6
42loc:@critic/q/q1_encoding/q1_encoder/hidden_0/bias
�
/critic/q/q1_encoding/q1_encoder/hidden_0/MatMulMatMulconcat4critic/q/q1_encoding/q1_encoder/hidden_0/kernel/read*
T0*
transpose_a( *
transpose_b( 
�
0critic/q/q1_encoding/q1_encoder/hidden_0/BiasAddBiasAdd/critic/q/q1_encoding/q1_encoder/hidden_0/MatMul2critic/q/q1_encoding/q1_encoder/hidden_0/bias/read*
T0*
data_formatNHWC
v
0critic/q/q1_encoding/q1_encoder/hidden_0/SigmoidSigmoid0critic/q/q1_encoding/q1_encoder/hidden_0/BiasAdd*
T0
�
,critic/q/q1_encoding/q1_encoder/hidden_0/MulMul0critic/q/q1_encoding/q1_encoder/hidden_0/BiasAdd0critic/q/q1_encoding/q1_encoder/hidden_0/Sigmoid*
T0
�
Rcritic/q/q1_encoding/q1_encoder/hidden_1/kernel/Initializer/truncated_normal/shapeConst*B
_class8
64loc:@critic/q/q1_encoding/q1_encoder/hidden_1/kernel*
dtype0*
valueB"@   @   
�
Qcritic/q/q1_encoding/q1_encoder/hidden_1/kernel/Initializer/truncated_normal/meanConst*B
_class8
64loc:@critic/q/q1_encoding/q1_encoder/hidden_1/kernel*
dtype0*
valueB
 *    
�
Scritic/q/q1_encoding/q1_encoder/hidden_1/kernel/Initializer/truncated_normal/stddevConst*B
_class8
64loc:@critic/q/q1_encoding/q1_encoder/hidden_1/kernel*
dtype0*
valueB
 *6�>
�
\critic/q/q1_encoding/q1_encoder/hidden_1/kernel/Initializer/truncated_normal/TruncatedNormalTruncatedNormalRcritic/q/q1_encoding/q1_encoder/hidden_1/kernel/Initializer/truncated_normal/shape*
T0*B
_class8
64loc:@critic/q/q1_encoding/q1_encoder/hidden_1/kernel*
dtype0*
seed�?*
seed2	
�
Pcritic/q/q1_encoding/q1_encoder/hidden_1/kernel/Initializer/truncated_normal/mulMul\critic/q/q1_encoding/q1_encoder/hidden_1/kernel/Initializer/truncated_normal/TruncatedNormalScritic/q/q1_encoding/q1_encoder/hidden_1/kernel/Initializer/truncated_normal/stddev*
T0*B
_class8
64loc:@critic/q/q1_encoding/q1_encoder/hidden_1/kernel
�
Lcritic/q/q1_encoding/q1_encoder/hidden_1/kernel/Initializer/truncated_normalAddPcritic/q/q1_encoding/q1_encoder/hidden_1/kernel/Initializer/truncated_normal/mulQcritic/q/q1_encoding/q1_encoder/hidden_1/kernel/Initializer/truncated_normal/mean*
T0*B
_class8
64loc:@critic/q/q1_encoding/q1_encoder/hidden_1/kernel
�
/critic/q/q1_encoding/q1_encoder/hidden_1/kernel
VariableV2*B
_class8
64loc:@critic/q/q1_encoding/q1_encoder/hidden_1/kernel*
	container *
dtype0*
shape
:@@*
shared_name 
�
6critic/q/q1_encoding/q1_encoder/hidden_1/kernel/AssignAssign/critic/q/q1_encoding/q1_encoder/hidden_1/kernelLcritic/q/q1_encoding/q1_encoder/hidden_1/kernel/Initializer/truncated_normal*
T0*B
_class8
64loc:@critic/q/q1_encoding/q1_encoder/hidden_1/kernel*
use_locking(*
validate_shape(
�
4critic/q/q1_encoding/q1_encoder/hidden_1/kernel/readIdentity/critic/q/q1_encoding/q1_encoder/hidden_1/kernel*
T0*B
_class8
64loc:@critic/q/q1_encoding/q1_encoder/hidden_1/kernel
�
?critic/q/q1_encoding/q1_encoder/hidden_1/bias/Initializer/zerosConst*@
_class6
42loc:@critic/q/q1_encoding/q1_encoder/hidden_1/bias*
dtype0*
valueB@*    
�
-critic/q/q1_encoding/q1_encoder/hidden_1/bias
VariableV2*@
_class6
42loc:@critic/q/q1_encoding/q1_encoder/hidden_1/bias*
	container *
dtype0*
shape:@*
shared_name 
�
4critic/q/q1_encoding/q1_encoder/hidden_1/bias/AssignAssign-critic/q/q1_encoding/q1_encoder/hidden_1/bias?critic/q/q1_encoding/q1_encoder/hidden_1/bias/Initializer/zeros*
T0*@
_class6
42loc:@critic/q/q1_encoding/q1_encoder/hidden_1/bias*
use_locking(*
validate_shape(
�
2critic/q/q1_encoding/q1_encoder/hidden_1/bias/readIdentity-critic/q/q1_encoding/q1_encoder/hidden_1/bias*
T0*@
_class6
42loc:@critic/q/q1_encoding/q1_encoder/hidden_1/bias
�
/critic/q/q1_encoding/q1_encoder/hidden_1/MatMulMatMul,critic/q/q1_encoding/q1_encoder/hidden_0/Mul4critic/q/q1_encoding/q1_encoder/hidden_1/kernel/read*
T0*
transpose_a( *
transpose_b( 
�
0critic/q/q1_encoding/q1_encoder/hidden_1/BiasAddBiasAdd/critic/q/q1_encoding/q1_encoder/hidden_1/MatMul2critic/q/q1_encoding/q1_encoder/hidden_1/bias/read*
T0*
data_formatNHWC
v
0critic/q/q1_encoding/q1_encoder/hidden_1/SigmoidSigmoid0critic/q/q1_encoding/q1_encoder/hidden_1/BiasAdd*
T0
�
,critic/q/q1_encoding/q1_encoder/hidden_1/MulMul0critic/q/q1_encoding/q1_encoder/hidden_1/BiasAdd0critic/q/q1_encoding/q1_encoder/hidden_1/Sigmoid*
T0
�
Icritic/q/q1_encoding/extrinsic_q1/kernel/Initializer/random_uniform/shapeConst*;
_class1
/-loc:@critic/q/q1_encoding/extrinsic_q1/kernel*
dtype0*
valueB"@      
�
Gcritic/q/q1_encoding/extrinsic_q1/kernel/Initializer/random_uniform/minConst*;
_class1
/-loc:@critic/q/q1_encoding/extrinsic_q1/kernel*
dtype0*
valueB
 *����
�
Gcritic/q/q1_encoding/extrinsic_q1/kernel/Initializer/random_uniform/maxConst*;
_class1
/-loc:@critic/q/q1_encoding/extrinsic_q1/kernel*
dtype0*
valueB
 *���>
�
Qcritic/q/q1_encoding/extrinsic_q1/kernel/Initializer/random_uniform/RandomUniformRandomUniformIcritic/q/q1_encoding/extrinsic_q1/kernel/Initializer/random_uniform/shape*
T0*;
_class1
/-loc:@critic/q/q1_encoding/extrinsic_q1/kernel*
dtype0*
seed�?*
seed2

�
Gcritic/q/q1_encoding/extrinsic_q1/kernel/Initializer/random_uniform/subSubGcritic/q/q1_encoding/extrinsic_q1/kernel/Initializer/random_uniform/maxGcritic/q/q1_encoding/extrinsic_q1/kernel/Initializer/random_uniform/min*
T0*;
_class1
/-loc:@critic/q/q1_encoding/extrinsic_q1/kernel
�
Gcritic/q/q1_encoding/extrinsic_q1/kernel/Initializer/random_uniform/mulMulQcritic/q/q1_encoding/extrinsic_q1/kernel/Initializer/random_uniform/RandomUniformGcritic/q/q1_encoding/extrinsic_q1/kernel/Initializer/random_uniform/sub*
T0*;
_class1
/-loc:@critic/q/q1_encoding/extrinsic_q1/kernel
�
Ccritic/q/q1_encoding/extrinsic_q1/kernel/Initializer/random_uniformAddGcritic/q/q1_encoding/extrinsic_q1/kernel/Initializer/random_uniform/mulGcritic/q/q1_encoding/extrinsic_q1/kernel/Initializer/random_uniform/min*
T0*;
_class1
/-loc:@critic/q/q1_encoding/extrinsic_q1/kernel
�
(critic/q/q1_encoding/extrinsic_q1/kernel
VariableV2*;
_class1
/-loc:@critic/q/q1_encoding/extrinsic_q1/kernel*
	container *
dtype0*
shape
:@*
shared_name 
�
/critic/q/q1_encoding/extrinsic_q1/kernel/AssignAssign(critic/q/q1_encoding/extrinsic_q1/kernelCcritic/q/q1_encoding/extrinsic_q1/kernel/Initializer/random_uniform*
T0*;
_class1
/-loc:@critic/q/q1_encoding/extrinsic_q1/kernel*
use_locking(*
validate_shape(
�
-critic/q/q1_encoding/extrinsic_q1/kernel/readIdentity(critic/q/q1_encoding/extrinsic_q1/kernel*
T0*;
_class1
/-loc:@critic/q/q1_encoding/extrinsic_q1/kernel
�
8critic/q/q1_encoding/extrinsic_q1/bias/Initializer/zerosConst*9
_class/
-+loc:@critic/q/q1_encoding/extrinsic_q1/bias*
dtype0*
valueB*    
�
&critic/q/q1_encoding/extrinsic_q1/bias
VariableV2*9
_class/
-+loc:@critic/q/q1_encoding/extrinsic_q1/bias*
	container *
dtype0*
shape:*
shared_name 
�
-critic/q/q1_encoding/extrinsic_q1/bias/AssignAssign&critic/q/q1_encoding/extrinsic_q1/bias8critic/q/q1_encoding/extrinsic_q1/bias/Initializer/zeros*
T0*9
_class/
-+loc:@critic/q/q1_encoding/extrinsic_q1/bias*
use_locking(*
validate_shape(
�
+critic/q/q1_encoding/extrinsic_q1/bias/readIdentity&critic/q/q1_encoding/extrinsic_q1/bias*
T0*9
_class/
-+loc:@critic/q/q1_encoding/extrinsic_q1/bias
�
(critic/q/q1_encoding/extrinsic_q1/MatMulMatMul,critic/q/q1_encoding/q1_encoder/hidden_1/Mul-critic/q/q1_encoding/extrinsic_q1/kernel/read*
T0*
transpose_a( *
transpose_b( 
�
)critic/q/q1_encoding/extrinsic_q1/BiasAddBiasAdd(critic/q/q1_encoding/extrinsic_q1/MatMul+critic/q/q1_encoding/extrinsic_q1/bias/read*
T0*
data_formatNHWC
p
critic/q/q1_encoding/Mean/inputPack)critic/q/q1_encoding/extrinsic_q1/BiasAdd*
N*
T0*

axis 
U
+critic/q/q1_encoding/Mean/reduction_indicesConst*
dtype0*
value	B : 
�
critic/q/q1_encoding/MeanMeancritic/q/q1_encoding/Mean/input+critic/q/q1_encoding/Mean/reduction_indices*
T0*

Tidx0*
	keep_dims( 
�
Rcritic/q/q2_encoding/q2_encoder/hidden_0/kernel/Initializer/truncated_normal/shapeConst*B
_class8
64loc:@critic/q/q2_encoding/q2_encoder/hidden_0/kernel*
dtype0*
valueB"   @   
�
Qcritic/q/q2_encoding/q2_encoder/hidden_0/kernel/Initializer/truncated_normal/meanConst*B
_class8
64loc:@critic/q/q2_encoding/q2_encoder/hidden_0/kernel*
dtype0*
valueB
 *    
�
Scritic/q/q2_encoding/q2_encoder/hidden_0/kernel/Initializer/truncated_normal/stddevConst*B
_class8
64loc:@critic/q/q2_encoding/q2_encoder/hidden_0/kernel*
dtype0*
valueB
 *d'?
�
\critic/q/q2_encoding/q2_encoder/hidden_0/kernel/Initializer/truncated_normal/TruncatedNormalTruncatedNormalRcritic/q/q2_encoding/q2_encoder/hidden_0/kernel/Initializer/truncated_normal/shape*
T0*B
_class8
64loc:@critic/q/q2_encoding/q2_encoder/hidden_0/kernel*
dtype0*
seed�?*
seed2
�
Pcritic/q/q2_encoding/q2_encoder/hidden_0/kernel/Initializer/truncated_normal/mulMul\critic/q/q2_encoding/q2_encoder/hidden_0/kernel/Initializer/truncated_normal/TruncatedNormalScritic/q/q2_encoding/q2_encoder/hidden_0/kernel/Initializer/truncated_normal/stddev*
T0*B
_class8
64loc:@critic/q/q2_encoding/q2_encoder/hidden_0/kernel
�
Lcritic/q/q2_encoding/q2_encoder/hidden_0/kernel/Initializer/truncated_normalAddPcritic/q/q2_encoding/q2_encoder/hidden_0/kernel/Initializer/truncated_normal/mulQcritic/q/q2_encoding/q2_encoder/hidden_0/kernel/Initializer/truncated_normal/mean*
T0*B
_class8
64loc:@critic/q/q2_encoding/q2_encoder/hidden_0/kernel
�
/critic/q/q2_encoding/q2_encoder/hidden_0/kernel
VariableV2*B
_class8
64loc:@critic/q/q2_encoding/q2_encoder/hidden_0/kernel*
	container *
dtype0*
shape
:@*
shared_name 
�
6critic/q/q2_encoding/q2_encoder/hidden_0/kernel/AssignAssign/critic/q/q2_encoding/q2_encoder/hidden_0/kernelLcritic/q/q2_encoding/q2_encoder/hidden_0/kernel/Initializer/truncated_normal*
T0*B
_class8
64loc:@critic/q/q2_encoding/q2_encoder/hidden_0/kernel*
use_locking(*
validate_shape(
�
4critic/q/q2_encoding/q2_encoder/hidden_0/kernel/readIdentity/critic/q/q2_encoding/q2_encoder/hidden_0/kernel*
T0*B
_class8
64loc:@critic/q/q2_encoding/q2_encoder/hidden_0/kernel
�
?critic/q/q2_encoding/q2_encoder/hidden_0/bias/Initializer/zerosConst*@
_class6
42loc:@critic/q/q2_encoding/q2_encoder/hidden_0/bias*
dtype0*
valueB@*    
�
-critic/q/q2_encoding/q2_encoder/hidden_0/bias
VariableV2*@
_class6
42loc:@critic/q/q2_encoding/q2_encoder/hidden_0/bias*
	container *
dtype0*
shape:@*
shared_name 
�
4critic/q/q2_encoding/q2_encoder/hidden_0/bias/AssignAssign-critic/q/q2_encoding/q2_encoder/hidden_0/bias?critic/q/q2_encoding/q2_encoder/hidden_0/bias/Initializer/zeros*
T0*@
_class6
42loc:@critic/q/q2_encoding/q2_encoder/hidden_0/bias*
use_locking(*
validate_shape(
�
2critic/q/q2_encoding/q2_encoder/hidden_0/bias/readIdentity-critic/q/q2_encoding/q2_encoder/hidden_0/bias*
T0*@
_class6
42loc:@critic/q/q2_encoding/q2_encoder/hidden_0/bias
�
/critic/q/q2_encoding/q2_encoder/hidden_0/MatMulMatMulconcat4critic/q/q2_encoding/q2_encoder/hidden_0/kernel/read*
T0*
transpose_a( *
transpose_b( 
�
0critic/q/q2_encoding/q2_encoder/hidden_0/BiasAddBiasAdd/critic/q/q2_encoding/q2_encoder/hidden_0/MatMul2critic/q/q2_encoding/q2_encoder/hidden_0/bias/read*
T0*
data_formatNHWC
v
0critic/q/q2_encoding/q2_encoder/hidden_0/SigmoidSigmoid0critic/q/q2_encoding/q2_encoder/hidden_0/BiasAdd*
T0
�
,critic/q/q2_encoding/q2_encoder/hidden_0/MulMul0critic/q/q2_encoding/q2_encoder/hidden_0/BiasAdd0critic/q/q2_encoding/q2_encoder/hidden_0/Sigmoid*
T0
�
Rcritic/q/q2_encoding/q2_encoder/hidden_1/kernel/Initializer/truncated_normal/shapeConst*B
_class8
64loc:@critic/q/q2_encoding/q2_encoder/hidden_1/kernel*
dtype0*
valueB"@   @   
�
Qcritic/q/q2_encoding/q2_encoder/hidden_1/kernel/Initializer/truncated_normal/meanConst*B
_class8
64loc:@critic/q/q2_encoding/q2_encoder/hidden_1/kernel*
dtype0*
valueB
 *    
�
Scritic/q/q2_encoding/q2_encoder/hidden_1/kernel/Initializer/truncated_normal/stddevConst*B
_class8
64loc:@critic/q/q2_encoding/q2_encoder/hidden_1/kernel*
dtype0*
valueB
 *6�>
�
\critic/q/q2_encoding/q2_encoder/hidden_1/kernel/Initializer/truncated_normal/TruncatedNormalTruncatedNormalRcritic/q/q2_encoding/q2_encoder/hidden_1/kernel/Initializer/truncated_normal/shape*
T0*B
_class8
64loc:@critic/q/q2_encoding/q2_encoder/hidden_1/kernel*
dtype0*
seed�?*
seed2
�
Pcritic/q/q2_encoding/q2_encoder/hidden_1/kernel/Initializer/truncated_normal/mulMul\critic/q/q2_encoding/q2_encoder/hidden_1/kernel/Initializer/truncated_normal/TruncatedNormalScritic/q/q2_encoding/q2_encoder/hidden_1/kernel/Initializer/truncated_normal/stddev*
T0*B
_class8
64loc:@critic/q/q2_encoding/q2_encoder/hidden_1/kernel
�
Lcritic/q/q2_encoding/q2_encoder/hidden_1/kernel/Initializer/truncated_normalAddPcritic/q/q2_encoding/q2_encoder/hidden_1/kernel/Initializer/truncated_normal/mulQcritic/q/q2_encoding/q2_encoder/hidden_1/kernel/Initializer/truncated_normal/mean*
T0*B
_class8
64loc:@critic/q/q2_encoding/q2_encoder/hidden_1/kernel
�
/critic/q/q2_encoding/q2_encoder/hidden_1/kernel
VariableV2*B
_class8
64loc:@critic/q/q2_encoding/q2_encoder/hidden_1/kernel*
	container *
dtype0*
shape
:@@*
shared_name 
�
6critic/q/q2_encoding/q2_encoder/hidden_1/kernel/AssignAssign/critic/q/q2_encoding/q2_encoder/hidden_1/kernelLcritic/q/q2_encoding/q2_encoder/hidden_1/kernel/Initializer/truncated_normal*
T0*B
_class8
64loc:@critic/q/q2_encoding/q2_encoder/hidden_1/kernel*
use_locking(*
validate_shape(
�
4critic/q/q2_encoding/q2_encoder/hidden_1/kernel/readIdentity/critic/q/q2_encoding/q2_encoder/hidden_1/kernel*
T0*B
_class8
64loc:@critic/q/q2_encoding/q2_encoder/hidden_1/kernel
�
?critic/q/q2_encoding/q2_encoder/hidden_1/bias/Initializer/zerosConst*@
_class6
42loc:@critic/q/q2_encoding/q2_encoder/hidden_1/bias*
dtype0*
valueB@*    
�
-critic/q/q2_encoding/q2_encoder/hidden_1/bias
VariableV2*@
_class6
42loc:@critic/q/q2_encoding/q2_encoder/hidden_1/bias*
	container *
dtype0*
shape:@*
shared_name 
�
4critic/q/q2_encoding/q2_encoder/hidden_1/bias/AssignAssign-critic/q/q2_encoding/q2_encoder/hidden_1/bias?critic/q/q2_encoding/q2_encoder/hidden_1/bias/Initializer/zeros*
T0*@
_class6
42loc:@critic/q/q2_encoding/q2_encoder/hidden_1/bias*
use_locking(*
validate_shape(
�
2critic/q/q2_encoding/q2_encoder/hidden_1/bias/readIdentity-critic/q/q2_encoding/q2_encoder/hidden_1/bias*
T0*@
_class6
42loc:@critic/q/q2_encoding/q2_encoder/hidden_1/bias
�
/critic/q/q2_encoding/q2_encoder/hidden_1/MatMulMatMul,critic/q/q2_encoding/q2_encoder/hidden_0/Mul4critic/q/q2_encoding/q2_encoder/hidden_1/kernel/read*
T0*
transpose_a( *
transpose_b( 
�
0critic/q/q2_encoding/q2_encoder/hidden_1/BiasAddBiasAdd/critic/q/q2_encoding/q2_encoder/hidden_1/MatMul2critic/q/q2_encoding/q2_encoder/hidden_1/bias/read*
T0*
data_formatNHWC
v
0critic/q/q2_encoding/q2_encoder/hidden_1/SigmoidSigmoid0critic/q/q2_encoding/q2_encoder/hidden_1/BiasAdd*
T0
�
,critic/q/q2_encoding/q2_encoder/hidden_1/MulMul0critic/q/q2_encoding/q2_encoder/hidden_1/BiasAdd0critic/q/q2_encoding/q2_encoder/hidden_1/Sigmoid*
T0
�
Icritic/q/q2_encoding/extrinsic_q2/kernel/Initializer/random_uniform/shapeConst*;
_class1
/-loc:@critic/q/q2_encoding/extrinsic_q2/kernel*
dtype0*
valueB"@      
�
Gcritic/q/q2_encoding/extrinsic_q2/kernel/Initializer/random_uniform/minConst*;
_class1
/-loc:@critic/q/q2_encoding/extrinsic_q2/kernel*
dtype0*
valueB
 *����
�
Gcritic/q/q2_encoding/extrinsic_q2/kernel/Initializer/random_uniform/maxConst*;
_class1
/-loc:@critic/q/q2_encoding/extrinsic_q2/kernel*
dtype0*
valueB
 *���>
�
Qcritic/q/q2_encoding/extrinsic_q2/kernel/Initializer/random_uniform/RandomUniformRandomUniformIcritic/q/q2_encoding/extrinsic_q2/kernel/Initializer/random_uniform/shape*
T0*;
_class1
/-loc:@critic/q/q2_encoding/extrinsic_q2/kernel*
dtype0*
seed�?*
seed2
�
Gcritic/q/q2_encoding/extrinsic_q2/kernel/Initializer/random_uniform/subSubGcritic/q/q2_encoding/extrinsic_q2/kernel/Initializer/random_uniform/maxGcritic/q/q2_encoding/extrinsic_q2/kernel/Initializer/random_uniform/min*
T0*;
_class1
/-loc:@critic/q/q2_encoding/extrinsic_q2/kernel
�
Gcritic/q/q2_encoding/extrinsic_q2/kernel/Initializer/random_uniform/mulMulQcritic/q/q2_encoding/extrinsic_q2/kernel/Initializer/random_uniform/RandomUniformGcritic/q/q2_encoding/extrinsic_q2/kernel/Initializer/random_uniform/sub*
T0*;
_class1
/-loc:@critic/q/q2_encoding/extrinsic_q2/kernel
�
Ccritic/q/q2_encoding/extrinsic_q2/kernel/Initializer/random_uniformAddGcritic/q/q2_encoding/extrinsic_q2/kernel/Initializer/random_uniform/mulGcritic/q/q2_encoding/extrinsic_q2/kernel/Initializer/random_uniform/min*
T0*;
_class1
/-loc:@critic/q/q2_encoding/extrinsic_q2/kernel
�
(critic/q/q2_encoding/extrinsic_q2/kernel
VariableV2*;
_class1
/-loc:@critic/q/q2_encoding/extrinsic_q2/kernel*
	container *
dtype0*
shape
:@*
shared_name 
�
/critic/q/q2_encoding/extrinsic_q2/kernel/AssignAssign(critic/q/q2_encoding/extrinsic_q2/kernelCcritic/q/q2_encoding/extrinsic_q2/kernel/Initializer/random_uniform*
T0*;
_class1
/-loc:@critic/q/q2_encoding/extrinsic_q2/kernel*
use_locking(*
validate_shape(
�
-critic/q/q2_encoding/extrinsic_q2/kernel/readIdentity(critic/q/q2_encoding/extrinsic_q2/kernel*
T0*;
_class1
/-loc:@critic/q/q2_encoding/extrinsic_q2/kernel
�
8critic/q/q2_encoding/extrinsic_q2/bias/Initializer/zerosConst*9
_class/
-+loc:@critic/q/q2_encoding/extrinsic_q2/bias*
dtype0*
valueB*    
�
&critic/q/q2_encoding/extrinsic_q2/bias
VariableV2*9
_class/
-+loc:@critic/q/q2_encoding/extrinsic_q2/bias*
	container *
dtype0*
shape:*
shared_name 
�
-critic/q/q2_encoding/extrinsic_q2/bias/AssignAssign&critic/q/q2_encoding/extrinsic_q2/bias8critic/q/q2_encoding/extrinsic_q2/bias/Initializer/zeros*
T0*9
_class/
-+loc:@critic/q/q2_encoding/extrinsic_q2/bias*
use_locking(*
validate_shape(
�
+critic/q/q2_encoding/extrinsic_q2/bias/readIdentity&critic/q/q2_encoding/extrinsic_q2/bias*
T0*9
_class/
-+loc:@critic/q/q2_encoding/extrinsic_q2/bias
�
(critic/q/q2_encoding/extrinsic_q2/MatMulMatMul,critic/q/q2_encoding/q2_encoder/hidden_1/Mul-critic/q/q2_encoding/extrinsic_q2/kernel/read*
T0*
transpose_a( *
transpose_b( 
�
)critic/q/q2_encoding/extrinsic_q2/BiasAddBiasAdd(critic/q/q2_encoding/extrinsic_q2/MatMul+critic/q/q2_encoding/extrinsic_q2/bias/read*
T0*
data_formatNHWC
p
critic/q/q2_encoding/Mean/inputPack)critic/q/q2_encoding/extrinsic_q2/BiasAdd*
N*
T0*

axis 
U
+critic/q/q2_encoding/Mean/reduction_indicesConst*
dtype0*
value	B : 
�
critic/q/q2_encoding/MeanMeancritic/q/q2_encoding/Mean/input+critic/q/q2_encoding/Mean/reduction_indices*
T0*

Tidx0*
	keep_dims( 
�
1critic/q/q1_encoding_1/q1_encoder/hidden_0/MatMulMatMulconcat_14critic/q/q1_encoding/q1_encoder/hidden_0/kernel/read*
T0*
transpose_a( *
transpose_b( 
�
2critic/q/q1_encoding_1/q1_encoder/hidden_0/BiasAddBiasAdd1critic/q/q1_encoding_1/q1_encoder/hidden_0/MatMul2critic/q/q1_encoding/q1_encoder/hidden_0/bias/read*
T0*
data_formatNHWC
z
2critic/q/q1_encoding_1/q1_encoder/hidden_0/SigmoidSigmoid2critic/q/q1_encoding_1/q1_encoder/hidden_0/BiasAdd*
T0
�
.critic/q/q1_encoding_1/q1_encoder/hidden_0/MulMul2critic/q/q1_encoding_1/q1_encoder/hidden_0/BiasAdd2critic/q/q1_encoding_1/q1_encoder/hidden_0/Sigmoid*
T0
�
1critic/q/q1_encoding_1/q1_encoder/hidden_1/MatMulMatMul.critic/q/q1_encoding_1/q1_encoder/hidden_0/Mul4critic/q/q1_encoding/q1_encoder/hidden_1/kernel/read*
T0*
transpose_a( *
transpose_b( 
�
2critic/q/q1_encoding_1/q1_encoder/hidden_1/BiasAddBiasAdd1critic/q/q1_encoding_1/q1_encoder/hidden_1/MatMul2critic/q/q1_encoding/q1_encoder/hidden_1/bias/read*
T0*
data_formatNHWC
z
2critic/q/q1_encoding_1/q1_encoder/hidden_1/SigmoidSigmoid2critic/q/q1_encoding_1/q1_encoder/hidden_1/BiasAdd*
T0
�
.critic/q/q1_encoding_1/q1_encoder/hidden_1/MulMul2critic/q/q1_encoding_1/q1_encoder/hidden_1/BiasAdd2critic/q/q1_encoding_1/q1_encoder/hidden_1/Sigmoid*
T0
�
*critic/q/q1_encoding_1/extrinsic_q1/MatMulMatMul.critic/q/q1_encoding_1/q1_encoder/hidden_1/Mul-critic/q/q1_encoding/extrinsic_q1/kernel/read*
T0*
transpose_a( *
transpose_b( 
�
+critic/q/q1_encoding_1/extrinsic_q1/BiasAddBiasAdd*critic/q/q1_encoding_1/extrinsic_q1/MatMul+critic/q/q1_encoding/extrinsic_q1/bias/read*
T0*
data_formatNHWC
t
!critic/q/q1_encoding_1/Mean/inputPack+critic/q/q1_encoding_1/extrinsic_q1/BiasAdd*
N*
T0*

axis 
W
-critic/q/q1_encoding_1/Mean/reduction_indicesConst*
dtype0*
value	B : 
�
critic/q/q1_encoding_1/MeanMean!critic/q/q1_encoding_1/Mean/input-critic/q/q1_encoding_1/Mean/reduction_indices*
T0*

Tidx0*
	keep_dims( 
�
1critic/q/q2_encoding_1/q2_encoder/hidden_0/MatMulMatMulconcat_14critic/q/q2_encoding/q2_encoder/hidden_0/kernel/read*
T0*
transpose_a( *
transpose_b( 
�
2critic/q/q2_encoding_1/q2_encoder/hidden_0/BiasAddBiasAdd1critic/q/q2_encoding_1/q2_encoder/hidden_0/MatMul2critic/q/q2_encoding/q2_encoder/hidden_0/bias/read*
T0*
data_formatNHWC
z
2critic/q/q2_encoding_1/q2_encoder/hidden_0/SigmoidSigmoid2critic/q/q2_encoding_1/q2_encoder/hidden_0/BiasAdd*
T0
�
.critic/q/q2_encoding_1/q2_encoder/hidden_0/MulMul2critic/q/q2_encoding_1/q2_encoder/hidden_0/BiasAdd2critic/q/q2_encoding_1/q2_encoder/hidden_0/Sigmoid*
T0
�
1critic/q/q2_encoding_1/q2_encoder/hidden_1/MatMulMatMul.critic/q/q2_encoding_1/q2_encoder/hidden_0/Mul4critic/q/q2_encoding/q2_encoder/hidden_1/kernel/read*
T0*
transpose_a( *
transpose_b( 
�
2critic/q/q2_encoding_1/q2_encoder/hidden_1/BiasAddBiasAdd1critic/q/q2_encoding_1/q2_encoder/hidden_1/MatMul2critic/q/q2_encoding/q2_encoder/hidden_1/bias/read*
T0*
data_formatNHWC
z
2critic/q/q2_encoding_1/q2_encoder/hidden_1/SigmoidSigmoid2critic/q/q2_encoding_1/q2_encoder/hidden_1/BiasAdd*
T0
�
.critic/q/q2_encoding_1/q2_encoder/hidden_1/MulMul2critic/q/q2_encoding_1/q2_encoder/hidden_1/BiasAdd2critic/q/q2_encoding_1/q2_encoder/hidden_1/Sigmoid*
T0
�
*critic/q/q2_encoding_1/extrinsic_q2/MatMulMatMul.critic/q/q2_encoding_1/q2_encoder/hidden_1/Mul-critic/q/q2_encoding/extrinsic_q2/kernel/read*
T0*
transpose_a( *
transpose_b( 
�
+critic/q/q2_encoding_1/extrinsic_q2/BiasAddBiasAdd*critic/q/q2_encoding_1/extrinsic_q2/MatMul+critic/q/q2_encoding/extrinsic_q2/bias/read*
T0*
data_formatNHWC
t
!critic/q/q2_encoding_1/Mean/inputPack+critic/q/q2_encoding_1/extrinsic_q2/BiasAdd*
N*
T0*

axis 
W
-critic/q/q2_encoding_1/Mean/reduction_indicesConst*
dtype0*
value	B : 
�
critic/q/q2_encoding_1/MeanMean!critic/q/q2_encoding_1/Mean/input-critic/q/q2_encoding_1/Mean/reduction_indices*
T0*

Tidx0*
	keep_dims( 
@
sac_sequence_length_1Placeholder*
dtype0*
shape:
[
!target_network/vector_observationPlaceholder*
dtype0*
shape:���������
�
4target_network/normalization_steps/Initializer/zerosConst*5
_class+
)'loc:@target_network/normalization_steps*
dtype0*
value	B : 
�
"target_network/normalization_steps
VariableV2*5
_class+
)'loc:@target_network/normalization_steps*
	container *
dtype0*
shape: *
shared_name 
�
)target_network/normalization_steps/AssignAssign"target_network/normalization_steps4target_network/normalization_steps/Initializer/zeros*
T0*5
_class+
)'loc:@target_network/normalization_steps*
use_locking(*
validate_shape(
�
'target_network/normalization_steps/readIdentity"target_network/normalization_steps*
T0*5
_class+
)'loc:@target_network/normalization_steps
�
-target_network/running_mean/Initializer/zerosConst*.
_class$
" loc:@target_network/running_mean*
dtype0*
valueB*    
�
target_network/running_mean
VariableV2*.
_class$
" loc:@target_network/running_mean*
	container *
dtype0*
shape:*
shared_name 
�
"target_network/running_mean/AssignAssigntarget_network/running_mean-target_network/running_mean/Initializer/zeros*
T0*.
_class$
" loc:@target_network/running_mean*
use_locking(*
validate_shape(
�
 target_network/running_mean/readIdentitytarget_network/running_mean*
T0*.
_class$
" loc:@target_network/running_mean
�
0target_network/running_variance/Initializer/onesConst*2
_class(
&$loc:@target_network/running_variance*
dtype0*
valueB*  �?
�
target_network/running_variance
VariableV2*2
_class(
&$loc:@target_network/running_variance*
	container *
dtype0*
shape:*
shared_name 
�
&target_network/running_variance/AssignAssigntarget_network/running_variance0target_network/running_variance/Initializer/ones*
T0*2
_class(
&$loc:@target_network/running_variance*
use_locking(*
validate_shape(
�
$target_network/running_variance/readIdentitytarget_network/running_variance*
T0*2
_class(
&$loc:@target_network/running_variance
Y
target_network/ShapeShape!target_network/vector_observation*
T0*
out_type0
P
"target_network/strided_slice/stackConst*
dtype0*
valueB: 
R
$target_network/strided_slice/stack_1Const*
dtype0*
valueB:
R
$target_network/strided_slice/stack_2Const*
dtype0*
valueB:
�
target_network/strided_sliceStridedSlicetarget_network/Shape"target_network/strided_slice/stack$target_network/strided_slice/stack_1$target_network/strided_slice/stack_2*
Index0*
T0*

begin_mask *
ellipsis_mask *
end_mask *
new_axis_mask *
shrink_axis_mask
i
target_network/AddAdd'target_network/normalization_steps/readtarget_network/strided_slice*
T0
g
target_network/SubSub!target_network/vector_observation target_network/running_mean/read*
T0
W
target_network/CastCasttarget_network/Add*

DstT0*

SrcT0*
Truncate( 
S
target_network/truedivRealDivtarget_network/Subtarget_network/Cast*
T0
N
$target_network/Sum/reduction_indicesConst*
dtype0*
value	B : 
}
target_network/SumSumtarget_network/truediv$target_network/Sum/reduction_indices*
T0*

Tidx0*
	keep_dims( 
\
target_network/add_1AddV2 target_network/running_mean/readtarget_network/Sum*
T0
]
target_network/Sub_1Sub!target_network/vector_observationtarget_network/add_1*
T0
L
target_network/mulMultarget_network/Sub_1target_network/Sub*
T0
P
&target_network/Sum_1/reduction_indicesConst*
dtype0*
value	B : 
}
target_network/Sum_1Sumtarget_network/mul&target_network/Sum_1/reduction_indices*
T0*

Tidx0*
	keep_dims( 
b
target_network/add_2AddV2$target_network/running_variance/readtarget_network/Sum_1*
T0
�
target_network/AssignAssigntarget_network/running_meantarget_network/add_1*
T0*.
_class$
" loc:@target_network/running_mean*
use_locking(*
validate_shape(
�
target_network/Assign_1Assigntarget_network/running_variancetarget_network/add_2*
T0*2
_class(
&$loc:@target_network/running_variance*
use_locking(*
validate_shape(
�
target_network/Assign_2Assign"target_network/normalization_stepstarget_network/Add*
T0*5
_class+
)'loc:@target_network/normalization_steps*
use_locking(*
validate_shape(
[
-target_network/moments/mean/reduction_indicesConst*
dtype0*
valueB: 
�
target_network/moments/meanMean!target_network/vector_observation-target_network/moments/mean/reduction_indices*
T0*

Tidx0*
	keep_dims(
Y
#target_network/moments/StopGradientStopGradienttarget_network/moments/mean*
T0
�
(target_network/moments/SquaredDifferenceSquaredDifference!target_network/vector_observation#target_network/moments/StopGradient*
T0
_
1target_network/moments/variance/reduction_indicesConst*
dtype0*
valueB: 
�
target_network/moments/varianceMean(target_network/moments/SquaredDifference1target_network/moments/variance/reduction_indices*
T0*

Tidx0*
	keep_dims(
f
target_network/moments/SqueezeSqueezetarget_network/moments/mean*
T0*
squeeze_dims
 
l
 target_network/moments/Squeeze_1Squeezetarget_network/moments/variance*
T0*
squeeze_dims
 
�
target_network/Assign_3Assigntarget_network/running_meantarget_network/moments/Squeeze*
T0*.
_class$
" loc:@target_network/running_mean*
use_locking(*
validate_shape(
C
target_network/add_3/yConst*
dtype0*
valueB
 *���3
`
target_network/add_3AddV2 target_network/moments/Squeeze_1target_network/add_3/y*
T0
Y
target_network/Cast_1Casttarget_network/Add*

DstT0*

SrcT0*
Truncate( 
Q
target_network/mul_1Multarget_network/add_3target_network/Cast_1*
T0
�
target_network/Assign_4Assigntarget_network/running_variancetarget_network/mul_1*
T0*2
_class(
&$loc:@target_network/running_variance*
use_locking(*
validate_shape(
o
target_network/group_depsNoOp^target_network/Assign_2^target_network/Assign_3^target_network/Assign_4
o
target_network/group_deps_1NoOp^target_network/Assign^target_network/Assign_1^target_network/Assign_2
i
target_network/sub_2Sub!target_network/vector_observation target_network/running_mean/read*
T0
n
target_network/Cast_2Cast'target_network/normalization_steps/read*

DstT0*

SrcT0*
Truncate( 
C
target_network/add_4/yConst*
dtype0*
valueB
 *  �?
U
target_network/add_4AddV2target_network/Cast_2target_network/add_4/y*
T0
h
target_network/truediv_1RealDiv$target_network/running_variance/readtarget_network/add_4*
T0
>
target_network/SqrtSqrttarget_network/truediv_1*
T0
W
target_network/truediv_2RealDivtarget_network/sub_2target_network/Sqrt*
T0
V
)target_network/normalized_state/Minimum/yConst*
dtype0*
valueB
 *  �@
�
'target_network/normalized_state/MinimumMinimumtarget_network/truediv_2)target_network/normalized_state/Minimum/y*
T0
N
!target_network/normalized_state/yConst*
dtype0*
valueB
 *  ��

target_network/normalized_stateMaximum'target_network/normalized_state/Minimum!target_network/normalized_state/y*
T0
�
Vtarget_network/critic/value/encoder/hidden_0/kernel/Initializer/truncated_normal/shapeConst*F
_class<
:8loc:@target_network/critic/value/encoder/hidden_0/kernel*
dtype0*
valueB"   @   
�
Utarget_network/critic/value/encoder/hidden_0/kernel/Initializer/truncated_normal/meanConst*F
_class<
:8loc:@target_network/critic/value/encoder/hidden_0/kernel*
dtype0*
valueB
 *    
�
Wtarget_network/critic/value/encoder/hidden_0/kernel/Initializer/truncated_normal/stddevConst*F
_class<
:8loc:@target_network/critic/value/encoder/hidden_0/kernel*
dtype0*
valueB
 *��M?
�
`target_network/critic/value/encoder/hidden_0/kernel/Initializer/truncated_normal/TruncatedNormalTruncatedNormalVtarget_network/critic/value/encoder/hidden_0/kernel/Initializer/truncated_normal/shape*
T0*F
_class<
:8loc:@target_network/critic/value/encoder/hidden_0/kernel*
dtype0*
seed�?*
seed2
�
Ttarget_network/critic/value/encoder/hidden_0/kernel/Initializer/truncated_normal/mulMul`target_network/critic/value/encoder/hidden_0/kernel/Initializer/truncated_normal/TruncatedNormalWtarget_network/critic/value/encoder/hidden_0/kernel/Initializer/truncated_normal/stddev*
T0*F
_class<
:8loc:@target_network/critic/value/encoder/hidden_0/kernel
�
Ptarget_network/critic/value/encoder/hidden_0/kernel/Initializer/truncated_normalAddTtarget_network/critic/value/encoder/hidden_0/kernel/Initializer/truncated_normal/mulUtarget_network/critic/value/encoder/hidden_0/kernel/Initializer/truncated_normal/mean*
T0*F
_class<
:8loc:@target_network/critic/value/encoder/hidden_0/kernel
�
3target_network/critic/value/encoder/hidden_0/kernel
VariableV2*F
_class<
:8loc:@target_network/critic/value/encoder/hidden_0/kernel*
	container *
dtype0*
shape
:@*
shared_name 
�
:target_network/critic/value/encoder/hidden_0/kernel/AssignAssign3target_network/critic/value/encoder/hidden_0/kernelPtarget_network/critic/value/encoder/hidden_0/kernel/Initializer/truncated_normal*
T0*F
_class<
:8loc:@target_network/critic/value/encoder/hidden_0/kernel*
use_locking(*
validate_shape(
�
8target_network/critic/value/encoder/hidden_0/kernel/readIdentity3target_network/critic/value/encoder/hidden_0/kernel*
T0*F
_class<
:8loc:@target_network/critic/value/encoder/hidden_0/kernel
�
Ctarget_network/critic/value/encoder/hidden_0/bias/Initializer/zerosConst*D
_class:
86loc:@target_network/critic/value/encoder/hidden_0/bias*
dtype0*
valueB@*    
�
1target_network/critic/value/encoder/hidden_0/bias
VariableV2*D
_class:
86loc:@target_network/critic/value/encoder/hidden_0/bias*
	container *
dtype0*
shape:@*
shared_name 
�
8target_network/critic/value/encoder/hidden_0/bias/AssignAssign1target_network/critic/value/encoder/hidden_0/biasCtarget_network/critic/value/encoder/hidden_0/bias/Initializer/zeros*
T0*D
_class:
86loc:@target_network/critic/value/encoder/hidden_0/bias*
use_locking(*
validate_shape(
�
6target_network/critic/value/encoder/hidden_0/bias/readIdentity1target_network/critic/value/encoder/hidden_0/bias*
T0*D
_class:
86loc:@target_network/critic/value/encoder/hidden_0/bias
�
3target_network/critic/value/encoder/hidden_0/MatMulMatMultarget_network/normalized_state8target_network/critic/value/encoder/hidden_0/kernel/read*
T0*
transpose_a( *
transpose_b( 
�
4target_network/critic/value/encoder/hidden_0/BiasAddBiasAdd3target_network/critic/value/encoder/hidden_0/MatMul6target_network/critic/value/encoder/hidden_0/bias/read*
T0*
data_formatNHWC
~
4target_network/critic/value/encoder/hidden_0/SigmoidSigmoid4target_network/critic/value/encoder/hidden_0/BiasAdd*
T0
�
0target_network/critic/value/encoder/hidden_0/MulMul4target_network/critic/value/encoder/hidden_0/BiasAdd4target_network/critic/value/encoder/hidden_0/Sigmoid*
T0
�
Vtarget_network/critic/value/encoder/hidden_1/kernel/Initializer/truncated_normal/shapeConst*F
_class<
:8loc:@target_network/critic/value/encoder/hidden_1/kernel*
dtype0*
valueB"@   @   
�
Utarget_network/critic/value/encoder/hidden_1/kernel/Initializer/truncated_normal/meanConst*F
_class<
:8loc:@target_network/critic/value/encoder/hidden_1/kernel*
dtype0*
valueB
 *    
�
Wtarget_network/critic/value/encoder/hidden_1/kernel/Initializer/truncated_normal/stddevConst*F
_class<
:8loc:@target_network/critic/value/encoder/hidden_1/kernel*
dtype0*
valueB
 *6�>
�
`target_network/critic/value/encoder/hidden_1/kernel/Initializer/truncated_normal/TruncatedNormalTruncatedNormalVtarget_network/critic/value/encoder/hidden_1/kernel/Initializer/truncated_normal/shape*
T0*F
_class<
:8loc:@target_network/critic/value/encoder/hidden_1/kernel*
dtype0*
seed�?*
seed2
�
Ttarget_network/critic/value/encoder/hidden_1/kernel/Initializer/truncated_normal/mulMul`target_network/critic/value/encoder/hidden_1/kernel/Initializer/truncated_normal/TruncatedNormalWtarget_network/critic/value/encoder/hidden_1/kernel/Initializer/truncated_normal/stddev*
T0*F
_class<
:8loc:@target_network/critic/value/encoder/hidden_1/kernel
�
Ptarget_network/critic/value/encoder/hidden_1/kernel/Initializer/truncated_normalAddTtarget_network/critic/value/encoder/hidden_1/kernel/Initializer/truncated_normal/mulUtarget_network/critic/value/encoder/hidden_1/kernel/Initializer/truncated_normal/mean*
T0*F
_class<
:8loc:@target_network/critic/value/encoder/hidden_1/kernel
�
3target_network/critic/value/encoder/hidden_1/kernel
VariableV2*F
_class<
:8loc:@target_network/critic/value/encoder/hidden_1/kernel*
	container *
dtype0*
shape
:@@*
shared_name 
�
:target_network/critic/value/encoder/hidden_1/kernel/AssignAssign3target_network/critic/value/encoder/hidden_1/kernelPtarget_network/critic/value/encoder/hidden_1/kernel/Initializer/truncated_normal*
T0*F
_class<
:8loc:@target_network/critic/value/encoder/hidden_1/kernel*
use_locking(*
validate_shape(
�
8target_network/critic/value/encoder/hidden_1/kernel/readIdentity3target_network/critic/value/encoder/hidden_1/kernel*
T0*F
_class<
:8loc:@target_network/critic/value/encoder/hidden_1/kernel
�
Ctarget_network/critic/value/encoder/hidden_1/bias/Initializer/zerosConst*D
_class:
86loc:@target_network/critic/value/encoder/hidden_1/bias*
dtype0*
valueB@*    
�
1target_network/critic/value/encoder/hidden_1/bias
VariableV2*D
_class:
86loc:@target_network/critic/value/encoder/hidden_1/bias*
	container *
dtype0*
shape:@*
shared_name 
�
8target_network/critic/value/encoder/hidden_1/bias/AssignAssign1target_network/critic/value/encoder/hidden_1/biasCtarget_network/critic/value/encoder/hidden_1/bias/Initializer/zeros*
T0*D
_class:
86loc:@target_network/critic/value/encoder/hidden_1/bias*
use_locking(*
validate_shape(
�
6target_network/critic/value/encoder/hidden_1/bias/readIdentity1target_network/critic/value/encoder/hidden_1/bias*
T0*D
_class:
86loc:@target_network/critic/value/encoder/hidden_1/bias
�
3target_network/critic/value/encoder/hidden_1/MatMulMatMul0target_network/critic/value/encoder/hidden_0/Mul8target_network/critic/value/encoder/hidden_1/kernel/read*
T0*
transpose_a( *
transpose_b( 
�
4target_network/critic/value/encoder/hidden_1/BiasAddBiasAdd3target_network/critic/value/encoder/hidden_1/MatMul6target_network/critic/value/encoder/hidden_1/bias/read*
T0*
data_formatNHWC
~
4target_network/critic/value/encoder/hidden_1/SigmoidSigmoid4target_network/critic/value/encoder/hidden_1/BiasAdd*
T0
�
0target_network/critic/value/encoder/hidden_1/MulMul4target_network/critic/value/encoder/hidden_1/BiasAdd4target_network/critic/value/encoder/hidden_1/Sigmoid*
T0
�
Starget_network/critic/value/extrinsic_value/kernel/Initializer/random_uniform/shapeConst*E
_class;
97loc:@target_network/critic/value/extrinsic_value/kernel*
dtype0*
valueB"@      
�
Qtarget_network/critic/value/extrinsic_value/kernel/Initializer/random_uniform/minConst*E
_class;
97loc:@target_network/critic/value/extrinsic_value/kernel*
dtype0*
valueB
 *����
�
Qtarget_network/critic/value/extrinsic_value/kernel/Initializer/random_uniform/maxConst*E
_class;
97loc:@target_network/critic/value/extrinsic_value/kernel*
dtype0*
valueB
 *���>
�
[target_network/critic/value/extrinsic_value/kernel/Initializer/random_uniform/RandomUniformRandomUniformStarget_network/critic/value/extrinsic_value/kernel/Initializer/random_uniform/shape*
T0*E
_class;
97loc:@target_network/critic/value/extrinsic_value/kernel*
dtype0*
seed�?*
seed2
�
Qtarget_network/critic/value/extrinsic_value/kernel/Initializer/random_uniform/subSubQtarget_network/critic/value/extrinsic_value/kernel/Initializer/random_uniform/maxQtarget_network/critic/value/extrinsic_value/kernel/Initializer/random_uniform/min*
T0*E
_class;
97loc:@target_network/critic/value/extrinsic_value/kernel
�
Qtarget_network/critic/value/extrinsic_value/kernel/Initializer/random_uniform/mulMul[target_network/critic/value/extrinsic_value/kernel/Initializer/random_uniform/RandomUniformQtarget_network/critic/value/extrinsic_value/kernel/Initializer/random_uniform/sub*
T0*E
_class;
97loc:@target_network/critic/value/extrinsic_value/kernel
�
Mtarget_network/critic/value/extrinsic_value/kernel/Initializer/random_uniformAddQtarget_network/critic/value/extrinsic_value/kernel/Initializer/random_uniform/mulQtarget_network/critic/value/extrinsic_value/kernel/Initializer/random_uniform/min*
T0*E
_class;
97loc:@target_network/critic/value/extrinsic_value/kernel
�
2target_network/critic/value/extrinsic_value/kernel
VariableV2*E
_class;
97loc:@target_network/critic/value/extrinsic_value/kernel*
	container *
dtype0*
shape
:@*
shared_name 
�
9target_network/critic/value/extrinsic_value/kernel/AssignAssign2target_network/critic/value/extrinsic_value/kernelMtarget_network/critic/value/extrinsic_value/kernel/Initializer/random_uniform*
T0*E
_class;
97loc:@target_network/critic/value/extrinsic_value/kernel*
use_locking(*
validate_shape(
�
7target_network/critic/value/extrinsic_value/kernel/readIdentity2target_network/critic/value/extrinsic_value/kernel*
T0*E
_class;
97loc:@target_network/critic/value/extrinsic_value/kernel
�
Btarget_network/critic/value/extrinsic_value/bias/Initializer/zerosConst*C
_class9
75loc:@target_network/critic/value/extrinsic_value/bias*
dtype0*
valueB*    
�
0target_network/critic/value/extrinsic_value/bias
VariableV2*C
_class9
75loc:@target_network/critic/value/extrinsic_value/bias*
	container *
dtype0*
shape:*
shared_name 
�
7target_network/critic/value/extrinsic_value/bias/AssignAssign0target_network/critic/value/extrinsic_value/biasBtarget_network/critic/value/extrinsic_value/bias/Initializer/zeros*
T0*C
_class9
75loc:@target_network/critic/value/extrinsic_value/bias*
use_locking(*
validate_shape(
�
5target_network/critic/value/extrinsic_value/bias/readIdentity0target_network/critic/value/extrinsic_value/bias*
T0*C
_class9
75loc:@target_network/critic/value/extrinsic_value/bias
�
2target_network/critic/value/extrinsic_value/MatMulMatMul0target_network/critic/value/encoder/hidden_1/Mul7target_network/critic/value/extrinsic_value/kernel/read*
T0*
transpose_a( *
transpose_b( 
�
3target_network/critic/value/extrinsic_value/BiasAddBiasAdd2target_network/critic/value/extrinsic_value/MatMul5target_network/critic/value/extrinsic_value/bias/read*
T0*
data_formatNHWC
�
&target_network/critic/value/Mean/inputPack3target_network/critic/value/extrinsic_value/BiasAdd*
N*
T0*

axis 
\
2target_network/critic/value/Mean/reduction_indicesConst*
dtype0*
value	B : 
�
 target_network/critic/value/MeanMean&target_network/critic/value/Mean/input2target_network/critic/value/Mean/reduction_indices*
T0*

Tidx0*
	keep_dims( 
N
external_action_in_1Placeholder*
dtype0*
shape:���������
=
value_estimate_unusedIdentitycritic/value/Mean*
T0
B
dones_holderPlaceholder*
dtype0*
shape:���������
E
Variable_1/initial_valueConst*
dtype0*
valueB
 *RI�9
V

Variable_1
VariableV2*
	container *
dtype0*
shape: *
shared_name 
�
Variable_1/AssignAssign
Variable_1Variable_1/initial_value*
T0*
_class
loc:@Variable_1*
use_locking(*
validate_shape(
O
Variable_1/readIdentity
Variable_1*
T0*
_class
loc:@Variable_1
u
MinimumMinimum+critic/q/q1_encoding_1/extrinsic_q1/BiasAdd+critic/q/q2_encoding_1/extrinsic_q2/BiasAdd*
T0
G
extrinsic_rewardsPlaceholder*
dtype0*
shape:���������
A
ExpandDims/dimConst*
dtype0*
valueB :
���������
K

ExpandDims
ExpandDimsdones_holderExpandDims/dim*
T0*

Tdim0
C
ExpandDims_1/dimConst*
dtype0*
valueB :
���������
T
ExpandDims_1
ExpandDimsextrinsic_rewardsExpandDims_1/dim*
T0*

Tdim0
0
mul_2MulVariable/read
ExpandDims*
T0
4
sub_3/xConst*
dtype0*
valueB
 *  �?
%
sub_3Subsub_3/xmul_2*
T0
4
mul_3/yConst*
dtype0*
valueB
 *�p}?
%
mul_3Mulsub_3mul_3/y*
T0
Q
mul_4Mulmul_33target_network/critic/value/extrinsic_value/BiasAdd*
T0
,
add_6AddV2ExpandDims_1mul_4*
T0
.
StopGradient_1StopGradientadd_6*
T0
?
ToFloatCastCast_3*

DstT0*

SrcT0*
Truncate( 
j
SquaredDifferenceSquaredDifferenceStopGradient_1)critic/q/q1_encoding/extrinsic_q1/BiasAdd*
T0
1
mul_5MulToFloatSquaredDifference*
T0
:
ConstConst*
dtype0*
valueB"       
@
MeanMeanmul_5Const*
T0*

Tidx0*
	keep_dims( 
4
mul_6/xConst*
dtype0*
valueB
 *   ?
$
mul_6Mulmul_6/xMean*
T0
A
	ToFloat_1CastCast_3*

DstT0*

SrcT0*
Truncate( 
l
SquaredDifference_1SquaredDifferenceStopGradient_1)critic/q/q2_encoding/extrinsic_q2/BiasAdd*
T0
5
mul_7Mul	ToFloat_1SquaredDifference_1*
T0
<
Const_1Const*
dtype0*
valueB"       
D
Mean_1Meanmul_7Const_1*
T0*

Tidx0*
	keep_dims( 
4
mul_8/xConst*
dtype0*
valueB
 *   ?
&
mul_8Mulmul_8/xMean_1*
T0
8
Rank/packedPackmul_6*
N*
T0*

axis 
.
RankConst*
dtype0*
value	B :
5
range/startConst*
dtype0*
value	B : 
5
range/deltaConst*
dtype0*
value	B :
:
rangeRangerange/startRankrange/delta*

Tidx0
9
Mean_2/inputPackmul_6*
N*
T0*

axis 
I
Mean_2MeanMean_2/inputrange*
T0*

Tidx0*
	keep_dims( 
:
Rank_1/packedPackmul_8*
N*
T0*

axis 
0
Rank_1Const*
dtype0*
value	B :
7
range_1/startConst*
dtype0*
value	B : 
7
range_1/deltaConst*
dtype0*
value	B :
B
range_1Rangerange_1/startRank_1range_1/delta*

Tidx0
9
Mean_3/inputPackmul_8*
N*
T0*

axis 
K
Mean_3MeanMean_3/inputrange_1*
T0*

Tidx0*
	keep_dims( 
4
Const_2Const*
dtype0*
valueB
 *r1�
G
log_ent_coef/initial_valueConst*
dtype0*
valueB
 *r1�
X
log_ent_coef
VariableV2*
	container *
dtype0*
shape: *
shared_name 
�
log_ent_coef/AssignAssignlog_ent_coeflog_ent_coef/initial_value*
T0*
_class
loc:@log_ent_coef*
use_locking(*
validate_shape(
U
log_ent_coef/readIdentitylog_ent_coef*
T0*
_class
loc:@log_ent_coef
&
ExpExplog_ent_coef/read*
T0
A
	ToFloat_2CastCast_3*

DstT0*

SrcT0*
Truncate( 
3
mul_9Mullog_ent_coef/read	ToFloat_2*
T0
4
add_7/yConst*
dtype0*
valueB
 *  @�
.
add_7AddV2action_probsadd_7/y*
T0
A
Sum_2/reduction_indicesConst*
dtype0*
value	B :
R
Sum_2Sumadd_7Sum_2/reduction_indices*
T0*

Tidx0*
	keep_dims(
.
StopGradient_2StopGradientSum_2*
T0
-
mul_10Mulmul_9StopGradient_2*
T0
<
Const_3Const*
dtype0*
valueB"       
E
Mean_4Meanmul_10Const_3*
T0*

Tidx0*
	keep_dims( 

NegNegMean_4*
T0
)
mul_11MulExpaction_probs*
T0
:
sub_4Submul_11critic/q/q1_encoding_1/Mean*
T0
B
Mean_5/reduction_indicesConst*
dtype0*
value	B :
U
Mean_5Meansub_4Mean_5/reduction_indices*
T0*

Tidx0*
	keep_dims( 
A
	ToFloat_3CastCast_3*

DstT0*

SrcT0*
Truncate( 
)
mul_12Mul	ToFloat_3Mean_5*
T0
5
Const_4Const*
dtype0*
valueB: 
E
Mean_6Meanmul_12Const_4*
T0*

Tidx0*
	keep_dims( 
)
mul_13MulExpaction_probs*
T0
A
Sum_3/reduction_indicesConst*
dtype0*
value	B :
S
Sum_3Summul_13Sum_3/reduction_indices*
T0*

Tidx0*
	keep_dims( 
%
sub_5SubMinimumSum_3*
T0
.
StopGradient_3StopGradientsub_5*
T0
A
	ToFloat_4CastCast_3*

DstT0*

SrcT0*
Truncate( 
g
SquaredDifference_2SquaredDifference$critic/value/extrinsic_value/BiasAddStopGradient_3*
T0
6
mul_14Mul	ToFloat_4SquaredDifference_2*
T0
<
Const_5Const*
dtype0*
valueB"       
E
Mean_7Meanmul_14Const_5*
T0*

Tidx0*
	keep_dims( 
5
mul_15/xConst*
dtype0*
valueB
 *   ?
(
mul_15Mulmul_15/xMean_7*
T0
;
Rank_2/packedPackmul_15*
N*
T0*

axis 
0
Rank_2Const*
dtype0*
value	B :
7
range_2/startConst*
dtype0*
value	B : 
7
range_2/deltaConst*
dtype0*
value	B :
B
range_2Rangerange_2/startRank_2range_2/delta*

Tidx0
:
Mean_8/inputPackmul_15*
N*
T0*

axis 
K
Mean_8MeanMean_8/inputrange_2*
T0*

Tidx0*
	keep_dims( 
'
add_8AddV2Mean_2Mean_3*
T0
&
add_9AddV2add_8Mean_8*
T0
5
mul_16/xConst*
dtype0*
valueB
 *R�~?
Z
mul_16Mulmul_16/x8target_network/critic/value/encoder/hidden_0/kernel/read*
T0
5
mul_17/xConst*
dtype0*
valueB
 *
ף;
K
mul_17Mulmul_17/x)critic/value/encoder/hidden_0/kernel/read*
T0
(
add_10AddV2mul_16mul_17*
T0
�
	Assign_26Assign3target_network/critic/value/encoder/hidden_0/kerneladd_10*
T0*F
_class<
:8loc:@target_network/critic/value/encoder/hidden_0/kernel*
use_locking(*
validate_shape(
5
mul_18/xConst*
dtype0*
valueB
 *R�~?
X
mul_18Mulmul_18/x6target_network/critic/value/encoder/hidden_0/bias/read*
T0
5
mul_19/xConst*
dtype0*
valueB
 *
ף;
I
mul_19Mulmul_19/x'critic/value/encoder/hidden_0/bias/read*
T0
(
add_11AddV2mul_18mul_19*
T0
�
	Assign_27Assign1target_network/critic/value/encoder/hidden_0/biasadd_11*
T0*D
_class:
86loc:@target_network/critic/value/encoder/hidden_0/bias*
use_locking(*
validate_shape(
5
mul_20/xConst*
dtype0*
valueB
 *R�~?
Z
mul_20Mulmul_20/x8target_network/critic/value/encoder/hidden_1/kernel/read*
T0
5
mul_21/xConst*
dtype0*
valueB
 *
ף;
K
mul_21Mulmul_21/x)critic/value/encoder/hidden_1/kernel/read*
T0
(
add_12AddV2mul_20mul_21*
T0
�
	Assign_28Assign3target_network/critic/value/encoder/hidden_1/kerneladd_12*
T0*F
_class<
:8loc:@target_network/critic/value/encoder/hidden_1/kernel*
use_locking(*
validate_shape(
5
mul_22/xConst*
dtype0*
valueB
 *R�~?
X
mul_22Mulmul_22/x6target_network/critic/value/encoder/hidden_1/bias/read*
T0
5
mul_23/xConst*
dtype0*
valueB
 *
ף;
I
mul_23Mulmul_23/x'critic/value/encoder/hidden_1/bias/read*
T0
(
add_13AddV2mul_22mul_23*
T0
�
	Assign_29Assign1target_network/critic/value/encoder/hidden_1/biasadd_13*
T0*D
_class:
86loc:@target_network/critic/value/encoder/hidden_1/bias*
use_locking(*
validate_shape(
5
mul_24/xConst*
dtype0*
valueB
 *R�~?
Y
mul_24Mulmul_24/x7target_network/critic/value/extrinsic_value/kernel/read*
T0
5
mul_25/xConst*
dtype0*
valueB
 *
ף;
J
mul_25Mulmul_25/x(critic/value/extrinsic_value/kernel/read*
T0
(
add_14AddV2mul_24mul_25*
T0
�
	Assign_30Assign2target_network/critic/value/extrinsic_value/kerneladd_14*
T0*E
_class;
97loc:@target_network/critic/value/extrinsic_value/kernel*
use_locking(*
validate_shape(
5
mul_26/xConst*
dtype0*
valueB
 *R�~?
W
mul_26Mulmul_26/x5target_network/critic/value/extrinsic_value/bias/read*
T0
5
mul_27/xConst*
dtype0*
valueB
 *
ף;
H
mul_27Mulmul_27/x&critic/value/extrinsic_value/bias/read*
T0
(
add_15AddV2mul_26mul_27*
T0
�
	Assign_31Assign0target_network/critic/value/extrinsic_value/biasadd_15*
T0*C
_class9
75loc:@target_network/critic/value/extrinsic_value/bias*
use_locking(*
validate_shape(
�
	Assign_32Assign3target_network/critic/value/encoder/hidden_0/kernel)critic/value/encoder/hidden_0/kernel/read*
T0*F
_class<
:8loc:@target_network/critic/value/encoder/hidden_0/kernel*
use_locking(*
validate_shape(
�
	Assign_33Assign1target_network/critic/value/encoder/hidden_0/bias'critic/value/encoder/hidden_0/bias/read*
T0*D
_class:
86loc:@target_network/critic/value/encoder/hidden_0/bias*
use_locking(*
validate_shape(
�
	Assign_34Assign3target_network/critic/value/encoder/hidden_1/kernel)critic/value/encoder/hidden_1/kernel/read*
T0*F
_class<
:8loc:@target_network/critic/value/encoder/hidden_1/kernel*
use_locking(*
validate_shape(
�
	Assign_35Assign1target_network/critic/value/encoder/hidden_1/bias'critic/value/encoder/hidden_1/bias/read*
T0*D
_class:
86loc:@target_network/critic/value/encoder/hidden_1/bias*
use_locking(*
validate_shape(
�
	Assign_36Assign2target_network/critic/value/extrinsic_value/kernel(critic/value/extrinsic_value/kernel/read*
T0*E
_class;
97loc:@target_network/critic/value/extrinsic_value/kernel*
use_locking(*
validate_shape(
�
	Assign_37Assign0target_network/critic/value/extrinsic_value/bias&critic/value/extrinsic_value/bias/read*
T0*C
_class9
75loc:@target_network/critic/value/extrinsic_value/bias*
use_locking(*
validate_shape(
8
gradients/ShapeConst*
dtype0*
valueB 
@
gradients/grad_ys_0Const*
dtype0*
valueB
 *  �?
W
gradients/FillFillgradients/Shapegradients/grad_ys_0*
T0*

index_type0
Q
#gradients/Mean_6_grad/Reshape/shapeConst*
dtype0*
valueB:
t
gradients/Mean_6_grad/ReshapeReshapegradients/Fill#gradients/Mean_6_grad/Reshape/shape*
T0*
Tshape0
E
gradients/Mean_6_grad/ShapeShapemul_12*
T0*
out_type0
y
gradients/Mean_6_grad/TileTilegradients/Mean_6_grad/Reshapegradients/Mean_6_grad/Shape*
T0*

Tmultiples0
G
gradients/Mean_6_grad/Shape_1Shapemul_12*
T0*
out_type0
F
gradients/Mean_6_grad/Shape_2Const*
dtype0*
valueB 
I
gradients/Mean_6_grad/ConstConst*
dtype0*
valueB: 
�
gradients/Mean_6_grad/ProdProdgradients/Mean_6_grad/Shape_1gradients/Mean_6_grad/Const*
T0*

Tidx0*
	keep_dims( 
K
gradients/Mean_6_grad/Const_1Const*
dtype0*
valueB: 
�
gradients/Mean_6_grad/Prod_1Prodgradients/Mean_6_grad/Shape_2gradients/Mean_6_grad/Const_1*
T0*

Tidx0*
	keep_dims( 
I
gradients/Mean_6_grad/Maximum/yConst*
dtype0*
value	B :
p
gradients/Mean_6_grad/MaximumMaximumgradients/Mean_6_grad/Prod_1gradients/Mean_6_grad/Maximum/y*
T0
n
gradients/Mean_6_grad/floordivFloorDivgradients/Mean_6_grad/Prodgradients/Mean_6_grad/Maximum*
T0
j
gradients/Mean_6_grad/CastCastgradients/Mean_6_grad/floordiv*

DstT0*

SrcT0*
Truncate( 
i
gradients/Mean_6_grad/truedivRealDivgradients/Mean_6_grad/Tilegradients/Mean_6_grad/Cast*
T0
H
gradients/mul_12_grad/ShapeShape	ToFloat_3*
T0*
out_type0
G
gradients/mul_12_grad/Shape_1ShapeMean_5*
T0*
out_type0
�
+gradients/mul_12_grad/BroadcastGradientArgsBroadcastGradientArgsgradients/mul_12_grad/Shapegradients/mul_12_grad/Shape_1*
T0
P
gradients/mul_12_grad/MulMulgradients/Mean_6_grad/truedivMean_5*
T0
�
gradients/mul_12_grad/SumSumgradients/mul_12_grad/Mul+gradients/mul_12_grad/BroadcastGradientArgs*
T0*

Tidx0*
	keep_dims( 
w
gradients/mul_12_grad/ReshapeReshapegradients/mul_12_grad/Sumgradients/mul_12_grad/Shape*
T0*
Tshape0
U
gradients/mul_12_grad/Mul_1Mul	ToFloat_3gradients/Mean_6_grad/truediv*
T0
�
gradients/mul_12_grad/Sum_1Sumgradients/mul_12_grad/Mul_1-gradients/mul_12_grad/BroadcastGradientArgs:1*
T0*

Tidx0*
	keep_dims( 
}
gradients/mul_12_grad/Reshape_1Reshapegradients/mul_12_grad/Sum_1gradients/mul_12_grad/Shape_1*
T0*
Tshape0
p
&gradients/mul_12_grad/tuple/group_depsNoOp^gradients/mul_12_grad/Reshape ^gradients/mul_12_grad/Reshape_1
�
.gradients/mul_12_grad/tuple/control_dependencyIdentitygradients/mul_12_grad/Reshape'^gradients/mul_12_grad/tuple/group_deps*
T0*0
_class&
$"loc:@gradients/mul_12_grad/Reshape
�
0gradients/mul_12_grad/tuple/control_dependency_1Identitygradients/mul_12_grad/Reshape_1'^gradients/mul_12_grad/tuple/group_deps*
T0*2
_class(
&$loc:@gradients/mul_12_grad/Reshape_1
D
gradients/Mean_5_grad/ShapeShapesub_4*
T0*
out_type0
t
gradients/Mean_5_grad/SizeConst*.
_class$
" loc:@gradients/Mean_5_grad/Shape*
dtype0*
value	B :
�
gradients/Mean_5_grad/addAddV2Mean_5/reduction_indicesgradients/Mean_5_grad/Size*
T0*.
_class$
" loc:@gradients/Mean_5_grad/Shape
�
gradients/Mean_5_grad/modFloorModgradients/Mean_5_grad/addgradients/Mean_5_grad/Size*
T0*.
_class$
" loc:@gradients/Mean_5_grad/Shape
v
gradients/Mean_5_grad/Shape_1Const*.
_class$
" loc:@gradients/Mean_5_grad/Shape*
dtype0*
valueB 
{
!gradients/Mean_5_grad/range/startConst*.
_class$
" loc:@gradients/Mean_5_grad/Shape*
dtype0*
value	B : 
{
!gradients/Mean_5_grad/range/deltaConst*.
_class$
" loc:@gradients/Mean_5_grad/Shape*
dtype0*
value	B :
�
gradients/Mean_5_grad/rangeRange!gradients/Mean_5_grad/range/startgradients/Mean_5_grad/Size!gradients/Mean_5_grad/range/delta*

Tidx0*.
_class$
" loc:@gradients/Mean_5_grad/Shape
z
 gradients/Mean_5_grad/Fill/valueConst*.
_class$
" loc:@gradients/Mean_5_grad/Shape*
dtype0*
value	B :
�
gradients/Mean_5_grad/FillFillgradients/Mean_5_grad/Shape_1 gradients/Mean_5_grad/Fill/value*
T0*.
_class$
" loc:@gradients/Mean_5_grad/Shape*

index_type0
�
#gradients/Mean_5_grad/DynamicStitchDynamicStitchgradients/Mean_5_grad/rangegradients/Mean_5_grad/modgradients/Mean_5_grad/Shapegradients/Mean_5_grad/Fill*
N*
T0*.
_class$
" loc:@gradients/Mean_5_grad/Shape
�
gradients/Mean_5_grad/ReshapeReshape0gradients/mul_12_grad/tuple/control_dependency_1#gradients/Mean_5_grad/DynamicStitch*
T0*
Tshape0
�
!gradients/Mean_5_grad/BroadcastToBroadcastTogradients/Mean_5_grad/Reshapegradients/Mean_5_grad/Shape*
T0*

Tidx0
F
gradients/Mean_5_grad/Shape_2Shapesub_4*
T0*
out_type0
G
gradients/Mean_5_grad/Shape_3ShapeMean_5*
T0*
out_type0
I
gradients/Mean_5_grad/ConstConst*
dtype0*
valueB: 
�
gradients/Mean_5_grad/ProdProdgradients/Mean_5_grad/Shape_2gradients/Mean_5_grad/Const*
T0*

Tidx0*
	keep_dims( 
K
gradients/Mean_5_grad/Const_1Const*
dtype0*
valueB: 
�
gradients/Mean_5_grad/Prod_1Prodgradients/Mean_5_grad/Shape_3gradients/Mean_5_grad/Const_1*
T0*

Tidx0*
	keep_dims( 
I
gradients/Mean_5_grad/Maximum/yConst*
dtype0*
value	B :
p
gradients/Mean_5_grad/MaximumMaximumgradients/Mean_5_grad/Prod_1gradients/Mean_5_grad/Maximum/y*
T0
n
gradients/Mean_5_grad/floordivFloorDivgradients/Mean_5_grad/Prodgradients/Mean_5_grad/Maximum*
T0
j
gradients/Mean_5_grad/CastCastgradients/Mean_5_grad/floordiv*

DstT0*

SrcT0*
Truncate( 
p
gradients/Mean_5_grad/truedivRealDiv!gradients/Mean_5_grad/BroadcastTogradients/Mean_5_grad/Cast*
T0
D
gradients/sub_4_grad/ShapeShapemul_11*
T0*
out_type0
[
gradients/sub_4_grad/Shape_1Shapecritic/q/q1_encoding_1/Mean*
T0*
out_type0
�
*gradients/sub_4_grad/BroadcastGradientArgsBroadcastGradientArgsgradients/sub_4_grad/Shapegradients/sub_4_grad/Shape_1*
T0
�
gradients/sub_4_grad/SumSumgradients/Mean_5_grad/truediv*gradients/sub_4_grad/BroadcastGradientArgs*
T0*

Tidx0*
	keep_dims( 
t
gradients/sub_4_grad/ReshapeReshapegradients/sub_4_grad/Sumgradients/sub_4_grad/Shape*
T0*
Tshape0
G
gradients/sub_4_grad/NegNeggradients/Mean_5_grad/truediv*
T0
�
gradients/sub_4_grad/Sum_1Sumgradients/sub_4_grad/Neg,gradients/sub_4_grad/BroadcastGradientArgs:1*
T0*

Tidx0*
	keep_dims( 
z
gradients/sub_4_grad/Reshape_1Reshapegradients/sub_4_grad/Sum_1gradients/sub_4_grad/Shape_1*
T0*
Tshape0
m
%gradients/sub_4_grad/tuple/group_depsNoOp^gradients/sub_4_grad/Reshape^gradients/sub_4_grad/Reshape_1
�
-gradients/sub_4_grad/tuple/control_dependencyIdentitygradients/sub_4_grad/Reshape&^gradients/sub_4_grad/tuple/group_deps*
T0*/
_class%
#!loc:@gradients/sub_4_grad/Reshape
�
/gradients/sub_4_grad/tuple/control_dependency_1Identitygradients/sub_4_grad/Reshape_1&^gradients/sub_4_grad/tuple/group_deps*
T0*1
_class'
%#loc:@gradients/sub_4_grad/Reshape_1
B
gradients/mul_11_grad/ShapeShapeExp*
T0*
out_type0
M
gradients/mul_11_grad/Shape_1Shapeaction_probs*
T0*
out_type0
�
+gradients/mul_11_grad/BroadcastGradientArgsBroadcastGradientArgsgradients/mul_11_grad/Shapegradients/mul_11_grad/Shape_1*
T0
f
gradients/mul_11_grad/MulMul-gradients/sub_4_grad/tuple/control_dependencyaction_probs*
T0
�
gradients/mul_11_grad/SumSumgradients/mul_11_grad/Mul+gradients/mul_11_grad/BroadcastGradientArgs*
T0*

Tidx0*
	keep_dims( 
w
gradients/mul_11_grad/ReshapeReshapegradients/mul_11_grad/Sumgradients/mul_11_grad/Shape*
T0*
Tshape0
_
gradients/mul_11_grad/Mul_1MulExp-gradients/sub_4_grad/tuple/control_dependency*
T0
�
gradients/mul_11_grad/Sum_1Sumgradients/mul_11_grad/Mul_1-gradients/mul_11_grad/BroadcastGradientArgs:1*
T0*

Tidx0*
	keep_dims( 
}
gradients/mul_11_grad/Reshape_1Reshapegradients/mul_11_grad/Sum_1gradients/mul_11_grad/Shape_1*
T0*
Tshape0
p
&gradients/mul_11_grad/tuple/group_depsNoOp^gradients/mul_11_grad/Reshape ^gradients/mul_11_grad/Reshape_1
�
.gradients/mul_11_grad/tuple/control_dependencyIdentitygradients/mul_11_grad/Reshape'^gradients/mul_11_grad/tuple/group_deps*
T0*0
_class&
$"loc:@gradients/mul_11_grad/Reshape
�
0gradients/mul_11_grad/tuple/control_dependency_1Identitygradients/mul_11_grad/Reshape_1'^gradients/mul_11_grad/tuple/group_deps*
T0*2
_class(
&$loc:@gradients/mul_11_grad/Reshape_1
u
0gradients/critic/q/q1_encoding_1/Mean_grad/ShapeShape!critic/q/q1_encoding_1/Mean/input*
T0*
out_type0
�
/gradients/critic/q/q1_encoding_1/Mean_grad/SizeConst*C
_class9
75loc:@gradients/critic/q/q1_encoding_1/Mean_grad/Shape*
dtype0*
value	B :
�
.gradients/critic/q/q1_encoding_1/Mean_grad/addAddV2-critic/q/q1_encoding_1/Mean/reduction_indices/gradients/critic/q/q1_encoding_1/Mean_grad/Size*
T0*C
_class9
75loc:@gradients/critic/q/q1_encoding_1/Mean_grad/Shape
�
.gradients/critic/q/q1_encoding_1/Mean_grad/modFloorMod.gradients/critic/q/q1_encoding_1/Mean_grad/add/gradients/critic/q/q1_encoding_1/Mean_grad/Size*
T0*C
_class9
75loc:@gradients/critic/q/q1_encoding_1/Mean_grad/Shape
�
2gradients/critic/q/q1_encoding_1/Mean_grad/Shape_1Const*C
_class9
75loc:@gradients/critic/q/q1_encoding_1/Mean_grad/Shape*
dtype0*
valueB 
�
6gradients/critic/q/q1_encoding_1/Mean_grad/range/startConst*C
_class9
75loc:@gradients/critic/q/q1_encoding_1/Mean_grad/Shape*
dtype0*
value	B : 
�
6gradients/critic/q/q1_encoding_1/Mean_grad/range/deltaConst*C
_class9
75loc:@gradients/critic/q/q1_encoding_1/Mean_grad/Shape*
dtype0*
value	B :
�
0gradients/critic/q/q1_encoding_1/Mean_grad/rangeRange6gradients/critic/q/q1_encoding_1/Mean_grad/range/start/gradients/critic/q/q1_encoding_1/Mean_grad/Size6gradients/critic/q/q1_encoding_1/Mean_grad/range/delta*

Tidx0*C
_class9
75loc:@gradients/critic/q/q1_encoding_1/Mean_grad/Shape
�
5gradients/critic/q/q1_encoding_1/Mean_grad/Fill/valueConst*C
_class9
75loc:@gradients/critic/q/q1_encoding_1/Mean_grad/Shape*
dtype0*
value	B :
�
/gradients/critic/q/q1_encoding_1/Mean_grad/FillFill2gradients/critic/q/q1_encoding_1/Mean_grad/Shape_15gradients/critic/q/q1_encoding_1/Mean_grad/Fill/value*
T0*C
_class9
75loc:@gradients/critic/q/q1_encoding_1/Mean_grad/Shape*

index_type0
�
8gradients/critic/q/q1_encoding_1/Mean_grad/DynamicStitchDynamicStitch0gradients/critic/q/q1_encoding_1/Mean_grad/range.gradients/critic/q/q1_encoding_1/Mean_grad/mod0gradients/critic/q/q1_encoding_1/Mean_grad/Shape/gradients/critic/q/q1_encoding_1/Mean_grad/Fill*
N*
T0*C
_class9
75loc:@gradients/critic/q/q1_encoding_1/Mean_grad/Shape
�
2gradients/critic/q/q1_encoding_1/Mean_grad/ReshapeReshape/gradients/sub_4_grad/tuple/control_dependency_18gradients/critic/q/q1_encoding_1/Mean_grad/DynamicStitch*
T0*
Tshape0
�
6gradients/critic/q/q1_encoding_1/Mean_grad/BroadcastToBroadcastTo2gradients/critic/q/q1_encoding_1/Mean_grad/Reshape0gradients/critic/q/q1_encoding_1/Mean_grad/Shape*
T0*

Tidx0
w
2gradients/critic/q/q1_encoding_1/Mean_grad/Shape_2Shape!critic/q/q1_encoding_1/Mean/input*
T0*
out_type0
q
2gradients/critic/q/q1_encoding_1/Mean_grad/Shape_3Shapecritic/q/q1_encoding_1/Mean*
T0*
out_type0
^
0gradients/critic/q/q1_encoding_1/Mean_grad/ConstConst*
dtype0*
valueB: 
�
/gradients/critic/q/q1_encoding_1/Mean_grad/ProdProd2gradients/critic/q/q1_encoding_1/Mean_grad/Shape_20gradients/critic/q/q1_encoding_1/Mean_grad/Const*
T0*

Tidx0*
	keep_dims( 
`
2gradients/critic/q/q1_encoding_1/Mean_grad/Const_1Const*
dtype0*
valueB: 
�
1gradients/critic/q/q1_encoding_1/Mean_grad/Prod_1Prod2gradients/critic/q/q1_encoding_1/Mean_grad/Shape_32gradients/critic/q/q1_encoding_1/Mean_grad/Const_1*
T0*

Tidx0*
	keep_dims( 
^
4gradients/critic/q/q1_encoding_1/Mean_grad/Maximum/yConst*
dtype0*
value	B :
�
2gradients/critic/q/q1_encoding_1/Mean_grad/MaximumMaximum1gradients/critic/q/q1_encoding_1/Mean_grad/Prod_14gradients/critic/q/q1_encoding_1/Mean_grad/Maximum/y*
T0
�
3gradients/critic/q/q1_encoding_1/Mean_grad/floordivFloorDiv/gradients/critic/q/q1_encoding_1/Mean_grad/Prod2gradients/critic/q/q1_encoding_1/Mean_grad/Maximum*
T0
�
/gradients/critic/q/q1_encoding_1/Mean_grad/CastCast3gradients/critic/q/q1_encoding_1/Mean_grad/floordiv*

DstT0*

SrcT0*
Truncate( 
�
2gradients/critic/q/q1_encoding_1/Mean_grad/truedivRealDiv6gradients/critic/q/q1_encoding_1/Mean_grad/BroadcastTo/gradients/critic/q/q1_encoding_1/Mean_grad/Cast*
T0
�
8gradients/critic/q/q1_encoding_1/Mean/input_grad/unstackUnpack2gradients/critic/q/q1_encoding_1/Mean_grad/truediv*
T0*

axis *	
num
U
#gradients/policy_1/sub_2_grad/ShapeShapepolicy_1/mul_2*
T0*
out_type0
U
%gradients/policy_1/sub_2_grad/Shape_1Shapepolicy_1/Log*
T0*
out_type0
�
3gradients/policy_1/sub_2_grad/BroadcastGradientArgsBroadcastGradientArgs#gradients/policy_1/sub_2_grad/Shape%gradients/policy_1/sub_2_grad/Shape_1*
T0
�
!gradients/policy_1/sub_2_grad/SumSum0gradients/mul_11_grad/tuple/control_dependency_13gradients/policy_1/sub_2_grad/BroadcastGradientArgs*
T0*

Tidx0*
	keep_dims( 
�
%gradients/policy_1/sub_2_grad/ReshapeReshape!gradients/policy_1/sub_2_grad/Sum#gradients/policy_1/sub_2_grad/Shape*
T0*
Tshape0
c
!gradients/policy_1/sub_2_grad/NegNeg0gradients/mul_11_grad/tuple/control_dependency_1*
T0
�
#gradients/policy_1/sub_2_grad/Sum_1Sum!gradients/policy_1/sub_2_grad/Neg5gradients/policy_1/sub_2_grad/BroadcastGradientArgs:1*
T0*

Tidx0*
	keep_dims( 
�
'gradients/policy_1/sub_2_grad/Reshape_1Reshape#gradients/policy_1/sub_2_grad/Sum_1%gradients/policy_1/sub_2_grad/Shape_1*
T0*
Tshape0
�
.gradients/policy_1/sub_2_grad/tuple/group_depsNoOp&^gradients/policy_1/sub_2_grad/Reshape(^gradients/policy_1/sub_2_grad/Reshape_1
�
6gradients/policy_1/sub_2_grad/tuple/control_dependencyIdentity%gradients/policy_1/sub_2_grad/Reshape/^gradients/policy_1/sub_2_grad/tuple/group_deps*
T0*8
_class.
,*loc:@gradients/policy_1/sub_2_grad/Reshape
�
8gradients/policy_1/sub_2_grad/tuple/control_dependency_1Identity'gradients/policy_1/sub_2_grad/Reshape_1/^gradients/policy_1/sub_2_grad/tuple/group_deps*
T0*:
_class0
.,loc:@gradients/policy_1/sub_2_grad/Reshape_1
�
Fgradients/critic/q/q1_encoding_1/extrinsic_q1/BiasAdd_grad/BiasAddGradBiasAddGrad8gradients/critic/q/q1_encoding_1/Mean/input_grad/unstack*
T0*
data_formatNHWC
�
Kgradients/critic/q/q1_encoding_1/extrinsic_q1/BiasAdd_grad/tuple/group_depsNoOp9^gradients/critic/q/q1_encoding_1/Mean/input_grad/unstackG^gradients/critic/q/q1_encoding_1/extrinsic_q1/BiasAdd_grad/BiasAddGrad
�
Sgradients/critic/q/q1_encoding_1/extrinsic_q1/BiasAdd_grad/tuple/control_dependencyIdentity8gradients/critic/q/q1_encoding_1/Mean/input_grad/unstackL^gradients/critic/q/q1_encoding_1/extrinsic_q1/BiasAdd_grad/tuple/group_deps*
T0*K
_classA
?=loc:@gradients/critic/q/q1_encoding_1/Mean/input_grad/unstack
�
Ugradients/critic/q/q1_encoding_1/extrinsic_q1/BiasAdd_grad/tuple/control_dependency_1IdentityFgradients/critic/q/q1_encoding_1/extrinsic_q1/BiasAdd_grad/BiasAddGradL^gradients/critic/q/q1_encoding_1/extrinsic_q1/BiasAdd_grad/tuple/group_deps*
T0*Y
_classO
MKloc:@gradients/critic/q/q1_encoding_1/extrinsic_q1/BiasAdd_grad/BiasAddGrad
W
#gradients/policy_1/mul_2_grad/ShapeShapepolicy_1/mul_2/x*
T0*
out_type0
W
%gradients/policy_1/mul_2_grad/Shape_1Shapepolicy_1/add_3*
T0*
out_type0
�
3gradients/policy_1/mul_2_grad/BroadcastGradientArgsBroadcastGradientArgs#gradients/policy_1/mul_2_grad/Shape%gradients/policy_1/mul_2_grad/Shape_1*
T0
y
!gradients/policy_1/mul_2_grad/MulMul6gradients/policy_1/sub_2_grad/tuple/control_dependencypolicy_1/add_3*
T0
�
!gradients/policy_1/mul_2_grad/SumSum!gradients/policy_1/mul_2_grad/Mul3gradients/policy_1/mul_2_grad/BroadcastGradientArgs*
T0*

Tidx0*
	keep_dims( 
�
%gradients/policy_1/mul_2_grad/ReshapeReshape!gradients/policy_1/mul_2_grad/Sum#gradients/policy_1/mul_2_grad/Shape*
T0*
Tshape0
}
#gradients/policy_1/mul_2_grad/Mul_1Mulpolicy_1/mul_2/x6gradients/policy_1/sub_2_grad/tuple/control_dependency*
T0
�
#gradients/policy_1/mul_2_grad/Sum_1Sum#gradients/policy_1/mul_2_grad/Mul_15gradients/policy_1/mul_2_grad/BroadcastGradientArgs:1*
T0*

Tidx0*
	keep_dims( 
�
'gradients/policy_1/mul_2_grad/Reshape_1Reshape#gradients/policy_1/mul_2_grad/Sum_1%gradients/policy_1/mul_2_grad/Shape_1*
T0*
Tshape0
�
.gradients/policy_1/mul_2_grad/tuple/group_depsNoOp&^gradients/policy_1/mul_2_grad/Reshape(^gradients/policy_1/mul_2_grad/Reshape_1
�
6gradients/policy_1/mul_2_grad/tuple/control_dependencyIdentity%gradients/policy_1/mul_2_grad/Reshape/^gradients/policy_1/mul_2_grad/tuple/group_deps*
T0*8
_class.
,*loc:@gradients/policy_1/mul_2_grad/Reshape
�
8gradients/policy_1/mul_2_grad/tuple/control_dependency_1Identity'gradients/policy_1/mul_2_grad/Reshape_1/^gradients/policy_1/mul_2_grad/tuple/group_deps*
T0*:
_class0
.,loc:@gradients/policy_1/mul_2_grad/Reshape_1
�
&gradients/policy_1/Log_grad/Reciprocal
Reciprocalpolicy_1/add_49^gradients/policy_1/sub_2_grad/tuple/control_dependency_1*
T0
�
gradients/policy_1/Log_grad/mulMul8gradients/policy_1/sub_2_grad/tuple/control_dependency_1&gradients/policy_1/Log_grad/Reciprocal*
T0
�
@gradients/critic/q/q1_encoding_1/extrinsic_q1/MatMul_grad/MatMulMatMulSgradients/critic/q/q1_encoding_1/extrinsic_q1/BiasAdd_grad/tuple/control_dependency-critic/q/q1_encoding/extrinsic_q1/kernel/read*
T0*
transpose_a( *
transpose_b(
�
Bgradients/critic/q/q1_encoding_1/extrinsic_q1/MatMul_grad/MatMul_1MatMul.critic/q/q1_encoding_1/q1_encoder/hidden_1/MulSgradients/critic/q/q1_encoding_1/extrinsic_q1/BiasAdd_grad/tuple/control_dependency*
T0*
transpose_a(*
transpose_b( 
�
Jgradients/critic/q/q1_encoding_1/extrinsic_q1/MatMul_grad/tuple/group_depsNoOpA^gradients/critic/q/q1_encoding_1/extrinsic_q1/MatMul_grad/MatMulC^gradients/critic/q/q1_encoding_1/extrinsic_q1/MatMul_grad/MatMul_1
�
Rgradients/critic/q/q1_encoding_1/extrinsic_q1/MatMul_grad/tuple/control_dependencyIdentity@gradients/critic/q/q1_encoding_1/extrinsic_q1/MatMul_grad/MatMulK^gradients/critic/q/q1_encoding_1/extrinsic_q1/MatMul_grad/tuple/group_deps*
T0*S
_classI
GEloc:@gradients/critic/q/q1_encoding_1/extrinsic_q1/MatMul_grad/MatMul
�
Tgradients/critic/q/q1_encoding_1/extrinsic_q1/MatMul_grad/tuple/control_dependency_1IdentityBgradients/critic/q/q1_encoding_1/extrinsic_q1/MatMul_grad/MatMul_1K^gradients/critic/q/q1_encoding_1/extrinsic_q1/MatMul_grad/tuple/group_deps*
T0*U
_classK
IGloc:@gradients/critic/q/q1_encoding_1/extrinsic_q1/MatMul_grad/MatMul_1
U
#gradients/policy_1/add_3_grad/ShapeShapepolicy_1/add_2*
T0*
out_type0
Y
%gradients/policy_1/add_3_grad/Shape_1Shapepolicy_1/add_3/y*
T0*
out_type0
�
3gradients/policy_1/add_3_grad/BroadcastGradientArgsBroadcastGradientArgs#gradients/policy_1/add_3_grad/Shape%gradients/policy_1/add_3_grad/Shape_1*
T0
�
!gradients/policy_1/add_3_grad/SumSum8gradients/policy_1/mul_2_grad/tuple/control_dependency_13gradients/policy_1/add_3_grad/BroadcastGradientArgs*
T0*

Tidx0*
	keep_dims( 
�
%gradients/policy_1/add_3_grad/ReshapeReshape!gradients/policy_1/add_3_grad/Sum#gradients/policy_1/add_3_grad/Shape*
T0*
Tshape0
�
#gradients/policy_1/add_3_grad/Sum_1Sum8gradients/policy_1/mul_2_grad/tuple/control_dependency_15gradients/policy_1/add_3_grad/BroadcastGradientArgs:1*
T0*

Tidx0*
	keep_dims( 
�
'gradients/policy_1/add_3_grad/Reshape_1Reshape#gradients/policy_1/add_3_grad/Sum_1%gradients/policy_1/add_3_grad/Shape_1*
T0*
Tshape0
�
.gradients/policy_1/add_3_grad/tuple/group_depsNoOp&^gradients/policy_1/add_3_grad/Reshape(^gradients/policy_1/add_3_grad/Reshape_1
�
6gradients/policy_1/add_3_grad/tuple/control_dependencyIdentity%gradients/policy_1/add_3_grad/Reshape/^gradients/policy_1/add_3_grad/tuple/group_deps*
T0*8
_class.
,*loc:@gradients/policy_1/add_3_grad/Reshape
�
8gradients/policy_1/add_3_grad/tuple/control_dependency_1Identity'gradients/policy_1/add_3_grad/Reshape_1/^gradients/policy_1/add_3_grad/tuple/group_deps*
T0*:
_class0
.,loc:@gradients/policy_1/add_3_grad/Reshape_1
U
#gradients/policy_1/add_4_grad/ShapeShapepolicy_1/sub_1*
T0*
out_type0
Y
%gradients/policy_1/add_4_grad/Shape_1Shapepolicy_1/add_4/y*
T0*
out_type0
�
3gradients/policy_1/add_4_grad/BroadcastGradientArgsBroadcastGradientArgs#gradients/policy_1/add_4_grad/Shape%gradients/policy_1/add_4_grad/Shape_1*
T0
�
!gradients/policy_1/add_4_grad/SumSumgradients/policy_1/Log_grad/mul3gradients/policy_1/add_4_grad/BroadcastGradientArgs*
T0*

Tidx0*
	keep_dims( 
�
%gradients/policy_1/add_4_grad/ReshapeReshape!gradients/policy_1/add_4_grad/Sum#gradients/policy_1/add_4_grad/Shape*
T0*
Tshape0
�
#gradients/policy_1/add_4_grad/Sum_1Sumgradients/policy_1/Log_grad/mul5gradients/policy_1/add_4_grad/BroadcastGradientArgs:1*
T0*

Tidx0*
	keep_dims( 
�
'gradients/policy_1/add_4_grad/Reshape_1Reshape#gradients/policy_1/add_4_grad/Sum_1%gradients/policy_1/add_4_grad/Shape_1*
T0*
Tshape0
�
.gradients/policy_1/add_4_grad/tuple/group_depsNoOp&^gradients/policy_1/add_4_grad/Reshape(^gradients/policy_1/add_4_grad/Reshape_1
�
6gradients/policy_1/add_4_grad/tuple/control_dependencyIdentity%gradients/policy_1/add_4_grad/Reshape/^gradients/policy_1/add_4_grad/tuple/group_deps*
T0*8
_class.
,*loc:@gradients/policy_1/add_4_grad/Reshape
�
8gradients/policy_1/add_4_grad/tuple/control_dependency_1Identity'gradients/policy_1/add_4_grad/Reshape_1/^gradients/policy_1/add_4_grad/tuple/group_deps*
T0*:
_class0
.,loc:@gradients/policy_1/add_4_grad/Reshape_1
�
Cgradients/critic/q/q1_encoding_1/q1_encoder/hidden_1/Mul_grad/ShapeShape2critic/q/q1_encoding_1/q1_encoder/hidden_1/BiasAdd*
T0*
out_type0
�
Egradients/critic/q/q1_encoding_1/q1_encoder/hidden_1/Mul_grad/Shape_1Shape2critic/q/q1_encoding_1/q1_encoder/hidden_1/Sigmoid*
T0*
out_type0
�
Sgradients/critic/q/q1_encoding_1/q1_encoder/hidden_1/Mul_grad/BroadcastGradientArgsBroadcastGradientArgsCgradients/critic/q/q1_encoding_1/q1_encoder/hidden_1/Mul_grad/ShapeEgradients/critic/q/q1_encoding_1/q1_encoder/hidden_1/Mul_grad/Shape_1*
T0
�
Agradients/critic/q/q1_encoding_1/q1_encoder/hidden_1/Mul_grad/MulMulRgradients/critic/q/q1_encoding_1/extrinsic_q1/MatMul_grad/tuple/control_dependency2critic/q/q1_encoding_1/q1_encoder/hidden_1/Sigmoid*
T0
�
Agradients/critic/q/q1_encoding_1/q1_encoder/hidden_1/Mul_grad/SumSumAgradients/critic/q/q1_encoding_1/q1_encoder/hidden_1/Mul_grad/MulSgradients/critic/q/q1_encoding_1/q1_encoder/hidden_1/Mul_grad/BroadcastGradientArgs*
T0*

Tidx0*
	keep_dims( 
�
Egradients/critic/q/q1_encoding_1/q1_encoder/hidden_1/Mul_grad/ReshapeReshapeAgradients/critic/q/q1_encoding_1/q1_encoder/hidden_1/Mul_grad/SumCgradients/critic/q/q1_encoding_1/q1_encoder/hidden_1/Mul_grad/Shape*
T0*
Tshape0
�
Cgradients/critic/q/q1_encoding_1/q1_encoder/hidden_1/Mul_grad/Mul_1Mul2critic/q/q1_encoding_1/q1_encoder/hidden_1/BiasAddRgradients/critic/q/q1_encoding_1/extrinsic_q1/MatMul_grad/tuple/control_dependency*
T0
�
Cgradients/critic/q/q1_encoding_1/q1_encoder/hidden_1/Mul_grad/Sum_1SumCgradients/critic/q/q1_encoding_1/q1_encoder/hidden_1/Mul_grad/Mul_1Ugradients/critic/q/q1_encoding_1/q1_encoder/hidden_1/Mul_grad/BroadcastGradientArgs:1*
T0*

Tidx0*
	keep_dims( 
�
Ggradients/critic/q/q1_encoding_1/q1_encoder/hidden_1/Mul_grad/Reshape_1ReshapeCgradients/critic/q/q1_encoding_1/q1_encoder/hidden_1/Mul_grad/Sum_1Egradients/critic/q/q1_encoding_1/q1_encoder/hidden_1/Mul_grad/Shape_1*
T0*
Tshape0
�
Ngradients/critic/q/q1_encoding_1/q1_encoder/hidden_1/Mul_grad/tuple/group_depsNoOpF^gradients/critic/q/q1_encoding_1/q1_encoder/hidden_1/Mul_grad/ReshapeH^gradients/critic/q/q1_encoding_1/q1_encoder/hidden_1/Mul_grad/Reshape_1
�
Vgradients/critic/q/q1_encoding_1/q1_encoder/hidden_1/Mul_grad/tuple/control_dependencyIdentityEgradients/critic/q/q1_encoding_1/q1_encoder/hidden_1/Mul_grad/ReshapeO^gradients/critic/q/q1_encoding_1/q1_encoder/hidden_1/Mul_grad/tuple/group_deps*
T0*X
_classN
LJloc:@gradients/critic/q/q1_encoding_1/q1_encoder/hidden_1/Mul_grad/Reshape
�
Xgradients/critic/q/q1_encoding_1/q1_encoder/hidden_1/Mul_grad/tuple/control_dependency_1IdentityGgradients/critic/q/q1_encoding_1/q1_encoder/hidden_1/Mul_grad/Reshape_1O^gradients/critic/q/q1_encoding_1/q1_encoder/hidden_1/Mul_grad/tuple/group_deps*
T0*Z
_classP
NLloc:@gradients/critic/q/q1_encoding_1/q1_encoder/hidden_1/Mul_grad/Reshape_1
S
#gradients/policy_1/add_2_grad/ShapeShapepolicy_1/pow*
T0*
out_type0
W
%gradients/policy_1/add_2_grad/Shape_1Shapepolicy_1/mul_1*
T0*
out_type0
�
3gradients/policy_1/add_2_grad/BroadcastGradientArgsBroadcastGradientArgs#gradients/policy_1/add_2_grad/Shape%gradients/policy_1/add_2_grad/Shape_1*
T0
�
!gradients/policy_1/add_2_grad/SumSum6gradients/policy_1/add_3_grad/tuple/control_dependency3gradients/policy_1/add_2_grad/BroadcastGradientArgs*
T0*

Tidx0*
	keep_dims( 
�
%gradients/policy_1/add_2_grad/ReshapeReshape!gradients/policy_1/add_2_grad/Sum#gradients/policy_1/add_2_grad/Shape*
T0*
Tshape0
�
#gradients/policy_1/add_2_grad/Sum_1Sum6gradients/policy_1/add_3_grad/tuple/control_dependency5gradients/policy_1/add_2_grad/BroadcastGradientArgs:1*
T0*

Tidx0*
	keep_dims( 
�
'gradients/policy_1/add_2_grad/Reshape_1Reshape#gradients/policy_1/add_2_grad/Sum_1%gradients/policy_1/add_2_grad/Shape_1*
T0*
Tshape0
�
.gradients/policy_1/add_2_grad/tuple/group_depsNoOp&^gradients/policy_1/add_2_grad/Reshape(^gradients/policy_1/add_2_grad/Reshape_1
�
6gradients/policy_1/add_2_grad/tuple/control_dependencyIdentity%gradients/policy_1/add_2_grad/Reshape/^gradients/policy_1/add_2_grad/tuple/group_deps*
T0*8
_class.
,*loc:@gradients/policy_1/add_2_grad/Reshape
�
8gradients/policy_1/add_2_grad/tuple/control_dependency_1Identity'gradients/policy_1/add_2_grad/Reshape_1/^gradients/policy_1/add_2_grad/tuple/group_deps*
T0*:
_class0
.,loc:@gradients/policy_1/add_2_grad/Reshape_1
W
#gradients/policy_1/sub_1_grad/ShapeShapepolicy_1/sub_1/x*
T0*
out_type0
W
%gradients/policy_1/sub_1_grad/Shape_1Shapepolicy_1/pow_1*
T0*
out_type0
�
3gradients/policy_1/sub_1_grad/BroadcastGradientArgsBroadcastGradientArgs#gradients/policy_1/sub_1_grad/Shape%gradients/policy_1/sub_1_grad/Shape_1*
T0
�
!gradients/policy_1/sub_1_grad/SumSum6gradients/policy_1/add_4_grad/tuple/control_dependency3gradients/policy_1/sub_1_grad/BroadcastGradientArgs*
T0*

Tidx0*
	keep_dims( 
�
%gradients/policy_1/sub_1_grad/ReshapeReshape!gradients/policy_1/sub_1_grad/Sum#gradients/policy_1/sub_1_grad/Shape*
T0*
Tshape0
i
!gradients/policy_1/sub_1_grad/NegNeg6gradients/policy_1/add_4_grad/tuple/control_dependency*
T0
�
#gradients/policy_1/sub_1_grad/Sum_1Sum!gradients/policy_1/sub_1_grad/Neg5gradients/policy_1/sub_1_grad/BroadcastGradientArgs:1*
T0*

Tidx0*
	keep_dims( 
�
'gradients/policy_1/sub_1_grad/Reshape_1Reshape#gradients/policy_1/sub_1_grad/Sum_1%gradients/policy_1/sub_1_grad/Shape_1*
T0*
Tshape0
�
.gradients/policy_1/sub_1_grad/tuple/group_depsNoOp&^gradients/policy_1/sub_1_grad/Reshape(^gradients/policy_1/sub_1_grad/Reshape_1
�
6gradients/policy_1/sub_1_grad/tuple/control_dependencyIdentity%gradients/policy_1/sub_1_grad/Reshape/^gradients/policy_1/sub_1_grad/tuple/group_deps*
T0*8
_class.
,*loc:@gradients/policy_1/sub_1_grad/Reshape
�
8gradients/policy_1/sub_1_grad/tuple/control_dependency_1Identity'gradients/policy_1/sub_1_grad/Reshape_1/^gradients/policy_1/sub_1_grad/tuple/group_deps*
T0*:
_class0
.,loc:@gradients/policy_1/sub_1_grad/Reshape_1
�
Mgradients/critic/q/q1_encoding_1/q1_encoder/hidden_1/Sigmoid_grad/SigmoidGradSigmoidGrad2critic/q/q1_encoding_1/q1_encoder/hidden_1/SigmoidXgradients/critic/q/q1_encoding_1/q1_encoder/hidden_1/Mul_grad/tuple/control_dependency_1*
T0
U
!gradients/policy_1/pow_grad/ShapeShapepolicy_1/truediv*
T0*
out_type0
U
#gradients/policy_1/pow_grad/Shape_1Shapepolicy_1/pow/y*
T0*
out_type0
�
1gradients/policy_1/pow_grad/BroadcastGradientArgsBroadcastGradientArgs!gradients/policy_1/pow_grad/Shape#gradients/policy_1/pow_grad/Shape_1*
T0
w
gradients/policy_1/pow_grad/mulMul6gradients/policy_1/add_2_grad/tuple/control_dependencypolicy_1/pow/y*
T0
N
!gradients/policy_1/pow_grad/sub/yConst*
dtype0*
valueB
 *  �?
b
gradients/policy_1/pow_grad/subSubpolicy_1/pow/y!gradients/policy_1/pow_grad/sub/y*
T0
b
gradients/policy_1/pow_grad/PowPowpolicy_1/truedivgradients/policy_1/pow_grad/sub*
T0
s
!gradients/policy_1/pow_grad/mul_1Mulgradients/policy_1/pow_grad/mulgradients/policy_1/pow_grad/Pow*
T0
�
gradients/policy_1/pow_grad/SumSum!gradients/policy_1/pow_grad/mul_11gradients/policy_1/pow_grad/BroadcastGradientArgs*
T0*

Tidx0*
	keep_dims( 
�
#gradients/policy_1/pow_grad/ReshapeReshapegradients/policy_1/pow_grad/Sum!gradients/policy_1/pow_grad/Shape*
T0*
Tshape0
R
%gradients/policy_1/pow_grad/Greater/yConst*
dtype0*
valueB
 *    
p
#gradients/policy_1/pow_grad/GreaterGreaterpolicy_1/truediv%gradients/policy_1/pow_grad/Greater/y*
T0
_
+gradients/policy_1/pow_grad/ones_like/ShapeShapepolicy_1/truediv*
T0*
out_type0
X
+gradients/policy_1/pow_grad/ones_like/ConstConst*
dtype0*
valueB
 *  �?
�
%gradients/policy_1/pow_grad/ones_likeFill+gradients/policy_1/pow_grad/ones_like/Shape+gradients/policy_1/pow_grad/ones_like/Const*
T0*

index_type0
�
"gradients/policy_1/pow_grad/SelectSelect#gradients/policy_1/pow_grad/Greaterpolicy_1/truediv%gradients/policy_1/pow_grad/ones_like*
T0
S
gradients/policy_1/pow_grad/LogLog"gradients/policy_1/pow_grad/Select*
T0
N
&gradients/policy_1/pow_grad/zeros_like	ZerosLikepolicy_1/truediv*
T0
�
$gradients/policy_1/pow_grad/Select_1Select#gradients/policy_1/pow_grad/Greatergradients/policy_1/pow_grad/Log&gradients/policy_1/pow_grad/zeros_like*
T0
w
!gradients/policy_1/pow_grad/mul_2Mul6gradients/policy_1/add_2_grad/tuple/control_dependencypolicy_1/pow*
T0
z
!gradients/policy_1/pow_grad/mul_3Mul!gradients/policy_1/pow_grad/mul_2$gradients/policy_1/pow_grad/Select_1*
T0
�
!gradients/policy_1/pow_grad/Sum_1Sum!gradients/policy_1/pow_grad/mul_33gradients/policy_1/pow_grad/BroadcastGradientArgs:1*
T0*

Tidx0*
	keep_dims( 
�
%gradients/policy_1/pow_grad/Reshape_1Reshape!gradients/policy_1/pow_grad/Sum_1#gradients/policy_1/pow_grad/Shape_1*
T0*
Tshape0
�
,gradients/policy_1/pow_grad/tuple/group_depsNoOp$^gradients/policy_1/pow_grad/Reshape&^gradients/policy_1/pow_grad/Reshape_1
�
4gradients/policy_1/pow_grad/tuple/control_dependencyIdentity#gradients/policy_1/pow_grad/Reshape-^gradients/policy_1/pow_grad/tuple/group_deps*
T0*6
_class,
*(loc:@gradients/policy_1/pow_grad/Reshape
�
6gradients/policy_1/pow_grad/tuple/control_dependency_1Identity%gradients/policy_1/pow_grad/Reshape_1-^gradients/policy_1/pow_grad/tuple/group_deps*
T0*8
_class.
,*loc:@gradients/policy_1/pow_grad/Reshape_1
W
#gradients/policy_1/mul_1_grad/ShapeShapepolicy_1/mul_1/x*
T0*
out_type0
_
%gradients/policy_1/mul_1_grad/Shape_1Shapepolicy_1/clip_by_value*
T0*
out_type0
�
3gradients/policy_1/mul_1_grad/BroadcastGradientArgsBroadcastGradientArgs#gradients/policy_1/mul_1_grad/Shape%gradients/policy_1/mul_1_grad/Shape_1*
T0
�
!gradients/policy_1/mul_1_grad/MulMul8gradients/policy_1/add_2_grad/tuple/control_dependency_1policy_1/clip_by_value*
T0
�
!gradients/policy_1/mul_1_grad/SumSum!gradients/policy_1/mul_1_grad/Mul3gradients/policy_1/mul_1_grad/BroadcastGradientArgs*
T0*

Tidx0*
	keep_dims( 
�
%gradients/policy_1/mul_1_grad/ReshapeReshape!gradients/policy_1/mul_1_grad/Sum#gradients/policy_1/mul_1_grad/Shape*
T0*
Tshape0

#gradients/policy_1/mul_1_grad/Mul_1Mulpolicy_1/mul_1/x8gradients/policy_1/add_2_grad/tuple/control_dependency_1*
T0
�
#gradients/policy_1/mul_1_grad/Sum_1Sum#gradients/policy_1/mul_1_grad/Mul_15gradients/policy_1/mul_1_grad/BroadcastGradientArgs:1*
T0*

Tidx0*
	keep_dims( 
�
'gradients/policy_1/mul_1_grad/Reshape_1Reshape#gradients/policy_1/mul_1_grad/Sum_1%gradients/policy_1/mul_1_grad/Shape_1*
T0*
Tshape0
�
.gradients/policy_1/mul_1_grad/tuple/group_depsNoOp&^gradients/policy_1/mul_1_grad/Reshape(^gradients/policy_1/mul_1_grad/Reshape_1
�
6gradients/policy_1/mul_1_grad/tuple/control_dependencyIdentity%gradients/policy_1/mul_1_grad/Reshape/^gradients/policy_1/mul_1_grad/tuple/group_deps*
T0*8
_class.
,*loc:@gradients/policy_1/mul_1_grad/Reshape
�
8gradients/policy_1/mul_1_grad/tuple/control_dependency_1Identity'gradients/policy_1/mul_1_grad/Reshape_1/^gradients/policy_1/mul_1_grad/tuple/group_deps*
T0*:
_class0
.,loc:@gradients/policy_1/mul_1_grad/Reshape_1
T
#gradients/policy_1/pow_1_grad/ShapeShapepolicy_1/Tanh*
T0*
out_type0
Y
%gradients/policy_1/pow_1_grad/Shape_1Shapepolicy_1/pow_1/y*
T0*
out_type0
�
3gradients/policy_1/pow_1_grad/BroadcastGradientArgsBroadcastGradientArgs#gradients/policy_1/pow_1_grad/Shape%gradients/policy_1/pow_1_grad/Shape_1*
T0
}
!gradients/policy_1/pow_1_grad/mulMul8gradients/policy_1/sub_1_grad/tuple/control_dependency_1policy_1/pow_1/y*
T0
P
#gradients/policy_1/pow_1_grad/sub/yConst*
dtype0*
valueB
 *  �?
h
!gradients/policy_1/pow_1_grad/subSubpolicy_1/pow_1/y#gradients/policy_1/pow_1_grad/sub/y*
T0
c
!gradients/policy_1/pow_1_grad/PowPowpolicy_1/Tanh!gradients/policy_1/pow_1_grad/sub*
T0
y
#gradients/policy_1/pow_1_grad/mul_1Mul!gradients/policy_1/pow_1_grad/mul!gradients/policy_1/pow_1_grad/Pow*
T0
�
!gradients/policy_1/pow_1_grad/SumSum#gradients/policy_1/pow_1_grad/mul_13gradients/policy_1/pow_1_grad/BroadcastGradientArgs*
T0*

Tidx0*
	keep_dims( 
�
%gradients/policy_1/pow_1_grad/ReshapeReshape!gradients/policy_1/pow_1_grad/Sum#gradients/policy_1/pow_1_grad/Shape*
T0*
Tshape0
T
'gradients/policy_1/pow_1_grad/Greater/yConst*
dtype0*
valueB
 *    
q
%gradients/policy_1/pow_1_grad/GreaterGreaterpolicy_1/Tanh'gradients/policy_1/pow_1_grad/Greater/y*
T0
^
-gradients/policy_1/pow_1_grad/ones_like/ShapeShapepolicy_1/Tanh*
T0*
out_type0
Z
-gradients/policy_1/pow_1_grad/ones_like/ConstConst*
dtype0*
valueB
 *  �?
�
'gradients/policy_1/pow_1_grad/ones_likeFill-gradients/policy_1/pow_1_grad/ones_like/Shape-gradients/policy_1/pow_1_grad/ones_like/Const*
T0*

index_type0
�
$gradients/policy_1/pow_1_grad/SelectSelect%gradients/policy_1/pow_1_grad/Greaterpolicy_1/Tanh'gradients/policy_1/pow_1_grad/ones_like*
T0
W
!gradients/policy_1/pow_1_grad/LogLog$gradients/policy_1/pow_1_grad/Select*
T0
M
(gradients/policy_1/pow_1_grad/zeros_like	ZerosLikepolicy_1/Tanh*
T0
�
&gradients/policy_1/pow_1_grad/Select_1Select%gradients/policy_1/pow_1_grad/Greater!gradients/policy_1/pow_1_grad/Log(gradients/policy_1/pow_1_grad/zeros_like*
T0
}
#gradients/policy_1/pow_1_grad/mul_2Mul8gradients/policy_1/sub_1_grad/tuple/control_dependency_1policy_1/pow_1*
T0
�
#gradients/policy_1/pow_1_grad/mul_3Mul#gradients/policy_1/pow_1_grad/mul_2&gradients/policy_1/pow_1_grad/Select_1*
T0
�
#gradients/policy_1/pow_1_grad/Sum_1Sum#gradients/policy_1/pow_1_grad/mul_35gradients/policy_1/pow_1_grad/BroadcastGradientArgs:1*
T0*

Tidx0*
	keep_dims( 
�
'gradients/policy_1/pow_1_grad/Reshape_1Reshape#gradients/policy_1/pow_1_grad/Sum_1%gradients/policy_1/pow_1_grad/Shape_1*
T0*
Tshape0
�
.gradients/policy_1/pow_1_grad/tuple/group_depsNoOp&^gradients/policy_1/pow_1_grad/Reshape(^gradients/policy_1/pow_1_grad/Reshape_1
�
6gradients/policy_1/pow_1_grad/tuple/control_dependencyIdentity%gradients/policy_1/pow_1_grad/Reshape/^gradients/policy_1/pow_1_grad/tuple/group_deps*
T0*8
_class.
,*loc:@gradients/policy_1/pow_1_grad/Reshape
�
8gradients/policy_1/pow_1_grad/tuple/control_dependency_1Identity'gradients/policy_1/pow_1_grad/Reshape_1/^gradients/policy_1/pow_1_grad/tuple/group_deps*
T0*:
_class0
.,loc:@gradients/policy_1/pow_1_grad/Reshape_1
�
gradients/AddNAddNVgradients/critic/q/q1_encoding_1/q1_encoder/hidden_1/Mul_grad/tuple/control_dependencyMgradients/critic/q/q1_encoding_1/q1_encoder/hidden_1/Sigmoid_grad/SigmoidGrad*
N*
T0*X
_classN
LJloc:@gradients/critic/q/q1_encoding_1/q1_encoder/hidden_1/Mul_grad/Reshape
�
Mgradients/critic/q/q1_encoding_1/q1_encoder/hidden_1/BiasAdd_grad/BiasAddGradBiasAddGradgradients/AddN*
T0*
data_formatNHWC
�
Rgradients/critic/q/q1_encoding_1/q1_encoder/hidden_1/BiasAdd_grad/tuple/group_depsNoOp^gradients/AddNN^gradients/critic/q/q1_encoding_1/q1_encoder/hidden_1/BiasAdd_grad/BiasAddGrad
�
Zgradients/critic/q/q1_encoding_1/q1_encoder/hidden_1/BiasAdd_grad/tuple/control_dependencyIdentitygradients/AddNS^gradients/critic/q/q1_encoding_1/q1_encoder/hidden_1/BiasAdd_grad/tuple/group_deps*
T0*X
_classN
LJloc:@gradients/critic/q/q1_encoding_1/q1_encoder/hidden_1/Mul_grad/Reshape
�
\gradients/critic/q/q1_encoding_1/q1_encoder/hidden_1/BiasAdd_grad/tuple/control_dependency_1IdentityMgradients/critic/q/q1_encoding_1/q1_encoder/hidden_1/BiasAdd_grad/BiasAddGradS^gradients/critic/q/q1_encoding_1/q1_encoder/hidden_1/BiasAdd_grad/tuple/group_deps*
T0*`
_classV
TRloc:@gradients/critic/q/q1_encoding_1/q1_encoder/hidden_1/BiasAdd_grad/BiasAddGrad
U
%gradients/policy_1/truediv_grad/ShapeShapepolicy_1/sub*
T0*
out_type0
Y
'gradients/policy_1/truediv_grad/Shape_1Shapepolicy_1/add_1*
T0*
out_type0
�
5gradients/policy_1/truediv_grad/BroadcastGradientArgsBroadcastGradientArgs%gradients/policy_1/truediv_grad/Shape'gradients/policy_1/truediv_grad/Shape_1*
T0
�
'gradients/policy_1/truediv_grad/RealDivRealDiv4gradients/policy_1/pow_grad/tuple/control_dependencypolicy_1/add_1*
T0
�
#gradients/policy_1/truediv_grad/SumSum'gradients/policy_1/truediv_grad/RealDiv5gradients/policy_1/truediv_grad/BroadcastGradientArgs*
T0*

Tidx0*
	keep_dims( 
�
'gradients/policy_1/truediv_grad/ReshapeReshape#gradients/policy_1/truediv_grad/Sum%gradients/policy_1/truediv_grad/Shape*
T0*
Tshape0
A
#gradients/policy_1/truediv_grad/NegNegpolicy_1/sub*
T0
r
)gradients/policy_1/truediv_grad/RealDiv_1RealDiv#gradients/policy_1/truediv_grad/Negpolicy_1/add_1*
T0
x
)gradients/policy_1/truediv_grad/RealDiv_2RealDiv)gradients/policy_1/truediv_grad/RealDiv_1policy_1/add_1*
T0
�
#gradients/policy_1/truediv_grad/mulMul4gradients/policy_1/pow_grad/tuple/control_dependency)gradients/policy_1/truediv_grad/RealDiv_2*
T0
�
%gradients/policy_1/truediv_grad/Sum_1Sum#gradients/policy_1/truediv_grad/mul7gradients/policy_1/truediv_grad/BroadcastGradientArgs:1*
T0*

Tidx0*
	keep_dims( 
�
)gradients/policy_1/truediv_grad/Reshape_1Reshape%gradients/policy_1/truediv_grad/Sum_1'gradients/policy_1/truediv_grad/Shape_1*
T0*
Tshape0
�
0gradients/policy_1/truediv_grad/tuple/group_depsNoOp(^gradients/policy_1/truediv_grad/Reshape*^gradients/policy_1/truediv_grad/Reshape_1
�
8gradients/policy_1/truediv_grad/tuple/control_dependencyIdentity'gradients/policy_1/truediv_grad/Reshape1^gradients/policy_1/truediv_grad/tuple/group_deps*
T0*:
_class0
.,loc:@gradients/policy_1/truediv_grad/Reshape
�
:gradients/policy_1/truediv_grad/tuple/control_dependency_1Identity)gradients/policy_1/truediv_grad/Reshape_11^gradients/policy_1/truediv_grad/tuple/group_deps*
T0*<
_class2
0.loc:@gradients/policy_1/truediv_grad/Reshape_1
�
Ggradients/critic/q/q1_encoding_1/q1_encoder/hidden_1/MatMul_grad/MatMulMatMulZgradients/critic/q/q1_encoding_1/q1_encoder/hidden_1/BiasAdd_grad/tuple/control_dependency4critic/q/q1_encoding/q1_encoder/hidden_1/kernel/read*
T0*
transpose_a( *
transpose_b(
�
Igradients/critic/q/q1_encoding_1/q1_encoder/hidden_1/MatMul_grad/MatMul_1MatMul.critic/q/q1_encoding_1/q1_encoder/hidden_0/MulZgradients/critic/q/q1_encoding_1/q1_encoder/hidden_1/BiasAdd_grad/tuple/control_dependency*
T0*
transpose_a(*
transpose_b( 
�
Qgradients/critic/q/q1_encoding_1/q1_encoder/hidden_1/MatMul_grad/tuple/group_depsNoOpH^gradients/critic/q/q1_encoding_1/q1_encoder/hidden_1/MatMul_grad/MatMulJ^gradients/critic/q/q1_encoding_1/q1_encoder/hidden_1/MatMul_grad/MatMul_1
�
Ygradients/critic/q/q1_encoding_1/q1_encoder/hidden_1/MatMul_grad/tuple/control_dependencyIdentityGgradients/critic/q/q1_encoding_1/q1_encoder/hidden_1/MatMul_grad/MatMulR^gradients/critic/q/q1_encoding_1/q1_encoder/hidden_1/MatMul_grad/tuple/group_deps*
T0*Z
_classP
NLloc:@gradients/critic/q/q1_encoding_1/q1_encoder/hidden_1/MatMul_grad/MatMul
�
[gradients/critic/q/q1_encoding_1/q1_encoder/hidden_1/MatMul_grad/tuple/control_dependency_1IdentityIgradients/critic/q/q1_encoding_1/q1_encoder/hidden_1/MatMul_grad/MatMul_1R^gradients/critic/q/q1_encoding_1/q1_encoder/hidden_1/MatMul_grad/tuple/group_deps*
T0*\
_classR
PNloc:@gradients/critic/q/q1_encoding_1/q1_encoder/hidden_1/MatMul_grad/MatMul_1
Q
!gradients/policy_1/sub_grad/ShapeShapepolicy_1/add*
T0*
out_type0
Z
#gradients/policy_1/sub_grad/Shape_1Shapepolicy_1/mu/BiasAdd*
T0*
out_type0
�
1gradients/policy_1/sub_grad/BroadcastGradientArgsBroadcastGradientArgs!gradients/policy_1/sub_grad/Shape#gradients/policy_1/sub_grad/Shape_1*
T0
�
gradients/policy_1/sub_grad/SumSum8gradients/policy_1/truediv_grad/tuple/control_dependency1gradients/policy_1/sub_grad/BroadcastGradientArgs*
T0*

Tidx0*
	keep_dims( 
�
#gradients/policy_1/sub_grad/ReshapeReshapegradients/policy_1/sub_grad/Sum!gradients/policy_1/sub_grad/Shape*
T0*
Tshape0
i
gradients/policy_1/sub_grad/NegNeg8gradients/policy_1/truediv_grad/tuple/control_dependency*
T0
�
!gradients/policy_1/sub_grad/Sum_1Sumgradients/policy_1/sub_grad/Neg3gradients/policy_1/sub_grad/BroadcastGradientArgs:1*
T0*

Tidx0*
	keep_dims( 
�
%gradients/policy_1/sub_grad/Reshape_1Reshape!gradients/policy_1/sub_grad/Sum_1#gradients/policy_1/sub_grad/Shape_1*
T0*
Tshape0
�
,gradients/policy_1/sub_grad/tuple/group_depsNoOp$^gradients/policy_1/sub_grad/Reshape&^gradients/policy_1/sub_grad/Reshape_1
�
4gradients/policy_1/sub_grad/tuple/control_dependencyIdentity#gradients/policy_1/sub_grad/Reshape-^gradients/policy_1/sub_grad/tuple/group_deps*
T0*6
_class,
*(loc:@gradients/policy_1/sub_grad/Reshape
�
6gradients/policy_1/sub_grad/tuple/control_dependency_1Identity%gradients/policy_1/sub_grad/Reshape_1-^gradients/policy_1/sub_grad/tuple/group_deps*
T0*8
_class.
,*loc:@gradients/policy_1/sub_grad/Reshape_1
S
#gradients/policy_1/add_1_grad/ShapeShapepolicy_1/Exp*
T0*
out_type0
Y
%gradients/policy_1/add_1_grad/Shape_1Shapepolicy_1/add_1/y*
T0*
out_type0
�
3gradients/policy_1/add_1_grad/BroadcastGradientArgsBroadcastGradientArgs#gradients/policy_1/add_1_grad/Shape%gradients/policy_1/add_1_grad/Shape_1*
T0
�
!gradients/policy_1/add_1_grad/SumSum:gradients/policy_1/truediv_grad/tuple/control_dependency_13gradients/policy_1/add_1_grad/BroadcastGradientArgs*
T0*

Tidx0*
	keep_dims( 
�
%gradients/policy_1/add_1_grad/ReshapeReshape!gradients/policy_1/add_1_grad/Sum#gradients/policy_1/add_1_grad/Shape*
T0*
Tshape0
�
#gradients/policy_1/add_1_grad/Sum_1Sum:gradients/policy_1/truediv_grad/tuple/control_dependency_15gradients/policy_1/add_1_grad/BroadcastGradientArgs:1*
T0*

Tidx0*
	keep_dims( 
�
'gradients/policy_1/add_1_grad/Reshape_1Reshape#gradients/policy_1/add_1_grad/Sum_1%gradients/policy_1/add_1_grad/Shape_1*
T0*
Tshape0
�
.gradients/policy_1/add_1_grad/tuple/group_depsNoOp&^gradients/policy_1/add_1_grad/Reshape(^gradients/policy_1/add_1_grad/Reshape_1
�
6gradients/policy_1/add_1_grad/tuple/control_dependencyIdentity%gradients/policy_1/add_1_grad/Reshape/^gradients/policy_1/add_1_grad/tuple/group_deps*
T0*8
_class.
,*loc:@gradients/policy_1/add_1_grad/Reshape
�
8gradients/policy_1/add_1_grad/tuple/control_dependency_1Identity'gradients/policy_1/add_1_grad/Reshape_1/^gradients/policy_1/add_1_grad/tuple/group_deps*
T0*:
_class0
.,loc:@gradients/policy_1/add_1_grad/Reshape_1
�
Cgradients/critic/q/q1_encoding_1/q1_encoder/hidden_0/Mul_grad/ShapeShape2critic/q/q1_encoding_1/q1_encoder/hidden_0/BiasAdd*
T0*
out_type0
�
Egradients/critic/q/q1_encoding_1/q1_encoder/hidden_0/Mul_grad/Shape_1Shape2critic/q/q1_encoding_1/q1_encoder/hidden_0/Sigmoid*
T0*
out_type0
�
Sgradients/critic/q/q1_encoding_1/q1_encoder/hidden_0/Mul_grad/BroadcastGradientArgsBroadcastGradientArgsCgradients/critic/q/q1_encoding_1/q1_encoder/hidden_0/Mul_grad/ShapeEgradients/critic/q/q1_encoding_1/q1_encoder/hidden_0/Mul_grad/Shape_1*
T0
�
Agradients/critic/q/q1_encoding_1/q1_encoder/hidden_0/Mul_grad/MulMulYgradients/critic/q/q1_encoding_1/q1_encoder/hidden_1/MatMul_grad/tuple/control_dependency2critic/q/q1_encoding_1/q1_encoder/hidden_0/Sigmoid*
T0
�
Agradients/critic/q/q1_encoding_1/q1_encoder/hidden_0/Mul_grad/SumSumAgradients/critic/q/q1_encoding_1/q1_encoder/hidden_0/Mul_grad/MulSgradients/critic/q/q1_encoding_1/q1_encoder/hidden_0/Mul_grad/BroadcastGradientArgs*
T0*

Tidx0*
	keep_dims( 
�
Egradients/critic/q/q1_encoding_1/q1_encoder/hidden_0/Mul_grad/ReshapeReshapeAgradients/critic/q/q1_encoding_1/q1_encoder/hidden_0/Mul_grad/SumCgradients/critic/q/q1_encoding_1/q1_encoder/hidden_0/Mul_grad/Shape*
T0*
Tshape0
�
Cgradients/critic/q/q1_encoding_1/q1_encoder/hidden_0/Mul_grad/Mul_1Mul2critic/q/q1_encoding_1/q1_encoder/hidden_0/BiasAddYgradients/critic/q/q1_encoding_1/q1_encoder/hidden_1/MatMul_grad/tuple/control_dependency*
T0
�
Cgradients/critic/q/q1_encoding_1/q1_encoder/hidden_0/Mul_grad/Sum_1SumCgradients/critic/q/q1_encoding_1/q1_encoder/hidden_0/Mul_grad/Mul_1Ugradients/critic/q/q1_encoding_1/q1_encoder/hidden_0/Mul_grad/BroadcastGradientArgs:1*
T0*

Tidx0*
	keep_dims( 
�
Ggradients/critic/q/q1_encoding_1/q1_encoder/hidden_0/Mul_grad/Reshape_1ReshapeCgradients/critic/q/q1_encoding_1/q1_encoder/hidden_0/Mul_grad/Sum_1Egradients/critic/q/q1_encoding_1/q1_encoder/hidden_0/Mul_grad/Shape_1*
T0*
Tshape0
�
Ngradients/critic/q/q1_encoding_1/q1_encoder/hidden_0/Mul_grad/tuple/group_depsNoOpF^gradients/critic/q/q1_encoding_1/q1_encoder/hidden_0/Mul_grad/ReshapeH^gradients/critic/q/q1_encoding_1/q1_encoder/hidden_0/Mul_grad/Reshape_1
�
Vgradients/critic/q/q1_encoding_1/q1_encoder/hidden_0/Mul_grad/tuple/control_dependencyIdentityEgradients/critic/q/q1_encoding_1/q1_encoder/hidden_0/Mul_grad/ReshapeO^gradients/critic/q/q1_encoding_1/q1_encoder/hidden_0/Mul_grad/tuple/group_deps*
T0*X
_classN
LJloc:@gradients/critic/q/q1_encoding_1/q1_encoder/hidden_0/Mul_grad/Reshape
�
Xgradients/critic/q/q1_encoding_1/q1_encoder/hidden_0/Mul_grad/tuple/control_dependency_1IdentityGgradients/critic/q/q1_encoding_1/q1_encoder/hidden_0/Mul_grad/Reshape_1O^gradients/critic/q/q1_encoding_1/q1_encoder/hidden_0/Mul_grad/tuple/group_deps*
T0*Z
_classP
NLloc:@gradients/critic/q/q1_encoding_1/q1_encoder/hidden_0/Mul_grad/Reshape_1
�
Mgradients/critic/q/q1_encoding_1/q1_encoder/hidden_0/Sigmoid_grad/SigmoidGradSigmoidGrad2critic/q/q1_encoding_1/q1_encoder/hidden_0/SigmoidXgradients/critic/q/q1_encoding_1/q1_encoder/hidden_0/Mul_grad/tuple/control_dependency_1*
T0
�
gradients/AddN_1AddNVgradients/critic/q/q1_encoding_1/q1_encoder/hidden_0/Mul_grad/tuple/control_dependencyMgradients/critic/q/q1_encoding_1/q1_encoder/hidden_0/Sigmoid_grad/SigmoidGrad*
N*
T0*X
_classN
LJloc:@gradients/critic/q/q1_encoding_1/q1_encoder/hidden_0/Mul_grad/Reshape
�
Mgradients/critic/q/q1_encoding_1/q1_encoder/hidden_0/BiasAdd_grad/BiasAddGradBiasAddGradgradients/AddN_1*
T0*
data_formatNHWC
�
Rgradients/critic/q/q1_encoding_1/q1_encoder/hidden_0/BiasAdd_grad/tuple/group_depsNoOp^gradients/AddN_1N^gradients/critic/q/q1_encoding_1/q1_encoder/hidden_0/BiasAdd_grad/BiasAddGrad
�
Zgradients/critic/q/q1_encoding_1/q1_encoder/hidden_0/BiasAdd_grad/tuple/control_dependencyIdentitygradients/AddN_1S^gradients/critic/q/q1_encoding_1/q1_encoder/hidden_0/BiasAdd_grad/tuple/group_deps*
T0*X
_classN
LJloc:@gradients/critic/q/q1_encoding_1/q1_encoder/hidden_0/Mul_grad/Reshape
�
\gradients/critic/q/q1_encoding_1/q1_encoder/hidden_0/BiasAdd_grad/tuple/control_dependency_1IdentityMgradients/critic/q/q1_encoding_1/q1_encoder/hidden_0/BiasAdd_grad/BiasAddGradS^gradients/critic/q/q1_encoding_1/q1_encoder/hidden_0/BiasAdd_grad/tuple/group_deps*
T0*`
_classV
TRloc:@gradients/critic/q/q1_encoding_1/q1_encoder/hidden_0/BiasAdd_grad/BiasAddGrad
�
Ggradients/critic/q/q1_encoding_1/q1_encoder/hidden_0/MatMul_grad/MatMulMatMulZgradients/critic/q/q1_encoding_1/q1_encoder/hidden_0/BiasAdd_grad/tuple/control_dependency4critic/q/q1_encoding/q1_encoder/hidden_0/kernel/read*
T0*
transpose_a( *
transpose_b(
�
Igradients/critic/q/q1_encoding_1/q1_encoder/hidden_0/MatMul_grad/MatMul_1MatMulconcat_1Zgradients/critic/q/q1_encoding_1/q1_encoder/hidden_0/BiasAdd_grad/tuple/control_dependency*
T0*
transpose_a(*
transpose_b( 
�
Qgradients/critic/q/q1_encoding_1/q1_encoder/hidden_0/MatMul_grad/tuple/group_depsNoOpH^gradients/critic/q/q1_encoding_1/q1_encoder/hidden_0/MatMul_grad/MatMulJ^gradients/critic/q/q1_encoding_1/q1_encoder/hidden_0/MatMul_grad/MatMul_1
�
Ygradients/critic/q/q1_encoding_1/q1_encoder/hidden_0/MatMul_grad/tuple/control_dependencyIdentityGgradients/critic/q/q1_encoding_1/q1_encoder/hidden_0/MatMul_grad/MatMulR^gradients/critic/q/q1_encoding_1/q1_encoder/hidden_0/MatMul_grad/tuple/group_deps*
T0*Z
_classP
NLloc:@gradients/critic/q/q1_encoding_1/q1_encoder/hidden_0/MatMul_grad/MatMul
�
[gradients/critic/q/q1_encoding_1/q1_encoder/hidden_0/MatMul_grad/tuple/control_dependency_1IdentityIgradients/critic/q/q1_encoding_1/q1_encoder/hidden_0/MatMul_grad/MatMul_1R^gradients/critic/q/q1_encoding_1/q1_encoder/hidden_0/MatMul_grad/tuple/group_deps*
T0*\
_classR
PNloc:@gradients/critic/q/q1_encoding_1/q1_encoder/hidden_0/MatMul_grad/MatMul_1
F
gradients/concat_1_grad/RankConst*
dtype0*
value	B :
]
gradients/concat_1_grad/modFloorModconcat_1/axisgradients/concat_1_grad/Rank*
T0
Q
gradients/concat_1_grad/ShapeShapenormalized_state*
T0*
out_type0
d
gradients/concat_1_grad/ShapeNShapeNnormalized_stateaction*
N*
T0*
out_type0
�
$gradients/concat_1_grad/ConcatOffsetConcatOffsetgradients/concat_1_grad/modgradients/concat_1_grad/ShapeN gradients/concat_1_grad/ShapeN:1*
N
�
gradients/concat_1_grad/SliceSliceYgradients/critic/q/q1_encoding_1/q1_encoder/hidden_0/MatMul_grad/tuple/control_dependency$gradients/concat_1_grad/ConcatOffsetgradients/concat_1_grad/ShapeN*
Index0*
T0
�
gradients/concat_1_grad/Slice_1SliceYgradients/critic/q/q1_encoding_1/q1_encoder/hidden_0/MatMul_grad/tuple/control_dependency&gradients/concat_1_grad/ConcatOffset:1 gradients/concat_1_grad/ShapeN:1*
Index0*
T0
r
(gradients/concat_1_grad/tuple/group_depsNoOp^gradients/concat_1_grad/Slice ^gradients/concat_1_grad/Slice_1
�
0gradients/concat_1_grad/tuple/control_dependencyIdentitygradients/concat_1_grad/Slice)^gradients/concat_1_grad/tuple/group_deps*
T0*0
_class&
$"loc:@gradients/concat_1_grad/Slice
�
2gradients/concat_1_grad/tuple/control_dependency_1Identitygradients/concat_1_grad/Slice_1)^gradients/concat_1_grad/tuple/group_deps*
T0*2
_class(
&$loc:@gradients/concat_1_grad/Slice_1
�
gradients/AddN_2AddN6gradients/policy_1/pow_1_grad/tuple/control_dependency2gradients/concat_1_grad/tuple/control_dependency_1*
N*
T0*8
_class.
,*loc:@gradients/policy_1/pow_1_grad/Reshape
[
%gradients/policy_1/Tanh_grad/TanhGradTanhGradpolicy_1/Tanhgradients/AddN_2*
T0
�
gradients/AddN_3AddN4gradients/policy_1/sub_grad/tuple/control_dependency%gradients/policy_1/Tanh_grad/TanhGrad*
N*
T0*6
_class,
*(loc:@gradients/policy_1/sub_grad/Reshape
X
!gradients/policy_1/add_grad/ShapeShapepolicy_1/mu/BiasAdd*
T0*
out_type0
S
#gradients/policy_1/add_grad/Shape_1Shapepolicy_1/mul*
T0*
out_type0
�
1gradients/policy_1/add_grad/BroadcastGradientArgsBroadcastGradientArgs!gradients/policy_1/add_grad/Shape#gradients/policy_1/add_grad/Shape_1*
T0
�
gradients/policy_1/add_grad/SumSumgradients/AddN_31gradients/policy_1/add_grad/BroadcastGradientArgs*
T0*

Tidx0*
	keep_dims( 
�
#gradients/policy_1/add_grad/ReshapeReshapegradients/policy_1/add_grad/Sum!gradients/policy_1/add_grad/Shape*
T0*
Tshape0
�
!gradients/policy_1/add_grad/Sum_1Sumgradients/AddN_33gradients/policy_1/add_grad/BroadcastGradientArgs:1*
T0*

Tidx0*
	keep_dims( 
�
%gradients/policy_1/add_grad/Reshape_1Reshape!gradients/policy_1/add_grad/Sum_1#gradients/policy_1/add_grad/Shape_1*
T0*
Tshape0
�
,gradients/policy_1/add_grad/tuple/group_depsNoOp$^gradients/policy_1/add_grad/Reshape&^gradients/policy_1/add_grad/Reshape_1
�
4gradients/policy_1/add_grad/tuple/control_dependencyIdentity#gradients/policy_1/add_grad/Reshape-^gradients/policy_1/add_grad/tuple/group_deps*
T0*6
_class,
*(loc:@gradients/policy_1/add_grad/Reshape
�
6gradients/policy_1/add_grad/tuple/control_dependency_1Identity%gradients/policy_1/add_grad/Reshape_1-^gradients/policy_1/add_grad/tuple/group_deps*
T0*8
_class.
,*loc:@gradients/policy_1/add_grad/Reshape_1
�
gradients/AddN_4AddN6gradients/policy_1/sub_grad/tuple/control_dependency_14gradients/policy_1/add_grad/tuple/control_dependency*
N*
T0*8
_class.
,*loc:@gradients/policy_1/sub_grad/Reshape_1
o
.gradients/policy_1/mu/BiasAdd_grad/BiasAddGradBiasAddGradgradients/AddN_4*
T0*
data_formatNHWC

3gradients/policy_1/mu/BiasAdd_grad/tuple/group_depsNoOp^gradients/AddN_4/^gradients/policy_1/mu/BiasAdd_grad/BiasAddGrad
�
;gradients/policy_1/mu/BiasAdd_grad/tuple/control_dependencyIdentitygradients/AddN_44^gradients/policy_1/mu/BiasAdd_grad/tuple/group_deps*
T0*8
_class.
,*loc:@gradients/policy_1/sub_grad/Reshape_1
�
=gradients/policy_1/mu/BiasAdd_grad/tuple/control_dependency_1Identity.gradients/policy_1/mu/BiasAdd_grad/BiasAddGrad4^gradients/policy_1/mu/BiasAdd_grad/tuple/group_deps*
T0*A
_class7
53loc:@gradients/policy_1/mu/BiasAdd_grad/BiasAddGrad
Q
!gradients/policy_1/mul_grad/ShapeShapepolicy_1/Exp*
T0*
out_type0
]
#gradients/policy_1/mul_grad/Shape_1Shapepolicy_1/random_normal*
T0*
out_type0
�
1gradients/policy_1/mul_grad/BroadcastGradientArgsBroadcastGradientArgs!gradients/policy_1/mul_grad/Shape#gradients/policy_1/mul_grad/Shape_1*
T0

gradients/policy_1/mul_grad/MulMul6gradients/policy_1/add_grad/tuple/control_dependency_1policy_1/random_normal*
T0
�
gradients/policy_1/mul_grad/SumSumgradients/policy_1/mul_grad/Mul1gradients/policy_1/mul_grad/BroadcastGradientArgs*
T0*

Tidx0*
	keep_dims( 
�
#gradients/policy_1/mul_grad/ReshapeReshapegradients/policy_1/mul_grad/Sum!gradients/policy_1/mul_grad/Shape*
T0*
Tshape0
w
!gradients/policy_1/mul_grad/Mul_1Mulpolicy_1/Exp6gradients/policy_1/add_grad/tuple/control_dependency_1*
T0
�
!gradients/policy_1/mul_grad/Sum_1Sum!gradients/policy_1/mul_grad/Mul_13gradients/policy_1/mul_grad/BroadcastGradientArgs:1*
T0*

Tidx0*
	keep_dims( 
�
%gradients/policy_1/mul_grad/Reshape_1Reshape!gradients/policy_1/mul_grad/Sum_1#gradients/policy_1/mul_grad/Shape_1*
T0*
Tshape0
�
,gradients/policy_1/mul_grad/tuple/group_depsNoOp$^gradients/policy_1/mul_grad/Reshape&^gradients/policy_1/mul_grad/Reshape_1
�
4gradients/policy_1/mul_grad/tuple/control_dependencyIdentity#gradients/policy_1/mul_grad/Reshape-^gradients/policy_1/mul_grad/tuple/group_deps*
T0*6
_class,
*(loc:@gradients/policy_1/mul_grad/Reshape
�
6gradients/policy_1/mul_grad/tuple/control_dependency_1Identity%gradients/policy_1/mul_grad/Reshape_1-^gradients/policy_1/mul_grad/tuple/group_deps*
T0*8
_class.
,*loc:@gradients/policy_1/mul_grad/Reshape_1
�
(gradients/policy_1/mu/MatMul_grad/MatMulMatMul;gradients/policy_1/mu/BiasAdd_grad/tuple/control_dependencypolicy/mu/kernel/read*
T0*
transpose_a( *
transpose_b(
�
*gradients/policy_1/mu/MatMul_grad/MatMul_1MatMul policy/main_graph_0/hidden_1/Mul;gradients/policy_1/mu/BiasAdd_grad/tuple/control_dependency*
T0*
transpose_a(*
transpose_b( 
�
2gradients/policy_1/mu/MatMul_grad/tuple/group_depsNoOp)^gradients/policy_1/mu/MatMul_grad/MatMul+^gradients/policy_1/mu/MatMul_grad/MatMul_1
�
:gradients/policy_1/mu/MatMul_grad/tuple/control_dependencyIdentity(gradients/policy_1/mu/MatMul_grad/MatMul3^gradients/policy_1/mu/MatMul_grad/tuple/group_deps*
T0*;
_class1
/-loc:@gradients/policy_1/mu/MatMul_grad/MatMul
�
<gradients/policy_1/mu/MatMul_grad/tuple/control_dependency_1Identity*gradients/policy_1/mu/MatMul_grad/MatMul_13^gradients/policy_1/mu/MatMul_grad/tuple/group_deps*
T0*=
_class3
1/loc:@gradients/policy_1/mu/MatMul_grad/MatMul_1
�
gradients/AddN_5AddN6gradients/policy_1/add_1_grad/tuple/control_dependency4gradients/policy_1/mul_grad/tuple/control_dependency*
N*
T0*8
_class.
,*loc:@gradients/policy_1/add_1_grad/Reshape
O
gradients/policy_1/Exp_grad/mulMulgradients/AddN_5policy_1/Exp*
T0
�
gradients/AddN_6AddN8gradients/policy_1/mul_1_grad/tuple/control_dependency_1gradients/policy_1/Exp_grad/mul*
N*
T0*:
_class0
.,loc:@gradients/policy_1/mul_1_grad/Reshape_1
m
+gradients/policy_1/clip_by_value_grad/ShapeShapepolicy_1/clip_by_value/Minimum*
T0*
out_type0
V
-gradients/policy_1/clip_by_value_grad/Shape_1Const*
dtype0*
valueB 
a
-gradients/policy_1/clip_by_value_grad/Shape_2Shapegradients/AddN_6*
T0*
out_type0
^
1gradients/policy_1/clip_by_value_grad/zeros/ConstConst*
dtype0*
valueB
 *    
�
+gradients/policy_1/clip_by_value_grad/zerosFill-gradients/policy_1/clip_by_value_grad/Shape_21gradients/policy_1/clip_by_value_grad/zeros/Const*
T0*

index_type0
�
2gradients/policy_1/clip_by_value_grad/GreaterEqualGreaterEqualpolicy_1/clip_by_value/Minimumpolicy_1/clip_by_value/y*
T0
�
;gradients/policy_1/clip_by_value_grad/BroadcastGradientArgsBroadcastGradientArgs+gradients/policy_1/clip_by_value_grad/Shape-gradients/policy_1/clip_by_value_grad/Shape_1*
T0
�
.gradients/policy_1/clip_by_value_grad/SelectV2SelectV22gradients/policy_1/clip_by_value_grad/GreaterEqualgradients/AddN_6+gradients/policy_1/clip_by_value_grad/zeros*
T0
�
)gradients/policy_1/clip_by_value_grad/SumSum.gradients/policy_1/clip_by_value_grad/SelectV2;gradients/policy_1/clip_by_value_grad/BroadcastGradientArgs*
T0*

Tidx0*
	keep_dims( 
�
-gradients/policy_1/clip_by_value_grad/ReshapeReshape)gradients/policy_1/clip_by_value_grad/Sum+gradients/policy_1/clip_by_value_grad/Shape*
T0*
Tshape0
�
0gradients/policy_1/clip_by_value_grad/SelectV2_1SelectV22gradients/policy_1/clip_by_value_grad/GreaterEqual+gradients/policy_1/clip_by_value_grad/zerosgradients/AddN_6*
T0
�
+gradients/policy_1/clip_by_value_grad/Sum_1Sum0gradients/policy_1/clip_by_value_grad/SelectV2_1=gradients/policy_1/clip_by_value_grad/BroadcastGradientArgs:1*
T0*

Tidx0*
	keep_dims( 
�
/gradients/policy_1/clip_by_value_grad/Reshape_1Reshape+gradients/policy_1/clip_by_value_grad/Sum_1-gradients/policy_1/clip_by_value_grad/Shape_1*
T0*
Tshape0
�
6gradients/policy_1/clip_by_value_grad/tuple/group_depsNoOp.^gradients/policy_1/clip_by_value_grad/Reshape0^gradients/policy_1/clip_by_value_grad/Reshape_1
�
>gradients/policy_1/clip_by_value_grad/tuple/control_dependencyIdentity-gradients/policy_1/clip_by_value_grad/Reshape7^gradients/policy_1/clip_by_value_grad/tuple/group_deps*
T0*@
_class6
42loc:@gradients/policy_1/clip_by_value_grad/Reshape
�
@gradients/policy_1/clip_by_value_grad/tuple/control_dependency_1Identity/gradients/policy_1/clip_by_value_grad/Reshape_17^gradients/policy_1/clip_by_value_grad/tuple/group_deps*
T0*B
_class8
64loc:@gradients/policy_1/clip_by_value_grad/Reshape_1
o
3gradients/policy_1/clip_by_value/Minimum_grad/ShapeShapepolicy_1/log_std/BiasAdd*
T0*
out_type0
^
5gradients/policy_1/clip_by_value/Minimum_grad/Shape_1Const*
dtype0*
valueB 
�
5gradients/policy_1/clip_by_value/Minimum_grad/Shape_2Shape>gradients/policy_1/clip_by_value_grad/tuple/control_dependency*
T0*
out_type0
f
9gradients/policy_1/clip_by_value/Minimum_grad/zeros/ConstConst*
dtype0*
valueB
 *    
�
3gradients/policy_1/clip_by_value/Minimum_grad/zerosFill5gradients/policy_1/clip_by_value/Minimum_grad/Shape_29gradients/policy_1/clip_by_value/Minimum_grad/zeros/Const*
T0*

index_type0
�
7gradients/policy_1/clip_by_value/Minimum_grad/LessEqual	LessEqualpolicy_1/log_std/BiasAdd policy_1/clip_by_value/Minimum/y*
T0
�
Cgradients/policy_1/clip_by_value/Minimum_grad/BroadcastGradientArgsBroadcastGradientArgs3gradients/policy_1/clip_by_value/Minimum_grad/Shape5gradients/policy_1/clip_by_value/Minimum_grad/Shape_1*
T0
�
6gradients/policy_1/clip_by_value/Minimum_grad/SelectV2SelectV27gradients/policy_1/clip_by_value/Minimum_grad/LessEqual>gradients/policy_1/clip_by_value_grad/tuple/control_dependency3gradients/policy_1/clip_by_value/Minimum_grad/zeros*
T0
�
1gradients/policy_1/clip_by_value/Minimum_grad/SumSum6gradients/policy_1/clip_by_value/Minimum_grad/SelectV2Cgradients/policy_1/clip_by_value/Minimum_grad/BroadcastGradientArgs*
T0*

Tidx0*
	keep_dims( 
�
5gradients/policy_1/clip_by_value/Minimum_grad/ReshapeReshape1gradients/policy_1/clip_by_value/Minimum_grad/Sum3gradients/policy_1/clip_by_value/Minimum_grad/Shape*
T0*
Tshape0
�
8gradients/policy_1/clip_by_value/Minimum_grad/SelectV2_1SelectV27gradients/policy_1/clip_by_value/Minimum_grad/LessEqual3gradients/policy_1/clip_by_value/Minimum_grad/zeros>gradients/policy_1/clip_by_value_grad/tuple/control_dependency*
T0
�
3gradients/policy_1/clip_by_value/Minimum_grad/Sum_1Sum8gradients/policy_1/clip_by_value/Minimum_grad/SelectV2_1Egradients/policy_1/clip_by_value/Minimum_grad/BroadcastGradientArgs:1*
T0*

Tidx0*
	keep_dims( 
�
7gradients/policy_1/clip_by_value/Minimum_grad/Reshape_1Reshape3gradients/policy_1/clip_by_value/Minimum_grad/Sum_15gradients/policy_1/clip_by_value/Minimum_grad/Shape_1*
T0*
Tshape0
�
>gradients/policy_1/clip_by_value/Minimum_grad/tuple/group_depsNoOp6^gradients/policy_1/clip_by_value/Minimum_grad/Reshape8^gradients/policy_1/clip_by_value/Minimum_grad/Reshape_1
�
Fgradients/policy_1/clip_by_value/Minimum_grad/tuple/control_dependencyIdentity5gradients/policy_1/clip_by_value/Minimum_grad/Reshape?^gradients/policy_1/clip_by_value/Minimum_grad/tuple/group_deps*
T0*H
_class>
<:loc:@gradients/policy_1/clip_by_value/Minimum_grad/Reshape
�
Hgradients/policy_1/clip_by_value/Minimum_grad/tuple/control_dependency_1Identity7gradients/policy_1/clip_by_value/Minimum_grad/Reshape_1?^gradients/policy_1/clip_by_value/Minimum_grad/tuple/group_deps*
T0*J
_class@
><loc:@gradients/policy_1/clip_by_value/Minimum_grad/Reshape_1
�
3gradients/policy_1/log_std/BiasAdd_grad/BiasAddGradBiasAddGradFgradients/policy_1/clip_by_value/Minimum_grad/tuple/control_dependency*
T0*
data_formatNHWC
�
8gradients/policy_1/log_std/BiasAdd_grad/tuple/group_depsNoOpG^gradients/policy_1/clip_by_value/Minimum_grad/tuple/control_dependency4^gradients/policy_1/log_std/BiasAdd_grad/BiasAddGrad
�
@gradients/policy_1/log_std/BiasAdd_grad/tuple/control_dependencyIdentityFgradients/policy_1/clip_by_value/Minimum_grad/tuple/control_dependency9^gradients/policy_1/log_std/BiasAdd_grad/tuple/group_deps*
T0*H
_class>
<:loc:@gradients/policy_1/clip_by_value/Minimum_grad/Reshape
�
Bgradients/policy_1/log_std/BiasAdd_grad/tuple/control_dependency_1Identity3gradients/policy_1/log_std/BiasAdd_grad/BiasAddGrad9^gradients/policy_1/log_std/BiasAdd_grad/tuple/group_deps*
T0*F
_class<
:8loc:@gradients/policy_1/log_std/BiasAdd_grad/BiasAddGrad
�
-gradients/policy_1/log_std/MatMul_grad/MatMulMatMul@gradients/policy_1/log_std/BiasAdd_grad/tuple/control_dependencypolicy/log_std/kernel/read*
T0*
transpose_a( *
transpose_b(
�
/gradients/policy_1/log_std/MatMul_grad/MatMul_1MatMul policy/main_graph_0/hidden_1/Mul@gradients/policy_1/log_std/BiasAdd_grad/tuple/control_dependency*
T0*
transpose_a(*
transpose_b( 
�
7gradients/policy_1/log_std/MatMul_grad/tuple/group_depsNoOp.^gradients/policy_1/log_std/MatMul_grad/MatMul0^gradients/policy_1/log_std/MatMul_grad/MatMul_1
�
?gradients/policy_1/log_std/MatMul_grad/tuple/control_dependencyIdentity-gradients/policy_1/log_std/MatMul_grad/MatMul8^gradients/policy_1/log_std/MatMul_grad/tuple/group_deps*
T0*@
_class6
42loc:@gradients/policy_1/log_std/MatMul_grad/MatMul
�
Agradients/policy_1/log_std/MatMul_grad/tuple/control_dependency_1Identity/gradients/policy_1/log_std/MatMul_grad/MatMul_18^gradients/policy_1/log_std/MatMul_grad/tuple/group_deps*
T0*B
_class8
64loc:@gradients/policy_1/log_std/MatMul_grad/MatMul_1
�
gradients/AddN_7AddN:gradients/policy_1/mu/MatMul_grad/tuple/control_dependency?gradients/policy_1/log_std/MatMul_grad/tuple/control_dependency*
N*
T0*;
_class1
/-loc:@gradients/policy_1/mu/MatMul_grad/MatMul
}
5gradients/policy/main_graph_0/hidden_1/Mul_grad/ShapeShape$policy/main_graph_0/hidden_1/BiasAdd*
T0*
out_type0

7gradients/policy/main_graph_0/hidden_1/Mul_grad/Shape_1Shape$policy/main_graph_0/hidden_1/Sigmoid*
T0*
out_type0
�
Egradients/policy/main_graph_0/hidden_1/Mul_grad/BroadcastGradientArgsBroadcastGradientArgs5gradients/policy/main_graph_0/hidden_1/Mul_grad/Shape7gradients/policy/main_graph_0/hidden_1/Mul_grad/Shape_1*
T0
{
3gradients/policy/main_graph_0/hidden_1/Mul_grad/MulMulgradients/AddN_7$policy/main_graph_0/hidden_1/Sigmoid*
T0
�
3gradients/policy/main_graph_0/hidden_1/Mul_grad/SumSum3gradients/policy/main_graph_0/hidden_1/Mul_grad/MulEgradients/policy/main_graph_0/hidden_1/Mul_grad/BroadcastGradientArgs*
T0*

Tidx0*
	keep_dims( 
�
7gradients/policy/main_graph_0/hidden_1/Mul_grad/ReshapeReshape3gradients/policy/main_graph_0/hidden_1/Mul_grad/Sum5gradients/policy/main_graph_0/hidden_1/Mul_grad/Shape*
T0*
Tshape0
}
5gradients/policy/main_graph_0/hidden_1/Mul_grad/Mul_1Mul$policy/main_graph_0/hidden_1/BiasAddgradients/AddN_7*
T0
�
5gradients/policy/main_graph_0/hidden_1/Mul_grad/Sum_1Sum5gradients/policy/main_graph_0/hidden_1/Mul_grad/Mul_1Ggradients/policy/main_graph_0/hidden_1/Mul_grad/BroadcastGradientArgs:1*
T0*

Tidx0*
	keep_dims( 
�
9gradients/policy/main_graph_0/hidden_1/Mul_grad/Reshape_1Reshape5gradients/policy/main_graph_0/hidden_1/Mul_grad/Sum_17gradients/policy/main_graph_0/hidden_1/Mul_grad/Shape_1*
T0*
Tshape0
�
@gradients/policy/main_graph_0/hidden_1/Mul_grad/tuple/group_depsNoOp8^gradients/policy/main_graph_0/hidden_1/Mul_grad/Reshape:^gradients/policy/main_graph_0/hidden_1/Mul_grad/Reshape_1
�
Hgradients/policy/main_graph_0/hidden_1/Mul_grad/tuple/control_dependencyIdentity7gradients/policy/main_graph_0/hidden_1/Mul_grad/ReshapeA^gradients/policy/main_graph_0/hidden_1/Mul_grad/tuple/group_deps*
T0*J
_class@
><loc:@gradients/policy/main_graph_0/hidden_1/Mul_grad/Reshape
�
Jgradients/policy/main_graph_0/hidden_1/Mul_grad/tuple/control_dependency_1Identity9gradients/policy/main_graph_0/hidden_1/Mul_grad/Reshape_1A^gradients/policy/main_graph_0/hidden_1/Mul_grad/tuple/group_deps*
T0*L
_classB
@>loc:@gradients/policy/main_graph_0/hidden_1/Mul_grad/Reshape_1
�
?gradients/policy/main_graph_0/hidden_1/Sigmoid_grad/SigmoidGradSigmoidGrad$policy/main_graph_0/hidden_1/SigmoidJgradients/policy/main_graph_0/hidden_1/Mul_grad/tuple/control_dependency_1*
T0
�
gradients/AddN_8AddNHgradients/policy/main_graph_0/hidden_1/Mul_grad/tuple/control_dependency?gradients/policy/main_graph_0/hidden_1/Sigmoid_grad/SigmoidGrad*
N*
T0*J
_class@
><loc:@gradients/policy/main_graph_0/hidden_1/Mul_grad/Reshape
�
?gradients/policy/main_graph_0/hidden_1/BiasAdd_grad/BiasAddGradBiasAddGradgradients/AddN_8*
T0*
data_formatNHWC
�
Dgradients/policy/main_graph_0/hidden_1/BiasAdd_grad/tuple/group_depsNoOp^gradients/AddN_8@^gradients/policy/main_graph_0/hidden_1/BiasAdd_grad/BiasAddGrad
�
Lgradients/policy/main_graph_0/hidden_1/BiasAdd_grad/tuple/control_dependencyIdentitygradients/AddN_8E^gradients/policy/main_graph_0/hidden_1/BiasAdd_grad/tuple/group_deps*
T0*J
_class@
><loc:@gradients/policy/main_graph_0/hidden_1/Mul_grad/Reshape
�
Ngradients/policy/main_graph_0/hidden_1/BiasAdd_grad/tuple/control_dependency_1Identity?gradients/policy/main_graph_0/hidden_1/BiasAdd_grad/BiasAddGradE^gradients/policy/main_graph_0/hidden_1/BiasAdd_grad/tuple/group_deps*
T0*R
_classH
FDloc:@gradients/policy/main_graph_0/hidden_1/BiasAdd_grad/BiasAddGrad
�
9gradients/policy/main_graph_0/hidden_1/MatMul_grad/MatMulMatMulLgradients/policy/main_graph_0/hidden_1/BiasAdd_grad/tuple/control_dependency(policy/main_graph_0/hidden_1/kernel/read*
T0*
transpose_a( *
transpose_b(
�
;gradients/policy/main_graph_0/hidden_1/MatMul_grad/MatMul_1MatMul policy/main_graph_0/hidden_0/MulLgradients/policy/main_graph_0/hidden_1/BiasAdd_grad/tuple/control_dependency*
T0*
transpose_a(*
transpose_b( 
�
Cgradients/policy/main_graph_0/hidden_1/MatMul_grad/tuple/group_depsNoOp:^gradients/policy/main_graph_0/hidden_1/MatMul_grad/MatMul<^gradients/policy/main_graph_0/hidden_1/MatMul_grad/MatMul_1
�
Kgradients/policy/main_graph_0/hidden_1/MatMul_grad/tuple/control_dependencyIdentity9gradients/policy/main_graph_0/hidden_1/MatMul_grad/MatMulD^gradients/policy/main_graph_0/hidden_1/MatMul_grad/tuple/group_deps*
T0*L
_classB
@>loc:@gradients/policy/main_graph_0/hidden_1/MatMul_grad/MatMul
�
Mgradients/policy/main_graph_0/hidden_1/MatMul_grad/tuple/control_dependency_1Identity;gradients/policy/main_graph_0/hidden_1/MatMul_grad/MatMul_1D^gradients/policy/main_graph_0/hidden_1/MatMul_grad/tuple/group_deps*
T0*N
_classD
B@loc:@gradients/policy/main_graph_0/hidden_1/MatMul_grad/MatMul_1
}
5gradients/policy/main_graph_0/hidden_0/Mul_grad/ShapeShape$policy/main_graph_0/hidden_0/BiasAdd*
T0*
out_type0

7gradients/policy/main_graph_0/hidden_0/Mul_grad/Shape_1Shape$policy/main_graph_0/hidden_0/Sigmoid*
T0*
out_type0
�
Egradients/policy/main_graph_0/hidden_0/Mul_grad/BroadcastGradientArgsBroadcastGradientArgs5gradients/policy/main_graph_0/hidden_0/Mul_grad/Shape7gradients/policy/main_graph_0/hidden_0/Mul_grad/Shape_1*
T0
�
3gradients/policy/main_graph_0/hidden_0/Mul_grad/MulMulKgradients/policy/main_graph_0/hidden_1/MatMul_grad/tuple/control_dependency$policy/main_graph_0/hidden_0/Sigmoid*
T0
�
3gradients/policy/main_graph_0/hidden_0/Mul_grad/SumSum3gradients/policy/main_graph_0/hidden_0/Mul_grad/MulEgradients/policy/main_graph_0/hidden_0/Mul_grad/BroadcastGradientArgs*
T0*

Tidx0*
	keep_dims( 
�
7gradients/policy/main_graph_0/hidden_0/Mul_grad/ReshapeReshape3gradients/policy/main_graph_0/hidden_0/Mul_grad/Sum5gradients/policy/main_graph_0/hidden_0/Mul_grad/Shape*
T0*
Tshape0
�
5gradients/policy/main_graph_0/hidden_0/Mul_grad/Mul_1Mul$policy/main_graph_0/hidden_0/BiasAddKgradients/policy/main_graph_0/hidden_1/MatMul_grad/tuple/control_dependency*
T0
�
5gradients/policy/main_graph_0/hidden_0/Mul_grad/Sum_1Sum5gradients/policy/main_graph_0/hidden_0/Mul_grad/Mul_1Ggradients/policy/main_graph_0/hidden_0/Mul_grad/BroadcastGradientArgs:1*
T0*

Tidx0*
	keep_dims( 
�
9gradients/policy/main_graph_0/hidden_0/Mul_grad/Reshape_1Reshape5gradients/policy/main_graph_0/hidden_0/Mul_grad/Sum_17gradients/policy/main_graph_0/hidden_0/Mul_grad/Shape_1*
T0*
Tshape0
�
@gradients/policy/main_graph_0/hidden_0/Mul_grad/tuple/group_depsNoOp8^gradients/policy/main_graph_0/hidden_0/Mul_grad/Reshape:^gradients/policy/main_graph_0/hidden_0/Mul_grad/Reshape_1
�
Hgradients/policy/main_graph_0/hidden_0/Mul_grad/tuple/control_dependencyIdentity7gradients/policy/main_graph_0/hidden_0/Mul_grad/ReshapeA^gradients/policy/main_graph_0/hidden_0/Mul_grad/tuple/group_deps*
T0*J
_class@
><loc:@gradients/policy/main_graph_0/hidden_0/Mul_grad/Reshape
�
Jgradients/policy/main_graph_0/hidden_0/Mul_grad/tuple/control_dependency_1Identity9gradients/policy/main_graph_0/hidden_0/Mul_grad/Reshape_1A^gradients/policy/main_graph_0/hidden_0/Mul_grad/tuple/group_deps*
T0*L
_classB
@>loc:@gradients/policy/main_graph_0/hidden_0/Mul_grad/Reshape_1
�
?gradients/policy/main_graph_0/hidden_0/Sigmoid_grad/SigmoidGradSigmoidGrad$policy/main_graph_0/hidden_0/SigmoidJgradients/policy/main_graph_0/hidden_0/Mul_grad/tuple/control_dependency_1*
T0
�
gradients/AddN_9AddNHgradients/policy/main_graph_0/hidden_0/Mul_grad/tuple/control_dependency?gradients/policy/main_graph_0/hidden_0/Sigmoid_grad/SigmoidGrad*
N*
T0*J
_class@
><loc:@gradients/policy/main_graph_0/hidden_0/Mul_grad/Reshape
�
?gradients/policy/main_graph_0/hidden_0/BiasAdd_grad/BiasAddGradBiasAddGradgradients/AddN_9*
T0*
data_formatNHWC
�
Dgradients/policy/main_graph_0/hidden_0/BiasAdd_grad/tuple/group_depsNoOp^gradients/AddN_9@^gradients/policy/main_graph_0/hidden_0/BiasAdd_grad/BiasAddGrad
�
Lgradients/policy/main_graph_0/hidden_0/BiasAdd_grad/tuple/control_dependencyIdentitygradients/AddN_9E^gradients/policy/main_graph_0/hidden_0/BiasAdd_grad/tuple/group_deps*
T0*J
_class@
><loc:@gradients/policy/main_graph_0/hidden_0/Mul_grad/Reshape
�
Ngradients/policy/main_graph_0/hidden_0/BiasAdd_grad/tuple/control_dependency_1Identity?gradients/policy/main_graph_0/hidden_0/BiasAdd_grad/BiasAddGradE^gradients/policy/main_graph_0/hidden_0/BiasAdd_grad/tuple/group_deps*
T0*R
_classH
FDloc:@gradients/policy/main_graph_0/hidden_0/BiasAdd_grad/BiasAddGrad
�
9gradients/policy/main_graph_0/hidden_0/MatMul_grad/MatMulMatMulLgradients/policy/main_graph_0/hidden_0/BiasAdd_grad/tuple/control_dependency(policy/main_graph_0/hidden_0/kernel/read*
T0*
transpose_a( *
transpose_b(
�
;gradients/policy/main_graph_0/hidden_0/MatMul_grad/MatMul_1MatMulnormalized_stateLgradients/policy/main_graph_0/hidden_0/BiasAdd_grad/tuple/control_dependency*
T0*
transpose_a(*
transpose_b( 
�
Cgradients/policy/main_graph_0/hidden_0/MatMul_grad/tuple/group_depsNoOp:^gradients/policy/main_graph_0/hidden_0/MatMul_grad/MatMul<^gradients/policy/main_graph_0/hidden_0/MatMul_grad/MatMul_1
�
Kgradients/policy/main_graph_0/hidden_0/MatMul_grad/tuple/control_dependencyIdentity9gradients/policy/main_graph_0/hidden_0/MatMul_grad/MatMulD^gradients/policy/main_graph_0/hidden_0/MatMul_grad/tuple/group_deps*
T0*L
_classB
@>loc:@gradients/policy/main_graph_0/hidden_0/MatMul_grad/MatMul
�
Mgradients/policy/main_graph_0/hidden_0/MatMul_grad/tuple/control_dependency_1Identity;gradients/policy/main_graph_0/hidden_0/MatMul_grad/MatMul_1D^gradients/policy/main_graph_0/hidden_0/MatMul_grad/tuple/group_deps*
T0*N
_classD
B@loc:@gradients/policy/main_graph_0/hidden_0/MatMul_grad/MatMul_1
n
beta1_power/initial_valueConst*&
_class
loc:@policy/log_std/bias*
dtype0*
valueB
 *fff?

beta1_power
VariableV2*&
_class
loc:@policy/log_std/bias*
	container *
dtype0*
shape: *
shared_name 
�
beta1_power/AssignAssignbeta1_powerbeta1_power/initial_value*
T0*&
_class
loc:@policy/log_std/bias*
use_locking(*
validate_shape(
Z
beta1_power/readIdentitybeta1_power*
T0*&
_class
loc:@policy/log_std/bias
n
beta2_power/initial_valueConst*&
_class
loc:@policy/log_std/bias*
dtype0*
valueB
 *w�?

beta2_power
VariableV2*&
_class
loc:@policy/log_std/bias*
	container *
dtype0*
shape: *
shared_name 
�
beta2_power/AssignAssignbeta2_powerbeta2_power/initial_value*
T0*&
_class
loc:@policy/log_std/bias*
use_locking(*
validate_shape(
Z
beta2_power/readIdentitybeta2_power*
T0*&
_class
loc:@policy/log_std/bias
�
Dpolicy/main_graph_0/hidden_0/kernel/sac_policy_opt/Initializer/zerosConst*6
_class,
*(loc:@policy/main_graph_0/hidden_0/kernel*
dtype0*
valueB@*    
�
2policy/main_graph_0/hidden_0/kernel/sac_policy_opt
VariableV2*6
_class,
*(loc:@policy/main_graph_0/hidden_0/kernel*
	container *
dtype0*
shape
:@*
shared_name 
�
9policy/main_graph_0/hidden_0/kernel/sac_policy_opt/AssignAssign2policy/main_graph_0/hidden_0/kernel/sac_policy_optDpolicy/main_graph_0/hidden_0/kernel/sac_policy_opt/Initializer/zeros*
T0*6
_class,
*(loc:@policy/main_graph_0/hidden_0/kernel*
use_locking(*
validate_shape(
�
7policy/main_graph_0/hidden_0/kernel/sac_policy_opt/readIdentity2policy/main_graph_0/hidden_0/kernel/sac_policy_opt*
T0*6
_class,
*(loc:@policy/main_graph_0/hidden_0/kernel
�
Fpolicy/main_graph_0/hidden_0/kernel/sac_policy_opt_1/Initializer/zerosConst*6
_class,
*(loc:@policy/main_graph_0/hidden_0/kernel*
dtype0*
valueB@*    
�
4policy/main_graph_0/hidden_0/kernel/sac_policy_opt_1
VariableV2*6
_class,
*(loc:@policy/main_graph_0/hidden_0/kernel*
	container *
dtype0*
shape
:@*
shared_name 
�
;policy/main_graph_0/hidden_0/kernel/sac_policy_opt_1/AssignAssign4policy/main_graph_0/hidden_0/kernel/sac_policy_opt_1Fpolicy/main_graph_0/hidden_0/kernel/sac_policy_opt_1/Initializer/zeros*
T0*6
_class,
*(loc:@policy/main_graph_0/hidden_0/kernel*
use_locking(*
validate_shape(
�
9policy/main_graph_0/hidden_0/kernel/sac_policy_opt_1/readIdentity4policy/main_graph_0/hidden_0/kernel/sac_policy_opt_1*
T0*6
_class,
*(loc:@policy/main_graph_0/hidden_0/kernel
�
Bpolicy/main_graph_0/hidden_0/bias/sac_policy_opt/Initializer/zerosConst*4
_class*
(&loc:@policy/main_graph_0/hidden_0/bias*
dtype0*
valueB@*    
�
0policy/main_graph_0/hidden_0/bias/sac_policy_opt
VariableV2*4
_class*
(&loc:@policy/main_graph_0/hidden_0/bias*
	container *
dtype0*
shape:@*
shared_name 
�
7policy/main_graph_0/hidden_0/bias/sac_policy_opt/AssignAssign0policy/main_graph_0/hidden_0/bias/sac_policy_optBpolicy/main_graph_0/hidden_0/bias/sac_policy_opt/Initializer/zeros*
T0*4
_class*
(&loc:@policy/main_graph_0/hidden_0/bias*
use_locking(*
validate_shape(
�
5policy/main_graph_0/hidden_0/bias/sac_policy_opt/readIdentity0policy/main_graph_0/hidden_0/bias/sac_policy_opt*
T0*4
_class*
(&loc:@policy/main_graph_0/hidden_0/bias
�
Dpolicy/main_graph_0/hidden_0/bias/sac_policy_opt_1/Initializer/zerosConst*4
_class*
(&loc:@policy/main_graph_0/hidden_0/bias*
dtype0*
valueB@*    
�
2policy/main_graph_0/hidden_0/bias/sac_policy_opt_1
VariableV2*4
_class*
(&loc:@policy/main_graph_0/hidden_0/bias*
	container *
dtype0*
shape:@*
shared_name 
�
9policy/main_graph_0/hidden_0/bias/sac_policy_opt_1/AssignAssign2policy/main_graph_0/hidden_0/bias/sac_policy_opt_1Dpolicy/main_graph_0/hidden_0/bias/sac_policy_opt_1/Initializer/zeros*
T0*4
_class*
(&loc:@policy/main_graph_0/hidden_0/bias*
use_locking(*
validate_shape(
�
7policy/main_graph_0/hidden_0/bias/sac_policy_opt_1/readIdentity2policy/main_graph_0/hidden_0/bias/sac_policy_opt_1*
T0*4
_class*
(&loc:@policy/main_graph_0/hidden_0/bias
�
Tpolicy/main_graph_0/hidden_1/kernel/sac_policy_opt/Initializer/zeros/shape_as_tensorConst*6
_class,
*(loc:@policy/main_graph_0/hidden_1/kernel*
dtype0*
valueB"@   @   
�
Jpolicy/main_graph_0/hidden_1/kernel/sac_policy_opt/Initializer/zeros/ConstConst*6
_class,
*(loc:@policy/main_graph_0/hidden_1/kernel*
dtype0*
valueB
 *    
�
Dpolicy/main_graph_0/hidden_1/kernel/sac_policy_opt/Initializer/zerosFillTpolicy/main_graph_0/hidden_1/kernel/sac_policy_opt/Initializer/zeros/shape_as_tensorJpolicy/main_graph_0/hidden_1/kernel/sac_policy_opt/Initializer/zeros/Const*
T0*6
_class,
*(loc:@policy/main_graph_0/hidden_1/kernel*

index_type0
�
2policy/main_graph_0/hidden_1/kernel/sac_policy_opt
VariableV2*6
_class,
*(loc:@policy/main_graph_0/hidden_1/kernel*
	container *
dtype0*
shape
:@@*
shared_name 
�
9policy/main_graph_0/hidden_1/kernel/sac_policy_opt/AssignAssign2policy/main_graph_0/hidden_1/kernel/sac_policy_optDpolicy/main_graph_0/hidden_1/kernel/sac_policy_opt/Initializer/zeros*
T0*6
_class,
*(loc:@policy/main_graph_0/hidden_1/kernel*
use_locking(*
validate_shape(
�
7policy/main_graph_0/hidden_1/kernel/sac_policy_opt/readIdentity2policy/main_graph_0/hidden_1/kernel/sac_policy_opt*
T0*6
_class,
*(loc:@policy/main_graph_0/hidden_1/kernel
�
Vpolicy/main_graph_0/hidden_1/kernel/sac_policy_opt_1/Initializer/zeros/shape_as_tensorConst*6
_class,
*(loc:@policy/main_graph_0/hidden_1/kernel*
dtype0*
valueB"@   @   
�
Lpolicy/main_graph_0/hidden_1/kernel/sac_policy_opt_1/Initializer/zeros/ConstConst*6
_class,
*(loc:@policy/main_graph_0/hidden_1/kernel*
dtype0*
valueB
 *    
�
Fpolicy/main_graph_0/hidden_1/kernel/sac_policy_opt_1/Initializer/zerosFillVpolicy/main_graph_0/hidden_1/kernel/sac_policy_opt_1/Initializer/zeros/shape_as_tensorLpolicy/main_graph_0/hidden_1/kernel/sac_policy_opt_1/Initializer/zeros/Const*
T0*6
_class,
*(loc:@policy/main_graph_0/hidden_1/kernel*

index_type0
�
4policy/main_graph_0/hidden_1/kernel/sac_policy_opt_1
VariableV2*6
_class,
*(loc:@policy/main_graph_0/hidden_1/kernel*
	container *
dtype0*
shape
:@@*
shared_name 
�
;policy/main_graph_0/hidden_1/kernel/sac_policy_opt_1/AssignAssign4policy/main_graph_0/hidden_1/kernel/sac_policy_opt_1Fpolicy/main_graph_0/hidden_1/kernel/sac_policy_opt_1/Initializer/zeros*
T0*6
_class,
*(loc:@policy/main_graph_0/hidden_1/kernel*
use_locking(*
validate_shape(
�
9policy/main_graph_0/hidden_1/kernel/sac_policy_opt_1/readIdentity4policy/main_graph_0/hidden_1/kernel/sac_policy_opt_1*
T0*6
_class,
*(loc:@policy/main_graph_0/hidden_1/kernel
�
Bpolicy/main_graph_0/hidden_1/bias/sac_policy_opt/Initializer/zerosConst*4
_class*
(&loc:@policy/main_graph_0/hidden_1/bias*
dtype0*
valueB@*    
�
0policy/main_graph_0/hidden_1/bias/sac_policy_opt
VariableV2*4
_class*
(&loc:@policy/main_graph_0/hidden_1/bias*
	container *
dtype0*
shape:@*
shared_name 
�
7policy/main_graph_0/hidden_1/bias/sac_policy_opt/AssignAssign0policy/main_graph_0/hidden_1/bias/sac_policy_optBpolicy/main_graph_0/hidden_1/bias/sac_policy_opt/Initializer/zeros*
T0*4
_class*
(&loc:@policy/main_graph_0/hidden_1/bias*
use_locking(*
validate_shape(
�
5policy/main_graph_0/hidden_1/bias/sac_policy_opt/readIdentity0policy/main_graph_0/hidden_1/bias/sac_policy_opt*
T0*4
_class*
(&loc:@policy/main_graph_0/hidden_1/bias
�
Dpolicy/main_graph_0/hidden_1/bias/sac_policy_opt_1/Initializer/zerosConst*4
_class*
(&loc:@policy/main_graph_0/hidden_1/bias*
dtype0*
valueB@*    
�
2policy/main_graph_0/hidden_1/bias/sac_policy_opt_1
VariableV2*4
_class*
(&loc:@policy/main_graph_0/hidden_1/bias*
	container *
dtype0*
shape:@*
shared_name 
�
9policy/main_graph_0/hidden_1/bias/sac_policy_opt_1/AssignAssign2policy/main_graph_0/hidden_1/bias/sac_policy_opt_1Dpolicy/main_graph_0/hidden_1/bias/sac_policy_opt_1/Initializer/zeros*
T0*4
_class*
(&loc:@policy/main_graph_0/hidden_1/bias*
use_locking(*
validate_shape(
�
7policy/main_graph_0/hidden_1/bias/sac_policy_opt_1/readIdentity2policy/main_graph_0/hidden_1/bias/sac_policy_opt_1*
T0*4
_class*
(&loc:@policy/main_graph_0/hidden_1/bias
�
1policy/mu/kernel/sac_policy_opt/Initializer/zerosConst*#
_class
loc:@policy/mu/kernel*
dtype0*
valueB@*    
�
policy/mu/kernel/sac_policy_opt
VariableV2*#
_class
loc:@policy/mu/kernel*
	container *
dtype0*
shape
:@*
shared_name 
�
&policy/mu/kernel/sac_policy_opt/AssignAssignpolicy/mu/kernel/sac_policy_opt1policy/mu/kernel/sac_policy_opt/Initializer/zeros*
T0*#
_class
loc:@policy/mu/kernel*
use_locking(*
validate_shape(

$policy/mu/kernel/sac_policy_opt/readIdentitypolicy/mu/kernel/sac_policy_opt*
T0*#
_class
loc:@policy/mu/kernel
�
3policy/mu/kernel/sac_policy_opt_1/Initializer/zerosConst*#
_class
loc:@policy/mu/kernel*
dtype0*
valueB@*    
�
!policy/mu/kernel/sac_policy_opt_1
VariableV2*#
_class
loc:@policy/mu/kernel*
	container *
dtype0*
shape
:@*
shared_name 
�
(policy/mu/kernel/sac_policy_opt_1/AssignAssign!policy/mu/kernel/sac_policy_opt_13policy/mu/kernel/sac_policy_opt_1/Initializer/zeros*
T0*#
_class
loc:@policy/mu/kernel*
use_locking(*
validate_shape(
�
&policy/mu/kernel/sac_policy_opt_1/readIdentity!policy/mu/kernel/sac_policy_opt_1*
T0*#
_class
loc:@policy/mu/kernel
�
/policy/mu/bias/sac_policy_opt/Initializer/zerosConst*!
_class
loc:@policy/mu/bias*
dtype0*
valueB*    
�
policy/mu/bias/sac_policy_opt
VariableV2*!
_class
loc:@policy/mu/bias*
	container *
dtype0*
shape:*
shared_name 
�
$policy/mu/bias/sac_policy_opt/AssignAssignpolicy/mu/bias/sac_policy_opt/policy/mu/bias/sac_policy_opt/Initializer/zeros*
T0*!
_class
loc:@policy/mu/bias*
use_locking(*
validate_shape(
y
"policy/mu/bias/sac_policy_opt/readIdentitypolicy/mu/bias/sac_policy_opt*
T0*!
_class
loc:@policy/mu/bias
�
1policy/mu/bias/sac_policy_opt_1/Initializer/zerosConst*!
_class
loc:@policy/mu/bias*
dtype0*
valueB*    
�
policy/mu/bias/sac_policy_opt_1
VariableV2*!
_class
loc:@policy/mu/bias*
	container *
dtype0*
shape:*
shared_name 
�
&policy/mu/bias/sac_policy_opt_1/AssignAssignpolicy/mu/bias/sac_policy_opt_11policy/mu/bias/sac_policy_opt_1/Initializer/zeros*
T0*!
_class
loc:@policy/mu/bias*
use_locking(*
validate_shape(
}
$policy/mu/bias/sac_policy_opt_1/readIdentitypolicy/mu/bias/sac_policy_opt_1*
T0*!
_class
loc:@policy/mu/bias
�
6policy/log_std/kernel/sac_policy_opt/Initializer/zerosConst*(
_class
loc:@policy/log_std/kernel*
dtype0*
valueB@*    
�
$policy/log_std/kernel/sac_policy_opt
VariableV2*(
_class
loc:@policy/log_std/kernel*
	container *
dtype0*
shape
:@*
shared_name 
�
+policy/log_std/kernel/sac_policy_opt/AssignAssign$policy/log_std/kernel/sac_policy_opt6policy/log_std/kernel/sac_policy_opt/Initializer/zeros*
T0*(
_class
loc:@policy/log_std/kernel*
use_locking(*
validate_shape(
�
)policy/log_std/kernel/sac_policy_opt/readIdentity$policy/log_std/kernel/sac_policy_opt*
T0*(
_class
loc:@policy/log_std/kernel
�
8policy/log_std/kernel/sac_policy_opt_1/Initializer/zerosConst*(
_class
loc:@policy/log_std/kernel*
dtype0*
valueB@*    
�
&policy/log_std/kernel/sac_policy_opt_1
VariableV2*(
_class
loc:@policy/log_std/kernel*
	container *
dtype0*
shape
:@*
shared_name 
�
-policy/log_std/kernel/sac_policy_opt_1/AssignAssign&policy/log_std/kernel/sac_policy_opt_18policy/log_std/kernel/sac_policy_opt_1/Initializer/zeros*
T0*(
_class
loc:@policy/log_std/kernel*
use_locking(*
validate_shape(
�
+policy/log_std/kernel/sac_policy_opt_1/readIdentity&policy/log_std/kernel/sac_policy_opt_1*
T0*(
_class
loc:@policy/log_std/kernel
�
4policy/log_std/bias/sac_policy_opt/Initializer/zerosConst*&
_class
loc:@policy/log_std/bias*
dtype0*
valueB*    
�
"policy/log_std/bias/sac_policy_opt
VariableV2*&
_class
loc:@policy/log_std/bias*
	container *
dtype0*
shape:*
shared_name 
�
)policy/log_std/bias/sac_policy_opt/AssignAssign"policy/log_std/bias/sac_policy_opt4policy/log_std/bias/sac_policy_opt/Initializer/zeros*
T0*&
_class
loc:@policy/log_std/bias*
use_locking(*
validate_shape(
�
'policy/log_std/bias/sac_policy_opt/readIdentity"policy/log_std/bias/sac_policy_opt*
T0*&
_class
loc:@policy/log_std/bias
�
6policy/log_std/bias/sac_policy_opt_1/Initializer/zerosConst*&
_class
loc:@policy/log_std/bias*
dtype0*
valueB*    
�
$policy/log_std/bias/sac_policy_opt_1
VariableV2*&
_class
loc:@policy/log_std/bias*
	container *
dtype0*
shape:*
shared_name 
�
+policy/log_std/bias/sac_policy_opt_1/AssignAssign$policy/log_std/bias/sac_policy_opt_16policy/log_std/bias/sac_policy_opt_1/Initializer/zeros*
T0*&
_class
loc:@policy/log_std/bias*
use_locking(*
validate_shape(
�
)policy/log_std/bias/sac_policy_opt_1/readIdentity$policy/log_std/bias/sac_policy_opt_1*
T0*&
_class
loc:@policy/log_std/bias
A
sac_policy_opt/beta1Const*
dtype0*
valueB
 *fff?
A
sac_policy_opt/beta2Const*
dtype0*
valueB
 *w�?
C
sac_policy_opt/epsilonConst*
dtype0*
valueB
 *w�+2
�
Csac_policy_opt/update_policy/main_graph_0/hidden_0/kernel/ApplyAdam	ApplyAdam#policy/main_graph_0/hidden_0/kernel2policy/main_graph_0/hidden_0/kernel/sac_policy_opt4policy/main_graph_0/hidden_0/kernel/sac_policy_opt_1beta1_power/readbeta2_power/readVariable_1/readsac_policy_opt/beta1sac_policy_opt/beta2sac_policy_opt/epsilonMgradients/policy/main_graph_0/hidden_0/MatMul_grad/tuple/control_dependency_1*
T0*6
_class,
*(loc:@policy/main_graph_0/hidden_0/kernel*
use_locking( *
use_nesterov( 
�
Asac_policy_opt/update_policy/main_graph_0/hidden_0/bias/ApplyAdam	ApplyAdam!policy/main_graph_0/hidden_0/bias0policy/main_graph_0/hidden_0/bias/sac_policy_opt2policy/main_graph_0/hidden_0/bias/sac_policy_opt_1beta1_power/readbeta2_power/readVariable_1/readsac_policy_opt/beta1sac_policy_opt/beta2sac_policy_opt/epsilonNgradients/policy/main_graph_0/hidden_0/BiasAdd_grad/tuple/control_dependency_1*
T0*4
_class*
(&loc:@policy/main_graph_0/hidden_0/bias*
use_locking( *
use_nesterov( 
�
Csac_policy_opt/update_policy/main_graph_0/hidden_1/kernel/ApplyAdam	ApplyAdam#policy/main_graph_0/hidden_1/kernel2policy/main_graph_0/hidden_1/kernel/sac_policy_opt4policy/main_graph_0/hidden_1/kernel/sac_policy_opt_1beta1_power/readbeta2_power/readVariable_1/readsac_policy_opt/beta1sac_policy_opt/beta2sac_policy_opt/epsilonMgradients/policy/main_graph_0/hidden_1/MatMul_grad/tuple/control_dependency_1*
T0*6
_class,
*(loc:@policy/main_graph_0/hidden_1/kernel*
use_locking( *
use_nesterov( 
�
Asac_policy_opt/update_policy/main_graph_0/hidden_1/bias/ApplyAdam	ApplyAdam!policy/main_graph_0/hidden_1/bias0policy/main_graph_0/hidden_1/bias/sac_policy_opt2policy/main_graph_0/hidden_1/bias/sac_policy_opt_1beta1_power/readbeta2_power/readVariable_1/readsac_policy_opt/beta1sac_policy_opt/beta2sac_policy_opt/epsilonNgradients/policy/main_graph_0/hidden_1/BiasAdd_grad/tuple/control_dependency_1*
T0*4
_class*
(&loc:@policy/main_graph_0/hidden_1/bias*
use_locking( *
use_nesterov( 
�
0sac_policy_opt/update_policy/mu/kernel/ApplyAdam	ApplyAdampolicy/mu/kernelpolicy/mu/kernel/sac_policy_opt!policy/mu/kernel/sac_policy_opt_1beta1_power/readbeta2_power/readVariable_1/readsac_policy_opt/beta1sac_policy_opt/beta2sac_policy_opt/epsilon<gradients/policy_1/mu/MatMul_grad/tuple/control_dependency_1*
T0*#
_class
loc:@policy/mu/kernel*
use_locking( *
use_nesterov( 
�
.sac_policy_opt/update_policy/mu/bias/ApplyAdam	ApplyAdampolicy/mu/biaspolicy/mu/bias/sac_policy_optpolicy/mu/bias/sac_policy_opt_1beta1_power/readbeta2_power/readVariable_1/readsac_policy_opt/beta1sac_policy_opt/beta2sac_policy_opt/epsilon=gradients/policy_1/mu/BiasAdd_grad/tuple/control_dependency_1*
T0*!
_class
loc:@policy/mu/bias*
use_locking( *
use_nesterov( 
�
5sac_policy_opt/update_policy/log_std/kernel/ApplyAdam	ApplyAdampolicy/log_std/kernel$policy/log_std/kernel/sac_policy_opt&policy/log_std/kernel/sac_policy_opt_1beta1_power/readbeta2_power/readVariable_1/readsac_policy_opt/beta1sac_policy_opt/beta2sac_policy_opt/epsilonAgradients/policy_1/log_std/MatMul_grad/tuple/control_dependency_1*
T0*(
_class
loc:@policy/log_std/kernel*
use_locking( *
use_nesterov( 
�
3sac_policy_opt/update_policy/log_std/bias/ApplyAdam	ApplyAdampolicy/log_std/bias"policy/log_std/bias/sac_policy_opt$policy/log_std/bias/sac_policy_opt_1beta1_power/readbeta2_power/readVariable_1/readsac_policy_opt/beta1sac_policy_opt/beta2sac_policy_opt/epsilonBgradients/policy_1/log_std/BiasAdd_grad/tuple/control_dependency_1*
T0*&
_class
loc:@policy/log_std/bias*
use_locking( *
use_nesterov( 
�
sac_policy_opt/mulMulbeta1_power/readsac_policy_opt/beta14^sac_policy_opt/update_policy/log_std/bias/ApplyAdam6^sac_policy_opt/update_policy/log_std/kernel/ApplyAdamB^sac_policy_opt/update_policy/main_graph_0/hidden_0/bias/ApplyAdamD^sac_policy_opt/update_policy/main_graph_0/hidden_0/kernel/ApplyAdamB^sac_policy_opt/update_policy/main_graph_0/hidden_1/bias/ApplyAdamD^sac_policy_opt/update_policy/main_graph_0/hidden_1/kernel/ApplyAdam/^sac_policy_opt/update_policy/mu/bias/ApplyAdam1^sac_policy_opt/update_policy/mu/kernel/ApplyAdam*
T0*&
_class
loc:@policy/log_std/bias
�
sac_policy_opt/AssignAssignbeta1_powersac_policy_opt/mul*
T0*&
_class
loc:@policy/log_std/bias*
use_locking( *
validate_shape(
�
sac_policy_opt/mul_1Mulbeta2_power/readsac_policy_opt/beta24^sac_policy_opt/update_policy/log_std/bias/ApplyAdam6^sac_policy_opt/update_policy/log_std/kernel/ApplyAdamB^sac_policy_opt/update_policy/main_graph_0/hidden_0/bias/ApplyAdamD^sac_policy_opt/update_policy/main_graph_0/hidden_0/kernel/ApplyAdamB^sac_policy_opt/update_policy/main_graph_0/hidden_1/bias/ApplyAdamD^sac_policy_opt/update_policy/main_graph_0/hidden_1/kernel/ApplyAdam/^sac_policy_opt/update_policy/mu/bias/ApplyAdam1^sac_policy_opt/update_policy/mu/kernel/ApplyAdam*
T0*&
_class
loc:@policy/log_std/bias
�
sac_policy_opt/Assign_1Assignbeta2_powersac_policy_opt/mul_1*
T0*&
_class
loc:@policy/log_std/bias*
use_locking( *
validate_shape(
�
sac_policy_optNoOp^sac_policy_opt/Assign^sac_policy_opt/Assign_14^sac_policy_opt/update_policy/log_std/bias/ApplyAdam6^sac_policy_opt/update_policy/log_std/kernel/ApplyAdamB^sac_policy_opt/update_policy/main_graph_0/hidden_0/bias/ApplyAdamD^sac_policy_opt/update_policy/main_graph_0/hidden_0/kernel/ApplyAdamB^sac_policy_opt/update_policy/main_graph_0/hidden_1/bias/ApplyAdamD^sac_policy_opt/update_policy/main_graph_0/hidden_1/kernel/ApplyAdam/^sac_policy_opt/update_policy/mu/bias/ApplyAdam1^sac_policy_opt/update_policy/mu/kernel/ApplyAdam
K
gradients_1/ShapeConst^sac_policy_opt*
dtype0*
valueB 
S
gradients_1/grad_ys_0Const^sac_policy_opt*
dtype0*
valueB
 *  �?
]
gradients_1/FillFillgradients_1/Shapegradients_1/grad_ys_0*
T0*

index_type0
S
'gradients_1/add_9_grad/tuple/group_depsNoOp^gradients_1/Fill^sac_policy_opt
�
/gradients_1/add_9_grad/tuple/control_dependencyIdentitygradients_1/Fill(^gradients_1/add_9_grad/tuple/group_deps*
T0*#
_class
loc:@gradients_1/Fill
�
1gradients_1/add_9_grad/tuple/control_dependency_1Identitygradients_1/Fill(^gradients_1/add_9_grad/tuple/group_deps*
T0*#
_class
loc:@gradients_1/Fill
r
'gradients_1/add_8_grad/tuple/group_depsNoOp0^gradients_1/add_9_grad/tuple/control_dependency^sac_policy_opt
�
/gradients_1/add_8_grad/tuple/control_dependencyIdentity/gradients_1/add_9_grad/tuple/control_dependency(^gradients_1/add_8_grad/tuple/group_deps*
T0*#
_class
loc:@gradients_1/Fill
�
1gradients_1/add_8_grad/tuple/control_dependency_1Identity/gradients_1/add_9_grad/tuple/control_dependency(^gradients_1/add_8_grad/tuple/group_deps*
T0*#
_class
loc:@gradients_1/Fill
d
%gradients_1/Mean_8_grad/Reshape/shapeConst^sac_policy_opt*
dtype0*
valueB:
�
gradients_1/Mean_8_grad/ReshapeReshape1gradients_1/add_9_grad/tuple/control_dependency_1%gradients_1/Mean_8_grad/Reshape/shape*
T0*
Tshape0
\
gradients_1/Mean_8_grad/ConstConst^sac_policy_opt*
dtype0*
valueB:

gradients_1/Mean_8_grad/TileTilegradients_1/Mean_8_grad/Reshapegradients_1/Mean_8_grad/Const*
T0*

Tmultiples0
]
gradients_1/Mean_8_grad/Const_1Const^sac_policy_opt*
dtype0*
valueB
 *  �?
r
gradients_1/Mean_8_grad/truedivRealDivgradients_1/Mean_8_grad/Tilegradients_1/Mean_8_grad/Const_1*
T0
d
%gradients_1/Mean_2_grad/Reshape/shapeConst^sac_policy_opt*
dtype0*
valueB:
�
gradients_1/Mean_2_grad/ReshapeReshape/gradients_1/add_8_grad/tuple/control_dependency%gradients_1/Mean_2_grad/Reshape/shape*
T0*
Tshape0
\
gradients_1/Mean_2_grad/ConstConst^sac_policy_opt*
dtype0*
valueB:

gradients_1/Mean_2_grad/TileTilegradients_1/Mean_2_grad/Reshapegradients_1/Mean_2_grad/Const*
T0*

Tmultiples0
]
gradients_1/Mean_2_grad/Const_1Const^sac_policy_opt*
dtype0*
valueB
 *  �?
r
gradients_1/Mean_2_grad/truedivRealDivgradients_1/Mean_2_grad/Tilegradients_1/Mean_2_grad/Const_1*
T0
d
%gradients_1/Mean_3_grad/Reshape/shapeConst^sac_policy_opt*
dtype0*
valueB:
�
gradients_1/Mean_3_grad/ReshapeReshape1gradients_1/add_8_grad/tuple/control_dependency_1%gradients_1/Mean_3_grad/Reshape/shape*
T0*
Tshape0
\
gradients_1/Mean_3_grad/ConstConst^sac_policy_opt*
dtype0*
valueB:

gradients_1/Mean_3_grad/TileTilegradients_1/Mean_3_grad/Reshapegradients_1/Mean_3_grad/Const*
T0*

Tmultiples0
]
gradients_1/Mean_3_grad/Const_1Const^sac_policy_opt*
dtype0*
valueB
 *  �?
r
gradients_1/Mean_3_grad/truedivRealDivgradients_1/Mean_3_grad/Tilegradients_1/Mean_3_grad/Const_1*
T0
p
%gradients_1/Mean_8/input_grad/unstackUnpackgradients_1/Mean_8_grad/truediv*
T0*

axis *	
num
p
%gradients_1/Mean_2/input_grad/unstackUnpackgradients_1/Mean_2_grad/truediv*
T0*

axis *	
num
p
%gradients_1/Mean_3/input_grad/unstackUnpackgradients_1/Mean_3_grad/truediv*
T0*

axis *	
num
Z
gradients_1/mul_15_grad/MulMul%gradients_1/Mean_8/input_grad/unstackMean_7*
T0
^
gradients_1/mul_15_grad/Mul_1Mul%gradients_1/Mean_8/input_grad/unstackmul_15/x*
T0

(gradients_1/mul_15_grad/tuple/group_depsNoOp^gradients_1/mul_15_grad/Mul^gradients_1/mul_15_grad/Mul_1^sac_policy_opt
�
0gradients_1/mul_15_grad/tuple/control_dependencyIdentitygradients_1/mul_15_grad/Mul)^gradients_1/mul_15_grad/tuple/group_deps*
T0*.
_class$
" loc:@gradients_1/mul_15_grad/Mul
�
2gradients_1/mul_15_grad/tuple/control_dependency_1Identitygradients_1/mul_15_grad/Mul_1)^gradients_1/mul_15_grad/tuple/group_deps*
T0*0
_class&
$"loc:@gradients_1/mul_15_grad/Mul_1
W
gradients_1/mul_6_grad/MulMul%gradients_1/Mean_2/input_grad/unstackMean*
T0
\
gradients_1/mul_6_grad/Mul_1Mul%gradients_1/Mean_2/input_grad/unstackmul_6/x*
T0
|
'gradients_1/mul_6_grad/tuple/group_depsNoOp^gradients_1/mul_6_grad/Mul^gradients_1/mul_6_grad/Mul_1^sac_policy_opt
�
/gradients_1/mul_6_grad/tuple/control_dependencyIdentitygradients_1/mul_6_grad/Mul(^gradients_1/mul_6_grad/tuple/group_deps*
T0*-
_class#
!loc:@gradients_1/mul_6_grad/Mul
�
1gradients_1/mul_6_grad/tuple/control_dependency_1Identitygradients_1/mul_6_grad/Mul_1(^gradients_1/mul_6_grad/tuple/group_deps*
T0*/
_class%
#!loc:@gradients_1/mul_6_grad/Mul_1
Y
gradients_1/mul_8_grad/MulMul%gradients_1/Mean_3/input_grad/unstackMean_1*
T0
\
gradients_1/mul_8_grad/Mul_1Mul%gradients_1/Mean_3/input_grad/unstackmul_8/x*
T0
|
'gradients_1/mul_8_grad/tuple/group_depsNoOp^gradients_1/mul_8_grad/Mul^gradients_1/mul_8_grad/Mul_1^sac_policy_opt
�
/gradients_1/mul_8_grad/tuple/control_dependencyIdentitygradients_1/mul_8_grad/Mul(^gradients_1/mul_8_grad/tuple/group_deps*
T0*-
_class#
!loc:@gradients_1/mul_8_grad/Mul
�
1gradients_1/mul_8_grad/tuple/control_dependency_1Identitygradients_1/mul_8_grad/Mul_1(^gradients_1/mul_8_grad/tuple/group_deps*
T0*/
_class%
#!loc:@gradients_1/mul_8_grad/Mul_1
k
%gradients_1/Mean_7_grad/Reshape/shapeConst^sac_policy_opt*
dtype0*
valueB"      
�
gradients_1/Mean_7_grad/ReshapeReshape2gradients_1/mul_15_grad/tuple/control_dependency_1%gradients_1/Mean_7_grad/Reshape/shape*
T0*
Tshape0
X
gradients_1/Mean_7_grad/ShapeShapemul_14^sac_policy_opt*
T0*
out_type0

gradients_1/Mean_7_grad/TileTilegradients_1/Mean_7_grad/Reshapegradients_1/Mean_7_grad/Shape*
T0*

Tmultiples0
Z
gradients_1/Mean_7_grad/Shape_1Shapemul_14^sac_policy_opt*
T0*
out_type0
Y
gradients_1/Mean_7_grad/Shape_2Const^sac_policy_opt*
dtype0*
valueB 
\
gradients_1/Mean_7_grad/ConstConst^sac_policy_opt*
dtype0*
valueB: 
�
gradients_1/Mean_7_grad/ProdProdgradients_1/Mean_7_grad/Shape_1gradients_1/Mean_7_grad/Const*
T0*

Tidx0*
	keep_dims( 
^
gradients_1/Mean_7_grad/Const_1Const^sac_policy_opt*
dtype0*
valueB: 
�
gradients_1/Mean_7_grad/Prod_1Prodgradients_1/Mean_7_grad/Shape_2gradients_1/Mean_7_grad/Const_1*
T0*

Tidx0*
	keep_dims( 
\
!gradients_1/Mean_7_grad/Maximum/yConst^sac_policy_opt*
dtype0*
value	B :
v
gradients_1/Mean_7_grad/MaximumMaximumgradients_1/Mean_7_grad/Prod_1!gradients_1/Mean_7_grad/Maximum/y*
T0
t
 gradients_1/Mean_7_grad/floordivFloorDivgradients_1/Mean_7_grad/Prodgradients_1/Mean_7_grad/Maximum*
T0
n
gradients_1/Mean_7_grad/CastCast gradients_1/Mean_7_grad/floordiv*

DstT0*

SrcT0*
Truncate( 
o
gradients_1/Mean_7_grad/truedivRealDivgradients_1/Mean_7_grad/Tilegradients_1/Mean_7_grad/Cast*
T0
i
#gradients_1/Mean_grad/Reshape/shapeConst^sac_policy_opt*
dtype0*
valueB"      
�
gradients_1/Mean_grad/ReshapeReshape1gradients_1/mul_6_grad/tuple/control_dependency_1#gradients_1/Mean_grad/Reshape/shape*
T0*
Tshape0
U
gradients_1/Mean_grad/ShapeShapemul_5^sac_policy_opt*
T0*
out_type0
y
gradients_1/Mean_grad/TileTilegradients_1/Mean_grad/Reshapegradients_1/Mean_grad/Shape*
T0*

Tmultiples0
W
gradients_1/Mean_grad/Shape_1Shapemul_5^sac_policy_opt*
T0*
out_type0
W
gradients_1/Mean_grad/Shape_2Const^sac_policy_opt*
dtype0*
valueB 
Z
gradients_1/Mean_grad/ConstConst^sac_policy_opt*
dtype0*
valueB: 
�
gradients_1/Mean_grad/ProdProdgradients_1/Mean_grad/Shape_1gradients_1/Mean_grad/Const*
T0*

Tidx0*
	keep_dims( 
\
gradients_1/Mean_grad/Const_1Const^sac_policy_opt*
dtype0*
valueB: 
�
gradients_1/Mean_grad/Prod_1Prodgradients_1/Mean_grad/Shape_2gradients_1/Mean_grad/Const_1*
T0*

Tidx0*
	keep_dims( 
Z
gradients_1/Mean_grad/Maximum/yConst^sac_policy_opt*
dtype0*
value	B :
p
gradients_1/Mean_grad/MaximumMaximumgradients_1/Mean_grad/Prod_1gradients_1/Mean_grad/Maximum/y*
T0
n
gradients_1/Mean_grad/floordivFloorDivgradients_1/Mean_grad/Prodgradients_1/Mean_grad/Maximum*
T0
j
gradients_1/Mean_grad/CastCastgradients_1/Mean_grad/floordiv*

DstT0*

SrcT0*
Truncate( 
i
gradients_1/Mean_grad/truedivRealDivgradients_1/Mean_grad/Tilegradients_1/Mean_grad/Cast*
T0
k
%gradients_1/Mean_1_grad/Reshape/shapeConst^sac_policy_opt*
dtype0*
valueB"      
�
gradients_1/Mean_1_grad/ReshapeReshape1gradients_1/mul_8_grad/tuple/control_dependency_1%gradients_1/Mean_1_grad/Reshape/shape*
T0*
Tshape0
W
gradients_1/Mean_1_grad/ShapeShapemul_7^sac_policy_opt*
T0*
out_type0

gradients_1/Mean_1_grad/TileTilegradients_1/Mean_1_grad/Reshapegradients_1/Mean_1_grad/Shape*
T0*

Tmultiples0
Y
gradients_1/Mean_1_grad/Shape_1Shapemul_7^sac_policy_opt*
T0*
out_type0
Y
gradients_1/Mean_1_grad/Shape_2Const^sac_policy_opt*
dtype0*
valueB 
\
gradients_1/Mean_1_grad/ConstConst^sac_policy_opt*
dtype0*
valueB: 
�
gradients_1/Mean_1_grad/ProdProdgradients_1/Mean_1_grad/Shape_1gradients_1/Mean_1_grad/Const*
T0*

Tidx0*
	keep_dims( 
^
gradients_1/Mean_1_grad/Const_1Const^sac_policy_opt*
dtype0*
valueB: 
�
gradients_1/Mean_1_grad/Prod_1Prodgradients_1/Mean_1_grad/Shape_2gradients_1/Mean_1_grad/Const_1*
T0*

Tidx0*
	keep_dims( 
\
!gradients_1/Mean_1_grad/Maximum/yConst^sac_policy_opt*
dtype0*
value	B :
v
gradients_1/Mean_1_grad/MaximumMaximumgradients_1/Mean_1_grad/Prod_1!gradients_1/Mean_1_grad/Maximum/y*
T0
t
 gradients_1/Mean_1_grad/floordivFloorDivgradients_1/Mean_1_grad/Prodgradients_1/Mean_1_grad/Maximum*
T0
n
gradients_1/Mean_1_grad/CastCast gradients_1/Mean_1_grad/floordiv*

DstT0*

SrcT0*
Truncate( 
o
gradients_1/Mean_1_grad/truedivRealDivgradients_1/Mean_1_grad/Tilegradients_1/Mean_1_grad/Cast*
T0
[
gradients_1/mul_14_grad/ShapeShape	ToFloat_4^sac_policy_opt*
T0*
out_type0
g
gradients_1/mul_14_grad/Shape_1ShapeSquaredDifference_2^sac_policy_opt*
T0*
out_type0
�
-gradients_1/mul_14_grad/BroadcastGradientArgsBroadcastGradientArgsgradients_1/mul_14_grad/Shapegradients_1/mul_14_grad/Shape_1*
T0
a
gradients_1/mul_14_grad/MulMulgradients_1/Mean_7_grad/truedivSquaredDifference_2*
T0
�
gradients_1/mul_14_grad/SumSumgradients_1/mul_14_grad/Mul-gradients_1/mul_14_grad/BroadcastGradientArgs*
T0*

Tidx0*
	keep_dims( 
}
gradients_1/mul_14_grad/ReshapeReshapegradients_1/mul_14_grad/Sumgradients_1/mul_14_grad/Shape*
T0*
Tshape0
Y
gradients_1/mul_14_grad/Mul_1Mul	ToFloat_4gradients_1/Mean_7_grad/truediv*
T0
�
gradients_1/mul_14_grad/Sum_1Sumgradients_1/mul_14_grad/Mul_1/gradients_1/mul_14_grad/BroadcastGradientArgs:1*
T0*

Tidx0*
	keep_dims( 
�
!gradients_1/mul_14_grad/Reshape_1Reshapegradients_1/mul_14_grad/Sum_1gradients_1/mul_14_grad/Shape_1*
T0*
Tshape0
�
(gradients_1/mul_14_grad/tuple/group_depsNoOp ^gradients_1/mul_14_grad/Reshape"^gradients_1/mul_14_grad/Reshape_1^sac_policy_opt
�
0gradients_1/mul_14_grad/tuple/control_dependencyIdentitygradients_1/mul_14_grad/Reshape)^gradients_1/mul_14_grad/tuple/group_deps*
T0*2
_class(
&$loc:@gradients_1/mul_14_grad/Reshape
�
2gradients_1/mul_14_grad/tuple/control_dependency_1Identity!gradients_1/mul_14_grad/Reshape_1)^gradients_1/mul_14_grad/tuple/group_deps*
T0*4
_class*
(&loc:@gradients_1/mul_14_grad/Reshape_1
X
gradients_1/mul_5_grad/ShapeShapeToFloat^sac_policy_opt*
T0*
out_type0
d
gradients_1/mul_5_grad/Shape_1ShapeSquaredDifference^sac_policy_opt*
T0*
out_type0
�
,gradients_1/mul_5_grad/BroadcastGradientArgsBroadcastGradientArgsgradients_1/mul_5_grad/Shapegradients_1/mul_5_grad/Shape_1*
T0
\
gradients_1/mul_5_grad/MulMulgradients_1/Mean_grad/truedivSquaredDifference*
T0
�
gradients_1/mul_5_grad/SumSumgradients_1/mul_5_grad/Mul,gradients_1/mul_5_grad/BroadcastGradientArgs*
T0*

Tidx0*
	keep_dims( 
z
gradients_1/mul_5_grad/ReshapeReshapegradients_1/mul_5_grad/Sumgradients_1/mul_5_grad/Shape*
T0*
Tshape0
T
gradients_1/mul_5_grad/Mul_1MulToFloatgradients_1/Mean_grad/truediv*
T0
�
gradients_1/mul_5_grad/Sum_1Sumgradients_1/mul_5_grad/Mul_1.gradients_1/mul_5_grad/BroadcastGradientArgs:1*
T0*

Tidx0*
	keep_dims( 
�
 gradients_1/mul_5_grad/Reshape_1Reshapegradients_1/mul_5_grad/Sum_1gradients_1/mul_5_grad/Shape_1*
T0*
Tshape0
�
'gradients_1/mul_5_grad/tuple/group_depsNoOp^gradients_1/mul_5_grad/Reshape!^gradients_1/mul_5_grad/Reshape_1^sac_policy_opt
�
/gradients_1/mul_5_grad/tuple/control_dependencyIdentitygradients_1/mul_5_grad/Reshape(^gradients_1/mul_5_grad/tuple/group_deps*
T0*1
_class'
%#loc:@gradients_1/mul_5_grad/Reshape
�
1gradients_1/mul_5_grad/tuple/control_dependency_1Identity gradients_1/mul_5_grad/Reshape_1(^gradients_1/mul_5_grad/tuple/group_deps*
T0*3
_class)
'%loc:@gradients_1/mul_5_grad/Reshape_1
Z
gradients_1/mul_7_grad/ShapeShape	ToFloat_1^sac_policy_opt*
T0*
out_type0
f
gradients_1/mul_7_grad/Shape_1ShapeSquaredDifference_1^sac_policy_opt*
T0*
out_type0
�
,gradients_1/mul_7_grad/BroadcastGradientArgsBroadcastGradientArgsgradients_1/mul_7_grad/Shapegradients_1/mul_7_grad/Shape_1*
T0
`
gradients_1/mul_7_grad/MulMulgradients_1/Mean_1_grad/truedivSquaredDifference_1*
T0
�
gradients_1/mul_7_grad/SumSumgradients_1/mul_7_grad/Mul,gradients_1/mul_7_grad/BroadcastGradientArgs*
T0*

Tidx0*
	keep_dims( 
z
gradients_1/mul_7_grad/ReshapeReshapegradients_1/mul_7_grad/Sumgradients_1/mul_7_grad/Shape*
T0*
Tshape0
X
gradients_1/mul_7_grad/Mul_1Mul	ToFloat_1gradients_1/Mean_1_grad/truediv*
T0
�
gradients_1/mul_7_grad/Sum_1Sumgradients_1/mul_7_grad/Mul_1.gradients_1/mul_7_grad/BroadcastGradientArgs:1*
T0*

Tidx0*
	keep_dims( 
�
 gradients_1/mul_7_grad/Reshape_1Reshapegradients_1/mul_7_grad/Sum_1gradients_1/mul_7_grad/Shape_1*
T0*
Tshape0
�
'gradients_1/mul_7_grad/tuple/group_depsNoOp^gradients_1/mul_7_grad/Reshape!^gradients_1/mul_7_grad/Reshape_1^sac_policy_opt
�
/gradients_1/mul_7_grad/tuple/control_dependencyIdentitygradients_1/mul_7_grad/Reshape(^gradients_1/mul_7_grad/tuple/group_deps*
T0*1
_class'
%#loc:@gradients_1/mul_7_grad/Reshape
�
1gradients_1/mul_7_grad/tuple/control_dependency_1Identity gradients_1/mul_7_grad/Reshape_1(^gradients_1/mul_7_grad/tuple/group_deps*
T0*3
_class)
'%loc:@gradients_1/mul_7_grad/Reshape_1
�
+gradients_1/SquaredDifference_2_grad/scalarConst3^gradients_1/mul_14_grad/tuple/control_dependency_1^sac_policy_opt*
dtype0*
valueB
 *   @
�
(gradients_1/SquaredDifference_2_grad/MulMul+gradients_1/SquaredDifference_2_grad/scalar2gradients_1/mul_14_grad/tuple/control_dependency_1*
T0
�
(gradients_1/SquaredDifference_2_grad/subSub$critic/value/extrinsic_value/BiasAddStopGradient_33^gradients_1/mul_14_grad/tuple/control_dependency_1^sac_policy_opt*
T0
�
*gradients_1/SquaredDifference_2_grad/mul_1Mul(gradients_1/SquaredDifference_2_grad/Mul(gradients_1/SquaredDifference_2_grad/sub*
T0
�
*gradients_1/SquaredDifference_2_grad/ShapeShape$critic/value/extrinsic_value/BiasAdd^sac_policy_opt*
T0*
out_type0
o
,gradients_1/SquaredDifference_2_grad/Shape_1ShapeStopGradient_3^sac_policy_opt*
T0*
out_type0
�
:gradients_1/SquaredDifference_2_grad/BroadcastGradientArgsBroadcastGradientArgs*gradients_1/SquaredDifference_2_grad/Shape,gradients_1/SquaredDifference_2_grad/Shape_1*
T0
�
(gradients_1/SquaredDifference_2_grad/SumSum*gradients_1/SquaredDifference_2_grad/mul_1:gradients_1/SquaredDifference_2_grad/BroadcastGradientArgs*
T0*

Tidx0*
	keep_dims( 
�
,gradients_1/SquaredDifference_2_grad/ReshapeReshape(gradients_1/SquaredDifference_2_grad/Sum*gradients_1/SquaredDifference_2_grad/Shape*
T0*
Tshape0
�
*gradients_1/SquaredDifference_2_grad/Sum_1Sum*gradients_1/SquaredDifference_2_grad/mul_1<gradients_1/SquaredDifference_2_grad/BroadcastGradientArgs:1*
T0*

Tidx0*
	keep_dims( 
�
.gradients_1/SquaredDifference_2_grad/Reshape_1Reshape*gradients_1/SquaredDifference_2_grad/Sum_1,gradients_1/SquaredDifference_2_grad/Shape_1*
T0*
Tshape0
h
(gradients_1/SquaredDifference_2_grad/NegNeg.gradients_1/SquaredDifference_2_grad/Reshape_1*
T0
�
5gradients_1/SquaredDifference_2_grad/tuple/group_depsNoOp)^gradients_1/SquaredDifference_2_grad/Neg-^gradients_1/SquaredDifference_2_grad/Reshape^sac_policy_opt
�
=gradients_1/SquaredDifference_2_grad/tuple/control_dependencyIdentity,gradients_1/SquaredDifference_2_grad/Reshape6^gradients_1/SquaredDifference_2_grad/tuple/group_deps*
T0*?
_class5
31loc:@gradients_1/SquaredDifference_2_grad/Reshape
�
?gradients_1/SquaredDifference_2_grad/tuple/control_dependency_1Identity(gradients_1/SquaredDifference_2_grad/Neg6^gradients_1/SquaredDifference_2_grad/tuple/group_deps*
T0*;
_class1
/-loc:@gradients_1/SquaredDifference_2_grad/Neg
�
)gradients_1/SquaredDifference_grad/scalarConst2^gradients_1/mul_5_grad/tuple/control_dependency_1^sac_policy_opt*
dtype0*
valueB
 *   @
�
&gradients_1/SquaredDifference_grad/MulMul)gradients_1/SquaredDifference_grad/scalar1gradients_1/mul_5_grad/tuple/control_dependency_1*
T0
�
&gradients_1/SquaredDifference_grad/subSubStopGradient_1)critic/q/q1_encoding/extrinsic_q1/BiasAdd2^gradients_1/mul_5_grad/tuple/control_dependency_1^sac_policy_opt*
T0
�
(gradients_1/SquaredDifference_grad/mul_1Mul&gradients_1/SquaredDifference_grad/Mul&gradients_1/SquaredDifference_grad/sub*
T0
k
(gradients_1/SquaredDifference_grad/ShapeShapeStopGradient_1^sac_policy_opt*
T0*
out_type0
�
*gradients_1/SquaredDifference_grad/Shape_1Shape)critic/q/q1_encoding/extrinsic_q1/BiasAdd^sac_policy_opt*
T0*
out_type0
�
8gradients_1/SquaredDifference_grad/BroadcastGradientArgsBroadcastGradientArgs(gradients_1/SquaredDifference_grad/Shape*gradients_1/SquaredDifference_grad/Shape_1*
T0
�
&gradients_1/SquaredDifference_grad/SumSum(gradients_1/SquaredDifference_grad/mul_18gradients_1/SquaredDifference_grad/BroadcastGradientArgs*
T0*

Tidx0*
	keep_dims( 
�
*gradients_1/SquaredDifference_grad/ReshapeReshape&gradients_1/SquaredDifference_grad/Sum(gradients_1/SquaredDifference_grad/Shape*
T0*
Tshape0
�
(gradients_1/SquaredDifference_grad/Sum_1Sum(gradients_1/SquaredDifference_grad/mul_1:gradients_1/SquaredDifference_grad/BroadcastGradientArgs:1*
T0*

Tidx0*
	keep_dims( 
�
,gradients_1/SquaredDifference_grad/Reshape_1Reshape(gradients_1/SquaredDifference_grad/Sum_1*gradients_1/SquaredDifference_grad/Shape_1*
T0*
Tshape0
d
&gradients_1/SquaredDifference_grad/NegNeg,gradients_1/SquaredDifference_grad/Reshape_1*
T0
�
3gradients_1/SquaredDifference_grad/tuple/group_depsNoOp'^gradients_1/SquaredDifference_grad/Neg+^gradients_1/SquaredDifference_grad/Reshape^sac_policy_opt
�
;gradients_1/SquaredDifference_grad/tuple/control_dependencyIdentity*gradients_1/SquaredDifference_grad/Reshape4^gradients_1/SquaredDifference_grad/tuple/group_deps*
T0*=
_class3
1/loc:@gradients_1/SquaredDifference_grad/Reshape
�
=gradients_1/SquaredDifference_grad/tuple/control_dependency_1Identity&gradients_1/SquaredDifference_grad/Neg4^gradients_1/SquaredDifference_grad/tuple/group_deps*
T0*9
_class/
-+loc:@gradients_1/SquaredDifference_grad/Neg
�
+gradients_1/SquaredDifference_1_grad/scalarConst2^gradients_1/mul_7_grad/tuple/control_dependency_1^sac_policy_opt*
dtype0*
valueB
 *   @
�
(gradients_1/SquaredDifference_1_grad/MulMul+gradients_1/SquaredDifference_1_grad/scalar1gradients_1/mul_7_grad/tuple/control_dependency_1*
T0
�
(gradients_1/SquaredDifference_1_grad/subSubStopGradient_1)critic/q/q2_encoding/extrinsic_q2/BiasAdd2^gradients_1/mul_7_grad/tuple/control_dependency_1^sac_policy_opt*
T0
�
*gradients_1/SquaredDifference_1_grad/mul_1Mul(gradients_1/SquaredDifference_1_grad/Mul(gradients_1/SquaredDifference_1_grad/sub*
T0
m
*gradients_1/SquaredDifference_1_grad/ShapeShapeStopGradient_1^sac_policy_opt*
T0*
out_type0
�
,gradients_1/SquaredDifference_1_grad/Shape_1Shape)critic/q/q2_encoding/extrinsic_q2/BiasAdd^sac_policy_opt*
T0*
out_type0
�
:gradients_1/SquaredDifference_1_grad/BroadcastGradientArgsBroadcastGradientArgs*gradients_1/SquaredDifference_1_grad/Shape,gradients_1/SquaredDifference_1_grad/Shape_1*
T0
�
(gradients_1/SquaredDifference_1_grad/SumSum*gradients_1/SquaredDifference_1_grad/mul_1:gradients_1/SquaredDifference_1_grad/BroadcastGradientArgs*
T0*

Tidx0*
	keep_dims( 
�
,gradients_1/SquaredDifference_1_grad/ReshapeReshape(gradients_1/SquaredDifference_1_grad/Sum*gradients_1/SquaredDifference_1_grad/Shape*
T0*
Tshape0
�
*gradients_1/SquaredDifference_1_grad/Sum_1Sum*gradients_1/SquaredDifference_1_grad/mul_1<gradients_1/SquaredDifference_1_grad/BroadcastGradientArgs:1*
T0*

Tidx0*
	keep_dims( 
�
.gradients_1/SquaredDifference_1_grad/Reshape_1Reshape*gradients_1/SquaredDifference_1_grad/Sum_1,gradients_1/SquaredDifference_1_grad/Shape_1*
T0*
Tshape0
h
(gradients_1/SquaredDifference_1_grad/NegNeg.gradients_1/SquaredDifference_1_grad/Reshape_1*
T0
�
5gradients_1/SquaredDifference_1_grad/tuple/group_depsNoOp)^gradients_1/SquaredDifference_1_grad/Neg-^gradients_1/SquaredDifference_1_grad/Reshape^sac_policy_opt
�
=gradients_1/SquaredDifference_1_grad/tuple/control_dependencyIdentity,gradients_1/SquaredDifference_1_grad/Reshape6^gradients_1/SquaredDifference_1_grad/tuple/group_deps*
T0*?
_class5
31loc:@gradients_1/SquaredDifference_1_grad/Reshape
�
?gradients_1/SquaredDifference_1_grad/tuple/control_dependency_1Identity(gradients_1/SquaredDifference_1_grad/Neg6^gradients_1/SquaredDifference_1_grad/tuple/group_deps*
T0*;
_class1
/-loc:@gradients_1/SquaredDifference_1_grad/Neg
�
Agradients_1/critic/value/extrinsic_value/BiasAdd_grad/BiasAddGradBiasAddGrad=gradients_1/SquaredDifference_2_grad/tuple/control_dependency*
T0*
data_formatNHWC
�
Fgradients_1/critic/value/extrinsic_value/BiasAdd_grad/tuple/group_depsNoOp>^gradients_1/SquaredDifference_2_grad/tuple/control_dependencyB^gradients_1/critic/value/extrinsic_value/BiasAdd_grad/BiasAddGrad^sac_policy_opt
�
Ngradients_1/critic/value/extrinsic_value/BiasAdd_grad/tuple/control_dependencyIdentity=gradients_1/SquaredDifference_2_grad/tuple/control_dependencyG^gradients_1/critic/value/extrinsic_value/BiasAdd_grad/tuple/group_deps*
T0*?
_class5
31loc:@gradients_1/SquaredDifference_2_grad/Reshape
�
Pgradients_1/critic/value/extrinsic_value/BiasAdd_grad/tuple/control_dependency_1IdentityAgradients_1/critic/value/extrinsic_value/BiasAdd_grad/BiasAddGradG^gradients_1/critic/value/extrinsic_value/BiasAdd_grad/tuple/group_deps*
T0*T
_classJ
HFloc:@gradients_1/critic/value/extrinsic_value/BiasAdd_grad/BiasAddGrad
�
Fgradients_1/critic/q/q1_encoding/extrinsic_q1/BiasAdd_grad/BiasAddGradBiasAddGrad=gradients_1/SquaredDifference_grad/tuple/control_dependency_1*
T0*
data_formatNHWC
�
Kgradients_1/critic/q/q1_encoding/extrinsic_q1/BiasAdd_grad/tuple/group_depsNoOp>^gradients_1/SquaredDifference_grad/tuple/control_dependency_1G^gradients_1/critic/q/q1_encoding/extrinsic_q1/BiasAdd_grad/BiasAddGrad^sac_policy_opt
�
Sgradients_1/critic/q/q1_encoding/extrinsic_q1/BiasAdd_grad/tuple/control_dependencyIdentity=gradients_1/SquaredDifference_grad/tuple/control_dependency_1L^gradients_1/critic/q/q1_encoding/extrinsic_q1/BiasAdd_grad/tuple/group_deps*
T0*9
_class/
-+loc:@gradients_1/SquaredDifference_grad/Neg
�
Ugradients_1/critic/q/q1_encoding/extrinsic_q1/BiasAdd_grad/tuple/control_dependency_1IdentityFgradients_1/critic/q/q1_encoding/extrinsic_q1/BiasAdd_grad/BiasAddGradL^gradients_1/critic/q/q1_encoding/extrinsic_q1/BiasAdd_grad/tuple/group_deps*
T0*Y
_classO
MKloc:@gradients_1/critic/q/q1_encoding/extrinsic_q1/BiasAdd_grad/BiasAddGrad
�
Fgradients_1/critic/q/q2_encoding/extrinsic_q2/BiasAdd_grad/BiasAddGradBiasAddGrad?gradients_1/SquaredDifference_1_grad/tuple/control_dependency_1*
T0*
data_formatNHWC
�
Kgradients_1/critic/q/q2_encoding/extrinsic_q2/BiasAdd_grad/tuple/group_depsNoOp@^gradients_1/SquaredDifference_1_grad/tuple/control_dependency_1G^gradients_1/critic/q/q2_encoding/extrinsic_q2/BiasAdd_grad/BiasAddGrad^sac_policy_opt
�
Sgradients_1/critic/q/q2_encoding/extrinsic_q2/BiasAdd_grad/tuple/control_dependencyIdentity?gradients_1/SquaredDifference_1_grad/tuple/control_dependency_1L^gradients_1/critic/q/q2_encoding/extrinsic_q2/BiasAdd_grad/tuple/group_deps*
T0*;
_class1
/-loc:@gradients_1/SquaredDifference_1_grad/Neg
�
Ugradients_1/critic/q/q2_encoding/extrinsic_q2/BiasAdd_grad/tuple/control_dependency_1IdentityFgradients_1/critic/q/q2_encoding/extrinsic_q2/BiasAdd_grad/BiasAddGradL^gradients_1/critic/q/q2_encoding/extrinsic_q2/BiasAdd_grad/tuple/group_deps*
T0*Y
_classO
MKloc:@gradients_1/critic/q/q2_encoding/extrinsic_q2/BiasAdd_grad/BiasAddGrad
�
;gradients_1/critic/value/extrinsic_value/MatMul_grad/MatMulMatMulNgradients_1/critic/value/extrinsic_value/BiasAdd_grad/tuple/control_dependency(critic/value/extrinsic_value/kernel/read*
T0*
transpose_a( *
transpose_b(
�
=gradients_1/critic/value/extrinsic_value/MatMul_grad/MatMul_1MatMul!critic/value/encoder/hidden_1/MulNgradients_1/critic/value/extrinsic_value/BiasAdd_grad/tuple/control_dependency*
T0*
transpose_a(*
transpose_b( 
�
Egradients_1/critic/value/extrinsic_value/MatMul_grad/tuple/group_depsNoOp<^gradients_1/critic/value/extrinsic_value/MatMul_grad/MatMul>^gradients_1/critic/value/extrinsic_value/MatMul_grad/MatMul_1^sac_policy_opt
�
Mgradients_1/critic/value/extrinsic_value/MatMul_grad/tuple/control_dependencyIdentity;gradients_1/critic/value/extrinsic_value/MatMul_grad/MatMulF^gradients_1/critic/value/extrinsic_value/MatMul_grad/tuple/group_deps*
T0*N
_classD
B@loc:@gradients_1/critic/value/extrinsic_value/MatMul_grad/MatMul
�
Ogradients_1/critic/value/extrinsic_value/MatMul_grad/tuple/control_dependency_1Identity=gradients_1/critic/value/extrinsic_value/MatMul_grad/MatMul_1F^gradients_1/critic/value/extrinsic_value/MatMul_grad/tuple/group_deps*
T0*P
_classF
DBloc:@gradients_1/critic/value/extrinsic_value/MatMul_grad/MatMul_1
�
@gradients_1/critic/q/q1_encoding/extrinsic_q1/MatMul_grad/MatMulMatMulSgradients_1/critic/q/q1_encoding/extrinsic_q1/BiasAdd_grad/tuple/control_dependency-critic/q/q1_encoding/extrinsic_q1/kernel/read*
T0*
transpose_a( *
transpose_b(
�
Bgradients_1/critic/q/q1_encoding/extrinsic_q1/MatMul_grad/MatMul_1MatMul,critic/q/q1_encoding/q1_encoder/hidden_1/MulSgradients_1/critic/q/q1_encoding/extrinsic_q1/BiasAdd_grad/tuple/control_dependency*
T0*
transpose_a(*
transpose_b( 
�
Jgradients_1/critic/q/q1_encoding/extrinsic_q1/MatMul_grad/tuple/group_depsNoOpA^gradients_1/critic/q/q1_encoding/extrinsic_q1/MatMul_grad/MatMulC^gradients_1/critic/q/q1_encoding/extrinsic_q1/MatMul_grad/MatMul_1^sac_policy_opt
�
Rgradients_1/critic/q/q1_encoding/extrinsic_q1/MatMul_grad/tuple/control_dependencyIdentity@gradients_1/critic/q/q1_encoding/extrinsic_q1/MatMul_grad/MatMulK^gradients_1/critic/q/q1_encoding/extrinsic_q1/MatMul_grad/tuple/group_deps*
T0*S
_classI
GEloc:@gradients_1/critic/q/q1_encoding/extrinsic_q1/MatMul_grad/MatMul
�
Tgradients_1/critic/q/q1_encoding/extrinsic_q1/MatMul_grad/tuple/control_dependency_1IdentityBgradients_1/critic/q/q1_encoding/extrinsic_q1/MatMul_grad/MatMul_1K^gradients_1/critic/q/q1_encoding/extrinsic_q1/MatMul_grad/tuple/group_deps*
T0*U
_classK
IGloc:@gradients_1/critic/q/q1_encoding/extrinsic_q1/MatMul_grad/MatMul_1
�
@gradients_1/critic/q/q2_encoding/extrinsic_q2/MatMul_grad/MatMulMatMulSgradients_1/critic/q/q2_encoding/extrinsic_q2/BiasAdd_grad/tuple/control_dependency-critic/q/q2_encoding/extrinsic_q2/kernel/read*
T0*
transpose_a( *
transpose_b(
�
Bgradients_1/critic/q/q2_encoding/extrinsic_q2/MatMul_grad/MatMul_1MatMul,critic/q/q2_encoding/q2_encoder/hidden_1/MulSgradients_1/critic/q/q2_encoding/extrinsic_q2/BiasAdd_grad/tuple/control_dependency*
T0*
transpose_a(*
transpose_b( 
�
Jgradients_1/critic/q/q2_encoding/extrinsic_q2/MatMul_grad/tuple/group_depsNoOpA^gradients_1/critic/q/q2_encoding/extrinsic_q2/MatMul_grad/MatMulC^gradients_1/critic/q/q2_encoding/extrinsic_q2/MatMul_grad/MatMul_1^sac_policy_opt
�
Rgradients_1/critic/q/q2_encoding/extrinsic_q2/MatMul_grad/tuple/control_dependencyIdentity@gradients_1/critic/q/q2_encoding/extrinsic_q2/MatMul_grad/MatMulK^gradients_1/critic/q/q2_encoding/extrinsic_q2/MatMul_grad/tuple/group_deps*
T0*S
_classI
GEloc:@gradients_1/critic/q/q2_encoding/extrinsic_q2/MatMul_grad/MatMul
�
Tgradients_1/critic/q/q2_encoding/extrinsic_q2/MatMul_grad/tuple/control_dependency_1IdentityBgradients_1/critic/q/q2_encoding/extrinsic_q2/MatMul_grad/MatMul_1K^gradients_1/critic/q/q2_encoding/extrinsic_q2/MatMul_grad/tuple/group_deps*
T0*U
_classK
IGloc:@gradients_1/critic/q/q2_encoding/extrinsic_q2/MatMul_grad/MatMul_1
�
8gradients_1/critic/value/encoder/hidden_1/Mul_grad/ShapeShape%critic/value/encoder/hidden_1/BiasAdd^sac_policy_opt*
T0*
out_type0
�
:gradients_1/critic/value/encoder/hidden_1/Mul_grad/Shape_1Shape%critic/value/encoder/hidden_1/Sigmoid^sac_policy_opt*
T0*
out_type0
�
Hgradients_1/critic/value/encoder/hidden_1/Mul_grad/BroadcastGradientArgsBroadcastGradientArgs8gradients_1/critic/value/encoder/hidden_1/Mul_grad/Shape:gradients_1/critic/value/encoder/hidden_1/Mul_grad/Shape_1*
T0
�
6gradients_1/critic/value/encoder/hidden_1/Mul_grad/MulMulMgradients_1/critic/value/extrinsic_value/MatMul_grad/tuple/control_dependency%critic/value/encoder/hidden_1/Sigmoid*
T0
�
6gradients_1/critic/value/encoder/hidden_1/Mul_grad/SumSum6gradients_1/critic/value/encoder/hidden_1/Mul_grad/MulHgradients_1/critic/value/encoder/hidden_1/Mul_grad/BroadcastGradientArgs*
T0*

Tidx0*
	keep_dims( 
�
:gradients_1/critic/value/encoder/hidden_1/Mul_grad/ReshapeReshape6gradients_1/critic/value/encoder/hidden_1/Mul_grad/Sum8gradients_1/critic/value/encoder/hidden_1/Mul_grad/Shape*
T0*
Tshape0
�
8gradients_1/critic/value/encoder/hidden_1/Mul_grad/Mul_1Mul%critic/value/encoder/hidden_1/BiasAddMgradients_1/critic/value/extrinsic_value/MatMul_grad/tuple/control_dependency*
T0
�
8gradients_1/critic/value/encoder/hidden_1/Mul_grad/Sum_1Sum8gradients_1/critic/value/encoder/hidden_1/Mul_grad/Mul_1Jgradients_1/critic/value/encoder/hidden_1/Mul_grad/BroadcastGradientArgs:1*
T0*

Tidx0*
	keep_dims( 
�
<gradients_1/critic/value/encoder/hidden_1/Mul_grad/Reshape_1Reshape8gradients_1/critic/value/encoder/hidden_1/Mul_grad/Sum_1:gradients_1/critic/value/encoder/hidden_1/Mul_grad/Shape_1*
T0*
Tshape0
�
Cgradients_1/critic/value/encoder/hidden_1/Mul_grad/tuple/group_depsNoOp;^gradients_1/critic/value/encoder/hidden_1/Mul_grad/Reshape=^gradients_1/critic/value/encoder/hidden_1/Mul_grad/Reshape_1^sac_policy_opt
�
Kgradients_1/critic/value/encoder/hidden_1/Mul_grad/tuple/control_dependencyIdentity:gradients_1/critic/value/encoder/hidden_1/Mul_grad/ReshapeD^gradients_1/critic/value/encoder/hidden_1/Mul_grad/tuple/group_deps*
T0*M
_classC
A?loc:@gradients_1/critic/value/encoder/hidden_1/Mul_grad/Reshape
�
Mgradients_1/critic/value/encoder/hidden_1/Mul_grad/tuple/control_dependency_1Identity<gradients_1/critic/value/encoder/hidden_1/Mul_grad/Reshape_1D^gradients_1/critic/value/encoder/hidden_1/Mul_grad/tuple/group_deps*
T0*O
_classE
CAloc:@gradients_1/critic/value/encoder/hidden_1/Mul_grad/Reshape_1
�
Cgradients_1/critic/q/q1_encoding/q1_encoder/hidden_1/Mul_grad/ShapeShape0critic/q/q1_encoding/q1_encoder/hidden_1/BiasAdd^sac_policy_opt*
T0*
out_type0
�
Egradients_1/critic/q/q1_encoding/q1_encoder/hidden_1/Mul_grad/Shape_1Shape0critic/q/q1_encoding/q1_encoder/hidden_1/Sigmoid^sac_policy_opt*
T0*
out_type0
�
Sgradients_1/critic/q/q1_encoding/q1_encoder/hidden_1/Mul_grad/BroadcastGradientArgsBroadcastGradientArgsCgradients_1/critic/q/q1_encoding/q1_encoder/hidden_1/Mul_grad/ShapeEgradients_1/critic/q/q1_encoding/q1_encoder/hidden_1/Mul_grad/Shape_1*
T0
�
Agradients_1/critic/q/q1_encoding/q1_encoder/hidden_1/Mul_grad/MulMulRgradients_1/critic/q/q1_encoding/extrinsic_q1/MatMul_grad/tuple/control_dependency0critic/q/q1_encoding/q1_encoder/hidden_1/Sigmoid*
T0
�
Agradients_1/critic/q/q1_encoding/q1_encoder/hidden_1/Mul_grad/SumSumAgradients_1/critic/q/q1_encoding/q1_encoder/hidden_1/Mul_grad/MulSgradients_1/critic/q/q1_encoding/q1_encoder/hidden_1/Mul_grad/BroadcastGradientArgs*
T0*

Tidx0*
	keep_dims( 
�
Egradients_1/critic/q/q1_encoding/q1_encoder/hidden_1/Mul_grad/ReshapeReshapeAgradients_1/critic/q/q1_encoding/q1_encoder/hidden_1/Mul_grad/SumCgradients_1/critic/q/q1_encoding/q1_encoder/hidden_1/Mul_grad/Shape*
T0*
Tshape0
�
Cgradients_1/critic/q/q1_encoding/q1_encoder/hidden_1/Mul_grad/Mul_1Mul0critic/q/q1_encoding/q1_encoder/hidden_1/BiasAddRgradients_1/critic/q/q1_encoding/extrinsic_q1/MatMul_grad/tuple/control_dependency*
T0
�
Cgradients_1/critic/q/q1_encoding/q1_encoder/hidden_1/Mul_grad/Sum_1SumCgradients_1/critic/q/q1_encoding/q1_encoder/hidden_1/Mul_grad/Mul_1Ugradients_1/critic/q/q1_encoding/q1_encoder/hidden_1/Mul_grad/BroadcastGradientArgs:1*
T0*

Tidx0*
	keep_dims( 
�
Ggradients_1/critic/q/q1_encoding/q1_encoder/hidden_1/Mul_grad/Reshape_1ReshapeCgradients_1/critic/q/q1_encoding/q1_encoder/hidden_1/Mul_grad/Sum_1Egradients_1/critic/q/q1_encoding/q1_encoder/hidden_1/Mul_grad/Shape_1*
T0*
Tshape0
�
Ngradients_1/critic/q/q1_encoding/q1_encoder/hidden_1/Mul_grad/tuple/group_depsNoOpF^gradients_1/critic/q/q1_encoding/q1_encoder/hidden_1/Mul_grad/ReshapeH^gradients_1/critic/q/q1_encoding/q1_encoder/hidden_1/Mul_grad/Reshape_1^sac_policy_opt
�
Vgradients_1/critic/q/q1_encoding/q1_encoder/hidden_1/Mul_grad/tuple/control_dependencyIdentityEgradients_1/critic/q/q1_encoding/q1_encoder/hidden_1/Mul_grad/ReshapeO^gradients_1/critic/q/q1_encoding/q1_encoder/hidden_1/Mul_grad/tuple/group_deps*
T0*X
_classN
LJloc:@gradients_1/critic/q/q1_encoding/q1_encoder/hidden_1/Mul_grad/Reshape
�
Xgradients_1/critic/q/q1_encoding/q1_encoder/hidden_1/Mul_grad/tuple/control_dependency_1IdentityGgradients_1/critic/q/q1_encoding/q1_encoder/hidden_1/Mul_grad/Reshape_1O^gradients_1/critic/q/q1_encoding/q1_encoder/hidden_1/Mul_grad/tuple/group_deps*
T0*Z
_classP
NLloc:@gradients_1/critic/q/q1_encoding/q1_encoder/hidden_1/Mul_grad/Reshape_1
�
Cgradients_1/critic/q/q2_encoding/q2_encoder/hidden_1/Mul_grad/ShapeShape0critic/q/q2_encoding/q2_encoder/hidden_1/BiasAdd^sac_policy_opt*
T0*
out_type0
�
Egradients_1/critic/q/q2_encoding/q2_encoder/hidden_1/Mul_grad/Shape_1Shape0critic/q/q2_encoding/q2_encoder/hidden_1/Sigmoid^sac_policy_opt*
T0*
out_type0
�
Sgradients_1/critic/q/q2_encoding/q2_encoder/hidden_1/Mul_grad/BroadcastGradientArgsBroadcastGradientArgsCgradients_1/critic/q/q2_encoding/q2_encoder/hidden_1/Mul_grad/ShapeEgradients_1/critic/q/q2_encoding/q2_encoder/hidden_1/Mul_grad/Shape_1*
T0
�
Agradients_1/critic/q/q2_encoding/q2_encoder/hidden_1/Mul_grad/MulMulRgradients_1/critic/q/q2_encoding/extrinsic_q2/MatMul_grad/tuple/control_dependency0critic/q/q2_encoding/q2_encoder/hidden_1/Sigmoid*
T0
�
Agradients_1/critic/q/q2_encoding/q2_encoder/hidden_1/Mul_grad/SumSumAgradients_1/critic/q/q2_encoding/q2_encoder/hidden_1/Mul_grad/MulSgradients_1/critic/q/q2_encoding/q2_encoder/hidden_1/Mul_grad/BroadcastGradientArgs*
T0*

Tidx0*
	keep_dims( 
�
Egradients_1/critic/q/q2_encoding/q2_encoder/hidden_1/Mul_grad/ReshapeReshapeAgradients_1/critic/q/q2_encoding/q2_encoder/hidden_1/Mul_grad/SumCgradients_1/critic/q/q2_encoding/q2_encoder/hidden_1/Mul_grad/Shape*
T0*
Tshape0
�
Cgradients_1/critic/q/q2_encoding/q2_encoder/hidden_1/Mul_grad/Mul_1Mul0critic/q/q2_encoding/q2_encoder/hidden_1/BiasAddRgradients_1/critic/q/q2_encoding/extrinsic_q2/MatMul_grad/tuple/control_dependency*
T0
�
Cgradients_1/critic/q/q2_encoding/q2_encoder/hidden_1/Mul_grad/Sum_1SumCgradients_1/critic/q/q2_encoding/q2_encoder/hidden_1/Mul_grad/Mul_1Ugradients_1/critic/q/q2_encoding/q2_encoder/hidden_1/Mul_grad/BroadcastGradientArgs:1*
T0*

Tidx0*
	keep_dims( 
�
Ggradients_1/critic/q/q2_encoding/q2_encoder/hidden_1/Mul_grad/Reshape_1ReshapeCgradients_1/critic/q/q2_encoding/q2_encoder/hidden_1/Mul_grad/Sum_1Egradients_1/critic/q/q2_encoding/q2_encoder/hidden_1/Mul_grad/Shape_1*
T0*
Tshape0
�
Ngradients_1/critic/q/q2_encoding/q2_encoder/hidden_1/Mul_grad/tuple/group_depsNoOpF^gradients_1/critic/q/q2_encoding/q2_encoder/hidden_1/Mul_grad/ReshapeH^gradients_1/critic/q/q2_encoding/q2_encoder/hidden_1/Mul_grad/Reshape_1^sac_policy_opt
�
Vgradients_1/critic/q/q2_encoding/q2_encoder/hidden_1/Mul_grad/tuple/control_dependencyIdentityEgradients_1/critic/q/q2_encoding/q2_encoder/hidden_1/Mul_grad/ReshapeO^gradients_1/critic/q/q2_encoding/q2_encoder/hidden_1/Mul_grad/tuple/group_deps*
T0*X
_classN
LJloc:@gradients_1/critic/q/q2_encoding/q2_encoder/hidden_1/Mul_grad/Reshape
�
Xgradients_1/critic/q/q2_encoding/q2_encoder/hidden_1/Mul_grad/tuple/control_dependency_1IdentityGgradients_1/critic/q/q2_encoding/q2_encoder/hidden_1/Mul_grad/Reshape_1O^gradients_1/critic/q/q2_encoding/q2_encoder/hidden_1/Mul_grad/tuple/group_deps*
T0*Z
_classP
NLloc:@gradients_1/critic/q/q2_encoding/q2_encoder/hidden_1/Mul_grad/Reshape_1
�
Bgradients_1/critic/value/encoder/hidden_1/Sigmoid_grad/SigmoidGradSigmoidGrad%critic/value/encoder/hidden_1/SigmoidMgradients_1/critic/value/encoder/hidden_1/Mul_grad/tuple/control_dependency_1*
T0
�
Mgradients_1/critic/q/q1_encoding/q1_encoder/hidden_1/Sigmoid_grad/SigmoidGradSigmoidGrad0critic/q/q1_encoding/q1_encoder/hidden_1/SigmoidXgradients_1/critic/q/q1_encoding/q1_encoder/hidden_1/Mul_grad/tuple/control_dependency_1*
T0
�
Mgradients_1/critic/q/q2_encoding/q2_encoder/hidden_1/Sigmoid_grad/SigmoidGradSigmoidGrad0critic/q/q2_encoding/q2_encoder/hidden_1/SigmoidXgradients_1/critic/q/q2_encoding/q2_encoder/hidden_1/Mul_grad/tuple/control_dependency_1*
T0
�
gradients_1/AddNAddNKgradients_1/critic/value/encoder/hidden_1/Mul_grad/tuple/control_dependencyBgradients_1/critic/value/encoder/hidden_1/Sigmoid_grad/SigmoidGrad*
N*
T0*M
_classC
A?loc:@gradients_1/critic/value/encoder/hidden_1/Mul_grad/Reshape
�
Bgradients_1/critic/value/encoder/hidden_1/BiasAdd_grad/BiasAddGradBiasAddGradgradients_1/AddN*
T0*
data_formatNHWC
�
Ggradients_1/critic/value/encoder/hidden_1/BiasAdd_grad/tuple/group_depsNoOp^gradients_1/AddNC^gradients_1/critic/value/encoder/hidden_1/BiasAdd_grad/BiasAddGrad^sac_policy_opt
�
Ogradients_1/critic/value/encoder/hidden_1/BiasAdd_grad/tuple/control_dependencyIdentitygradients_1/AddNH^gradients_1/critic/value/encoder/hidden_1/BiasAdd_grad/tuple/group_deps*
T0*M
_classC
A?loc:@gradients_1/critic/value/encoder/hidden_1/Mul_grad/Reshape
�
Qgradients_1/critic/value/encoder/hidden_1/BiasAdd_grad/tuple/control_dependency_1IdentityBgradients_1/critic/value/encoder/hidden_1/BiasAdd_grad/BiasAddGradH^gradients_1/critic/value/encoder/hidden_1/BiasAdd_grad/tuple/group_deps*
T0*U
_classK
IGloc:@gradients_1/critic/value/encoder/hidden_1/BiasAdd_grad/BiasAddGrad
�
gradients_1/AddN_1AddNVgradients_1/critic/q/q1_encoding/q1_encoder/hidden_1/Mul_grad/tuple/control_dependencyMgradients_1/critic/q/q1_encoding/q1_encoder/hidden_1/Sigmoid_grad/SigmoidGrad*
N*
T0*X
_classN
LJloc:@gradients_1/critic/q/q1_encoding/q1_encoder/hidden_1/Mul_grad/Reshape
�
Mgradients_1/critic/q/q1_encoding/q1_encoder/hidden_1/BiasAdd_grad/BiasAddGradBiasAddGradgradients_1/AddN_1*
T0*
data_formatNHWC
�
Rgradients_1/critic/q/q1_encoding/q1_encoder/hidden_1/BiasAdd_grad/tuple/group_depsNoOp^gradients_1/AddN_1N^gradients_1/critic/q/q1_encoding/q1_encoder/hidden_1/BiasAdd_grad/BiasAddGrad^sac_policy_opt
�
Zgradients_1/critic/q/q1_encoding/q1_encoder/hidden_1/BiasAdd_grad/tuple/control_dependencyIdentitygradients_1/AddN_1S^gradients_1/critic/q/q1_encoding/q1_encoder/hidden_1/BiasAdd_grad/tuple/group_deps*
T0*X
_classN
LJloc:@gradients_1/critic/q/q1_encoding/q1_encoder/hidden_1/Mul_grad/Reshape
�
\gradients_1/critic/q/q1_encoding/q1_encoder/hidden_1/BiasAdd_grad/tuple/control_dependency_1IdentityMgradients_1/critic/q/q1_encoding/q1_encoder/hidden_1/BiasAdd_grad/BiasAddGradS^gradients_1/critic/q/q1_encoding/q1_encoder/hidden_1/BiasAdd_grad/tuple/group_deps*
T0*`
_classV
TRloc:@gradients_1/critic/q/q1_encoding/q1_encoder/hidden_1/BiasAdd_grad/BiasAddGrad
�
gradients_1/AddN_2AddNVgradients_1/critic/q/q2_encoding/q2_encoder/hidden_1/Mul_grad/tuple/control_dependencyMgradients_1/critic/q/q2_encoding/q2_encoder/hidden_1/Sigmoid_grad/SigmoidGrad*
N*
T0*X
_classN
LJloc:@gradients_1/critic/q/q2_encoding/q2_encoder/hidden_1/Mul_grad/Reshape
�
Mgradients_1/critic/q/q2_encoding/q2_encoder/hidden_1/BiasAdd_grad/BiasAddGradBiasAddGradgradients_1/AddN_2*
T0*
data_formatNHWC
�
Rgradients_1/critic/q/q2_encoding/q2_encoder/hidden_1/BiasAdd_grad/tuple/group_depsNoOp^gradients_1/AddN_2N^gradients_1/critic/q/q2_encoding/q2_encoder/hidden_1/BiasAdd_grad/BiasAddGrad^sac_policy_opt
�
Zgradients_1/critic/q/q2_encoding/q2_encoder/hidden_1/BiasAdd_grad/tuple/control_dependencyIdentitygradients_1/AddN_2S^gradients_1/critic/q/q2_encoding/q2_encoder/hidden_1/BiasAdd_grad/tuple/group_deps*
T0*X
_classN
LJloc:@gradients_1/critic/q/q2_encoding/q2_encoder/hidden_1/Mul_grad/Reshape
�
\gradients_1/critic/q/q2_encoding/q2_encoder/hidden_1/BiasAdd_grad/tuple/control_dependency_1IdentityMgradients_1/critic/q/q2_encoding/q2_encoder/hidden_1/BiasAdd_grad/BiasAddGradS^gradients_1/critic/q/q2_encoding/q2_encoder/hidden_1/BiasAdd_grad/tuple/group_deps*
T0*`
_classV
TRloc:@gradients_1/critic/q/q2_encoding/q2_encoder/hidden_1/BiasAdd_grad/BiasAddGrad
�
<gradients_1/critic/value/encoder/hidden_1/MatMul_grad/MatMulMatMulOgradients_1/critic/value/encoder/hidden_1/BiasAdd_grad/tuple/control_dependency)critic/value/encoder/hidden_1/kernel/read*
T0*
transpose_a( *
transpose_b(
�
>gradients_1/critic/value/encoder/hidden_1/MatMul_grad/MatMul_1MatMul!critic/value/encoder/hidden_0/MulOgradients_1/critic/value/encoder/hidden_1/BiasAdd_grad/tuple/control_dependency*
T0*
transpose_a(*
transpose_b( 
�
Fgradients_1/critic/value/encoder/hidden_1/MatMul_grad/tuple/group_depsNoOp=^gradients_1/critic/value/encoder/hidden_1/MatMul_grad/MatMul?^gradients_1/critic/value/encoder/hidden_1/MatMul_grad/MatMul_1^sac_policy_opt
�
Ngradients_1/critic/value/encoder/hidden_1/MatMul_grad/tuple/control_dependencyIdentity<gradients_1/critic/value/encoder/hidden_1/MatMul_grad/MatMulG^gradients_1/critic/value/encoder/hidden_1/MatMul_grad/tuple/group_deps*
T0*O
_classE
CAloc:@gradients_1/critic/value/encoder/hidden_1/MatMul_grad/MatMul
�
Pgradients_1/critic/value/encoder/hidden_1/MatMul_grad/tuple/control_dependency_1Identity>gradients_1/critic/value/encoder/hidden_1/MatMul_grad/MatMul_1G^gradients_1/critic/value/encoder/hidden_1/MatMul_grad/tuple/group_deps*
T0*Q
_classG
ECloc:@gradients_1/critic/value/encoder/hidden_1/MatMul_grad/MatMul_1
�
Ggradients_1/critic/q/q1_encoding/q1_encoder/hidden_1/MatMul_grad/MatMulMatMulZgradients_1/critic/q/q1_encoding/q1_encoder/hidden_1/BiasAdd_grad/tuple/control_dependency4critic/q/q1_encoding/q1_encoder/hidden_1/kernel/read*
T0*
transpose_a( *
transpose_b(
�
Igradients_1/critic/q/q1_encoding/q1_encoder/hidden_1/MatMul_grad/MatMul_1MatMul,critic/q/q1_encoding/q1_encoder/hidden_0/MulZgradients_1/critic/q/q1_encoding/q1_encoder/hidden_1/BiasAdd_grad/tuple/control_dependency*
T0*
transpose_a(*
transpose_b( 
�
Qgradients_1/critic/q/q1_encoding/q1_encoder/hidden_1/MatMul_grad/tuple/group_depsNoOpH^gradients_1/critic/q/q1_encoding/q1_encoder/hidden_1/MatMul_grad/MatMulJ^gradients_1/critic/q/q1_encoding/q1_encoder/hidden_1/MatMul_grad/MatMul_1^sac_policy_opt
�
Ygradients_1/critic/q/q1_encoding/q1_encoder/hidden_1/MatMul_grad/tuple/control_dependencyIdentityGgradients_1/critic/q/q1_encoding/q1_encoder/hidden_1/MatMul_grad/MatMulR^gradients_1/critic/q/q1_encoding/q1_encoder/hidden_1/MatMul_grad/tuple/group_deps*
T0*Z
_classP
NLloc:@gradients_1/critic/q/q1_encoding/q1_encoder/hidden_1/MatMul_grad/MatMul
�
[gradients_1/critic/q/q1_encoding/q1_encoder/hidden_1/MatMul_grad/tuple/control_dependency_1IdentityIgradients_1/critic/q/q1_encoding/q1_encoder/hidden_1/MatMul_grad/MatMul_1R^gradients_1/critic/q/q1_encoding/q1_encoder/hidden_1/MatMul_grad/tuple/group_deps*
T0*\
_classR
PNloc:@gradients_1/critic/q/q1_encoding/q1_encoder/hidden_1/MatMul_grad/MatMul_1
�
Ggradients_1/critic/q/q2_encoding/q2_encoder/hidden_1/MatMul_grad/MatMulMatMulZgradients_1/critic/q/q2_encoding/q2_encoder/hidden_1/BiasAdd_grad/tuple/control_dependency4critic/q/q2_encoding/q2_encoder/hidden_1/kernel/read*
T0*
transpose_a( *
transpose_b(
�
Igradients_1/critic/q/q2_encoding/q2_encoder/hidden_1/MatMul_grad/MatMul_1MatMul,critic/q/q2_encoding/q2_encoder/hidden_0/MulZgradients_1/critic/q/q2_encoding/q2_encoder/hidden_1/BiasAdd_grad/tuple/control_dependency*
T0*
transpose_a(*
transpose_b( 
�
Qgradients_1/critic/q/q2_encoding/q2_encoder/hidden_1/MatMul_grad/tuple/group_depsNoOpH^gradients_1/critic/q/q2_encoding/q2_encoder/hidden_1/MatMul_grad/MatMulJ^gradients_1/critic/q/q2_encoding/q2_encoder/hidden_1/MatMul_grad/MatMul_1^sac_policy_opt
�
Ygradients_1/critic/q/q2_encoding/q2_encoder/hidden_1/MatMul_grad/tuple/control_dependencyIdentityGgradients_1/critic/q/q2_encoding/q2_encoder/hidden_1/MatMul_grad/MatMulR^gradients_1/critic/q/q2_encoding/q2_encoder/hidden_1/MatMul_grad/tuple/group_deps*
T0*Z
_classP
NLloc:@gradients_1/critic/q/q2_encoding/q2_encoder/hidden_1/MatMul_grad/MatMul
�
[gradients_1/critic/q/q2_encoding/q2_encoder/hidden_1/MatMul_grad/tuple/control_dependency_1IdentityIgradients_1/critic/q/q2_encoding/q2_encoder/hidden_1/MatMul_grad/MatMul_1R^gradients_1/critic/q/q2_encoding/q2_encoder/hidden_1/MatMul_grad/tuple/group_deps*
T0*\
_classR
PNloc:@gradients_1/critic/q/q2_encoding/q2_encoder/hidden_1/MatMul_grad/MatMul_1
�
8gradients_1/critic/value/encoder/hidden_0/Mul_grad/ShapeShape%critic/value/encoder/hidden_0/BiasAdd^sac_policy_opt*
T0*
out_type0
�
:gradients_1/critic/value/encoder/hidden_0/Mul_grad/Shape_1Shape%critic/value/encoder/hidden_0/Sigmoid^sac_policy_opt*
T0*
out_type0
�
Hgradients_1/critic/value/encoder/hidden_0/Mul_grad/BroadcastGradientArgsBroadcastGradientArgs8gradients_1/critic/value/encoder/hidden_0/Mul_grad/Shape:gradients_1/critic/value/encoder/hidden_0/Mul_grad/Shape_1*
T0
�
6gradients_1/critic/value/encoder/hidden_0/Mul_grad/MulMulNgradients_1/critic/value/encoder/hidden_1/MatMul_grad/tuple/control_dependency%critic/value/encoder/hidden_0/Sigmoid*
T0
�
6gradients_1/critic/value/encoder/hidden_0/Mul_grad/SumSum6gradients_1/critic/value/encoder/hidden_0/Mul_grad/MulHgradients_1/critic/value/encoder/hidden_0/Mul_grad/BroadcastGradientArgs*
T0*

Tidx0*
	keep_dims( 
�
:gradients_1/critic/value/encoder/hidden_0/Mul_grad/ReshapeReshape6gradients_1/critic/value/encoder/hidden_0/Mul_grad/Sum8gradients_1/critic/value/encoder/hidden_0/Mul_grad/Shape*
T0*
Tshape0
�
8gradients_1/critic/value/encoder/hidden_0/Mul_grad/Mul_1Mul%critic/value/encoder/hidden_0/BiasAddNgradients_1/critic/value/encoder/hidden_1/MatMul_grad/tuple/control_dependency*
T0
�
8gradients_1/critic/value/encoder/hidden_0/Mul_grad/Sum_1Sum8gradients_1/critic/value/encoder/hidden_0/Mul_grad/Mul_1Jgradients_1/critic/value/encoder/hidden_0/Mul_grad/BroadcastGradientArgs:1*
T0*

Tidx0*
	keep_dims( 
�
<gradients_1/critic/value/encoder/hidden_0/Mul_grad/Reshape_1Reshape8gradients_1/critic/value/encoder/hidden_0/Mul_grad/Sum_1:gradients_1/critic/value/encoder/hidden_0/Mul_grad/Shape_1*
T0*
Tshape0
�
Cgradients_1/critic/value/encoder/hidden_0/Mul_grad/tuple/group_depsNoOp;^gradients_1/critic/value/encoder/hidden_0/Mul_grad/Reshape=^gradients_1/critic/value/encoder/hidden_0/Mul_grad/Reshape_1^sac_policy_opt
�
Kgradients_1/critic/value/encoder/hidden_0/Mul_grad/tuple/control_dependencyIdentity:gradients_1/critic/value/encoder/hidden_0/Mul_grad/ReshapeD^gradients_1/critic/value/encoder/hidden_0/Mul_grad/tuple/group_deps*
T0*M
_classC
A?loc:@gradients_1/critic/value/encoder/hidden_0/Mul_grad/Reshape
�
Mgradients_1/critic/value/encoder/hidden_0/Mul_grad/tuple/control_dependency_1Identity<gradients_1/critic/value/encoder/hidden_0/Mul_grad/Reshape_1D^gradients_1/critic/value/encoder/hidden_0/Mul_grad/tuple/group_deps*
T0*O
_classE
CAloc:@gradients_1/critic/value/encoder/hidden_0/Mul_grad/Reshape_1
�
Cgradients_1/critic/q/q1_encoding/q1_encoder/hidden_0/Mul_grad/ShapeShape0critic/q/q1_encoding/q1_encoder/hidden_0/BiasAdd^sac_policy_opt*
T0*
out_type0
�
Egradients_1/critic/q/q1_encoding/q1_encoder/hidden_0/Mul_grad/Shape_1Shape0critic/q/q1_encoding/q1_encoder/hidden_0/Sigmoid^sac_policy_opt*
T0*
out_type0
�
Sgradients_1/critic/q/q1_encoding/q1_encoder/hidden_0/Mul_grad/BroadcastGradientArgsBroadcastGradientArgsCgradients_1/critic/q/q1_encoding/q1_encoder/hidden_0/Mul_grad/ShapeEgradients_1/critic/q/q1_encoding/q1_encoder/hidden_0/Mul_grad/Shape_1*
T0
�
Agradients_1/critic/q/q1_encoding/q1_encoder/hidden_0/Mul_grad/MulMulYgradients_1/critic/q/q1_encoding/q1_encoder/hidden_1/MatMul_grad/tuple/control_dependency0critic/q/q1_encoding/q1_encoder/hidden_0/Sigmoid*
T0
�
Agradients_1/critic/q/q1_encoding/q1_encoder/hidden_0/Mul_grad/SumSumAgradients_1/critic/q/q1_encoding/q1_encoder/hidden_0/Mul_grad/MulSgradients_1/critic/q/q1_encoding/q1_encoder/hidden_0/Mul_grad/BroadcastGradientArgs*
T0*

Tidx0*
	keep_dims( 
�
Egradients_1/critic/q/q1_encoding/q1_encoder/hidden_0/Mul_grad/ReshapeReshapeAgradients_1/critic/q/q1_encoding/q1_encoder/hidden_0/Mul_grad/SumCgradients_1/critic/q/q1_encoding/q1_encoder/hidden_0/Mul_grad/Shape*
T0*
Tshape0
�
Cgradients_1/critic/q/q1_encoding/q1_encoder/hidden_0/Mul_grad/Mul_1Mul0critic/q/q1_encoding/q1_encoder/hidden_0/BiasAddYgradients_1/critic/q/q1_encoding/q1_encoder/hidden_1/MatMul_grad/tuple/control_dependency*
T0
�
Cgradients_1/critic/q/q1_encoding/q1_encoder/hidden_0/Mul_grad/Sum_1SumCgradients_1/critic/q/q1_encoding/q1_encoder/hidden_0/Mul_grad/Mul_1Ugradients_1/critic/q/q1_encoding/q1_encoder/hidden_0/Mul_grad/BroadcastGradientArgs:1*
T0*

Tidx0*
	keep_dims( 
�
Ggradients_1/critic/q/q1_encoding/q1_encoder/hidden_0/Mul_grad/Reshape_1ReshapeCgradients_1/critic/q/q1_encoding/q1_encoder/hidden_0/Mul_grad/Sum_1Egradients_1/critic/q/q1_encoding/q1_encoder/hidden_0/Mul_grad/Shape_1*
T0*
Tshape0
�
Ngradients_1/critic/q/q1_encoding/q1_encoder/hidden_0/Mul_grad/tuple/group_depsNoOpF^gradients_1/critic/q/q1_encoding/q1_encoder/hidden_0/Mul_grad/ReshapeH^gradients_1/critic/q/q1_encoding/q1_encoder/hidden_0/Mul_grad/Reshape_1^sac_policy_opt
�
Vgradients_1/critic/q/q1_encoding/q1_encoder/hidden_0/Mul_grad/tuple/control_dependencyIdentityEgradients_1/critic/q/q1_encoding/q1_encoder/hidden_0/Mul_grad/ReshapeO^gradients_1/critic/q/q1_encoding/q1_encoder/hidden_0/Mul_grad/tuple/group_deps*
T0*X
_classN
LJloc:@gradients_1/critic/q/q1_encoding/q1_encoder/hidden_0/Mul_grad/Reshape
�
Xgradients_1/critic/q/q1_encoding/q1_encoder/hidden_0/Mul_grad/tuple/control_dependency_1IdentityGgradients_1/critic/q/q1_encoding/q1_encoder/hidden_0/Mul_grad/Reshape_1O^gradients_1/critic/q/q1_encoding/q1_encoder/hidden_0/Mul_grad/tuple/group_deps*
T0*Z
_classP
NLloc:@gradients_1/critic/q/q1_encoding/q1_encoder/hidden_0/Mul_grad/Reshape_1
�
Cgradients_1/critic/q/q2_encoding/q2_encoder/hidden_0/Mul_grad/ShapeShape0critic/q/q2_encoding/q2_encoder/hidden_0/BiasAdd^sac_policy_opt*
T0*
out_type0
�
Egradients_1/critic/q/q2_encoding/q2_encoder/hidden_0/Mul_grad/Shape_1Shape0critic/q/q2_encoding/q2_encoder/hidden_0/Sigmoid^sac_policy_opt*
T0*
out_type0
�
Sgradients_1/critic/q/q2_encoding/q2_encoder/hidden_0/Mul_grad/BroadcastGradientArgsBroadcastGradientArgsCgradients_1/critic/q/q2_encoding/q2_encoder/hidden_0/Mul_grad/ShapeEgradients_1/critic/q/q2_encoding/q2_encoder/hidden_0/Mul_grad/Shape_1*
T0
�
Agradients_1/critic/q/q2_encoding/q2_encoder/hidden_0/Mul_grad/MulMulYgradients_1/critic/q/q2_encoding/q2_encoder/hidden_1/MatMul_grad/tuple/control_dependency0critic/q/q2_encoding/q2_encoder/hidden_0/Sigmoid*
T0
�
Agradients_1/critic/q/q2_encoding/q2_encoder/hidden_0/Mul_grad/SumSumAgradients_1/critic/q/q2_encoding/q2_encoder/hidden_0/Mul_grad/MulSgradients_1/critic/q/q2_encoding/q2_encoder/hidden_0/Mul_grad/BroadcastGradientArgs*
T0*

Tidx0*
	keep_dims( 
�
Egradients_1/critic/q/q2_encoding/q2_encoder/hidden_0/Mul_grad/ReshapeReshapeAgradients_1/critic/q/q2_encoding/q2_encoder/hidden_0/Mul_grad/SumCgradients_1/critic/q/q2_encoding/q2_encoder/hidden_0/Mul_grad/Shape*
T0*
Tshape0
�
Cgradients_1/critic/q/q2_encoding/q2_encoder/hidden_0/Mul_grad/Mul_1Mul0critic/q/q2_encoding/q2_encoder/hidden_0/BiasAddYgradients_1/critic/q/q2_encoding/q2_encoder/hidden_1/MatMul_grad/tuple/control_dependency*
T0
�
Cgradients_1/critic/q/q2_encoding/q2_encoder/hidden_0/Mul_grad/Sum_1SumCgradients_1/critic/q/q2_encoding/q2_encoder/hidden_0/Mul_grad/Mul_1Ugradients_1/critic/q/q2_encoding/q2_encoder/hidden_0/Mul_grad/BroadcastGradientArgs:1*
T0*

Tidx0*
	keep_dims( 
�
Ggradients_1/critic/q/q2_encoding/q2_encoder/hidden_0/Mul_grad/Reshape_1ReshapeCgradients_1/critic/q/q2_encoding/q2_encoder/hidden_0/Mul_grad/Sum_1Egradients_1/critic/q/q2_encoding/q2_encoder/hidden_0/Mul_grad/Shape_1*
T0*
Tshape0
�
Ngradients_1/critic/q/q2_encoding/q2_encoder/hidden_0/Mul_grad/tuple/group_depsNoOpF^gradients_1/critic/q/q2_encoding/q2_encoder/hidden_0/Mul_grad/ReshapeH^gradients_1/critic/q/q2_encoding/q2_encoder/hidden_0/Mul_grad/Reshape_1^sac_policy_opt
�
Vgradients_1/critic/q/q2_encoding/q2_encoder/hidden_0/Mul_grad/tuple/control_dependencyIdentityEgradients_1/critic/q/q2_encoding/q2_encoder/hidden_0/Mul_grad/ReshapeO^gradients_1/critic/q/q2_encoding/q2_encoder/hidden_0/Mul_grad/tuple/group_deps*
T0*X
_classN
LJloc:@gradients_1/critic/q/q2_encoding/q2_encoder/hidden_0/Mul_grad/Reshape
�
Xgradients_1/critic/q/q2_encoding/q2_encoder/hidden_0/Mul_grad/tuple/control_dependency_1IdentityGgradients_1/critic/q/q2_encoding/q2_encoder/hidden_0/Mul_grad/Reshape_1O^gradients_1/critic/q/q2_encoding/q2_encoder/hidden_0/Mul_grad/tuple/group_deps*
T0*Z
_classP
NLloc:@gradients_1/critic/q/q2_encoding/q2_encoder/hidden_0/Mul_grad/Reshape_1
�
Bgradients_1/critic/value/encoder/hidden_0/Sigmoid_grad/SigmoidGradSigmoidGrad%critic/value/encoder/hidden_0/SigmoidMgradients_1/critic/value/encoder/hidden_0/Mul_grad/tuple/control_dependency_1*
T0
�
Mgradients_1/critic/q/q1_encoding/q1_encoder/hidden_0/Sigmoid_grad/SigmoidGradSigmoidGrad0critic/q/q1_encoding/q1_encoder/hidden_0/SigmoidXgradients_1/critic/q/q1_encoding/q1_encoder/hidden_0/Mul_grad/tuple/control_dependency_1*
T0
�
Mgradients_1/critic/q/q2_encoding/q2_encoder/hidden_0/Sigmoid_grad/SigmoidGradSigmoidGrad0critic/q/q2_encoding/q2_encoder/hidden_0/SigmoidXgradients_1/critic/q/q2_encoding/q2_encoder/hidden_0/Mul_grad/tuple/control_dependency_1*
T0
�
gradients_1/AddN_3AddNKgradients_1/critic/value/encoder/hidden_0/Mul_grad/tuple/control_dependencyBgradients_1/critic/value/encoder/hidden_0/Sigmoid_grad/SigmoidGrad*
N*
T0*M
_classC
A?loc:@gradients_1/critic/value/encoder/hidden_0/Mul_grad/Reshape
�
Bgradients_1/critic/value/encoder/hidden_0/BiasAdd_grad/BiasAddGradBiasAddGradgradients_1/AddN_3*
T0*
data_formatNHWC
�
Ggradients_1/critic/value/encoder/hidden_0/BiasAdd_grad/tuple/group_depsNoOp^gradients_1/AddN_3C^gradients_1/critic/value/encoder/hidden_0/BiasAdd_grad/BiasAddGrad^sac_policy_opt
�
Ogradients_1/critic/value/encoder/hidden_0/BiasAdd_grad/tuple/control_dependencyIdentitygradients_1/AddN_3H^gradients_1/critic/value/encoder/hidden_0/BiasAdd_grad/tuple/group_deps*
T0*M
_classC
A?loc:@gradients_1/critic/value/encoder/hidden_0/Mul_grad/Reshape
�
Qgradients_1/critic/value/encoder/hidden_0/BiasAdd_grad/tuple/control_dependency_1IdentityBgradients_1/critic/value/encoder/hidden_0/BiasAdd_grad/BiasAddGradH^gradients_1/critic/value/encoder/hidden_0/BiasAdd_grad/tuple/group_deps*
T0*U
_classK
IGloc:@gradients_1/critic/value/encoder/hidden_0/BiasAdd_grad/BiasAddGrad
�
gradients_1/AddN_4AddNVgradients_1/critic/q/q1_encoding/q1_encoder/hidden_0/Mul_grad/tuple/control_dependencyMgradients_1/critic/q/q1_encoding/q1_encoder/hidden_0/Sigmoid_grad/SigmoidGrad*
N*
T0*X
_classN
LJloc:@gradients_1/critic/q/q1_encoding/q1_encoder/hidden_0/Mul_grad/Reshape
�
Mgradients_1/critic/q/q1_encoding/q1_encoder/hidden_0/BiasAdd_grad/BiasAddGradBiasAddGradgradients_1/AddN_4*
T0*
data_formatNHWC
�
Rgradients_1/critic/q/q1_encoding/q1_encoder/hidden_0/BiasAdd_grad/tuple/group_depsNoOp^gradients_1/AddN_4N^gradients_1/critic/q/q1_encoding/q1_encoder/hidden_0/BiasAdd_grad/BiasAddGrad^sac_policy_opt
�
Zgradients_1/critic/q/q1_encoding/q1_encoder/hidden_0/BiasAdd_grad/tuple/control_dependencyIdentitygradients_1/AddN_4S^gradients_1/critic/q/q1_encoding/q1_encoder/hidden_0/BiasAdd_grad/tuple/group_deps*
T0*X
_classN
LJloc:@gradients_1/critic/q/q1_encoding/q1_encoder/hidden_0/Mul_grad/Reshape
�
\gradients_1/critic/q/q1_encoding/q1_encoder/hidden_0/BiasAdd_grad/tuple/control_dependency_1IdentityMgradients_1/critic/q/q1_encoding/q1_encoder/hidden_0/BiasAdd_grad/BiasAddGradS^gradients_1/critic/q/q1_encoding/q1_encoder/hidden_0/BiasAdd_grad/tuple/group_deps*
T0*`
_classV
TRloc:@gradients_1/critic/q/q1_encoding/q1_encoder/hidden_0/BiasAdd_grad/BiasAddGrad
�
gradients_1/AddN_5AddNVgradients_1/critic/q/q2_encoding/q2_encoder/hidden_0/Mul_grad/tuple/control_dependencyMgradients_1/critic/q/q2_encoding/q2_encoder/hidden_0/Sigmoid_grad/SigmoidGrad*
N*
T0*X
_classN
LJloc:@gradients_1/critic/q/q2_encoding/q2_encoder/hidden_0/Mul_grad/Reshape
�
Mgradients_1/critic/q/q2_encoding/q2_encoder/hidden_0/BiasAdd_grad/BiasAddGradBiasAddGradgradients_1/AddN_5*
T0*
data_formatNHWC
�
Rgradients_1/critic/q/q2_encoding/q2_encoder/hidden_0/BiasAdd_grad/tuple/group_depsNoOp^gradients_1/AddN_5N^gradients_1/critic/q/q2_encoding/q2_encoder/hidden_0/BiasAdd_grad/BiasAddGrad^sac_policy_opt
�
Zgradients_1/critic/q/q2_encoding/q2_encoder/hidden_0/BiasAdd_grad/tuple/control_dependencyIdentitygradients_1/AddN_5S^gradients_1/critic/q/q2_encoding/q2_encoder/hidden_0/BiasAdd_grad/tuple/group_deps*
T0*X
_classN
LJloc:@gradients_1/critic/q/q2_encoding/q2_encoder/hidden_0/Mul_grad/Reshape
�
\gradients_1/critic/q/q2_encoding/q2_encoder/hidden_0/BiasAdd_grad/tuple/control_dependency_1IdentityMgradients_1/critic/q/q2_encoding/q2_encoder/hidden_0/BiasAdd_grad/BiasAddGradS^gradients_1/critic/q/q2_encoding/q2_encoder/hidden_0/BiasAdd_grad/tuple/group_deps*
T0*`
_classV
TRloc:@gradients_1/critic/q/q2_encoding/q2_encoder/hidden_0/BiasAdd_grad/BiasAddGrad
�
<gradients_1/critic/value/encoder/hidden_0/MatMul_grad/MatMulMatMulOgradients_1/critic/value/encoder/hidden_0/BiasAdd_grad/tuple/control_dependency)critic/value/encoder/hidden_0/kernel/read*
T0*
transpose_a( *
transpose_b(
�
>gradients_1/critic/value/encoder/hidden_0/MatMul_grad/MatMul_1MatMulnormalized_stateOgradients_1/critic/value/encoder/hidden_0/BiasAdd_grad/tuple/control_dependency*
T0*
transpose_a(*
transpose_b( 
�
Fgradients_1/critic/value/encoder/hidden_0/MatMul_grad/tuple/group_depsNoOp=^gradients_1/critic/value/encoder/hidden_0/MatMul_grad/MatMul?^gradients_1/critic/value/encoder/hidden_0/MatMul_grad/MatMul_1^sac_policy_opt
�
Ngradients_1/critic/value/encoder/hidden_0/MatMul_grad/tuple/control_dependencyIdentity<gradients_1/critic/value/encoder/hidden_0/MatMul_grad/MatMulG^gradients_1/critic/value/encoder/hidden_0/MatMul_grad/tuple/group_deps*
T0*O
_classE
CAloc:@gradients_1/critic/value/encoder/hidden_0/MatMul_grad/MatMul
�
Pgradients_1/critic/value/encoder/hidden_0/MatMul_grad/tuple/control_dependency_1Identity>gradients_1/critic/value/encoder/hidden_0/MatMul_grad/MatMul_1G^gradients_1/critic/value/encoder/hidden_0/MatMul_grad/tuple/group_deps*
T0*Q
_classG
ECloc:@gradients_1/critic/value/encoder/hidden_0/MatMul_grad/MatMul_1
�
Ggradients_1/critic/q/q1_encoding/q1_encoder/hidden_0/MatMul_grad/MatMulMatMulZgradients_1/critic/q/q1_encoding/q1_encoder/hidden_0/BiasAdd_grad/tuple/control_dependency4critic/q/q1_encoding/q1_encoder/hidden_0/kernel/read*
T0*
transpose_a( *
transpose_b(
�
Igradients_1/critic/q/q1_encoding/q1_encoder/hidden_0/MatMul_grad/MatMul_1MatMulconcatZgradients_1/critic/q/q1_encoding/q1_encoder/hidden_0/BiasAdd_grad/tuple/control_dependency*
T0*
transpose_a(*
transpose_b( 
�
Qgradients_1/critic/q/q1_encoding/q1_encoder/hidden_0/MatMul_grad/tuple/group_depsNoOpH^gradients_1/critic/q/q1_encoding/q1_encoder/hidden_0/MatMul_grad/MatMulJ^gradients_1/critic/q/q1_encoding/q1_encoder/hidden_0/MatMul_grad/MatMul_1^sac_policy_opt
�
Ygradients_1/critic/q/q1_encoding/q1_encoder/hidden_0/MatMul_grad/tuple/control_dependencyIdentityGgradients_1/critic/q/q1_encoding/q1_encoder/hidden_0/MatMul_grad/MatMulR^gradients_1/critic/q/q1_encoding/q1_encoder/hidden_0/MatMul_grad/tuple/group_deps*
T0*Z
_classP
NLloc:@gradients_1/critic/q/q1_encoding/q1_encoder/hidden_0/MatMul_grad/MatMul
�
[gradients_1/critic/q/q1_encoding/q1_encoder/hidden_0/MatMul_grad/tuple/control_dependency_1IdentityIgradients_1/critic/q/q1_encoding/q1_encoder/hidden_0/MatMul_grad/MatMul_1R^gradients_1/critic/q/q1_encoding/q1_encoder/hidden_0/MatMul_grad/tuple/group_deps*
T0*\
_classR
PNloc:@gradients_1/critic/q/q1_encoding/q1_encoder/hidden_0/MatMul_grad/MatMul_1
�
Ggradients_1/critic/q/q2_encoding/q2_encoder/hidden_0/MatMul_grad/MatMulMatMulZgradients_1/critic/q/q2_encoding/q2_encoder/hidden_0/BiasAdd_grad/tuple/control_dependency4critic/q/q2_encoding/q2_encoder/hidden_0/kernel/read*
T0*
transpose_a( *
transpose_b(
�
Igradients_1/critic/q/q2_encoding/q2_encoder/hidden_0/MatMul_grad/MatMul_1MatMulconcatZgradients_1/critic/q/q2_encoding/q2_encoder/hidden_0/BiasAdd_grad/tuple/control_dependency*
T0*
transpose_a(*
transpose_b( 
�
Qgradients_1/critic/q/q2_encoding/q2_encoder/hidden_0/MatMul_grad/tuple/group_depsNoOpH^gradients_1/critic/q/q2_encoding/q2_encoder/hidden_0/MatMul_grad/MatMulJ^gradients_1/critic/q/q2_encoding/q2_encoder/hidden_0/MatMul_grad/MatMul_1^sac_policy_opt
�
Ygradients_1/critic/q/q2_encoding/q2_encoder/hidden_0/MatMul_grad/tuple/control_dependencyIdentityGgradients_1/critic/q/q2_encoding/q2_encoder/hidden_0/MatMul_grad/MatMulR^gradients_1/critic/q/q2_encoding/q2_encoder/hidden_0/MatMul_grad/tuple/group_deps*
T0*Z
_classP
NLloc:@gradients_1/critic/q/q2_encoding/q2_encoder/hidden_0/MatMul_grad/MatMul
�
[gradients_1/critic/q/q2_encoding/q2_encoder/hidden_0/MatMul_grad/tuple/control_dependency_1IdentityIgradients_1/critic/q/q2_encoding/q2_encoder/hidden_0/MatMul_grad/MatMul_1R^gradients_1/critic/q/q2_encoding/q2_encoder/hidden_0/MatMul_grad/tuple/group_deps*
T0*\
_classR
PNloc:@gradients_1/critic/q/q2_encoding/q2_encoder/hidden_0/MatMul_grad/MatMul_1
�
beta1_power_1/initial_valueConst*9
_class/
-+loc:@critic/q/q1_encoding/extrinsic_q1/bias*
dtype0*
valueB
 *fff?
�
beta1_power_1
VariableV2*9
_class/
-+loc:@critic/q/q1_encoding/extrinsic_q1/bias*
	container *
dtype0*
shape: *
shared_name 
�
beta1_power_1/AssignAssignbeta1_power_1beta1_power_1/initial_value*
T0*9
_class/
-+loc:@critic/q/q1_encoding/extrinsic_q1/bias*
use_locking(*
validate_shape(
q
beta1_power_1/readIdentitybeta1_power_1*
T0*9
_class/
-+loc:@critic/q/q1_encoding/extrinsic_q1/bias
�
beta2_power_1/initial_valueConst*9
_class/
-+loc:@critic/q/q1_encoding/extrinsic_q1/bias*
dtype0*
valueB
 *w�?
�
beta2_power_1
VariableV2*9
_class/
-+loc:@critic/q/q1_encoding/extrinsic_q1/bias*
	container *
dtype0*
shape: *
shared_name 
�
beta2_power_1/AssignAssignbeta2_power_1beta2_power_1/initial_value*
T0*9
_class/
-+loc:@critic/q/q1_encoding/extrinsic_q1/bias*
use_locking(*
validate_shape(
q
beta2_power_1/readIdentitybeta2_power_1*
T0*9
_class/
-+loc:@critic/q/q1_encoding/extrinsic_q1/bias
�
Dcritic/value/encoder/hidden_0/kernel/sac_value_opt/Initializer/zerosConst*7
_class-
+)loc:@critic/value/encoder/hidden_0/kernel*
dtype0*
valueB@*    
�
2critic/value/encoder/hidden_0/kernel/sac_value_opt
VariableV2*7
_class-
+)loc:@critic/value/encoder/hidden_0/kernel*
	container *
dtype0*
shape
:@*
shared_name 
�
9critic/value/encoder/hidden_0/kernel/sac_value_opt/AssignAssign2critic/value/encoder/hidden_0/kernel/sac_value_optDcritic/value/encoder/hidden_0/kernel/sac_value_opt/Initializer/zeros*
T0*7
_class-
+)loc:@critic/value/encoder/hidden_0/kernel*
use_locking(*
validate_shape(
�
7critic/value/encoder/hidden_0/kernel/sac_value_opt/readIdentity2critic/value/encoder/hidden_0/kernel/sac_value_opt*
T0*7
_class-
+)loc:@critic/value/encoder/hidden_0/kernel
�
Fcritic/value/encoder/hidden_0/kernel/sac_value_opt_1/Initializer/zerosConst*7
_class-
+)loc:@critic/value/encoder/hidden_0/kernel*
dtype0*
valueB@*    
�
4critic/value/encoder/hidden_0/kernel/sac_value_opt_1
VariableV2*7
_class-
+)loc:@critic/value/encoder/hidden_0/kernel*
	container *
dtype0*
shape
:@*
shared_name 
�
;critic/value/encoder/hidden_0/kernel/sac_value_opt_1/AssignAssign4critic/value/encoder/hidden_0/kernel/sac_value_opt_1Fcritic/value/encoder/hidden_0/kernel/sac_value_opt_1/Initializer/zeros*
T0*7
_class-
+)loc:@critic/value/encoder/hidden_0/kernel*
use_locking(*
validate_shape(
�
9critic/value/encoder/hidden_0/kernel/sac_value_opt_1/readIdentity4critic/value/encoder/hidden_0/kernel/sac_value_opt_1*
T0*7
_class-
+)loc:@critic/value/encoder/hidden_0/kernel
�
Bcritic/value/encoder/hidden_0/bias/sac_value_opt/Initializer/zerosConst*5
_class+
)'loc:@critic/value/encoder/hidden_0/bias*
dtype0*
valueB@*    
�
0critic/value/encoder/hidden_0/bias/sac_value_opt
VariableV2*5
_class+
)'loc:@critic/value/encoder/hidden_0/bias*
	container *
dtype0*
shape:@*
shared_name 
�
7critic/value/encoder/hidden_0/bias/sac_value_opt/AssignAssign0critic/value/encoder/hidden_0/bias/sac_value_optBcritic/value/encoder/hidden_0/bias/sac_value_opt/Initializer/zeros*
T0*5
_class+
)'loc:@critic/value/encoder/hidden_0/bias*
use_locking(*
validate_shape(
�
5critic/value/encoder/hidden_0/bias/sac_value_opt/readIdentity0critic/value/encoder/hidden_0/bias/sac_value_opt*
T0*5
_class+
)'loc:@critic/value/encoder/hidden_0/bias
�
Dcritic/value/encoder/hidden_0/bias/sac_value_opt_1/Initializer/zerosConst*5
_class+
)'loc:@critic/value/encoder/hidden_0/bias*
dtype0*
valueB@*    
�
2critic/value/encoder/hidden_0/bias/sac_value_opt_1
VariableV2*5
_class+
)'loc:@critic/value/encoder/hidden_0/bias*
	container *
dtype0*
shape:@*
shared_name 
�
9critic/value/encoder/hidden_0/bias/sac_value_opt_1/AssignAssign2critic/value/encoder/hidden_0/bias/sac_value_opt_1Dcritic/value/encoder/hidden_0/bias/sac_value_opt_1/Initializer/zeros*
T0*5
_class+
)'loc:@critic/value/encoder/hidden_0/bias*
use_locking(*
validate_shape(
�
7critic/value/encoder/hidden_0/bias/sac_value_opt_1/readIdentity2critic/value/encoder/hidden_0/bias/sac_value_opt_1*
T0*5
_class+
)'loc:@critic/value/encoder/hidden_0/bias
�
Tcritic/value/encoder/hidden_1/kernel/sac_value_opt/Initializer/zeros/shape_as_tensorConst*7
_class-
+)loc:@critic/value/encoder/hidden_1/kernel*
dtype0*
valueB"@   @   
�
Jcritic/value/encoder/hidden_1/kernel/sac_value_opt/Initializer/zeros/ConstConst*7
_class-
+)loc:@critic/value/encoder/hidden_1/kernel*
dtype0*
valueB
 *    
�
Dcritic/value/encoder/hidden_1/kernel/sac_value_opt/Initializer/zerosFillTcritic/value/encoder/hidden_1/kernel/sac_value_opt/Initializer/zeros/shape_as_tensorJcritic/value/encoder/hidden_1/kernel/sac_value_opt/Initializer/zeros/Const*
T0*7
_class-
+)loc:@critic/value/encoder/hidden_1/kernel*

index_type0
�
2critic/value/encoder/hidden_1/kernel/sac_value_opt
VariableV2*7
_class-
+)loc:@critic/value/encoder/hidden_1/kernel*
	container *
dtype0*
shape
:@@*
shared_name 
�
9critic/value/encoder/hidden_1/kernel/sac_value_opt/AssignAssign2critic/value/encoder/hidden_1/kernel/sac_value_optDcritic/value/encoder/hidden_1/kernel/sac_value_opt/Initializer/zeros*
T0*7
_class-
+)loc:@critic/value/encoder/hidden_1/kernel*
use_locking(*
validate_shape(
�
7critic/value/encoder/hidden_1/kernel/sac_value_opt/readIdentity2critic/value/encoder/hidden_1/kernel/sac_value_opt*
T0*7
_class-
+)loc:@critic/value/encoder/hidden_1/kernel
�
Vcritic/value/encoder/hidden_1/kernel/sac_value_opt_1/Initializer/zeros/shape_as_tensorConst*7
_class-
+)loc:@critic/value/encoder/hidden_1/kernel*
dtype0*
valueB"@   @   
�
Lcritic/value/encoder/hidden_1/kernel/sac_value_opt_1/Initializer/zeros/ConstConst*7
_class-
+)loc:@critic/value/encoder/hidden_1/kernel*
dtype0*
valueB
 *    
�
Fcritic/value/encoder/hidden_1/kernel/sac_value_opt_1/Initializer/zerosFillVcritic/value/encoder/hidden_1/kernel/sac_value_opt_1/Initializer/zeros/shape_as_tensorLcritic/value/encoder/hidden_1/kernel/sac_value_opt_1/Initializer/zeros/Const*
T0*7
_class-
+)loc:@critic/value/encoder/hidden_1/kernel*

index_type0
�
4critic/value/encoder/hidden_1/kernel/sac_value_opt_1
VariableV2*7
_class-
+)loc:@critic/value/encoder/hidden_1/kernel*
	container *
dtype0*
shape
:@@*
shared_name 
�
;critic/value/encoder/hidden_1/kernel/sac_value_opt_1/AssignAssign4critic/value/encoder/hidden_1/kernel/sac_value_opt_1Fcritic/value/encoder/hidden_1/kernel/sac_value_opt_1/Initializer/zeros*
T0*7
_class-
+)loc:@critic/value/encoder/hidden_1/kernel*
use_locking(*
validate_shape(
�
9critic/value/encoder/hidden_1/kernel/sac_value_opt_1/readIdentity4critic/value/encoder/hidden_1/kernel/sac_value_opt_1*
T0*7
_class-
+)loc:@critic/value/encoder/hidden_1/kernel
�
Bcritic/value/encoder/hidden_1/bias/sac_value_opt/Initializer/zerosConst*5
_class+
)'loc:@critic/value/encoder/hidden_1/bias*
dtype0*
valueB@*    
�
0critic/value/encoder/hidden_1/bias/sac_value_opt
VariableV2*5
_class+
)'loc:@critic/value/encoder/hidden_1/bias*
	container *
dtype0*
shape:@*
shared_name 
�
7critic/value/encoder/hidden_1/bias/sac_value_opt/AssignAssign0critic/value/encoder/hidden_1/bias/sac_value_optBcritic/value/encoder/hidden_1/bias/sac_value_opt/Initializer/zeros*
T0*5
_class+
)'loc:@critic/value/encoder/hidden_1/bias*
use_locking(*
validate_shape(
�
5critic/value/encoder/hidden_1/bias/sac_value_opt/readIdentity0critic/value/encoder/hidden_1/bias/sac_value_opt*
T0*5
_class+
)'loc:@critic/value/encoder/hidden_1/bias
�
Dcritic/value/encoder/hidden_1/bias/sac_value_opt_1/Initializer/zerosConst*5
_class+
)'loc:@critic/value/encoder/hidden_1/bias*
dtype0*
valueB@*    
�
2critic/value/encoder/hidden_1/bias/sac_value_opt_1
VariableV2*5
_class+
)'loc:@critic/value/encoder/hidden_1/bias*
	container *
dtype0*
shape:@*
shared_name 
�
9critic/value/encoder/hidden_1/bias/sac_value_opt_1/AssignAssign2critic/value/encoder/hidden_1/bias/sac_value_opt_1Dcritic/value/encoder/hidden_1/bias/sac_value_opt_1/Initializer/zeros*
T0*5
_class+
)'loc:@critic/value/encoder/hidden_1/bias*
use_locking(*
validate_shape(
�
7critic/value/encoder/hidden_1/bias/sac_value_opt_1/readIdentity2critic/value/encoder/hidden_1/bias/sac_value_opt_1*
T0*5
_class+
)'loc:@critic/value/encoder/hidden_1/bias
�
Ccritic/value/extrinsic_value/kernel/sac_value_opt/Initializer/zerosConst*6
_class,
*(loc:@critic/value/extrinsic_value/kernel*
dtype0*
valueB@*    
�
1critic/value/extrinsic_value/kernel/sac_value_opt
VariableV2*6
_class,
*(loc:@critic/value/extrinsic_value/kernel*
	container *
dtype0*
shape
:@*
shared_name 
�
8critic/value/extrinsic_value/kernel/sac_value_opt/AssignAssign1critic/value/extrinsic_value/kernel/sac_value_optCcritic/value/extrinsic_value/kernel/sac_value_opt/Initializer/zeros*
T0*6
_class,
*(loc:@critic/value/extrinsic_value/kernel*
use_locking(*
validate_shape(
�
6critic/value/extrinsic_value/kernel/sac_value_opt/readIdentity1critic/value/extrinsic_value/kernel/sac_value_opt*
T0*6
_class,
*(loc:@critic/value/extrinsic_value/kernel
�
Ecritic/value/extrinsic_value/kernel/sac_value_opt_1/Initializer/zerosConst*6
_class,
*(loc:@critic/value/extrinsic_value/kernel*
dtype0*
valueB@*    
�
3critic/value/extrinsic_value/kernel/sac_value_opt_1
VariableV2*6
_class,
*(loc:@critic/value/extrinsic_value/kernel*
	container *
dtype0*
shape
:@*
shared_name 
�
:critic/value/extrinsic_value/kernel/sac_value_opt_1/AssignAssign3critic/value/extrinsic_value/kernel/sac_value_opt_1Ecritic/value/extrinsic_value/kernel/sac_value_opt_1/Initializer/zeros*
T0*6
_class,
*(loc:@critic/value/extrinsic_value/kernel*
use_locking(*
validate_shape(
�
8critic/value/extrinsic_value/kernel/sac_value_opt_1/readIdentity3critic/value/extrinsic_value/kernel/sac_value_opt_1*
T0*6
_class,
*(loc:@critic/value/extrinsic_value/kernel
�
Acritic/value/extrinsic_value/bias/sac_value_opt/Initializer/zerosConst*4
_class*
(&loc:@critic/value/extrinsic_value/bias*
dtype0*
valueB*    
�
/critic/value/extrinsic_value/bias/sac_value_opt
VariableV2*4
_class*
(&loc:@critic/value/extrinsic_value/bias*
	container *
dtype0*
shape:*
shared_name 
�
6critic/value/extrinsic_value/bias/sac_value_opt/AssignAssign/critic/value/extrinsic_value/bias/sac_value_optAcritic/value/extrinsic_value/bias/sac_value_opt/Initializer/zeros*
T0*4
_class*
(&loc:@critic/value/extrinsic_value/bias*
use_locking(*
validate_shape(
�
4critic/value/extrinsic_value/bias/sac_value_opt/readIdentity/critic/value/extrinsic_value/bias/sac_value_opt*
T0*4
_class*
(&loc:@critic/value/extrinsic_value/bias
�
Ccritic/value/extrinsic_value/bias/sac_value_opt_1/Initializer/zerosConst*4
_class*
(&loc:@critic/value/extrinsic_value/bias*
dtype0*
valueB*    
�
1critic/value/extrinsic_value/bias/sac_value_opt_1
VariableV2*4
_class*
(&loc:@critic/value/extrinsic_value/bias*
	container *
dtype0*
shape:*
shared_name 
�
8critic/value/extrinsic_value/bias/sac_value_opt_1/AssignAssign1critic/value/extrinsic_value/bias/sac_value_opt_1Ccritic/value/extrinsic_value/bias/sac_value_opt_1/Initializer/zeros*
T0*4
_class*
(&loc:@critic/value/extrinsic_value/bias*
use_locking(*
validate_shape(
�
6critic/value/extrinsic_value/bias/sac_value_opt_1/readIdentity1critic/value/extrinsic_value/bias/sac_value_opt_1*
T0*4
_class*
(&loc:@critic/value/extrinsic_value/bias
�
Ocritic/q/q1_encoding/q1_encoder/hidden_0/kernel/sac_value_opt/Initializer/zerosConst*B
_class8
64loc:@critic/q/q1_encoding/q1_encoder/hidden_0/kernel*
dtype0*
valueB@*    
�
=critic/q/q1_encoding/q1_encoder/hidden_0/kernel/sac_value_opt
VariableV2*B
_class8
64loc:@critic/q/q1_encoding/q1_encoder/hidden_0/kernel*
	container *
dtype0*
shape
:@*
shared_name 
�
Dcritic/q/q1_encoding/q1_encoder/hidden_0/kernel/sac_value_opt/AssignAssign=critic/q/q1_encoding/q1_encoder/hidden_0/kernel/sac_value_optOcritic/q/q1_encoding/q1_encoder/hidden_0/kernel/sac_value_opt/Initializer/zeros*
T0*B
_class8
64loc:@critic/q/q1_encoding/q1_encoder/hidden_0/kernel*
use_locking(*
validate_shape(
�
Bcritic/q/q1_encoding/q1_encoder/hidden_0/kernel/sac_value_opt/readIdentity=critic/q/q1_encoding/q1_encoder/hidden_0/kernel/sac_value_opt*
T0*B
_class8
64loc:@critic/q/q1_encoding/q1_encoder/hidden_0/kernel
�
Qcritic/q/q1_encoding/q1_encoder/hidden_0/kernel/sac_value_opt_1/Initializer/zerosConst*B
_class8
64loc:@critic/q/q1_encoding/q1_encoder/hidden_0/kernel*
dtype0*
valueB@*    
�
?critic/q/q1_encoding/q1_encoder/hidden_0/kernel/sac_value_opt_1
VariableV2*B
_class8
64loc:@critic/q/q1_encoding/q1_encoder/hidden_0/kernel*
	container *
dtype0*
shape
:@*
shared_name 
�
Fcritic/q/q1_encoding/q1_encoder/hidden_0/kernel/sac_value_opt_1/AssignAssign?critic/q/q1_encoding/q1_encoder/hidden_0/kernel/sac_value_opt_1Qcritic/q/q1_encoding/q1_encoder/hidden_0/kernel/sac_value_opt_1/Initializer/zeros*
T0*B
_class8
64loc:@critic/q/q1_encoding/q1_encoder/hidden_0/kernel*
use_locking(*
validate_shape(
�
Dcritic/q/q1_encoding/q1_encoder/hidden_0/kernel/sac_value_opt_1/readIdentity?critic/q/q1_encoding/q1_encoder/hidden_0/kernel/sac_value_opt_1*
T0*B
_class8
64loc:@critic/q/q1_encoding/q1_encoder/hidden_0/kernel
�
Mcritic/q/q1_encoding/q1_encoder/hidden_0/bias/sac_value_opt/Initializer/zerosConst*@
_class6
42loc:@critic/q/q1_encoding/q1_encoder/hidden_0/bias*
dtype0*
valueB@*    
�
;critic/q/q1_encoding/q1_encoder/hidden_0/bias/sac_value_opt
VariableV2*@
_class6
42loc:@critic/q/q1_encoding/q1_encoder/hidden_0/bias*
	container *
dtype0*
shape:@*
shared_name 
�
Bcritic/q/q1_encoding/q1_encoder/hidden_0/bias/sac_value_opt/AssignAssign;critic/q/q1_encoding/q1_encoder/hidden_0/bias/sac_value_optMcritic/q/q1_encoding/q1_encoder/hidden_0/bias/sac_value_opt/Initializer/zeros*
T0*@
_class6
42loc:@critic/q/q1_encoding/q1_encoder/hidden_0/bias*
use_locking(*
validate_shape(
�
@critic/q/q1_encoding/q1_encoder/hidden_0/bias/sac_value_opt/readIdentity;critic/q/q1_encoding/q1_encoder/hidden_0/bias/sac_value_opt*
T0*@
_class6
42loc:@critic/q/q1_encoding/q1_encoder/hidden_0/bias
�
Ocritic/q/q1_encoding/q1_encoder/hidden_0/bias/sac_value_opt_1/Initializer/zerosConst*@
_class6
42loc:@critic/q/q1_encoding/q1_encoder/hidden_0/bias*
dtype0*
valueB@*    
�
=critic/q/q1_encoding/q1_encoder/hidden_0/bias/sac_value_opt_1
VariableV2*@
_class6
42loc:@critic/q/q1_encoding/q1_encoder/hidden_0/bias*
	container *
dtype0*
shape:@*
shared_name 
�
Dcritic/q/q1_encoding/q1_encoder/hidden_0/bias/sac_value_opt_1/AssignAssign=critic/q/q1_encoding/q1_encoder/hidden_0/bias/sac_value_opt_1Ocritic/q/q1_encoding/q1_encoder/hidden_0/bias/sac_value_opt_1/Initializer/zeros*
T0*@
_class6
42loc:@critic/q/q1_encoding/q1_encoder/hidden_0/bias*
use_locking(*
validate_shape(
�
Bcritic/q/q1_encoding/q1_encoder/hidden_0/bias/sac_value_opt_1/readIdentity=critic/q/q1_encoding/q1_encoder/hidden_0/bias/sac_value_opt_1*
T0*@
_class6
42loc:@critic/q/q1_encoding/q1_encoder/hidden_0/bias
�
_critic/q/q1_encoding/q1_encoder/hidden_1/kernel/sac_value_opt/Initializer/zeros/shape_as_tensorConst*B
_class8
64loc:@critic/q/q1_encoding/q1_encoder/hidden_1/kernel*
dtype0*
valueB"@   @   
�
Ucritic/q/q1_encoding/q1_encoder/hidden_1/kernel/sac_value_opt/Initializer/zeros/ConstConst*B
_class8
64loc:@critic/q/q1_encoding/q1_encoder/hidden_1/kernel*
dtype0*
valueB
 *    
�
Ocritic/q/q1_encoding/q1_encoder/hidden_1/kernel/sac_value_opt/Initializer/zerosFill_critic/q/q1_encoding/q1_encoder/hidden_1/kernel/sac_value_opt/Initializer/zeros/shape_as_tensorUcritic/q/q1_encoding/q1_encoder/hidden_1/kernel/sac_value_opt/Initializer/zeros/Const*
T0*B
_class8
64loc:@critic/q/q1_encoding/q1_encoder/hidden_1/kernel*

index_type0
�
=critic/q/q1_encoding/q1_encoder/hidden_1/kernel/sac_value_opt
VariableV2*B
_class8
64loc:@critic/q/q1_encoding/q1_encoder/hidden_1/kernel*
	container *
dtype0*
shape
:@@*
shared_name 
�
Dcritic/q/q1_encoding/q1_encoder/hidden_1/kernel/sac_value_opt/AssignAssign=critic/q/q1_encoding/q1_encoder/hidden_1/kernel/sac_value_optOcritic/q/q1_encoding/q1_encoder/hidden_1/kernel/sac_value_opt/Initializer/zeros*
T0*B
_class8
64loc:@critic/q/q1_encoding/q1_encoder/hidden_1/kernel*
use_locking(*
validate_shape(
�
Bcritic/q/q1_encoding/q1_encoder/hidden_1/kernel/sac_value_opt/readIdentity=critic/q/q1_encoding/q1_encoder/hidden_1/kernel/sac_value_opt*
T0*B
_class8
64loc:@critic/q/q1_encoding/q1_encoder/hidden_1/kernel
�
acritic/q/q1_encoding/q1_encoder/hidden_1/kernel/sac_value_opt_1/Initializer/zeros/shape_as_tensorConst*B
_class8
64loc:@critic/q/q1_encoding/q1_encoder/hidden_1/kernel*
dtype0*
valueB"@   @   
�
Wcritic/q/q1_encoding/q1_encoder/hidden_1/kernel/sac_value_opt_1/Initializer/zeros/ConstConst*B
_class8
64loc:@critic/q/q1_encoding/q1_encoder/hidden_1/kernel*
dtype0*
valueB
 *    
�
Qcritic/q/q1_encoding/q1_encoder/hidden_1/kernel/sac_value_opt_1/Initializer/zerosFillacritic/q/q1_encoding/q1_encoder/hidden_1/kernel/sac_value_opt_1/Initializer/zeros/shape_as_tensorWcritic/q/q1_encoding/q1_encoder/hidden_1/kernel/sac_value_opt_1/Initializer/zeros/Const*
T0*B
_class8
64loc:@critic/q/q1_encoding/q1_encoder/hidden_1/kernel*

index_type0
�
?critic/q/q1_encoding/q1_encoder/hidden_1/kernel/sac_value_opt_1
VariableV2*B
_class8
64loc:@critic/q/q1_encoding/q1_encoder/hidden_1/kernel*
	container *
dtype0*
shape
:@@*
shared_name 
�
Fcritic/q/q1_encoding/q1_encoder/hidden_1/kernel/sac_value_opt_1/AssignAssign?critic/q/q1_encoding/q1_encoder/hidden_1/kernel/sac_value_opt_1Qcritic/q/q1_encoding/q1_encoder/hidden_1/kernel/sac_value_opt_1/Initializer/zeros*
T0*B
_class8
64loc:@critic/q/q1_encoding/q1_encoder/hidden_1/kernel*
use_locking(*
validate_shape(
�
Dcritic/q/q1_encoding/q1_encoder/hidden_1/kernel/sac_value_opt_1/readIdentity?critic/q/q1_encoding/q1_encoder/hidden_1/kernel/sac_value_opt_1*
T0*B
_class8
64loc:@critic/q/q1_encoding/q1_encoder/hidden_1/kernel
�
Mcritic/q/q1_encoding/q1_encoder/hidden_1/bias/sac_value_opt/Initializer/zerosConst*@
_class6
42loc:@critic/q/q1_encoding/q1_encoder/hidden_1/bias*
dtype0*
valueB@*    
�
;critic/q/q1_encoding/q1_encoder/hidden_1/bias/sac_value_opt
VariableV2*@
_class6
42loc:@critic/q/q1_encoding/q1_encoder/hidden_1/bias*
	container *
dtype0*
shape:@*
shared_name 
�
Bcritic/q/q1_encoding/q1_encoder/hidden_1/bias/sac_value_opt/AssignAssign;critic/q/q1_encoding/q1_encoder/hidden_1/bias/sac_value_optMcritic/q/q1_encoding/q1_encoder/hidden_1/bias/sac_value_opt/Initializer/zeros*
T0*@
_class6
42loc:@critic/q/q1_encoding/q1_encoder/hidden_1/bias*
use_locking(*
validate_shape(
�
@critic/q/q1_encoding/q1_encoder/hidden_1/bias/sac_value_opt/readIdentity;critic/q/q1_encoding/q1_encoder/hidden_1/bias/sac_value_opt*
T0*@
_class6
42loc:@critic/q/q1_encoding/q1_encoder/hidden_1/bias
�
Ocritic/q/q1_encoding/q1_encoder/hidden_1/bias/sac_value_opt_1/Initializer/zerosConst*@
_class6
42loc:@critic/q/q1_encoding/q1_encoder/hidden_1/bias*
dtype0*
valueB@*    
�
=critic/q/q1_encoding/q1_encoder/hidden_1/bias/sac_value_opt_1
VariableV2*@
_class6
42loc:@critic/q/q1_encoding/q1_encoder/hidden_1/bias*
	container *
dtype0*
shape:@*
shared_name 
�
Dcritic/q/q1_encoding/q1_encoder/hidden_1/bias/sac_value_opt_1/AssignAssign=critic/q/q1_encoding/q1_encoder/hidden_1/bias/sac_value_opt_1Ocritic/q/q1_encoding/q1_encoder/hidden_1/bias/sac_value_opt_1/Initializer/zeros*
T0*@
_class6
42loc:@critic/q/q1_encoding/q1_encoder/hidden_1/bias*
use_locking(*
validate_shape(
�
Bcritic/q/q1_encoding/q1_encoder/hidden_1/bias/sac_value_opt_1/readIdentity=critic/q/q1_encoding/q1_encoder/hidden_1/bias/sac_value_opt_1*
T0*@
_class6
42loc:@critic/q/q1_encoding/q1_encoder/hidden_1/bias
�
Hcritic/q/q1_encoding/extrinsic_q1/kernel/sac_value_opt/Initializer/zerosConst*;
_class1
/-loc:@critic/q/q1_encoding/extrinsic_q1/kernel*
dtype0*
valueB@*    
�
6critic/q/q1_encoding/extrinsic_q1/kernel/sac_value_opt
VariableV2*;
_class1
/-loc:@critic/q/q1_encoding/extrinsic_q1/kernel*
	container *
dtype0*
shape
:@*
shared_name 
�
=critic/q/q1_encoding/extrinsic_q1/kernel/sac_value_opt/AssignAssign6critic/q/q1_encoding/extrinsic_q1/kernel/sac_value_optHcritic/q/q1_encoding/extrinsic_q1/kernel/sac_value_opt/Initializer/zeros*
T0*;
_class1
/-loc:@critic/q/q1_encoding/extrinsic_q1/kernel*
use_locking(*
validate_shape(
�
;critic/q/q1_encoding/extrinsic_q1/kernel/sac_value_opt/readIdentity6critic/q/q1_encoding/extrinsic_q1/kernel/sac_value_opt*
T0*;
_class1
/-loc:@critic/q/q1_encoding/extrinsic_q1/kernel
�
Jcritic/q/q1_encoding/extrinsic_q1/kernel/sac_value_opt_1/Initializer/zerosConst*;
_class1
/-loc:@critic/q/q1_encoding/extrinsic_q1/kernel*
dtype0*
valueB@*    
�
8critic/q/q1_encoding/extrinsic_q1/kernel/sac_value_opt_1
VariableV2*;
_class1
/-loc:@critic/q/q1_encoding/extrinsic_q1/kernel*
	container *
dtype0*
shape
:@*
shared_name 
�
?critic/q/q1_encoding/extrinsic_q1/kernel/sac_value_opt_1/AssignAssign8critic/q/q1_encoding/extrinsic_q1/kernel/sac_value_opt_1Jcritic/q/q1_encoding/extrinsic_q1/kernel/sac_value_opt_1/Initializer/zeros*
T0*;
_class1
/-loc:@critic/q/q1_encoding/extrinsic_q1/kernel*
use_locking(*
validate_shape(
�
=critic/q/q1_encoding/extrinsic_q1/kernel/sac_value_opt_1/readIdentity8critic/q/q1_encoding/extrinsic_q1/kernel/sac_value_opt_1*
T0*;
_class1
/-loc:@critic/q/q1_encoding/extrinsic_q1/kernel
�
Fcritic/q/q1_encoding/extrinsic_q1/bias/sac_value_opt/Initializer/zerosConst*9
_class/
-+loc:@critic/q/q1_encoding/extrinsic_q1/bias*
dtype0*
valueB*    
�
4critic/q/q1_encoding/extrinsic_q1/bias/sac_value_opt
VariableV2*9
_class/
-+loc:@critic/q/q1_encoding/extrinsic_q1/bias*
	container *
dtype0*
shape:*
shared_name 
�
;critic/q/q1_encoding/extrinsic_q1/bias/sac_value_opt/AssignAssign4critic/q/q1_encoding/extrinsic_q1/bias/sac_value_optFcritic/q/q1_encoding/extrinsic_q1/bias/sac_value_opt/Initializer/zeros*
T0*9
_class/
-+loc:@critic/q/q1_encoding/extrinsic_q1/bias*
use_locking(*
validate_shape(
�
9critic/q/q1_encoding/extrinsic_q1/bias/sac_value_opt/readIdentity4critic/q/q1_encoding/extrinsic_q1/bias/sac_value_opt*
T0*9
_class/
-+loc:@critic/q/q1_encoding/extrinsic_q1/bias
�
Hcritic/q/q1_encoding/extrinsic_q1/bias/sac_value_opt_1/Initializer/zerosConst*9
_class/
-+loc:@critic/q/q1_encoding/extrinsic_q1/bias*
dtype0*
valueB*    
�
6critic/q/q1_encoding/extrinsic_q1/bias/sac_value_opt_1
VariableV2*9
_class/
-+loc:@critic/q/q1_encoding/extrinsic_q1/bias*
	container *
dtype0*
shape:*
shared_name 
�
=critic/q/q1_encoding/extrinsic_q1/bias/sac_value_opt_1/AssignAssign6critic/q/q1_encoding/extrinsic_q1/bias/sac_value_opt_1Hcritic/q/q1_encoding/extrinsic_q1/bias/sac_value_opt_1/Initializer/zeros*
T0*9
_class/
-+loc:@critic/q/q1_encoding/extrinsic_q1/bias*
use_locking(*
validate_shape(
�
;critic/q/q1_encoding/extrinsic_q1/bias/sac_value_opt_1/readIdentity6critic/q/q1_encoding/extrinsic_q1/bias/sac_value_opt_1*
T0*9
_class/
-+loc:@critic/q/q1_encoding/extrinsic_q1/bias
�
Ocritic/q/q2_encoding/q2_encoder/hidden_0/kernel/sac_value_opt/Initializer/zerosConst*B
_class8
64loc:@critic/q/q2_encoding/q2_encoder/hidden_0/kernel*
dtype0*
valueB@*    
�
=critic/q/q2_encoding/q2_encoder/hidden_0/kernel/sac_value_opt
VariableV2*B
_class8
64loc:@critic/q/q2_encoding/q2_encoder/hidden_0/kernel*
	container *
dtype0*
shape
:@*
shared_name 
�
Dcritic/q/q2_encoding/q2_encoder/hidden_0/kernel/sac_value_opt/AssignAssign=critic/q/q2_encoding/q2_encoder/hidden_0/kernel/sac_value_optOcritic/q/q2_encoding/q2_encoder/hidden_0/kernel/sac_value_opt/Initializer/zeros*
T0*B
_class8
64loc:@critic/q/q2_encoding/q2_encoder/hidden_0/kernel*
use_locking(*
validate_shape(
�
Bcritic/q/q2_encoding/q2_encoder/hidden_0/kernel/sac_value_opt/readIdentity=critic/q/q2_encoding/q2_encoder/hidden_0/kernel/sac_value_opt*
T0*B
_class8
64loc:@critic/q/q2_encoding/q2_encoder/hidden_0/kernel
�
Qcritic/q/q2_encoding/q2_encoder/hidden_0/kernel/sac_value_opt_1/Initializer/zerosConst*B
_class8
64loc:@critic/q/q2_encoding/q2_encoder/hidden_0/kernel*
dtype0*
valueB@*    
�
?critic/q/q2_encoding/q2_encoder/hidden_0/kernel/sac_value_opt_1
VariableV2*B
_class8
64loc:@critic/q/q2_encoding/q2_encoder/hidden_0/kernel*
	container *
dtype0*
shape
:@*
shared_name 
�
Fcritic/q/q2_encoding/q2_encoder/hidden_0/kernel/sac_value_opt_1/AssignAssign?critic/q/q2_encoding/q2_encoder/hidden_0/kernel/sac_value_opt_1Qcritic/q/q2_encoding/q2_encoder/hidden_0/kernel/sac_value_opt_1/Initializer/zeros*
T0*B
_class8
64loc:@critic/q/q2_encoding/q2_encoder/hidden_0/kernel*
use_locking(*
validate_shape(
�
Dcritic/q/q2_encoding/q2_encoder/hidden_0/kernel/sac_value_opt_1/readIdentity?critic/q/q2_encoding/q2_encoder/hidden_0/kernel/sac_value_opt_1*
T0*B
_class8
64loc:@critic/q/q2_encoding/q2_encoder/hidden_0/kernel
�
Mcritic/q/q2_encoding/q2_encoder/hidden_0/bias/sac_value_opt/Initializer/zerosConst*@
_class6
42loc:@critic/q/q2_encoding/q2_encoder/hidden_0/bias*
dtype0*
valueB@*    
�
;critic/q/q2_encoding/q2_encoder/hidden_0/bias/sac_value_opt
VariableV2*@
_class6
42loc:@critic/q/q2_encoding/q2_encoder/hidden_0/bias*
	container *
dtype0*
shape:@*
shared_name 
�
Bcritic/q/q2_encoding/q2_encoder/hidden_0/bias/sac_value_opt/AssignAssign;critic/q/q2_encoding/q2_encoder/hidden_0/bias/sac_value_optMcritic/q/q2_encoding/q2_encoder/hidden_0/bias/sac_value_opt/Initializer/zeros*
T0*@
_class6
42loc:@critic/q/q2_encoding/q2_encoder/hidden_0/bias*
use_locking(*
validate_shape(
�
@critic/q/q2_encoding/q2_encoder/hidden_0/bias/sac_value_opt/readIdentity;critic/q/q2_encoding/q2_encoder/hidden_0/bias/sac_value_opt*
T0*@
_class6
42loc:@critic/q/q2_encoding/q2_encoder/hidden_0/bias
�
Ocritic/q/q2_encoding/q2_encoder/hidden_0/bias/sac_value_opt_1/Initializer/zerosConst*@
_class6
42loc:@critic/q/q2_encoding/q2_encoder/hidden_0/bias*
dtype0*
valueB@*    
�
=critic/q/q2_encoding/q2_encoder/hidden_0/bias/sac_value_opt_1
VariableV2*@
_class6
42loc:@critic/q/q2_encoding/q2_encoder/hidden_0/bias*
	container *
dtype0*
shape:@*
shared_name 
�
Dcritic/q/q2_encoding/q2_encoder/hidden_0/bias/sac_value_opt_1/AssignAssign=critic/q/q2_encoding/q2_encoder/hidden_0/bias/sac_value_opt_1Ocritic/q/q2_encoding/q2_encoder/hidden_0/bias/sac_value_opt_1/Initializer/zeros*
T0*@
_class6
42loc:@critic/q/q2_encoding/q2_encoder/hidden_0/bias*
use_locking(*
validate_shape(
�
Bcritic/q/q2_encoding/q2_encoder/hidden_0/bias/sac_value_opt_1/readIdentity=critic/q/q2_encoding/q2_encoder/hidden_0/bias/sac_value_opt_1*
T0*@
_class6
42loc:@critic/q/q2_encoding/q2_encoder/hidden_0/bias
�
_critic/q/q2_encoding/q2_encoder/hidden_1/kernel/sac_value_opt/Initializer/zeros/shape_as_tensorConst*B
_class8
64loc:@critic/q/q2_encoding/q2_encoder/hidden_1/kernel*
dtype0*
valueB"@   @   
�
Ucritic/q/q2_encoding/q2_encoder/hidden_1/kernel/sac_value_opt/Initializer/zeros/ConstConst*B
_class8
64loc:@critic/q/q2_encoding/q2_encoder/hidden_1/kernel*
dtype0*
valueB
 *    
�
Ocritic/q/q2_encoding/q2_encoder/hidden_1/kernel/sac_value_opt/Initializer/zerosFill_critic/q/q2_encoding/q2_encoder/hidden_1/kernel/sac_value_opt/Initializer/zeros/shape_as_tensorUcritic/q/q2_encoding/q2_encoder/hidden_1/kernel/sac_value_opt/Initializer/zeros/Const*
T0*B
_class8
64loc:@critic/q/q2_encoding/q2_encoder/hidden_1/kernel*

index_type0
�
=critic/q/q2_encoding/q2_encoder/hidden_1/kernel/sac_value_opt
VariableV2*B
_class8
64loc:@critic/q/q2_encoding/q2_encoder/hidden_1/kernel*
	container *
dtype0*
shape
:@@*
shared_name 
�
Dcritic/q/q2_encoding/q2_encoder/hidden_1/kernel/sac_value_opt/AssignAssign=critic/q/q2_encoding/q2_encoder/hidden_1/kernel/sac_value_optOcritic/q/q2_encoding/q2_encoder/hidden_1/kernel/sac_value_opt/Initializer/zeros*
T0*B
_class8
64loc:@critic/q/q2_encoding/q2_encoder/hidden_1/kernel*
use_locking(*
validate_shape(
�
Bcritic/q/q2_encoding/q2_encoder/hidden_1/kernel/sac_value_opt/readIdentity=critic/q/q2_encoding/q2_encoder/hidden_1/kernel/sac_value_opt*
T0*B
_class8
64loc:@critic/q/q2_encoding/q2_encoder/hidden_1/kernel
�
acritic/q/q2_encoding/q2_encoder/hidden_1/kernel/sac_value_opt_1/Initializer/zeros/shape_as_tensorConst*B
_class8
64loc:@critic/q/q2_encoding/q2_encoder/hidden_1/kernel*
dtype0*
valueB"@   @   
�
Wcritic/q/q2_encoding/q2_encoder/hidden_1/kernel/sac_value_opt_1/Initializer/zeros/ConstConst*B
_class8
64loc:@critic/q/q2_encoding/q2_encoder/hidden_1/kernel*
dtype0*
valueB
 *    
�
Qcritic/q/q2_encoding/q2_encoder/hidden_1/kernel/sac_value_opt_1/Initializer/zerosFillacritic/q/q2_encoding/q2_encoder/hidden_1/kernel/sac_value_opt_1/Initializer/zeros/shape_as_tensorWcritic/q/q2_encoding/q2_encoder/hidden_1/kernel/sac_value_opt_1/Initializer/zeros/Const*
T0*B
_class8
64loc:@critic/q/q2_encoding/q2_encoder/hidden_1/kernel*

index_type0
�
?critic/q/q2_encoding/q2_encoder/hidden_1/kernel/sac_value_opt_1
VariableV2*B
_class8
64loc:@critic/q/q2_encoding/q2_encoder/hidden_1/kernel*
	container *
dtype0*
shape
:@@*
shared_name 
�
Fcritic/q/q2_encoding/q2_encoder/hidden_1/kernel/sac_value_opt_1/AssignAssign?critic/q/q2_encoding/q2_encoder/hidden_1/kernel/sac_value_opt_1Qcritic/q/q2_encoding/q2_encoder/hidden_1/kernel/sac_value_opt_1/Initializer/zeros*
T0*B
_class8
64loc:@critic/q/q2_encoding/q2_encoder/hidden_1/kernel*
use_locking(*
validate_shape(
�
Dcritic/q/q2_encoding/q2_encoder/hidden_1/kernel/sac_value_opt_1/readIdentity?critic/q/q2_encoding/q2_encoder/hidden_1/kernel/sac_value_opt_1*
T0*B
_class8
64loc:@critic/q/q2_encoding/q2_encoder/hidden_1/kernel
�
Mcritic/q/q2_encoding/q2_encoder/hidden_1/bias/sac_value_opt/Initializer/zerosConst*@
_class6
42loc:@critic/q/q2_encoding/q2_encoder/hidden_1/bias*
dtype0*
valueB@*    
�
;critic/q/q2_encoding/q2_encoder/hidden_1/bias/sac_value_opt
VariableV2*@
_class6
42loc:@critic/q/q2_encoding/q2_encoder/hidden_1/bias*
	container *
dtype0*
shape:@*
shared_name 
�
Bcritic/q/q2_encoding/q2_encoder/hidden_1/bias/sac_value_opt/AssignAssign;critic/q/q2_encoding/q2_encoder/hidden_1/bias/sac_value_optMcritic/q/q2_encoding/q2_encoder/hidden_1/bias/sac_value_opt/Initializer/zeros*
T0*@
_class6
42loc:@critic/q/q2_encoding/q2_encoder/hidden_1/bias*
use_locking(*
validate_shape(
�
@critic/q/q2_encoding/q2_encoder/hidden_1/bias/sac_value_opt/readIdentity;critic/q/q2_encoding/q2_encoder/hidden_1/bias/sac_value_opt*
T0*@
_class6
42loc:@critic/q/q2_encoding/q2_encoder/hidden_1/bias
�
Ocritic/q/q2_encoding/q2_encoder/hidden_1/bias/sac_value_opt_1/Initializer/zerosConst*@
_class6
42loc:@critic/q/q2_encoding/q2_encoder/hidden_1/bias*
dtype0*
valueB@*    
�
=critic/q/q2_encoding/q2_encoder/hidden_1/bias/sac_value_opt_1
VariableV2*@
_class6
42loc:@critic/q/q2_encoding/q2_encoder/hidden_1/bias*
	container *
dtype0*
shape:@*
shared_name 
�
Dcritic/q/q2_encoding/q2_encoder/hidden_1/bias/sac_value_opt_1/AssignAssign=critic/q/q2_encoding/q2_encoder/hidden_1/bias/sac_value_opt_1Ocritic/q/q2_encoding/q2_encoder/hidden_1/bias/sac_value_opt_1/Initializer/zeros*
T0*@
_class6
42loc:@critic/q/q2_encoding/q2_encoder/hidden_1/bias*
use_locking(*
validate_shape(
�
Bcritic/q/q2_encoding/q2_encoder/hidden_1/bias/sac_value_opt_1/readIdentity=critic/q/q2_encoding/q2_encoder/hidden_1/bias/sac_value_opt_1*
T0*@
_class6
42loc:@critic/q/q2_encoding/q2_encoder/hidden_1/bias
�
Hcritic/q/q2_encoding/extrinsic_q2/kernel/sac_value_opt/Initializer/zerosConst*;
_class1
/-loc:@critic/q/q2_encoding/extrinsic_q2/kernel*
dtype0*
valueB@*    
�
6critic/q/q2_encoding/extrinsic_q2/kernel/sac_value_opt
VariableV2*;
_class1
/-loc:@critic/q/q2_encoding/extrinsic_q2/kernel*
	container *
dtype0*
shape
:@*
shared_name 
�
=critic/q/q2_encoding/extrinsic_q2/kernel/sac_value_opt/AssignAssign6critic/q/q2_encoding/extrinsic_q2/kernel/sac_value_optHcritic/q/q2_encoding/extrinsic_q2/kernel/sac_value_opt/Initializer/zeros*
T0*;
_class1
/-loc:@critic/q/q2_encoding/extrinsic_q2/kernel*
use_locking(*
validate_shape(
�
;critic/q/q2_encoding/extrinsic_q2/kernel/sac_value_opt/readIdentity6critic/q/q2_encoding/extrinsic_q2/kernel/sac_value_opt*
T0*;
_class1
/-loc:@critic/q/q2_encoding/extrinsic_q2/kernel
�
Jcritic/q/q2_encoding/extrinsic_q2/kernel/sac_value_opt_1/Initializer/zerosConst*;
_class1
/-loc:@critic/q/q2_encoding/extrinsic_q2/kernel*
dtype0*
valueB@*    
�
8critic/q/q2_encoding/extrinsic_q2/kernel/sac_value_opt_1
VariableV2*;
_class1
/-loc:@critic/q/q2_encoding/extrinsic_q2/kernel*
	container *
dtype0*
shape
:@*
shared_name 
�
?critic/q/q2_encoding/extrinsic_q2/kernel/sac_value_opt_1/AssignAssign8critic/q/q2_encoding/extrinsic_q2/kernel/sac_value_opt_1Jcritic/q/q2_encoding/extrinsic_q2/kernel/sac_value_opt_1/Initializer/zeros*
T0*;
_class1
/-loc:@critic/q/q2_encoding/extrinsic_q2/kernel*
use_locking(*
validate_shape(
�
=critic/q/q2_encoding/extrinsic_q2/kernel/sac_value_opt_1/readIdentity8critic/q/q2_encoding/extrinsic_q2/kernel/sac_value_opt_1*
T0*;
_class1
/-loc:@critic/q/q2_encoding/extrinsic_q2/kernel
�
Fcritic/q/q2_encoding/extrinsic_q2/bias/sac_value_opt/Initializer/zerosConst*9
_class/
-+loc:@critic/q/q2_encoding/extrinsic_q2/bias*
dtype0*
valueB*    
�
4critic/q/q2_encoding/extrinsic_q2/bias/sac_value_opt
VariableV2*9
_class/
-+loc:@critic/q/q2_encoding/extrinsic_q2/bias*
	container *
dtype0*
shape:*
shared_name 
�
;critic/q/q2_encoding/extrinsic_q2/bias/sac_value_opt/AssignAssign4critic/q/q2_encoding/extrinsic_q2/bias/sac_value_optFcritic/q/q2_encoding/extrinsic_q2/bias/sac_value_opt/Initializer/zeros*
T0*9
_class/
-+loc:@critic/q/q2_encoding/extrinsic_q2/bias*
use_locking(*
validate_shape(
�
9critic/q/q2_encoding/extrinsic_q2/bias/sac_value_opt/readIdentity4critic/q/q2_encoding/extrinsic_q2/bias/sac_value_opt*
T0*9
_class/
-+loc:@critic/q/q2_encoding/extrinsic_q2/bias
�
Hcritic/q/q2_encoding/extrinsic_q2/bias/sac_value_opt_1/Initializer/zerosConst*9
_class/
-+loc:@critic/q/q2_encoding/extrinsic_q2/bias*
dtype0*
valueB*    
�
6critic/q/q2_encoding/extrinsic_q2/bias/sac_value_opt_1
VariableV2*9
_class/
-+loc:@critic/q/q2_encoding/extrinsic_q2/bias*
	container *
dtype0*
shape:*
shared_name 
�
=critic/q/q2_encoding/extrinsic_q2/bias/sac_value_opt_1/AssignAssign6critic/q/q2_encoding/extrinsic_q2/bias/sac_value_opt_1Hcritic/q/q2_encoding/extrinsic_q2/bias/sac_value_opt_1/Initializer/zeros*
T0*9
_class/
-+loc:@critic/q/q2_encoding/extrinsic_q2/bias*
use_locking(*
validate_shape(
�
;critic/q/q2_encoding/extrinsic_q2/bias/sac_value_opt_1/readIdentity6critic/q/q2_encoding/extrinsic_q2/bias/sac_value_opt_1*
T0*9
_class/
-+loc:@critic/q/q2_encoding/extrinsic_q2/bias
Q
sac_value_opt/beta1Const^sac_policy_opt*
dtype0*
valueB
 *fff?
Q
sac_value_opt/beta2Const^sac_policy_opt*
dtype0*
valueB
 *w�?
S
sac_value_opt/epsilonConst^sac_policy_opt*
dtype0*
valueB
 *w�+2
�
Csac_value_opt/update_critic/value/encoder/hidden_0/kernel/ApplyAdam	ApplyAdam$critic/value/encoder/hidden_0/kernel2critic/value/encoder/hidden_0/kernel/sac_value_opt4critic/value/encoder/hidden_0/kernel/sac_value_opt_1beta1_power_1/readbeta2_power_1/readVariable_1/readsac_value_opt/beta1sac_value_opt/beta2sac_value_opt/epsilonPgradients_1/critic/value/encoder/hidden_0/MatMul_grad/tuple/control_dependency_1*
T0*7
_class-
+)loc:@critic/value/encoder/hidden_0/kernel*
use_locking( *
use_nesterov( 
�
Asac_value_opt/update_critic/value/encoder/hidden_0/bias/ApplyAdam	ApplyAdam"critic/value/encoder/hidden_0/bias0critic/value/encoder/hidden_0/bias/sac_value_opt2critic/value/encoder/hidden_0/bias/sac_value_opt_1beta1_power_1/readbeta2_power_1/readVariable_1/readsac_value_opt/beta1sac_value_opt/beta2sac_value_opt/epsilonQgradients_1/critic/value/encoder/hidden_0/BiasAdd_grad/tuple/control_dependency_1*
T0*5
_class+
)'loc:@critic/value/encoder/hidden_0/bias*
use_locking( *
use_nesterov( 
�
Csac_value_opt/update_critic/value/encoder/hidden_1/kernel/ApplyAdam	ApplyAdam$critic/value/encoder/hidden_1/kernel2critic/value/encoder/hidden_1/kernel/sac_value_opt4critic/value/encoder/hidden_1/kernel/sac_value_opt_1beta1_power_1/readbeta2_power_1/readVariable_1/readsac_value_opt/beta1sac_value_opt/beta2sac_value_opt/epsilonPgradients_1/critic/value/encoder/hidden_1/MatMul_grad/tuple/control_dependency_1*
T0*7
_class-
+)loc:@critic/value/encoder/hidden_1/kernel*
use_locking( *
use_nesterov( 
�
Asac_value_opt/update_critic/value/encoder/hidden_1/bias/ApplyAdam	ApplyAdam"critic/value/encoder/hidden_1/bias0critic/value/encoder/hidden_1/bias/sac_value_opt2critic/value/encoder/hidden_1/bias/sac_value_opt_1beta1_power_1/readbeta2_power_1/readVariable_1/readsac_value_opt/beta1sac_value_opt/beta2sac_value_opt/epsilonQgradients_1/critic/value/encoder/hidden_1/BiasAdd_grad/tuple/control_dependency_1*
T0*5
_class+
)'loc:@critic/value/encoder/hidden_1/bias*
use_locking( *
use_nesterov( 
�
Bsac_value_opt/update_critic/value/extrinsic_value/kernel/ApplyAdam	ApplyAdam#critic/value/extrinsic_value/kernel1critic/value/extrinsic_value/kernel/sac_value_opt3critic/value/extrinsic_value/kernel/sac_value_opt_1beta1_power_1/readbeta2_power_1/readVariable_1/readsac_value_opt/beta1sac_value_opt/beta2sac_value_opt/epsilonOgradients_1/critic/value/extrinsic_value/MatMul_grad/tuple/control_dependency_1*
T0*6
_class,
*(loc:@critic/value/extrinsic_value/kernel*
use_locking( *
use_nesterov( 
�
@sac_value_opt/update_critic/value/extrinsic_value/bias/ApplyAdam	ApplyAdam!critic/value/extrinsic_value/bias/critic/value/extrinsic_value/bias/sac_value_opt1critic/value/extrinsic_value/bias/sac_value_opt_1beta1_power_1/readbeta2_power_1/readVariable_1/readsac_value_opt/beta1sac_value_opt/beta2sac_value_opt/epsilonPgradients_1/critic/value/extrinsic_value/BiasAdd_grad/tuple/control_dependency_1*
T0*4
_class*
(&loc:@critic/value/extrinsic_value/bias*
use_locking( *
use_nesterov( 
�
Nsac_value_opt/update_critic/q/q1_encoding/q1_encoder/hidden_0/kernel/ApplyAdam	ApplyAdam/critic/q/q1_encoding/q1_encoder/hidden_0/kernel=critic/q/q1_encoding/q1_encoder/hidden_0/kernel/sac_value_opt?critic/q/q1_encoding/q1_encoder/hidden_0/kernel/sac_value_opt_1beta1_power_1/readbeta2_power_1/readVariable_1/readsac_value_opt/beta1sac_value_opt/beta2sac_value_opt/epsilon[gradients_1/critic/q/q1_encoding/q1_encoder/hidden_0/MatMul_grad/tuple/control_dependency_1*
T0*B
_class8
64loc:@critic/q/q1_encoding/q1_encoder/hidden_0/kernel*
use_locking( *
use_nesterov( 
�
Lsac_value_opt/update_critic/q/q1_encoding/q1_encoder/hidden_0/bias/ApplyAdam	ApplyAdam-critic/q/q1_encoding/q1_encoder/hidden_0/bias;critic/q/q1_encoding/q1_encoder/hidden_0/bias/sac_value_opt=critic/q/q1_encoding/q1_encoder/hidden_0/bias/sac_value_opt_1beta1_power_1/readbeta2_power_1/readVariable_1/readsac_value_opt/beta1sac_value_opt/beta2sac_value_opt/epsilon\gradients_1/critic/q/q1_encoding/q1_encoder/hidden_0/BiasAdd_grad/tuple/control_dependency_1*
T0*@
_class6
42loc:@critic/q/q1_encoding/q1_encoder/hidden_0/bias*
use_locking( *
use_nesterov( 
�
Nsac_value_opt/update_critic/q/q1_encoding/q1_encoder/hidden_1/kernel/ApplyAdam	ApplyAdam/critic/q/q1_encoding/q1_encoder/hidden_1/kernel=critic/q/q1_encoding/q1_encoder/hidden_1/kernel/sac_value_opt?critic/q/q1_encoding/q1_encoder/hidden_1/kernel/sac_value_opt_1beta1_power_1/readbeta2_power_1/readVariable_1/readsac_value_opt/beta1sac_value_opt/beta2sac_value_opt/epsilon[gradients_1/critic/q/q1_encoding/q1_encoder/hidden_1/MatMul_grad/tuple/control_dependency_1*
T0*B
_class8
64loc:@critic/q/q1_encoding/q1_encoder/hidden_1/kernel*
use_locking( *
use_nesterov( 
�
Lsac_value_opt/update_critic/q/q1_encoding/q1_encoder/hidden_1/bias/ApplyAdam	ApplyAdam-critic/q/q1_encoding/q1_encoder/hidden_1/bias;critic/q/q1_encoding/q1_encoder/hidden_1/bias/sac_value_opt=critic/q/q1_encoding/q1_encoder/hidden_1/bias/sac_value_opt_1beta1_power_1/readbeta2_power_1/readVariable_1/readsac_value_opt/beta1sac_value_opt/beta2sac_value_opt/epsilon\gradients_1/critic/q/q1_encoding/q1_encoder/hidden_1/BiasAdd_grad/tuple/control_dependency_1*
T0*@
_class6
42loc:@critic/q/q1_encoding/q1_encoder/hidden_1/bias*
use_locking( *
use_nesterov( 
�
Gsac_value_opt/update_critic/q/q1_encoding/extrinsic_q1/kernel/ApplyAdam	ApplyAdam(critic/q/q1_encoding/extrinsic_q1/kernel6critic/q/q1_encoding/extrinsic_q1/kernel/sac_value_opt8critic/q/q1_encoding/extrinsic_q1/kernel/sac_value_opt_1beta1_power_1/readbeta2_power_1/readVariable_1/readsac_value_opt/beta1sac_value_opt/beta2sac_value_opt/epsilonTgradients_1/critic/q/q1_encoding/extrinsic_q1/MatMul_grad/tuple/control_dependency_1*
T0*;
_class1
/-loc:@critic/q/q1_encoding/extrinsic_q1/kernel*
use_locking( *
use_nesterov( 
�
Esac_value_opt/update_critic/q/q1_encoding/extrinsic_q1/bias/ApplyAdam	ApplyAdam&critic/q/q1_encoding/extrinsic_q1/bias4critic/q/q1_encoding/extrinsic_q1/bias/sac_value_opt6critic/q/q1_encoding/extrinsic_q1/bias/sac_value_opt_1beta1_power_1/readbeta2_power_1/readVariable_1/readsac_value_opt/beta1sac_value_opt/beta2sac_value_opt/epsilonUgradients_1/critic/q/q1_encoding/extrinsic_q1/BiasAdd_grad/tuple/control_dependency_1*
T0*9
_class/
-+loc:@critic/q/q1_encoding/extrinsic_q1/bias*
use_locking( *
use_nesterov( 
�
Nsac_value_opt/update_critic/q/q2_encoding/q2_encoder/hidden_0/kernel/ApplyAdam	ApplyAdam/critic/q/q2_encoding/q2_encoder/hidden_0/kernel=critic/q/q2_encoding/q2_encoder/hidden_0/kernel/sac_value_opt?critic/q/q2_encoding/q2_encoder/hidden_0/kernel/sac_value_opt_1beta1_power_1/readbeta2_power_1/readVariable_1/readsac_value_opt/beta1sac_value_opt/beta2sac_value_opt/epsilon[gradients_1/critic/q/q2_encoding/q2_encoder/hidden_0/MatMul_grad/tuple/control_dependency_1*
T0*B
_class8
64loc:@critic/q/q2_encoding/q2_encoder/hidden_0/kernel*
use_locking( *
use_nesterov( 
�
Lsac_value_opt/update_critic/q/q2_encoding/q2_encoder/hidden_0/bias/ApplyAdam	ApplyAdam-critic/q/q2_encoding/q2_encoder/hidden_0/bias;critic/q/q2_encoding/q2_encoder/hidden_0/bias/sac_value_opt=critic/q/q2_encoding/q2_encoder/hidden_0/bias/sac_value_opt_1beta1_power_1/readbeta2_power_1/readVariable_1/readsac_value_opt/beta1sac_value_opt/beta2sac_value_opt/epsilon\gradients_1/critic/q/q2_encoding/q2_encoder/hidden_0/BiasAdd_grad/tuple/control_dependency_1*
T0*@
_class6
42loc:@critic/q/q2_encoding/q2_encoder/hidden_0/bias*
use_locking( *
use_nesterov( 
�
Nsac_value_opt/update_critic/q/q2_encoding/q2_encoder/hidden_1/kernel/ApplyAdam	ApplyAdam/critic/q/q2_encoding/q2_encoder/hidden_1/kernel=critic/q/q2_encoding/q2_encoder/hidden_1/kernel/sac_value_opt?critic/q/q2_encoding/q2_encoder/hidden_1/kernel/sac_value_opt_1beta1_power_1/readbeta2_power_1/readVariable_1/readsac_value_opt/beta1sac_value_opt/beta2sac_value_opt/epsilon[gradients_1/critic/q/q2_encoding/q2_encoder/hidden_1/MatMul_grad/tuple/control_dependency_1*
T0*B
_class8
64loc:@critic/q/q2_encoding/q2_encoder/hidden_1/kernel*
use_locking( *
use_nesterov( 
�
Lsac_value_opt/update_critic/q/q2_encoding/q2_encoder/hidden_1/bias/ApplyAdam	ApplyAdam-critic/q/q2_encoding/q2_encoder/hidden_1/bias;critic/q/q2_encoding/q2_encoder/hidden_1/bias/sac_value_opt=critic/q/q2_encoding/q2_encoder/hidden_1/bias/sac_value_opt_1beta1_power_1/readbeta2_power_1/readVariable_1/readsac_value_opt/beta1sac_value_opt/beta2sac_value_opt/epsilon\gradients_1/critic/q/q2_encoding/q2_encoder/hidden_1/BiasAdd_grad/tuple/control_dependency_1*
T0*@
_class6
42loc:@critic/q/q2_encoding/q2_encoder/hidden_1/bias*
use_locking( *
use_nesterov( 
�
Gsac_value_opt/update_critic/q/q2_encoding/extrinsic_q2/kernel/ApplyAdam	ApplyAdam(critic/q/q2_encoding/extrinsic_q2/kernel6critic/q/q2_encoding/extrinsic_q2/kernel/sac_value_opt8critic/q/q2_encoding/extrinsic_q2/kernel/sac_value_opt_1beta1_power_1/readbeta2_power_1/readVariable_1/readsac_value_opt/beta1sac_value_opt/beta2sac_value_opt/epsilonTgradients_1/critic/q/q2_encoding/extrinsic_q2/MatMul_grad/tuple/control_dependency_1*
T0*;
_class1
/-loc:@critic/q/q2_encoding/extrinsic_q2/kernel*
use_locking( *
use_nesterov( 
�
Esac_value_opt/update_critic/q/q2_encoding/extrinsic_q2/bias/ApplyAdam	ApplyAdam&critic/q/q2_encoding/extrinsic_q2/bias4critic/q/q2_encoding/extrinsic_q2/bias/sac_value_opt6critic/q/q2_encoding/extrinsic_q2/bias/sac_value_opt_1beta1_power_1/readbeta2_power_1/readVariable_1/readsac_value_opt/beta1sac_value_opt/beta2sac_value_opt/epsilonUgradients_1/critic/q/q2_encoding/extrinsic_q2/BiasAdd_grad/tuple/control_dependency_1*
T0*9
_class/
-+loc:@critic/q/q2_encoding/extrinsic_q2/bias*
use_locking( *
use_nesterov( 
�
sac_value_opt/mulMulbeta1_power_1/readsac_value_opt/beta1F^sac_value_opt/update_critic/q/q1_encoding/extrinsic_q1/bias/ApplyAdamH^sac_value_opt/update_critic/q/q1_encoding/extrinsic_q1/kernel/ApplyAdamM^sac_value_opt/update_critic/q/q1_encoding/q1_encoder/hidden_0/bias/ApplyAdamO^sac_value_opt/update_critic/q/q1_encoding/q1_encoder/hidden_0/kernel/ApplyAdamM^sac_value_opt/update_critic/q/q1_encoding/q1_encoder/hidden_1/bias/ApplyAdamO^sac_value_opt/update_critic/q/q1_encoding/q1_encoder/hidden_1/kernel/ApplyAdamF^sac_value_opt/update_critic/q/q2_encoding/extrinsic_q2/bias/ApplyAdamH^sac_value_opt/update_critic/q/q2_encoding/extrinsic_q2/kernel/ApplyAdamM^sac_value_opt/update_critic/q/q2_encoding/q2_encoder/hidden_0/bias/ApplyAdamO^sac_value_opt/update_critic/q/q2_encoding/q2_encoder/hidden_0/kernel/ApplyAdamM^sac_value_opt/update_critic/q/q2_encoding/q2_encoder/hidden_1/bias/ApplyAdamO^sac_value_opt/update_critic/q/q2_encoding/q2_encoder/hidden_1/kernel/ApplyAdamB^sac_value_opt/update_critic/value/encoder/hidden_0/bias/ApplyAdamD^sac_value_opt/update_critic/value/encoder/hidden_0/kernel/ApplyAdamB^sac_value_opt/update_critic/value/encoder/hidden_1/bias/ApplyAdamD^sac_value_opt/update_critic/value/encoder/hidden_1/kernel/ApplyAdamA^sac_value_opt/update_critic/value/extrinsic_value/bias/ApplyAdamC^sac_value_opt/update_critic/value/extrinsic_value/kernel/ApplyAdam*
T0*9
_class/
-+loc:@critic/q/q1_encoding/extrinsic_q1/bias
�
sac_value_opt/AssignAssignbeta1_power_1sac_value_opt/mul*
T0*9
_class/
-+loc:@critic/q/q1_encoding/extrinsic_q1/bias*
use_locking( *
validate_shape(
�
sac_value_opt/mul_1Mulbeta2_power_1/readsac_value_opt/beta2F^sac_value_opt/update_critic/q/q1_encoding/extrinsic_q1/bias/ApplyAdamH^sac_value_opt/update_critic/q/q1_encoding/extrinsic_q1/kernel/ApplyAdamM^sac_value_opt/update_critic/q/q1_encoding/q1_encoder/hidden_0/bias/ApplyAdamO^sac_value_opt/update_critic/q/q1_encoding/q1_encoder/hidden_0/kernel/ApplyAdamM^sac_value_opt/update_critic/q/q1_encoding/q1_encoder/hidden_1/bias/ApplyAdamO^sac_value_opt/update_critic/q/q1_encoding/q1_encoder/hidden_1/kernel/ApplyAdamF^sac_value_opt/update_critic/q/q2_encoding/extrinsic_q2/bias/ApplyAdamH^sac_value_opt/update_critic/q/q2_encoding/extrinsic_q2/kernel/ApplyAdamM^sac_value_opt/update_critic/q/q2_encoding/q2_encoder/hidden_0/bias/ApplyAdamO^sac_value_opt/update_critic/q/q2_encoding/q2_encoder/hidden_0/kernel/ApplyAdamM^sac_value_opt/update_critic/q/q2_encoding/q2_encoder/hidden_1/bias/ApplyAdamO^sac_value_opt/update_critic/q/q2_encoding/q2_encoder/hidden_1/kernel/ApplyAdamB^sac_value_opt/update_critic/value/encoder/hidden_0/bias/ApplyAdamD^sac_value_opt/update_critic/value/encoder/hidden_0/kernel/ApplyAdamB^sac_value_opt/update_critic/value/encoder/hidden_1/bias/ApplyAdamD^sac_value_opt/update_critic/value/encoder/hidden_1/kernel/ApplyAdamA^sac_value_opt/update_critic/value/extrinsic_value/bias/ApplyAdamC^sac_value_opt/update_critic/value/extrinsic_value/kernel/ApplyAdam*
T0*9
_class/
-+loc:@critic/q/q1_encoding/extrinsic_q1/bias
�
sac_value_opt/Assign_1Assignbeta2_power_1sac_value_opt/mul_1*
T0*9
_class/
-+loc:@critic/q/q1_encoding/extrinsic_q1/bias*
use_locking( *
validate_shape(
�
sac_value_optNoOp^sac_policy_opt^sac_value_opt/Assign^sac_value_opt/Assign_1F^sac_value_opt/update_critic/q/q1_encoding/extrinsic_q1/bias/ApplyAdamH^sac_value_opt/update_critic/q/q1_encoding/extrinsic_q1/kernel/ApplyAdamM^sac_value_opt/update_critic/q/q1_encoding/q1_encoder/hidden_0/bias/ApplyAdamO^sac_value_opt/update_critic/q/q1_encoding/q1_encoder/hidden_0/kernel/ApplyAdamM^sac_value_opt/update_critic/q/q1_encoding/q1_encoder/hidden_1/bias/ApplyAdamO^sac_value_opt/update_critic/q/q1_encoding/q1_encoder/hidden_1/kernel/ApplyAdamF^sac_value_opt/update_critic/q/q2_encoding/extrinsic_q2/bias/ApplyAdamH^sac_value_opt/update_critic/q/q2_encoding/extrinsic_q2/kernel/ApplyAdamM^sac_value_opt/update_critic/q/q2_encoding/q2_encoder/hidden_0/bias/ApplyAdamO^sac_value_opt/update_critic/q/q2_encoding/q2_encoder/hidden_0/kernel/ApplyAdamM^sac_value_opt/update_critic/q/q2_encoding/q2_encoder/hidden_1/bias/ApplyAdamO^sac_value_opt/update_critic/q/q2_encoding/q2_encoder/hidden_1/kernel/ApplyAdamB^sac_value_opt/update_critic/value/encoder/hidden_0/bias/ApplyAdamD^sac_value_opt/update_critic/value/encoder/hidden_0/kernel/ApplyAdamB^sac_value_opt/update_critic/value/encoder/hidden_1/bias/ApplyAdamD^sac_value_opt/update_critic/value/encoder/hidden_1/kernel/ApplyAdamA^sac_value_opt/update_critic/value/extrinsic_value/bias/ApplyAdamC^sac_value_opt/update_critic/value/extrinsic_value/kernel/ApplyAdam
[
gradients_2/ShapeConst^sac_policy_opt^sac_value_opt*
dtype0*
valueB 
c
gradients_2/grad_ys_0Const^sac_policy_opt^sac_value_opt*
dtype0*
valueB
 *  �?
]
gradients_2/FillFillgradients_2/Shapegradients_2/grad_ys_0*
T0*

index_type0
:
gradients_2/Neg_grad/NegNeggradients_2/Fill*
T0
{
%gradients_2/Mean_4_grad/Reshape/shapeConst^sac_policy_opt^sac_value_opt*
dtype0*
valueB"      
�
gradients_2/Mean_4_grad/ReshapeReshapegradients_2/Neg_grad/Neg%gradients_2/Mean_4_grad/Reshape/shape*
T0*
Tshape0
h
gradients_2/Mean_4_grad/ShapeShapemul_10^sac_policy_opt^sac_value_opt*
T0*
out_type0

gradients_2/Mean_4_grad/TileTilegradients_2/Mean_4_grad/Reshapegradients_2/Mean_4_grad/Shape*
T0*

Tmultiples0
j
gradients_2/Mean_4_grad/Shape_1Shapemul_10^sac_policy_opt^sac_value_opt*
T0*
out_type0
i
gradients_2/Mean_4_grad/Shape_2Const^sac_policy_opt^sac_value_opt*
dtype0*
valueB 
l
gradients_2/Mean_4_grad/ConstConst^sac_policy_opt^sac_value_opt*
dtype0*
valueB: 
�
gradients_2/Mean_4_grad/ProdProdgradients_2/Mean_4_grad/Shape_1gradients_2/Mean_4_grad/Const*
T0*

Tidx0*
	keep_dims( 
n
gradients_2/Mean_4_grad/Const_1Const^sac_policy_opt^sac_value_opt*
dtype0*
valueB: 
�
gradients_2/Mean_4_grad/Prod_1Prodgradients_2/Mean_4_grad/Shape_2gradients_2/Mean_4_grad/Const_1*
T0*

Tidx0*
	keep_dims( 
l
!gradients_2/Mean_4_grad/Maximum/yConst^sac_policy_opt^sac_value_opt*
dtype0*
value	B :
v
gradients_2/Mean_4_grad/MaximumMaximumgradients_2/Mean_4_grad/Prod_1!gradients_2/Mean_4_grad/Maximum/y*
T0
t
 gradients_2/Mean_4_grad/floordivFloorDivgradients_2/Mean_4_grad/Prodgradients_2/Mean_4_grad/Maximum*
T0
n
gradients_2/Mean_4_grad/CastCast gradients_2/Mean_4_grad/floordiv*

DstT0*

SrcT0*
Truncate( 
o
gradients_2/Mean_4_grad/truedivRealDivgradients_2/Mean_4_grad/Tilegradients_2/Mean_4_grad/Cast*
T0
g
gradients_2/mul_10_grad/ShapeShapemul_9^sac_policy_opt^sac_value_opt*
T0*
out_type0
r
gradients_2/mul_10_grad/Shape_1ShapeStopGradient_2^sac_policy_opt^sac_value_opt*
T0*
out_type0
�
-gradients_2/mul_10_grad/BroadcastGradientArgsBroadcastGradientArgsgradients_2/mul_10_grad/Shapegradients_2/mul_10_grad/Shape_1*
T0
\
gradients_2/mul_10_grad/MulMulgradients_2/Mean_4_grad/truedivStopGradient_2*
T0
�
gradients_2/mul_10_grad/SumSumgradients_2/mul_10_grad/Mul-gradients_2/mul_10_grad/BroadcastGradientArgs*
T0*

Tidx0*
	keep_dims( 
}
gradients_2/mul_10_grad/ReshapeReshapegradients_2/mul_10_grad/Sumgradients_2/mul_10_grad/Shape*
T0*
Tshape0
U
gradients_2/mul_10_grad/Mul_1Mulmul_9gradients_2/Mean_4_grad/truediv*
T0
�
gradients_2/mul_10_grad/Sum_1Sumgradients_2/mul_10_grad/Mul_1/gradients_2/mul_10_grad/BroadcastGradientArgs:1*
T0*

Tidx0*
	keep_dims( 
�
!gradients_2/mul_10_grad/Reshape_1Reshapegradients_2/mul_10_grad/Sum_1gradients_2/mul_10_grad/Shape_1*
T0*
Tshape0
�
(gradients_2/mul_10_grad/tuple/group_depsNoOp ^gradients_2/mul_10_grad/Reshape"^gradients_2/mul_10_grad/Reshape_1^sac_policy_opt^sac_value_opt
�
0gradients_2/mul_10_grad/tuple/control_dependencyIdentitygradients_2/mul_10_grad/Reshape)^gradients_2/mul_10_grad/tuple/group_deps*
T0*2
_class(
&$loc:@gradients_2/mul_10_grad/Reshape
�
2gradients_2/mul_10_grad/tuple/control_dependency_1Identity!gradients_2/mul_10_grad/Reshape_1)^gradients_2/mul_10_grad/tuple/group_deps*
T0*4
_class*
(&loc:@gradients_2/mul_10_grad/Reshape_1
r
gradients_2/mul_9_grad/ShapeShapelog_ent_coef/read^sac_policy_opt^sac_value_opt*
T0*
out_type0
l
gradients_2/mul_9_grad/Shape_1Shape	ToFloat_2^sac_policy_opt^sac_value_opt*
T0*
out_type0
�
,gradients_2/mul_9_grad/BroadcastGradientArgsBroadcastGradientArgsgradients_2/mul_9_grad/Shapegradients_2/mul_9_grad/Shape_1*
T0
g
gradients_2/mul_9_grad/MulMul0gradients_2/mul_10_grad/tuple/control_dependency	ToFloat_2*
T0
�
gradients_2/mul_9_grad/SumSumgradients_2/mul_9_grad/Mul,gradients_2/mul_9_grad/BroadcastGradientArgs*
T0*

Tidx0*
	keep_dims( 
z
gradients_2/mul_9_grad/ReshapeReshapegradients_2/mul_9_grad/Sumgradients_2/mul_9_grad/Shape*
T0*
Tshape0
q
gradients_2/mul_9_grad/Mul_1Mullog_ent_coef/read0gradients_2/mul_10_grad/tuple/control_dependency*
T0
�
gradients_2/mul_9_grad/Sum_1Sumgradients_2/mul_9_grad/Mul_1.gradients_2/mul_9_grad/BroadcastGradientArgs:1*
T0*

Tidx0*
	keep_dims( 
�
 gradients_2/mul_9_grad/Reshape_1Reshapegradients_2/mul_9_grad/Sum_1gradients_2/mul_9_grad/Shape_1*
T0*
Tshape0
�
'gradients_2/mul_9_grad/tuple/group_depsNoOp^gradients_2/mul_9_grad/Reshape!^gradients_2/mul_9_grad/Reshape_1^sac_policy_opt^sac_value_opt
�
/gradients_2/mul_9_grad/tuple/control_dependencyIdentitygradients_2/mul_9_grad/Reshape(^gradients_2/mul_9_grad/tuple/group_deps*
T0*1
_class'
%#loc:@gradients_2/mul_9_grad/Reshape
�
1gradients_2/mul_9_grad/tuple/control_dependency_1Identity gradients_2/mul_9_grad/Reshape_1(^gradients_2/mul_9_grad/tuple/group_deps*
T0*3
_class)
'%loc:@gradients_2/mul_9_grad/Reshape_1
i
beta1_power_2/initial_valueConst*
_class
loc:@log_ent_coef*
dtype0*
valueB
 *fff?
z
beta1_power_2
VariableV2*
_class
loc:@log_ent_coef*
	container *
dtype0*
shape: *
shared_name 
�
beta1_power_2/AssignAssignbeta1_power_2beta1_power_2/initial_value*
T0*
_class
loc:@log_ent_coef*
use_locking(*
validate_shape(
W
beta1_power_2/readIdentitybeta1_power_2*
T0*
_class
loc:@log_ent_coef
i
beta2_power_2/initial_valueConst*
_class
loc:@log_ent_coef*
dtype0*
valueB
 *w�?
z
beta2_power_2
VariableV2*
_class
loc:@log_ent_coef*
	container *
dtype0*
shape: *
shared_name 
�
beta2_power_2/AssignAssignbeta2_power_2beta2_power_2/initial_value*
T0*
_class
loc:@log_ent_coef*
use_locking(*
validate_shape(
W
beta2_power_2/readIdentitybeta2_power_2*
T0*
_class
loc:@log_ent_coef
|
.log_ent_coef/sac_entropy_opt/Initializer/zerosConst*
_class
loc:@log_ent_coef*
dtype0*
valueB
 *    
�
log_ent_coef/sac_entropy_opt
VariableV2*
_class
loc:@log_ent_coef*
	container *
dtype0*
shape: *
shared_name 
�
#log_ent_coef/sac_entropy_opt/AssignAssignlog_ent_coef/sac_entropy_opt.log_ent_coef/sac_entropy_opt/Initializer/zeros*
T0*
_class
loc:@log_ent_coef*
use_locking(*
validate_shape(
u
!log_ent_coef/sac_entropy_opt/readIdentitylog_ent_coef/sac_entropy_opt*
T0*
_class
loc:@log_ent_coef
~
0log_ent_coef/sac_entropy_opt_1/Initializer/zerosConst*
_class
loc:@log_ent_coef*
dtype0*
valueB
 *    
�
log_ent_coef/sac_entropy_opt_1
VariableV2*
_class
loc:@log_ent_coef*
	container *
dtype0*
shape: *
shared_name 
�
%log_ent_coef/sac_entropy_opt_1/AssignAssignlog_ent_coef/sac_entropy_opt_10log_ent_coef/sac_entropy_opt_1/Initializer/zeros*
T0*
_class
loc:@log_ent_coef*
use_locking(*
validate_shape(
y
#log_ent_coef/sac_entropy_opt_1/readIdentitylog_ent_coef/sac_entropy_opt_1*
T0*
_class
loc:@log_ent_coef
c
sac_entropy_opt/beta1Const^sac_policy_opt^sac_value_opt*
dtype0*
valueB
 *fff?
c
sac_entropy_opt/beta2Const^sac_policy_opt^sac_value_opt*
dtype0*
valueB
 *w�?
e
sac_entropy_opt/epsilonConst^sac_policy_opt^sac_value_opt*
dtype0*
valueB
 *w�+2
�
-sac_entropy_opt/update_log_ent_coef/ApplyAdam	ApplyAdamlog_ent_coeflog_ent_coef/sac_entropy_optlog_ent_coef/sac_entropy_opt_1beta1_power_2/readbeta2_power_2/readVariable_1/readsac_entropy_opt/beta1sac_entropy_opt/beta2sac_entropy_opt/epsilon/gradients_2/mul_9_grad/tuple/control_dependency*
T0*
_class
loc:@log_ent_coef*
use_locking( *
use_nesterov( 
�
sac_entropy_opt/mulMulbeta1_power_2/readsac_entropy_opt/beta1.^sac_entropy_opt/update_log_ent_coef/ApplyAdam*
T0*
_class
loc:@log_ent_coef
�
sac_entropy_opt/AssignAssignbeta1_power_2sac_entropy_opt/mul*
T0*
_class
loc:@log_ent_coef*
use_locking( *
validate_shape(
�
sac_entropy_opt/mul_1Mulbeta2_power_2/readsac_entropy_opt/beta2.^sac_entropy_opt/update_log_ent_coef/ApplyAdam*
T0*
_class
loc:@log_ent_coef
�
sac_entropy_opt/Assign_1Assignbeta2_power_2sac_entropy_opt/mul_1*
T0*
_class
loc:@log_ent_coef*
use_locking( *
validate_shape(
�
sac_entropy_optNoOp^sac_entropy_opt/Assign^sac_entropy_opt/Assign_1.^sac_entropy_opt/update_log_ent_coef/ApplyAdam^sac_policy_opt^sac_value_opt
�
	Assign_38Assigntarget_network/running_meanrunning_mean/read*
T0*.
_class$
" loc:@target_network/running_mean*
use_locking(*
validate_shape(
�
	Assign_39Assigntarget_network/running_variancerunning_variance/read*
T0*2
_class(
&$loc:@target_network/running_variance*
use_locking(*
validate_shape(
�
	Assign_40Assign"target_network/normalization_stepsnormalization_steps/read*
T0*5
_class+
)'loc:@target_network/normalization_steps*
use_locking(*
validate_shape(
8
group_deps_2NoOp
^Assign_38
^Assign_39
^Assign_40
2
group_deps_3NoOp^group_deps_1^group_deps_2
A
save/filename/inputConst*
dtype0*
valueB Bmodel
V
save/filenamePlaceholderWithDefaultsave/filename/input*
dtype0*
shape: 
M

save/ConstPlaceholderWithDefaultsave/filename*
dtype0*
shape: 
�$
save/SaveV2/tensor_namesConst*
dtype0*�#
value�#B�#mBVariableB
Variable_1Baction_output_shapeBbeta1_powerBbeta1_power_1Bbeta1_power_2Bbeta2_powerBbeta2_power_1Bbeta2_power_2B&critic/q/q1_encoding/extrinsic_q1/biasB4critic/q/q1_encoding/extrinsic_q1/bias/sac_value_optB6critic/q/q1_encoding/extrinsic_q1/bias/sac_value_opt_1B(critic/q/q1_encoding/extrinsic_q1/kernelB6critic/q/q1_encoding/extrinsic_q1/kernel/sac_value_optB8critic/q/q1_encoding/extrinsic_q1/kernel/sac_value_opt_1B-critic/q/q1_encoding/q1_encoder/hidden_0/biasB;critic/q/q1_encoding/q1_encoder/hidden_0/bias/sac_value_optB=critic/q/q1_encoding/q1_encoder/hidden_0/bias/sac_value_opt_1B/critic/q/q1_encoding/q1_encoder/hidden_0/kernelB=critic/q/q1_encoding/q1_encoder/hidden_0/kernel/sac_value_optB?critic/q/q1_encoding/q1_encoder/hidden_0/kernel/sac_value_opt_1B-critic/q/q1_encoding/q1_encoder/hidden_1/biasB;critic/q/q1_encoding/q1_encoder/hidden_1/bias/sac_value_optB=critic/q/q1_encoding/q1_encoder/hidden_1/bias/sac_value_opt_1B/critic/q/q1_encoding/q1_encoder/hidden_1/kernelB=critic/q/q1_encoding/q1_encoder/hidden_1/kernel/sac_value_optB?critic/q/q1_encoding/q1_encoder/hidden_1/kernel/sac_value_opt_1B&critic/q/q2_encoding/extrinsic_q2/biasB4critic/q/q2_encoding/extrinsic_q2/bias/sac_value_optB6critic/q/q2_encoding/extrinsic_q2/bias/sac_value_opt_1B(critic/q/q2_encoding/extrinsic_q2/kernelB6critic/q/q2_encoding/extrinsic_q2/kernel/sac_value_optB8critic/q/q2_encoding/extrinsic_q2/kernel/sac_value_opt_1B-critic/q/q2_encoding/q2_encoder/hidden_0/biasB;critic/q/q2_encoding/q2_encoder/hidden_0/bias/sac_value_optB=critic/q/q2_encoding/q2_encoder/hidden_0/bias/sac_value_opt_1B/critic/q/q2_encoding/q2_encoder/hidden_0/kernelB=critic/q/q2_encoding/q2_encoder/hidden_0/kernel/sac_value_optB?critic/q/q2_encoding/q2_encoder/hidden_0/kernel/sac_value_opt_1B-critic/q/q2_encoding/q2_encoder/hidden_1/biasB;critic/q/q2_encoding/q2_encoder/hidden_1/bias/sac_value_optB=critic/q/q2_encoding/q2_encoder/hidden_1/bias/sac_value_opt_1B/critic/q/q2_encoding/q2_encoder/hidden_1/kernelB=critic/q/q2_encoding/q2_encoder/hidden_1/kernel/sac_value_optB?critic/q/q2_encoding/q2_encoder/hidden_1/kernel/sac_value_opt_1B"critic/value/encoder/hidden_0/biasB0critic/value/encoder/hidden_0/bias/sac_value_optB2critic/value/encoder/hidden_0/bias/sac_value_opt_1B$critic/value/encoder/hidden_0/kernelB2critic/value/encoder/hidden_0/kernel/sac_value_optB4critic/value/encoder/hidden_0/kernel/sac_value_opt_1B"critic/value/encoder/hidden_1/biasB0critic/value/encoder/hidden_1/bias/sac_value_optB2critic/value/encoder/hidden_1/bias/sac_value_opt_1B$critic/value/encoder/hidden_1/kernelB2critic/value/encoder/hidden_1/kernel/sac_value_optB4critic/value/encoder/hidden_1/kernel/sac_value_opt_1B!critic/value/extrinsic_value/biasB/critic/value/extrinsic_value/bias/sac_value_optB1critic/value/extrinsic_value/bias/sac_value_opt_1B#critic/value/extrinsic_value/kernelB1critic/value/extrinsic_value/kernel/sac_value_optB3critic/value/extrinsic_value/kernel/sac_value_opt_1Bglobal_stepBis_continuous_controlBlog_ent_coefBlog_ent_coef/sac_entropy_optBlog_ent_coef/sac_entropy_opt_1Bmemory_sizeBnormalization_stepsBpolicy/log_std/biasB"policy/log_std/bias/sac_policy_optB$policy/log_std/bias/sac_policy_opt_1Bpolicy/log_std/kernelB$policy/log_std/kernel/sac_policy_optB&policy/log_std/kernel/sac_policy_opt_1B!policy/main_graph_0/hidden_0/biasB0policy/main_graph_0/hidden_0/bias/sac_policy_optB2policy/main_graph_0/hidden_0/bias/sac_policy_opt_1B#policy/main_graph_0/hidden_0/kernelB2policy/main_graph_0/hidden_0/kernel/sac_policy_optB4policy/main_graph_0/hidden_0/kernel/sac_policy_opt_1B!policy/main_graph_0/hidden_1/biasB0policy/main_graph_0/hidden_1/bias/sac_policy_optB2policy/main_graph_0/hidden_1/bias/sac_policy_opt_1B#policy/main_graph_0/hidden_1/kernelB2policy/main_graph_0/hidden_1/kernel/sac_policy_optB4policy/main_graph_0/hidden_1/kernel/sac_policy_opt_1Bpolicy/mu/biasBpolicy/mu/bias/sac_policy_optBpolicy/mu/bias/sac_policy_opt_1Bpolicy/mu/kernelBpolicy/mu/kernel/sac_policy_optB!policy/mu/kernel/sac_policy_opt_1Brunning_meanBrunning_varianceB1target_network/critic/value/encoder/hidden_0/biasB3target_network/critic/value/encoder/hidden_0/kernelB1target_network/critic/value/encoder/hidden_1/biasB3target_network/critic/value/encoder/hidden_1/kernelB0target_network/critic/value/extrinsic_value/biasB2target_network/critic/value/extrinsic_value/kernelB"target_network/normalization_stepsBtarget_network/running_meanBtarget_network/running_varianceBtrainer_major_versionBtrainer_minor_versionBtrainer_patch_versionBversion_number
�
save/SaveV2/shape_and_slicesConst*
dtype0*�
value�B�mB B B B B B B B B B B B B B B B B B B B B B B B B B B B B B B B B B B B B B B B B B B B B B B B B B B B B B B B B B B B B B B B B B B B B B B B B B B B B B B B B B B B B B B B B B B B B B B B B B B B B B B B B B B B B 
�%
save/SaveV2SaveV2
save/Constsave/SaveV2/tensor_namessave/SaveV2/shape_and_slicesVariable
Variable_1action_output_shapebeta1_powerbeta1_power_1beta1_power_2beta2_powerbeta2_power_1beta2_power_2&critic/q/q1_encoding/extrinsic_q1/bias4critic/q/q1_encoding/extrinsic_q1/bias/sac_value_opt6critic/q/q1_encoding/extrinsic_q1/bias/sac_value_opt_1(critic/q/q1_encoding/extrinsic_q1/kernel6critic/q/q1_encoding/extrinsic_q1/kernel/sac_value_opt8critic/q/q1_encoding/extrinsic_q1/kernel/sac_value_opt_1-critic/q/q1_encoding/q1_encoder/hidden_0/bias;critic/q/q1_encoding/q1_encoder/hidden_0/bias/sac_value_opt=critic/q/q1_encoding/q1_encoder/hidden_0/bias/sac_value_opt_1/critic/q/q1_encoding/q1_encoder/hidden_0/kernel=critic/q/q1_encoding/q1_encoder/hidden_0/kernel/sac_value_opt?critic/q/q1_encoding/q1_encoder/hidden_0/kernel/sac_value_opt_1-critic/q/q1_encoding/q1_encoder/hidden_1/bias;critic/q/q1_encoding/q1_encoder/hidden_1/bias/sac_value_opt=critic/q/q1_encoding/q1_encoder/hidden_1/bias/sac_value_opt_1/critic/q/q1_encoding/q1_encoder/hidden_1/kernel=critic/q/q1_encoding/q1_encoder/hidden_1/kernel/sac_value_opt?critic/q/q1_encoding/q1_encoder/hidden_1/kernel/sac_value_opt_1&critic/q/q2_encoding/extrinsic_q2/bias4critic/q/q2_encoding/extrinsic_q2/bias/sac_value_opt6critic/q/q2_encoding/extrinsic_q2/bias/sac_value_opt_1(critic/q/q2_encoding/extrinsic_q2/kernel6critic/q/q2_encoding/extrinsic_q2/kernel/sac_value_opt8critic/q/q2_encoding/extrinsic_q2/kernel/sac_value_opt_1-critic/q/q2_encoding/q2_encoder/hidden_0/bias;critic/q/q2_encoding/q2_encoder/hidden_0/bias/sac_value_opt=critic/q/q2_encoding/q2_encoder/hidden_0/bias/sac_value_opt_1/critic/q/q2_encoding/q2_encoder/hidden_0/kernel=critic/q/q2_encoding/q2_encoder/hidden_0/kernel/sac_value_opt?critic/q/q2_encoding/q2_encoder/hidden_0/kernel/sac_value_opt_1-critic/q/q2_encoding/q2_encoder/hidden_1/bias;critic/q/q2_encoding/q2_encoder/hidden_1/bias/sac_value_opt=critic/q/q2_encoding/q2_encoder/hidden_1/bias/sac_value_opt_1/critic/q/q2_encoding/q2_encoder/hidden_1/kernel=critic/q/q2_encoding/q2_encoder/hidden_1/kernel/sac_value_opt?critic/q/q2_encoding/q2_encoder/hidden_1/kernel/sac_value_opt_1"critic/value/encoder/hidden_0/bias0critic/value/encoder/hidden_0/bias/sac_value_opt2critic/value/encoder/hidden_0/bias/sac_value_opt_1$critic/value/encoder/hidden_0/kernel2critic/value/encoder/hidden_0/kernel/sac_value_opt4critic/value/encoder/hidden_0/kernel/sac_value_opt_1"critic/value/encoder/hidden_1/bias0critic/value/encoder/hidden_1/bias/sac_value_opt2critic/value/encoder/hidden_1/bias/sac_value_opt_1$critic/value/encoder/hidden_1/kernel2critic/value/encoder/hidden_1/kernel/sac_value_opt4critic/value/encoder/hidden_1/kernel/sac_value_opt_1!critic/value/extrinsic_value/bias/critic/value/extrinsic_value/bias/sac_value_opt1critic/value/extrinsic_value/bias/sac_value_opt_1#critic/value/extrinsic_value/kernel1critic/value/extrinsic_value/kernel/sac_value_opt3critic/value/extrinsic_value/kernel/sac_value_opt_1global_stepis_continuous_controllog_ent_coeflog_ent_coef/sac_entropy_optlog_ent_coef/sac_entropy_opt_1memory_sizenormalization_stepspolicy/log_std/bias"policy/log_std/bias/sac_policy_opt$policy/log_std/bias/sac_policy_opt_1policy/log_std/kernel$policy/log_std/kernel/sac_policy_opt&policy/log_std/kernel/sac_policy_opt_1!policy/main_graph_0/hidden_0/bias0policy/main_graph_0/hidden_0/bias/sac_policy_opt2policy/main_graph_0/hidden_0/bias/sac_policy_opt_1#policy/main_graph_0/hidden_0/kernel2policy/main_graph_0/hidden_0/kernel/sac_policy_opt4policy/main_graph_0/hidden_0/kernel/sac_policy_opt_1!policy/main_graph_0/hidden_1/bias0policy/main_graph_0/hidden_1/bias/sac_policy_opt2policy/main_graph_0/hidden_1/bias/sac_policy_opt_1#policy/main_graph_0/hidden_1/kernel2policy/main_graph_0/hidden_1/kernel/sac_policy_opt4policy/main_graph_0/hidden_1/kernel/sac_policy_opt_1policy/mu/biaspolicy/mu/bias/sac_policy_optpolicy/mu/bias/sac_policy_opt_1policy/mu/kernelpolicy/mu/kernel/sac_policy_opt!policy/mu/kernel/sac_policy_opt_1running_meanrunning_variance1target_network/critic/value/encoder/hidden_0/bias3target_network/critic/value/encoder/hidden_0/kernel1target_network/critic/value/encoder/hidden_1/bias3target_network/critic/value/encoder/hidden_1/kernel0target_network/critic/value/extrinsic_value/bias2target_network/critic/value/extrinsic_value/kernel"target_network/normalization_stepstarget_network/running_meantarget_network/running_variancetrainer_major_versiontrainer_minor_versiontrainer_patch_versionversion_number*{
dtypesq
o2m
e
save/control_dependencyIdentity
save/Const^save/SaveV2*
T0*
_class
loc:@save/Const
�$
save/RestoreV2/tensor_namesConst"/device:CPU:0*
dtype0*�#
value�#B�#mBVariableB
Variable_1Baction_output_shapeBbeta1_powerBbeta1_power_1Bbeta1_power_2Bbeta2_powerBbeta2_power_1Bbeta2_power_2B&critic/q/q1_encoding/extrinsic_q1/biasB4critic/q/q1_encoding/extrinsic_q1/bias/sac_value_optB6critic/q/q1_encoding/extrinsic_q1/bias/sac_value_opt_1B(critic/q/q1_encoding/extrinsic_q1/kernelB6critic/q/q1_encoding/extrinsic_q1/kernel/sac_value_optB8critic/q/q1_encoding/extrinsic_q1/kernel/sac_value_opt_1B-critic/q/q1_encoding/q1_encoder/hidden_0/biasB;critic/q/q1_encoding/q1_encoder/hidden_0/bias/sac_value_optB=critic/q/q1_encoding/q1_encoder/hidden_0/bias/sac_value_opt_1B/critic/q/q1_encoding/q1_encoder/hidden_0/kernelB=critic/q/q1_encoding/q1_encoder/hidden_0/kernel/sac_value_optB?critic/q/q1_encoding/q1_encoder/hidden_0/kernel/sac_value_opt_1B-critic/q/q1_encoding/q1_encoder/hidden_1/biasB;critic/q/q1_encoding/q1_encoder/hidden_1/bias/sac_value_optB=critic/q/q1_encoding/q1_encoder/hidden_1/bias/sac_value_opt_1B/critic/q/q1_encoding/q1_encoder/hidden_1/kernelB=critic/q/q1_encoding/q1_encoder/hidden_1/kernel/sac_value_optB?critic/q/q1_encoding/q1_encoder/hidden_1/kernel/sac_value_opt_1B&critic/q/q2_encoding/extrinsic_q2/biasB4critic/q/q2_encoding/extrinsic_q2/bias/sac_value_optB6critic/q/q2_encoding/extrinsic_q2/bias/sac_value_opt_1B(critic/q/q2_encoding/extrinsic_q2/kernelB6critic/q/q2_encoding/extrinsic_q2/kernel/sac_value_optB8critic/q/q2_encoding/extrinsic_q2/kernel/sac_value_opt_1B-critic/q/q2_encoding/q2_encoder/hidden_0/biasB;critic/q/q2_encoding/q2_encoder/hidden_0/bias/sac_value_optB=critic/q/q2_encoding/q2_encoder/hidden_0/bias/sac_value_opt_1B/critic/q/q2_encoding/q2_encoder/hidden_0/kernelB=critic/q/q2_encoding/q2_encoder/hidden_0/kernel/sac_value_optB?critic/q/q2_encoding/q2_encoder/hidden_0/kernel/sac_value_opt_1B-critic/q/q2_encoding/q2_encoder/hidden_1/biasB;critic/q/q2_encoding/q2_encoder/hidden_1/bias/sac_value_optB=critic/q/q2_encoding/q2_encoder/hidden_1/bias/sac_value_opt_1B/critic/q/q2_encoding/q2_encoder/hidden_1/kernelB=critic/q/q2_encoding/q2_encoder/hidden_1/kernel/sac_value_optB?critic/q/q2_encoding/q2_encoder/hidden_1/kernel/sac_value_opt_1B"critic/value/encoder/hidden_0/biasB0critic/value/encoder/hidden_0/bias/sac_value_optB2critic/value/encoder/hidden_0/bias/sac_value_opt_1B$critic/value/encoder/hidden_0/kernelB2critic/value/encoder/hidden_0/kernel/sac_value_optB4critic/value/encoder/hidden_0/kernel/sac_value_opt_1B"critic/value/encoder/hidden_1/biasB0critic/value/encoder/hidden_1/bias/sac_value_optB2critic/value/encoder/hidden_1/bias/sac_value_opt_1B$critic/value/encoder/hidden_1/kernelB2critic/value/encoder/hidden_1/kernel/sac_value_optB4critic/value/encoder/hidden_1/kernel/sac_value_opt_1B!critic/value/extrinsic_value/biasB/critic/value/extrinsic_value/bias/sac_value_optB1critic/value/extrinsic_value/bias/sac_value_opt_1B#critic/value/extrinsic_value/kernelB1critic/value/extrinsic_value/kernel/sac_value_optB3critic/value/extrinsic_value/kernel/sac_value_opt_1Bglobal_stepBis_continuous_controlBlog_ent_coefBlog_ent_coef/sac_entropy_optBlog_ent_coef/sac_entropy_opt_1Bmemory_sizeBnormalization_stepsBpolicy/log_std/biasB"policy/log_std/bias/sac_policy_optB$policy/log_std/bias/sac_policy_opt_1Bpolicy/log_std/kernelB$policy/log_std/kernel/sac_policy_optB&policy/log_std/kernel/sac_policy_opt_1B!policy/main_graph_0/hidden_0/biasB0policy/main_graph_0/hidden_0/bias/sac_policy_optB2policy/main_graph_0/hidden_0/bias/sac_policy_opt_1B#policy/main_graph_0/hidden_0/kernelB2policy/main_graph_0/hidden_0/kernel/sac_policy_optB4policy/main_graph_0/hidden_0/kernel/sac_policy_opt_1B!policy/main_graph_0/hidden_1/biasB0policy/main_graph_0/hidden_1/bias/sac_policy_optB2policy/main_graph_0/hidden_1/bias/sac_policy_opt_1B#policy/main_graph_0/hidden_1/kernelB2policy/main_graph_0/hidden_1/kernel/sac_policy_optB4policy/main_graph_0/hidden_1/kernel/sac_policy_opt_1Bpolicy/mu/biasBpolicy/mu/bias/sac_policy_optBpolicy/mu/bias/sac_policy_opt_1Bpolicy/mu/kernelBpolicy/mu/kernel/sac_policy_optB!policy/mu/kernel/sac_policy_opt_1Brunning_meanBrunning_varianceB1target_network/critic/value/encoder/hidden_0/biasB3target_network/critic/value/encoder/hidden_0/kernelB1target_network/critic/value/encoder/hidden_1/biasB3target_network/critic/value/encoder/hidden_1/kernelB0target_network/critic/value/extrinsic_value/biasB2target_network/critic/value/extrinsic_value/kernelB"target_network/normalization_stepsBtarget_network/running_meanBtarget_network/running_varianceBtrainer_major_versionBtrainer_minor_versionBtrainer_patch_versionBversion_number
�
save/RestoreV2/shape_and_slicesConst"/device:CPU:0*
dtype0*�
value�B�mB B B B B B B B B B B B B B B B B B B B B B B B B B B B B B B B B B B B B B B B B B B B B B B B B B B B B B B B B B B B B B B B B B B B B B B B B B B B B B B B B B B B B B B B B B B B B B B B B B B B B B B B B B B B B 
�
save/RestoreV2	RestoreV2
save/Constsave/RestoreV2/tensor_namessave/RestoreV2/shape_and_slices"/device:CPU:0*{
dtypesq
o2m
~
save/AssignAssignVariablesave/RestoreV2*
T0*
_class
loc:@Variable*
use_locking(*
validate_shape(
�
save/Assign_1Assign
Variable_1save/RestoreV2:1*
T0*
_class
loc:@Variable_1*
use_locking(*
validate_shape(
�
save/Assign_2Assignaction_output_shapesave/RestoreV2:2*
T0*&
_class
loc:@action_output_shape*
use_locking(*
validate_shape(
�
save/Assign_3Assignbeta1_powersave/RestoreV2:3*
T0*&
_class
loc:@policy/log_std/bias*
use_locking(*
validate_shape(
�
save/Assign_4Assignbeta1_power_1save/RestoreV2:4*
T0*9
_class/
-+loc:@critic/q/q1_encoding/extrinsic_q1/bias*
use_locking(*
validate_shape(
�
save/Assign_5Assignbeta1_power_2save/RestoreV2:5*
T0*
_class
loc:@log_ent_coef*
use_locking(*
validate_shape(
�
save/Assign_6Assignbeta2_powersave/RestoreV2:6*
T0*&
_class
loc:@policy/log_std/bias*
use_locking(*
validate_shape(
�
save/Assign_7Assignbeta2_power_1save/RestoreV2:7*
T0*9
_class/
-+loc:@critic/q/q1_encoding/extrinsic_q1/bias*
use_locking(*
validate_shape(
�
save/Assign_8Assignbeta2_power_2save/RestoreV2:8*
T0*
_class
loc:@log_ent_coef*
use_locking(*
validate_shape(
�
save/Assign_9Assign&critic/q/q1_encoding/extrinsic_q1/biassave/RestoreV2:9*
T0*9
_class/
-+loc:@critic/q/q1_encoding/extrinsic_q1/bias*
use_locking(*
validate_shape(
�
save/Assign_10Assign4critic/q/q1_encoding/extrinsic_q1/bias/sac_value_optsave/RestoreV2:10*
T0*9
_class/
-+loc:@critic/q/q1_encoding/extrinsic_q1/bias*
use_locking(*
validate_shape(
�
save/Assign_11Assign6critic/q/q1_encoding/extrinsic_q1/bias/sac_value_opt_1save/RestoreV2:11*
T0*9
_class/
-+loc:@critic/q/q1_encoding/extrinsic_q1/bias*
use_locking(*
validate_shape(
�
save/Assign_12Assign(critic/q/q1_encoding/extrinsic_q1/kernelsave/RestoreV2:12*
T0*;
_class1
/-loc:@critic/q/q1_encoding/extrinsic_q1/kernel*
use_locking(*
validate_shape(
�
save/Assign_13Assign6critic/q/q1_encoding/extrinsic_q1/kernel/sac_value_optsave/RestoreV2:13*
T0*;
_class1
/-loc:@critic/q/q1_encoding/extrinsic_q1/kernel*
use_locking(*
validate_shape(
�
save/Assign_14Assign8critic/q/q1_encoding/extrinsic_q1/kernel/sac_value_opt_1save/RestoreV2:14*
T0*;
_class1
/-loc:@critic/q/q1_encoding/extrinsic_q1/kernel*
use_locking(*
validate_shape(
�
save/Assign_15Assign-critic/q/q1_encoding/q1_encoder/hidden_0/biassave/RestoreV2:15*
T0*@
_class6
42loc:@critic/q/q1_encoding/q1_encoder/hidden_0/bias*
use_locking(*
validate_shape(
�
save/Assign_16Assign;critic/q/q1_encoding/q1_encoder/hidden_0/bias/sac_value_optsave/RestoreV2:16*
T0*@
_class6
42loc:@critic/q/q1_encoding/q1_encoder/hidden_0/bias*
use_locking(*
validate_shape(
�
save/Assign_17Assign=critic/q/q1_encoding/q1_encoder/hidden_0/bias/sac_value_opt_1save/RestoreV2:17*
T0*@
_class6
42loc:@critic/q/q1_encoding/q1_encoder/hidden_0/bias*
use_locking(*
validate_shape(
�
save/Assign_18Assign/critic/q/q1_encoding/q1_encoder/hidden_0/kernelsave/RestoreV2:18*
T0*B
_class8
64loc:@critic/q/q1_encoding/q1_encoder/hidden_0/kernel*
use_locking(*
validate_shape(
�
save/Assign_19Assign=critic/q/q1_encoding/q1_encoder/hidden_0/kernel/sac_value_optsave/RestoreV2:19*
T0*B
_class8
64loc:@critic/q/q1_encoding/q1_encoder/hidden_0/kernel*
use_locking(*
validate_shape(
�
save/Assign_20Assign?critic/q/q1_encoding/q1_encoder/hidden_0/kernel/sac_value_opt_1save/RestoreV2:20*
T0*B
_class8
64loc:@critic/q/q1_encoding/q1_encoder/hidden_0/kernel*
use_locking(*
validate_shape(
�
save/Assign_21Assign-critic/q/q1_encoding/q1_encoder/hidden_1/biassave/RestoreV2:21*
T0*@
_class6
42loc:@critic/q/q1_encoding/q1_encoder/hidden_1/bias*
use_locking(*
validate_shape(
�
save/Assign_22Assign;critic/q/q1_encoding/q1_encoder/hidden_1/bias/sac_value_optsave/RestoreV2:22*
T0*@
_class6
42loc:@critic/q/q1_encoding/q1_encoder/hidden_1/bias*
use_locking(*
validate_shape(
�
save/Assign_23Assign=critic/q/q1_encoding/q1_encoder/hidden_1/bias/sac_value_opt_1save/RestoreV2:23*
T0*@
_class6
42loc:@critic/q/q1_encoding/q1_encoder/hidden_1/bias*
use_locking(*
validate_shape(
�
save/Assign_24Assign/critic/q/q1_encoding/q1_encoder/hidden_1/kernelsave/RestoreV2:24*
T0*B
_class8
64loc:@critic/q/q1_encoding/q1_encoder/hidden_1/kernel*
use_locking(*
validate_shape(
�
save/Assign_25Assign=critic/q/q1_encoding/q1_encoder/hidden_1/kernel/sac_value_optsave/RestoreV2:25*
T0*B
_class8
64loc:@critic/q/q1_encoding/q1_encoder/hidden_1/kernel*
use_locking(*
validate_shape(
�
save/Assign_26Assign?critic/q/q1_encoding/q1_encoder/hidden_1/kernel/sac_value_opt_1save/RestoreV2:26*
T0*B
_class8
64loc:@critic/q/q1_encoding/q1_encoder/hidden_1/kernel*
use_locking(*
validate_shape(
�
save/Assign_27Assign&critic/q/q2_encoding/extrinsic_q2/biassave/RestoreV2:27*
T0*9
_class/
-+loc:@critic/q/q2_encoding/extrinsic_q2/bias*
use_locking(*
validate_shape(
�
save/Assign_28Assign4critic/q/q2_encoding/extrinsic_q2/bias/sac_value_optsave/RestoreV2:28*
T0*9
_class/
-+loc:@critic/q/q2_encoding/extrinsic_q2/bias*
use_locking(*
validate_shape(
�
save/Assign_29Assign6critic/q/q2_encoding/extrinsic_q2/bias/sac_value_opt_1save/RestoreV2:29*
T0*9
_class/
-+loc:@critic/q/q2_encoding/extrinsic_q2/bias*
use_locking(*
validate_shape(
�
save/Assign_30Assign(critic/q/q2_encoding/extrinsic_q2/kernelsave/RestoreV2:30*
T0*;
_class1
/-loc:@critic/q/q2_encoding/extrinsic_q2/kernel*
use_locking(*
validate_shape(
�
save/Assign_31Assign6critic/q/q2_encoding/extrinsic_q2/kernel/sac_value_optsave/RestoreV2:31*
T0*;
_class1
/-loc:@critic/q/q2_encoding/extrinsic_q2/kernel*
use_locking(*
validate_shape(
�
save/Assign_32Assign8critic/q/q2_encoding/extrinsic_q2/kernel/sac_value_opt_1save/RestoreV2:32*
T0*;
_class1
/-loc:@critic/q/q2_encoding/extrinsic_q2/kernel*
use_locking(*
validate_shape(
�
save/Assign_33Assign-critic/q/q2_encoding/q2_encoder/hidden_0/biassave/RestoreV2:33*
T0*@
_class6
42loc:@critic/q/q2_encoding/q2_encoder/hidden_0/bias*
use_locking(*
validate_shape(
�
save/Assign_34Assign;critic/q/q2_encoding/q2_encoder/hidden_0/bias/sac_value_optsave/RestoreV2:34*
T0*@
_class6
42loc:@critic/q/q2_encoding/q2_encoder/hidden_0/bias*
use_locking(*
validate_shape(
�
save/Assign_35Assign=critic/q/q2_encoding/q2_encoder/hidden_0/bias/sac_value_opt_1save/RestoreV2:35*
T0*@
_class6
42loc:@critic/q/q2_encoding/q2_encoder/hidden_0/bias*
use_locking(*
validate_shape(
�
save/Assign_36Assign/critic/q/q2_encoding/q2_encoder/hidden_0/kernelsave/RestoreV2:36*
T0*B
_class8
64loc:@critic/q/q2_encoding/q2_encoder/hidden_0/kernel*
use_locking(*
validate_shape(
�
save/Assign_37Assign=critic/q/q2_encoding/q2_encoder/hidden_0/kernel/sac_value_optsave/RestoreV2:37*
T0*B
_class8
64loc:@critic/q/q2_encoding/q2_encoder/hidden_0/kernel*
use_locking(*
validate_shape(
�
save/Assign_38Assign?critic/q/q2_encoding/q2_encoder/hidden_0/kernel/sac_value_opt_1save/RestoreV2:38*
T0*B
_class8
64loc:@critic/q/q2_encoding/q2_encoder/hidden_0/kernel*
use_locking(*
validate_shape(
�
save/Assign_39Assign-critic/q/q2_encoding/q2_encoder/hidden_1/biassave/RestoreV2:39*
T0*@
_class6
42loc:@critic/q/q2_encoding/q2_encoder/hidden_1/bias*
use_locking(*
validate_shape(
�
save/Assign_40Assign;critic/q/q2_encoding/q2_encoder/hidden_1/bias/sac_value_optsave/RestoreV2:40*
T0*@
_class6
42loc:@critic/q/q2_encoding/q2_encoder/hidden_1/bias*
use_locking(*
validate_shape(
�
save/Assign_41Assign=critic/q/q2_encoding/q2_encoder/hidden_1/bias/sac_value_opt_1save/RestoreV2:41*
T0*@
_class6
42loc:@critic/q/q2_encoding/q2_encoder/hidden_1/bias*
use_locking(*
validate_shape(
�
save/Assign_42Assign/critic/q/q2_encoding/q2_encoder/hidden_1/kernelsave/RestoreV2:42*
T0*B
_class8
64loc:@critic/q/q2_encoding/q2_encoder/hidden_1/kernel*
use_locking(*
validate_shape(
�
save/Assign_43Assign=critic/q/q2_encoding/q2_encoder/hidden_1/kernel/sac_value_optsave/RestoreV2:43*
T0*B
_class8
64loc:@critic/q/q2_encoding/q2_encoder/hidden_1/kernel*
use_locking(*
validate_shape(
�
save/Assign_44Assign?critic/q/q2_encoding/q2_encoder/hidden_1/kernel/sac_value_opt_1save/RestoreV2:44*
T0*B
_class8
64loc:@critic/q/q2_encoding/q2_encoder/hidden_1/kernel*
use_locking(*
validate_shape(
�
save/Assign_45Assign"critic/value/encoder/hidden_0/biassave/RestoreV2:45*
T0*5
_class+
)'loc:@critic/value/encoder/hidden_0/bias*
use_locking(*
validate_shape(
�
save/Assign_46Assign0critic/value/encoder/hidden_0/bias/sac_value_optsave/RestoreV2:46*
T0*5
_class+
)'loc:@critic/value/encoder/hidden_0/bias*
use_locking(*
validate_shape(
�
save/Assign_47Assign2critic/value/encoder/hidden_0/bias/sac_value_opt_1save/RestoreV2:47*
T0*5
_class+
)'loc:@critic/value/encoder/hidden_0/bias*
use_locking(*
validate_shape(
�
save/Assign_48Assign$critic/value/encoder/hidden_0/kernelsave/RestoreV2:48*
T0*7
_class-
+)loc:@critic/value/encoder/hidden_0/kernel*
use_locking(*
validate_shape(
�
save/Assign_49Assign2critic/value/encoder/hidden_0/kernel/sac_value_optsave/RestoreV2:49*
T0*7
_class-
+)loc:@critic/value/encoder/hidden_0/kernel*
use_locking(*
validate_shape(
�
save/Assign_50Assign4critic/value/encoder/hidden_0/kernel/sac_value_opt_1save/RestoreV2:50*
T0*7
_class-
+)loc:@critic/value/encoder/hidden_0/kernel*
use_locking(*
validate_shape(
�
save/Assign_51Assign"critic/value/encoder/hidden_1/biassave/RestoreV2:51*
T0*5
_class+
)'loc:@critic/value/encoder/hidden_1/bias*
use_locking(*
validate_shape(
�
save/Assign_52Assign0critic/value/encoder/hidden_1/bias/sac_value_optsave/RestoreV2:52*
T0*5
_class+
)'loc:@critic/value/encoder/hidden_1/bias*
use_locking(*
validate_shape(
�
save/Assign_53Assign2critic/value/encoder/hidden_1/bias/sac_value_opt_1save/RestoreV2:53*
T0*5
_class+
)'loc:@critic/value/encoder/hidden_1/bias*
use_locking(*
validate_shape(
�
save/Assign_54Assign$critic/value/encoder/hidden_1/kernelsave/RestoreV2:54*
T0*7
_class-
+)loc:@critic/value/encoder/hidden_1/kernel*
use_locking(*
validate_shape(
�
save/Assign_55Assign2critic/value/encoder/hidden_1/kernel/sac_value_optsave/RestoreV2:55*
T0*7
_class-
+)loc:@critic/value/encoder/hidden_1/kernel*
use_locking(*
validate_shape(
�
save/Assign_56Assign4critic/value/encoder/hidden_1/kernel/sac_value_opt_1save/RestoreV2:56*
T0*7
_class-
+)loc:@critic/value/encoder/hidden_1/kernel*
use_locking(*
validate_shape(
�
save/Assign_57Assign!critic/value/extrinsic_value/biassave/RestoreV2:57*
T0*4
_class*
(&loc:@critic/value/extrinsic_value/bias*
use_locking(*
validate_shape(
�
save/Assign_58Assign/critic/value/extrinsic_value/bias/sac_value_optsave/RestoreV2:58*
T0*4
_class*
(&loc:@critic/value/extrinsic_value/bias*
use_locking(*
validate_shape(
�
save/Assign_59Assign1critic/value/extrinsic_value/bias/sac_value_opt_1save/RestoreV2:59*
T0*4
_class*
(&loc:@critic/value/extrinsic_value/bias*
use_locking(*
validate_shape(
�
save/Assign_60Assign#critic/value/extrinsic_value/kernelsave/RestoreV2:60*
T0*6
_class,
*(loc:@critic/value/extrinsic_value/kernel*
use_locking(*
validate_shape(
�
save/Assign_61Assign1critic/value/extrinsic_value/kernel/sac_value_optsave/RestoreV2:61*
T0*6
_class,
*(loc:@critic/value/extrinsic_value/kernel*
use_locking(*
validate_shape(
�
save/Assign_62Assign3critic/value/extrinsic_value/kernel/sac_value_opt_1save/RestoreV2:62*
T0*6
_class,
*(loc:@critic/value/extrinsic_value/kernel*
use_locking(*
validate_shape(
�
save/Assign_63Assignglobal_stepsave/RestoreV2:63*
T0*
_class
loc:@global_step*
use_locking(*
validate_shape(
�
save/Assign_64Assignis_continuous_controlsave/RestoreV2:64*
T0*(
_class
loc:@is_continuous_control*
use_locking(*
validate_shape(
�
save/Assign_65Assignlog_ent_coefsave/RestoreV2:65*
T0*
_class
loc:@log_ent_coef*
use_locking(*
validate_shape(
�
save/Assign_66Assignlog_ent_coef/sac_entropy_optsave/RestoreV2:66*
T0*
_class
loc:@log_ent_coef*
use_locking(*
validate_shape(
�
save/Assign_67Assignlog_ent_coef/sac_entropy_opt_1save/RestoreV2:67*
T0*
_class
loc:@log_ent_coef*
use_locking(*
validate_shape(
�
save/Assign_68Assignmemory_sizesave/RestoreV2:68*
T0*
_class
loc:@memory_size*
use_locking(*
validate_shape(
�
save/Assign_69Assignnormalization_stepssave/RestoreV2:69*
T0*&
_class
loc:@normalization_steps*
use_locking(*
validate_shape(
�
save/Assign_70Assignpolicy/log_std/biassave/RestoreV2:70*
T0*&
_class
loc:@policy/log_std/bias*
use_locking(*
validate_shape(
�
save/Assign_71Assign"policy/log_std/bias/sac_policy_optsave/RestoreV2:71*
T0*&
_class
loc:@policy/log_std/bias*
use_locking(*
validate_shape(
�
save/Assign_72Assign$policy/log_std/bias/sac_policy_opt_1save/RestoreV2:72*
T0*&
_class
loc:@policy/log_std/bias*
use_locking(*
validate_shape(
�
save/Assign_73Assignpolicy/log_std/kernelsave/RestoreV2:73*
T0*(
_class
loc:@policy/log_std/kernel*
use_locking(*
validate_shape(
�
save/Assign_74Assign$policy/log_std/kernel/sac_policy_optsave/RestoreV2:74*
T0*(
_class
loc:@policy/log_std/kernel*
use_locking(*
validate_shape(
�
save/Assign_75Assign&policy/log_std/kernel/sac_policy_opt_1save/RestoreV2:75*
T0*(
_class
loc:@policy/log_std/kernel*
use_locking(*
validate_shape(
�
save/Assign_76Assign!policy/main_graph_0/hidden_0/biassave/RestoreV2:76*
T0*4
_class*
(&loc:@policy/main_graph_0/hidden_0/bias*
use_locking(*
validate_shape(
�
save/Assign_77Assign0policy/main_graph_0/hidden_0/bias/sac_policy_optsave/RestoreV2:77*
T0*4
_class*
(&loc:@policy/main_graph_0/hidden_0/bias*
use_locking(*
validate_shape(
�
save/Assign_78Assign2policy/main_graph_0/hidden_0/bias/sac_policy_opt_1save/RestoreV2:78*
T0*4
_class*
(&loc:@policy/main_graph_0/hidden_0/bias*
use_locking(*
validate_shape(
�
save/Assign_79Assign#policy/main_graph_0/hidden_0/kernelsave/RestoreV2:79*
T0*6
_class,
*(loc:@policy/main_graph_0/hidden_0/kernel*
use_locking(*
validate_shape(
�
save/Assign_80Assign2policy/main_graph_0/hidden_0/kernel/sac_policy_optsave/RestoreV2:80*
T0*6
_class,
*(loc:@policy/main_graph_0/hidden_0/kernel*
use_locking(*
validate_shape(
�
save/Assign_81Assign4policy/main_graph_0/hidden_0/kernel/sac_policy_opt_1save/RestoreV2:81*
T0*6
_class,
*(loc:@policy/main_graph_0/hidden_0/kernel*
use_locking(*
validate_shape(
�
save/Assign_82Assign!policy/main_graph_0/hidden_1/biassave/RestoreV2:82*
T0*4
_class*
(&loc:@policy/main_graph_0/hidden_1/bias*
use_locking(*
validate_shape(
�
save/Assign_83Assign0policy/main_graph_0/hidden_1/bias/sac_policy_optsave/RestoreV2:83*
T0*4
_class*
(&loc:@policy/main_graph_0/hidden_1/bias*
use_locking(*
validate_shape(
�
save/Assign_84Assign2policy/main_graph_0/hidden_1/bias/sac_policy_opt_1save/RestoreV2:84*
T0*4
_class*
(&loc:@policy/main_graph_0/hidden_1/bias*
use_locking(*
validate_shape(
�
save/Assign_85Assign#policy/main_graph_0/hidden_1/kernelsave/RestoreV2:85*
T0*6
_class,
*(loc:@policy/main_graph_0/hidden_1/kernel*
use_locking(*
validate_shape(
�
save/Assign_86Assign2policy/main_graph_0/hidden_1/kernel/sac_policy_optsave/RestoreV2:86*
T0*6
_class,
*(loc:@policy/main_graph_0/hidden_1/kernel*
use_locking(*
validate_shape(
�
save/Assign_87Assign4policy/main_graph_0/hidden_1/kernel/sac_policy_opt_1save/RestoreV2:87*
T0*6
_class,
*(loc:@policy/main_graph_0/hidden_1/kernel*
use_locking(*
validate_shape(
�
save/Assign_88Assignpolicy/mu/biassave/RestoreV2:88*
T0*!
_class
loc:@policy/mu/bias*
use_locking(*
validate_shape(
�
save/Assign_89Assignpolicy/mu/bias/sac_policy_optsave/RestoreV2:89*
T0*!
_class
loc:@policy/mu/bias*
use_locking(*
validate_shape(
�
save/Assign_90Assignpolicy/mu/bias/sac_policy_opt_1save/RestoreV2:90*
T0*!
_class
loc:@policy/mu/bias*
use_locking(*
validate_shape(
�
save/Assign_91Assignpolicy/mu/kernelsave/RestoreV2:91*
T0*#
_class
loc:@policy/mu/kernel*
use_locking(*
validate_shape(
�
save/Assign_92Assignpolicy/mu/kernel/sac_policy_optsave/RestoreV2:92*
T0*#
_class
loc:@policy/mu/kernel*
use_locking(*
validate_shape(
�
save/Assign_93Assign!policy/mu/kernel/sac_policy_opt_1save/RestoreV2:93*
T0*#
_class
loc:@policy/mu/kernel*
use_locking(*
validate_shape(
�
save/Assign_94Assignrunning_meansave/RestoreV2:94*
T0*
_class
loc:@running_mean*
use_locking(*
validate_shape(
�
save/Assign_95Assignrunning_variancesave/RestoreV2:95*
T0*#
_class
loc:@running_variance*
use_locking(*
validate_shape(
�
save/Assign_96Assign1target_network/critic/value/encoder/hidden_0/biassave/RestoreV2:96*
T0*D
_class:
86loc:@target_network/critic/value/encoder/hidden_0/bias*
use_locking(*
validate_shape(
�
save/Assign_97Assign3target_network/critic/value/encoder/hidden_0/kernelsave/RestoreV2:97*
T0*F
_class<
:8loc:@target_network/critic/value/encoder/hidden_0/kernel*
use_locking(*
validate_shape(
�
save/Assign_98Assign1target_network/critic/value/encoder/hidden_1/biassave/RestoreV2:98*
T0*D
_class:
86loc:@target_network/critic/value/encoder/hidden_1/bias*
use_locking(*
validate_shape(
�
save/Assign_99Assign3target_network/critic/value/encoder/hidden_1/kernelsave/RestoreV2:99*
T0*F
_class<
:8loc:@target_network/critic/value/encoder/hidden_1/kernel*
use_locking(*
validate_shape(
�
save/Assign_100Assign0target_network/critic/value/extrinsic_value/biassave/RestoreV2:100*
T0*C
_class9
75loc:@target_network/critic/value/extrinsic_value/bias*
use_locking(*
validate_shape(
�
save/Assign_101Assign2target_network/critic/value/extrinsic_value/kernelsave/RestoreV2:101*
T0*E
_class;
97loc:@target_network/critic/value/extrinsic_value/kernel*
use_locking(*
validate_shape(
�
save/Assign_102Assign"target_network/normalization_stepssave/RestoreV2:102*
T0*5
_class+
)'loc:@target_network/normalization_steps*
use_locking(*
validate_shape(
�
save/Assign_103Assigntarget_network/running_meansave/RestoreV2:103*
T0*.
_class$
" loc:@target_network/running_mean*
use_locking(*
validate_shape(
�
save/Assign_104Assigntarget_network/running_variancesave/RestoreV2:104*
T0*2
_class(
&$loc:@target_network/running_variance*
use_locking(*
validate_shape(
�
save/Assign_105Assigntrainer_major_versionsave/RestoreV2:105*
T0*(
_class
loc:@trainer_major_version*
use_locking(*
validate_shape(
�
save/Assign_106Assigntrainer_minor_versionsave/RestoreV2:106*
T0*(
_class
loc:@trainer_minor_version*
use_locking(*
validate_shape(
�
save/Assign_107Assigntrainer_patch_versionsave/RestoreV2:107*
T0*(
_class
loc:@trainer_patch_version*
use_locking(*
validate_shape(
�
save/Assign_108Assignversion_numbersave/RestoreV2:108*
T0*!
_class
loc:@version_number*
use_locking(*
validate_shape(
�
save/restore_allNoOp^save/Assign^save/Assign_1^save/Assign_10^save/Assign_100^save/Assign_101^save/Assign_102^save/Assign_103^save/Assign_104^save/Assign_105^save/Assign_106^save/Assign_107^save/Assign_108^save/Assign_11^save/Assign_12^save/Assign_13^save/Assign_14^save/Assign_15^save/Assign_16^save/Assign_17^save/Assign_18^save/Assign_19^save/Assign_2^save/Assign_20^save/Assign_21^save/Assign_22^save/Assign_23^save/Assign_24^save/Assign_25^save/Assign_26^save/Assign_27^save/Assign_28^save/Assign_29^save/Assign_3^save/Assign_30^save/Assign_31^save/Assign_32^save/Assign_33^save/Assign_34^save/Assign_35^save/Assign_36^save/Assign_37^save/Assign_38^save/Assign_39^save/Assign_4^save/Assign_40^save/Assign_41^save/Assign_42^save/Assign_43^save/Assign_44^save/Assign_45^save/Assign_46^save/Assign_47^save/Assign_48^save/Assign_49^save/Assign_5^save/Assign_50^save/Assign_51^save/Assign_52^save/Assign_53^save/Assign_54^save/Assign_55^save/Assign_56^save/Assign_57^save/Assign_58^save/Assign_59^save/Assign_6^save/Assign_60^save/Assign_61^save/Assign_62^save/Assign_63^save/Assign_64^save/Assign_65^save/Assign_66^save/Assign_67^save/Assign_68^save/Assign_69^save/Assign_7^save/Assign_70^save/Assign_71^save/Assign_72^save/Assign_73^save/Assign_74^save/Assign_75^save/Assign_76^save/Assign_77^save/Assign_78^save/Assign_79^save/Assign_8^save/Assign_80^save/Assign_81^save/Assign_82^save/Assign_83^save/Assign_84^save/Assign_85^save/Assign_86^save/Assign_87^save/Assign_88^save/Assign_89^save/Assign_9^save/Assign_90^save/Assign_91^save/Assign_92^save/Assign_93^save/Assign_94^save/Assign_95^save/Assign_96^save/Assign_97^save/Assign_98^save/Assign_99
�*
init_1NoOp^Variable/Assign^Variable_1/Assign^action_output_shape/Assign^beta1_power/Assign^beta1_power_1/Assign^beta1_power_2/Assign^beta2_power/Assign^beta2_power_1/Assign^beta2_power_2/Assign.^critic/q/q1_encoding/extrinsic_q1/bias/Assign<^critic/q/q1_encoding/extrinsic_q1/bias/sac_value_opt/Assign>^critic/q/q1_encoding/extrinsic_q1/bias/sac_value_opt_1/Assign0^critic/q/q1_encoding/extrinsic_q1/kernel/Assign>^critic/q/q1_encoding/extrinsic_q1/kernel/sac_value_opt/Assign@^critic/q/q1_encoding/extrinsic_q1/kernel/sac_value_opt_1/Assign5^critic/q/q1_encoding/q1_encoder/hidden_0/bias/AssignC^critic/q/q1_encoding/q1_encoder/hidden_0/bias/sac_value_opt/AssignE^critic/q/q1_encoding/q1_encoder/hidden_0/bias/sac_value_opt_1/Assign7^critic/q/q1_encoding/q1_encoder/hidden_0/kernel/AssignE^critic/q/q1_encoding/q1_encoder/hidden_0/kernel/sac_value_opt/AssignG^critic/q/q1_encoding/q1_encoder/hidden_0/kernel/sac_value_opt_1/Assign5^critic/q/q1_encoding/q1_encoder/hidden_1/bias/AssignC^critic/q/q1_encoding/q1_encoder/hidden_1/bias/sac_value_opt/AssignE^critic/q/q1_encoding/q1_encoder/hidden_1/bias/sac_value_opt_1/Assign7^critic/q/q1_encoding/q1_encoder/hidden_1/kernel/AssignE^critic/q/q1_encoding/q1_encoder/hidden_1/kernel/sac_value_opt/AssignG^critic/q/q1_encoding/q1_encoder/hidden_1/kernel/sac_value_opt_1/Assign.^critic/q/q2_encoding/extrinsic_q2/bias/Assign<^critic/q/q2_encoding/extrinsic_q2/bias/sac_value_opt/Assign>^critic/q/q2_encoding/extrinsic_q2/bias/sac_value_opt_1/Assign0^critic/q/q2_encoding/extrinsic_q2/kernel/Assign>^critic/q/q2_encoding/extrinsic_q2/kernel/sac_value_opt/Assign@^critic/q/q2_encoding/extrinsic_q2/kernel/sac_value_opt_1/Assign5^critic/q/q2_encoding/q2_encoder/hidden_0/bias/AssignC^critic/q/q2_encoding/q2_encoder/hidden_0/bias/sac_value_opt/AssignE^critic/q/q2_encoding/q2_encoder/hidden_0/bias/sac_value_opt_1/Assign7^critic/q/q2_encoding/q2_encoder/hidden_0/kernel/AssignE^critic/q/q2_encoding/q2_encoder/hidden_0/kernel/sac_value_opt/AssignG^critic/q/q2_encoding/q2_encoder/hidden_0/kernel/sac_value_opt_1/Assign5^critic/q/q2_encoding/q2_encoder/hidden_1/bias/AssignC^critic/q/q2_encoding/q2_encoder/hidden_1/bias/sac_value_opt/AssignE^critic/q/q2_encoding/q2_encoder/hidden_1/bias/sac_value_opt_1/Assign7^critic/q/q2_encoding/q2_encoder/hidden_1/kernel/AssignE^critic/q/q2_encoding/q2_encoder/hidden_1/kernel/sac_value_opt/AssignG^critic/q/q2_encoding/q2_encoder/hidden_1/kernel/sac_value_opt_1/Assign*^critic/value/encoder/hidden_0/bias/Assign8^critic/value/encoder/hidden_0/bias/sac_value_opt/Assign:^critic/value/encoder/hidden_0/bias/sac_value_opt_1/Assign,^critic/value/encoder/hidden_0/kernel/Assign:^critic/value/encoder/hidden_0/kernel/sac_value_opt/Assign<^critic/value/encoder/hidden_0/kernel/sac_value_opt_1/Assign*^critic/value/encoder/hidden_1/bias/Assign8^critic/value/encoder/hidden_1/bias/sac_value_opt/Assign:^critic/value/encoder/hidden_1/bias/sac_value_opt_1/Assign,^critic/value/encoder/hidden_1/kernel/Assign:^critic/value/encoder/hidden_1/kernel/sac_value_opt/Assign<^critic/value/encoder/hidden_1/kernel/sac_value_opt_1/Assign)^critic/value/extrinsic_value/bias/Assign7^critic/value/extrinsic_value/bias/sac_value_opt/Assign9^critic/value/extrinsic_value/bias/sac_value_opt_1/Assign+^critic/value/extrinsic_value/kernel/Assign9^critic/value/extrinsic_value/kernel/sac_value_opt/Assign;^critic/value/extrinsic_value/kernel/sac_value_opt_1/Assign^global_step/Assign^is_continuous_control/Assign^log_ent_coef/Assign$^log_ent_coef/sac_entropy_opt/Assign&^log_ent_coef/sac_entropy_opt_1/Assign^memory_size/Assign^normalization_steps/Assign^policy/log_std/bias/Assign*^policy/log_std/bias/sac_policy_opt/Assign,^policy/log_std/bias/sac_policy_opt_1/Assign^policy/log_std/kernel/Assign,^policy/log_std/kernel/sac_policy_opt/Assign.^policy/log_std/kernel/sac_policy_opt_1/Assign)^policy/main_graph_0/hidden_0/bias/Assign8^policy/main_graph_0/hidden_0/bias/sac_policy_opt/Assign:^policy/main_graph_0/hidden_0/bias/sac_policy_opt_1/Assign+^policy/main_graph_0/hidden_0/kernel/Assign:^policy/main_graph_0/hidden_0/kernel/sac_policy_opt/Assign<^policy/main_graph_0/hidden_0/kernel/sac_policy_opt_1/Assign)^policy/main_graph_0/hidden_1/bias/Assign8^policy/main_graph_0/hidden_1/bias/sac_policy_opt/Assign:^policy/main_graph_0/hidden_1/bias/sac_policy_opt_1/Assign+^policy/main_graph_0/hidden_1/kernel/Assign:^policy/main_graph_0/hidden_1/kernel/sac_policy_opt/Assign<^policy/main_graph_0/hidden_1/kernel/sac_policy_opt_1/Assign^policy/mu/bias/Assign%^policy/mu/bias/sac_policy_opt/Assign'^policy/mu/bias/sac_policy_opt_1/Assign^policy/mu/kernel/Assign'^policy/mu/kernel/sac_policy_opt/Assign)^policy/mu/kernel/sac_policy_opt_1/Assign^running_mean/Assign^running_variance/Assign9^target_network/critic/value/encoder/hidden_0/bias/Assign;^target_network/critic/value/encoder/hidden_0/kernel/Assign9^target_network/critic/value/encoder/hidden_1/bias/Assign;^target_network/critic/value/encoder/hidden_1/kernel/Assign8^target_network/critic/value/extrinsic_value/bias/Assign:^target_network/critic/value/extrinsic_value/kernel/Assign*^target_network/normalization_steps/Assign#^target_network/running_mean/Assign'^target_network/running_variance/Assign^trainer_major_version/Assign^trainer_minor_version/Assign^trainer_patch_version/Assign^version_number/Assign"�