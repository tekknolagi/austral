(*
    Copyright 2018 Fernando Borretti <fernando@borretti.me>

    This file is part of Austral.

    Austral is free software: you can redistribute it and/or modify
    it under the terms of the GNU General Public License as published by
    the Free Software Foundation, either version 3 of the License, or
    (at your option) any later version.

    Austral is distributed in the hope that it will be useful,
    but WITHOUT ANY WARRANTY; without even the implied warranty of
    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
    GNU General Public License for more details.

    You should have received a copy of the GNU General Public License
    along with Austral.  If not, see <http://www.gnu.org/licenses/>.
*)

signature MODULE = sig
    include SYMBOL

    type nicknames = (module_name, module_name) Map.map
    datatype imports = Imports of (symbol_name, module_name) Map.map
    datatype exports = Exports of symbol_name Set.set
    datatype module = Module of module_name * nicknames * imports * exports * string option
    type menv

    val moduleName : module -> module_name
    val moduleExports : module -> symbol_name Set.set
    val moduleImports : module -> (symbol_name, module_name) Map.map

    val emptyEnv : menv
    val addModule : menv -> module -> menv
    val envGet : menv -> module_name -> module option

    (* Given the current module, and the name of a module (which is potentially
       a module-local nickname), this function returns the true name if it's a
       nickname, or returns the module name unchanged if it's not. *)
    val resolveNickname : module -> module_name -> module_name

    (* Given the module environment, the current module, and the name of a
       symbol, if the symbol was imported from another module, return the name
       of that module, otherwise, return the name of the first argument. This
       works transitively: if A exports a, and B imports a from A and exports a,
       and C imports a from B, then we get A as the result. *)
    val sourceModule : menv -> module -> symbol_name -> module_name

    (* Test whether a module exports a given symbol *)
    val doesModuleExport : module -> symbol_name -> bool

    (* The default module environment: the Austral module, and related
       implementation modules *)
    val defaultMenv : menv

    (* Defmodule *)

    datatype defmodule_clause = NicknamesClause of (Symbol.symbol_name * Symbol.module_name) list
                              | UseClause of Symbol.module_name list
                              | ImportFromClause of Symbol.module_name * (Symbol.symbol_name list)
                              | ExportClause of Symbol.symbol_name list
                              | DocstringClause of string

    (* Given a module environment, a module name, and a list of defmodule
       clauses, compile these into a proper module, signalling any errors *)
    val resolveModule : menv -> module_name -> defmodule_clause list -> module
end