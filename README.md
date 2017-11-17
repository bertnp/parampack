ParamPack
=========
MATLAB library for defining and iterating over parameter sweeps.

Function summary
================

collapse_ptuples(p_list)
-----------------------
given a p_list, return the field names, replacing any ptuples with their first
numerical sub-field

expand_tuples(p_list, fields)
-----------------------------
given a p_list and a list of fields, resolve any
elements in fields which are sub-fields back to their parent tuple

get_field_ind(p_list, field, fields, s_list):
---------------------------------------------
find the index in fields corresponding to field (field may be a sub-field, or
contain sub-fields in source_list)

isptuple(p, field)
------------------
boolean which is true if field contains the text "ptuple" and p.(field) is a
struct

out2array(out, p_list, val_field, fields)
-----------------------------------------
organize results of a parameter sweep into a matrix with specified indexing

param_linearize(p_list, p_it)
-----------------------------
return the p_it'th parameter configuration from p_list

param_list(p_list, field)
-------------------------
return the array of possible values for field

param_method_pack(p_list, p_global)
-----------------
to each field in p_list, merge the fields from p_global

param_slice(p_list, varargin)
-----------------------------
convert (field, ind) pairs to a linear index

param_translate(p_in, i_in, p_out)
----------------------------------
translate linear indices between parameter lists

struct_numel(p, fields)
-----------------------
get number of elements in each struct field (a custom subset/ordering of fields
may be specified). tuples are accounted for.

struct_select(s, f)
-------------------
extract values out of array of structs
