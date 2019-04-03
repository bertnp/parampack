ParamPack
=========
MATLAB library for defining and iterating over parameter sweeps.

ParamPack Example
=================
It is often useful to study algorithm behavior by measuring performance over a grid of parameter values. This can lead to code that looks as follows:
```MATLAB
param1_list = 1:10;
param2_list = 100:200;
for p1_it = 1:numel(param1_list)
    for p2_it = 1:numel(param2_list)
        output(p1_it, p2_it) = my_algo(param1_list(p1_it), param2_list(p2_it))
    end
end
```
But this approach is fragile and inflexible code. In particular, it potentially requires many nested loops, and modification of a single parameter requires changes to multiple pieces of code.

ParamPack allows you to easily define parameter and iterate over parameter sweeps. The above example becomes:
```MATLAB
p_list.p1 = 1:10;
p_list.p2 = 100:200;
n_params = param_linearize(p_list, 0);
for p_it = 1:n_total
    p = param_linearize(p_list, p_it)
    output(p_it) = my_algo(p);
end
```
No more nested loops! So if we want to add a third parameter, just add a single line:
```MATLAB
p_list.p3 = {'works', 'with', 'cells', 'too!'};
```


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
