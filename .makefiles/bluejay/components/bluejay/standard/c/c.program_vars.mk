#-------------------------------------------------------------------------------
# File: c.program_vars.mk
#
# Description:
#
#-------------------------------------------------------------------------------

#-------------------------------------------------------------------------------
# $(prg)_C_EXE_PKG
#
# c.set_exe_pkg,$(prg),$(exe_pkg)
# c.get_exe_pkg,$(prg)
# c.get_all_exe_pkg
#-------------------------------------------------------------------------------
$(call function,declare_pkg_var,c,exe_pkg,C_EXE_PKG,C_PROGRAMS)

#-------------------------------------------------------------------------------
# $(prg)_C_EXE
#
# c.set_exe,$(prg),$(exe)
# c.get_exe,$(prg)
# c.get_all_exe
#-------------------------------------------------------------------------------
$(call function,declare_pkg_var,c,exe,C_EXE,C_PROGRAMS)

#-------------------------------------------------------------------------------
# $(prg)_C_EXE_DIR
#
# c.set_exe_dir,$(prg),$(exe_dir)
# c.get_exe_dir,$(prg)
# c.get_all_exe_dir
#-------------------------------------------------------------------------------
$(call function,declare_pkg_var,c,exe_dir,C_EXE_DIR,C_PROGRAMS)

#-------------------------------------------------------------------------------
# $(prg)_C_EXE_MAIN
#
# c.set_exe_main,$(prg),$(exe_main)
# c.get_exe_main,$(prg)
# c.get_all_exe_main
#-------------------------------------------------------------------------------
$(call function,declare_pkg_var,c,exe_main,C_EXE_MAIN,C_PROGRAMS)

#-------------------------------------------------------------------------------
# $(prg)_C_EXE_MAIN_OBJ
#
# c.set_exe_main_obj,$(prg),$(exe_main_obj)
# c.get_exe_main_obj,$(prg)
# c.get_all_exe_main_obj
#-------------------------------------------------------------------------------
$(call function,declare_pkg_var,c,exe_main_obj,C_EXE_MAIN_OBJ,C_PROGRAMS)

#-------------------------------------------------------------------------------
# $(prg)_C_EXE_DEPS
#
# c.add_exe_deps,$(prg),$(exe_deps)
# c.get_exe_deps,$(prg)
# c.get_all_exe_deps
# c.has_exe_deps,$(prg),$(exe_deps_to_look_for)
#-------------------------------------------------------------------------------
$(call function,declare_unsorted_pkg_list,c,exe_deps,C_EXE_DEPS,C_PROGRAMS)
