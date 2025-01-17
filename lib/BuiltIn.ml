open Identifier
open Cst
open Names

(* Austral.Pervasive *)

let pervasive_module_name = make_mod_name "Austral.Pervasive"

let root_cap_type_name = make_ident "Root_Capability"

let pervasive_imports =
  ConcreteImportList (
      pervasive_module_name,
      [
        ConcreteImport (make_ident "Option", None);
        ConcreteImport (make_ident "Some", None);
        ConcreteImport (make_ident "None", None);
        ConcreteImport (make_ident "Either", None);
        ConcreteImport (make_ident "Left", None);
        ConcreteImport (make_ident "Right", None);
        ConcreteImport (make_ident "Deref", None);
        ConcreteImport (make_ident "Deref_Write", None);
        ConcreteImport (make_ident "Fixed_Array_Size", None);
        ConcreteImport (make_ident "Abort", None);
        ConcreteImport (make_ident "Root_Capability", None);
        ConcreteImport (make_ident "Maximum_Natural_8", None);
        ConcreteImport (make_ident "Maximum_Natural_16", None);
        ConcreteImport (make_ident "Maximum_Natural_32", None);
        ConcreteImport (make_ident "Maximum_Natural_64", None);
        ConcreteImport (make_ident "Minimum_Integer_8", None);
        ConcreteImport (make_ident "Minimum_Integer_16", None);
        ConcreteImport (make_ident "Minimum_Integer_32", None);
        ConcreteImport (make_ident "Minimum_Integer_64", None);
        ConcreteImport (make_ident "Maximum_Integer_8", None);
        ConcreteImport (make_ident "Maximum_Integer_16", None);
        ConcreteImport (make_ident "Maximum_Integer_32", None);
        ConcreteImport (make_ident "Maximum_Integer_64", None);
        ConcreteImport (make_ident "Trapping_Arithmetic", None);
        ConcreteImport (make_ident "Trapping_Add", None);
        ConcreteImport (make_ident "Trapping_Subtract", None);
        ConcreteImport (make_ident "Trapping_Multiply", None);
        ConcreteImport (make_ident "Trapping_Divide", None);
        ConcreteImport (make_ident "Modular_Arithmetic", None);
        ConcreteImport (make_ident "Modular_Add", None);
        ConcreteImport (make_ident "Modular_Subtract", None);
        ConcreteImport (make_ident "Modular_Multiply", None);
        ConcreteImport (make_ident "Modular_Divide", None);
        ConcreteImport (make_ident "Printable", None);
        ConcreteImport (make_ident "Print", None);
        ConcreteImport (make_ident "PrintLn", None);
      ]
    )

(* Austral.Memory *)

let memory_module_name = make_mod_name "Austral.Memory"

let is_address_type (name: qident): bool =
  let s = source_module_name name
  and o = original_name name
  in
  (equal_module_name s memory_module_name)
  && (equal_identifier o (make_ident address_name))

let is_pointer_type (name: qident): bool =
  let s = source_module_name name
  and o = original_name name
  in
  (equal_module_name s memory_module_name)
  && (equal_identifier o (make_ident pointer_name))
