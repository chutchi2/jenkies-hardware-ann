#-------------------------------------------------------------------------------
# File: cpp.program_vars.mk
#
# Description:
#
#-------------------------------------------------------------------------------

#-------------------------------------------------------------------------------
# $(prg)_CPP_EXE_PKG
#
# cpp.set_exe_pkg,$(prg),$(exe_pkg)
# cpp.get_exe_pkg,$(prg)
# cpp.get_all_exe_pkg
#-------------------------------------------------------------------------------
$(call function,declare_pkg_var,cpp,exe_pkg,CPP_EXE_PKG,CPP_PROGRAMS)

#-------------------------------------------------------------------------------
# $(prg)_CPP_EXE
#
# cpp.set_exe,$(prg),$(exe)
# cpp.get_exe,$(prg)
# cpp.get_all_exe
#-------------------------------------------------------------------------------
$(call function,declare_pkg_var,cpp,exe,CPP_EXE,CPP_PROGRAMS)

#-------------------------------------------------------------------------------
# $(prg)_CPP_EXE_DIR
#
# cpp.set_exe_dir,$(prg),$(exe_dir)
# cpp.get_exe_dir,$(prg)
# cpp.get_all_exe_dir
#-------------------------------------------------------------------------------
$(call function,declare_pkg_var,cpp,exe_dir,CPP_EXE_DIR,CPP_PROGRAMS)

#-------------------------------------------------------------------------------
# $(prg)_CPP_EXE_MAIN
#
# cpp.set_exe_main,$(prg),$(exe_main)
# cpp.get_exe_main,$(prg)
# cpp.get_all_exe_main
#-------------------------------------------------------------------------------
$(call function,declare_pkg_var,cpp,exe_main,CPP_EXE_MAIN,CPP_PROGRAMS)

#-------------------------------------------------------------------------------
# $(prg)_CPP_EXE_MAIN_OBJ
#
# cpp.set_exe_main_obj,$(prg),$(exe_main_obj)
# cpp.get_exe_main_obj,$(prg)
# cpp.get_all_exe_main_obj
#-------------------------------------------------------------------------------
$(call function,declare_pkg_var,cpp,exe_main_obj,CPP_EXE_MAIN_OBJ,CPP_PROGRAMS)

#-------------------------------------------------------------------------------
# $(prg)_CPP_EXE_DEPS
#
# cpp.add_exe_deps,$(prg),$(exe_deps)
# cpp.get_exe_deps,$(prg)
# cpp.get_all_exe_deps
# cpp.has_exe_deps,$(prg),$(exe_deps_to_look_for)
#-------------------------------------------------------------------------------
$(call function,declare_unsorted_pkg_list,cpp,exe_deps,CPP_EXE_DEPS,CPP_PROGRAMS)
