*----------------------------------------------------------------------*
*       CLASS lcl_Test DEFINITION
*----------------------------------------------------------------------*
*
*----------------------------------------------------------------------*
CLASS ltcl_test DEFINITION FOR TESTING
  DURATION SHORT
  RISK LEVEL HARMLESS
  FINAL.

  PRIVATE SECTION.
* ================

    DATA: mt_code   TYPE string_table,
          ms_result TYPE scirest_ad,
          mo_check  TYPE REF TO zcl_aoc_check_20.

    METHODS: setup,
             test001_01 FOR TESTING,
             test001_02 FOR TESTING,
             test001_03 FOR TESTING,
             test001_04 FOR TESTING,
             test001_05 FOR TESTING,
             test001_06 FOR TESTING,
             test001_07 FOR TESTING,
             test001_08 FOR TESTING,
             test001_09 FOR TESTING,
             test001_10 FOR TESTING,
             test001_11 FOR TESTING,
             test001_12 FOR TESTING,
             test001_13 FOR TESTING,
             test001_14 FOR TESTING,
             test001_15 FOR TESTING.

ENDCLASS.       "lcl_Test

*----------------------------------------------------------------------*
*       CLASS lcl_Test IMPLEMENTATION
*----------------------------------------------------------------------*
*
*----------------------------------------------------------------------*
CLASS ltcl_test IMPLEMENTATION.
* ==============================

  DEFINE _code.
    append &1 to mt_code.
  END-OF-DEFINITION.

  METHOD setup.
    CREATE OBJECT mo_check.
  ENDMETHOD.                    "setup

  METHOD test001_01.
* ===========

    _code '  READ TABLE lt_table '.
    _code 'INDEX 1 INTO ls_wa.'.

    ms_result = zcl_aoc_unit_test=>check( it_code  = mt_code
                                          io_check = mo_check ).

    cl_abap_unit_assert=>assert_equals( exp = '001'
                                        act = ms_result-code ).

  ENDMETHOD.                    "test1

  METHOD test001_02.
* ===========

    _code '  READ TABLE lt_table '.
    _code '  INDEX 1 INTO ls_wa.'.

    ms_result = zcl_aoc_unit_test=>check( it_code  = mt_code
                                          io_check = mo_check ).

    cl_abap_unit_assert=>assert_equals( exp = '001'
                                        act = ms_result-code ).

  ENDMETHOD.                    "test001_02

  METHOD test001_03.
* ===========

    _code '  READ TABLE lt_table '.
    _code '    INDEX 1 INTO ls_wa.'.

    ms_result = zcl_aoc_unit_test=>check( it_code  = mt_code
                                          io_check = mo_check ).

    cl_abap_unit_assert=>assert_initial( ms_result-code ).

  ENDMETHOD.                    "test001_03

  METHOD test001_04.
* ===========

    _code 'IF lv_foo = lv_bar'.
    _code '    AND lv_moo = lv_boo.'.
    _code 'ENDIF.'.

    ms_result = zcl_aoc_unit_test=>check( it_code  = mt_code
                                          io_check = mo_check ).

    cl_abap_unit_assert=>assert_initial( ms_result-code ).

  ENDMETHOD.                    "test001_04

  METHOD test001_05.
* ===========

    _code 'IF lv_foo = lv_bar'.
    _code '  AND lv_moo = lv_boo.'.
    _code '  WRITE: ''huh''.'.
    _code 'ENDIF.'.

    ms_result = zcl_aoc_unit_test=>check( it_code  = mt_code
                                          io_check = mo_check ).

    cl_abap_unit_assert=>assert_equals( exp = '001'
                                        act = ms_result-code ).

  ENDMETHOD.                    "test001_05

  METHOD test001_06.
* ===========

    _code 'IF lv_foo = lv_bar'.
    _code '    AND lv_moo = lv_boo.'.
    _code 'ELSEIF lv_foo = lv_bar'.
    _code '    AND lv_moo = lv_boo.'.
    _code 'ENDIF.'.

    ms_result = zcl_aoc_unit_test=>check( it_code  = mt_code
                                          io_check = mo_check ).

    cl_abap_unit_assert=>assert_initial( ms_result-code ).

  ENDMETHOD.                    "test001_04

  METHOD test001_07.
* ===========

    _code 'IF lv_foo = lv_bar'.
    _code '    AND lv_moo = lv_boo.'.
    _code '  WRITE: ''huh''.'.
    _code 'ELSEIF lv_foo = lv_bar'.
    _code '  AND lv_moo = lv_boo.'.
    _code '  WRITE: ''huh''.'.
    _code 'ENDIF.'.

    ms_result = zcl_aoc_unit_test=>check( it_code  = mt_code
                                          io_check = mo_check ).

    cl_abap_unit_assert=>assert_equals( exp = '001'
                                        act = ms_result-code ).

  ENDMETHOD.

  METHOD test001_08.
* ===========

    _code 'TRY.'.
    _code '    lv_foo = lv_moo.'.
    _code '  CATCH zcx_error.'.
    _code 'ENDTRY.'.

    ms_result = zcl_aoc_unit_test=>check( it_code  = mt_code
                                          io_check = mo_check ).

    cl_abap_unit_assert=>assert_initial( ms_result-code ).

  ENDMETHOD.

  METHOD test001_09.
* ===========

    _code 'TRY.'.
    _code '    lv_foo = lv_moo.'.
    _code '  CATCH'.
    _code '  zcx_error.'.
    _code 'ENDTRY.'.

    ms_result = zcl_aoc_unit_test=>check( it_code  = mt_code
                                          io_check = mo_check ).

    cl_abap_unit_assert=>assert_equals( exp = '001'
                                        act = ms_result-code ).

  ENDMETHOD.

  METHOD test001_10.
* ===========

    _code 'TRY.'.
    _code '  CATCH zcx_error.'.
    _code '    lv_foo = lv_moo.'.
    _code 'ENDTRY.'.

    ms_result = zcl_aoc_unit_test=>check( it_code  = mt_code
                                          io_check = mo_check ).

    cl_abap_unit_assert=>assert_initial( ms_result-code ).

  ENDMETHOD.

  METHOD test001_11.
* ===========

    _code 'DO 2 TIMES.'.
    _code '  lv_moo = lv_foo.'.
    _code 'ENDDO.'.

    ms_result = zcl_aoc_unit_test=>check( it_code  = mt_code
                                          io_check = mo_check ).

    cl_abap_unit_assert=>assert_initial( ms_result-code ).

  ENDMETHOD.


  METHOD test001_12.
* ===========

    _code 'DO'.
    _code '  2 TIMES.'.
    _code '  lv_moo = lv_foo.'.
    _code 'ENDDO.'.

    ms_result = zcl_aoc_unit_test=>check( it_code  = mt_code
                                          io_check = mo_check ).

    cl_abap_unit_assert=>assert_equals( exp = '001'
                                        act = ms_result-code ).

  ENDMETHOD.

  METHOD test001_13.
* ===========

    _code 'WHILE lv_bar = abap_true.'.
    _code '  lv_moo = lv_foo.'.
    _code 'ENDWHILE.'.

    ms_result = zcl_aoc_unit_test=>check( it_code  = mt_code
                                          io_check = mo_check ).

    cl_abap_unit_assert=>assert_initial( ms_result-code ).

  ENDMETHOD.


  METHOD test001_14.
* ===========

    _code 'WHILE'.
    _code 'lv_bar = abap_true.'.
    _code '  lv_moo = lv_foo.'.
    _code 'ENDWHILE.'.

    ms_result = zcl_aoc_unit_test=>check( it_code  = mt_code
                                          io_check = mo_check ).

    cl_abap_unit_assert=>assert_equals( exp = '001'
                                        act = ms_result-code ).

  ENDMETHOD.

  METHOD test001_15.
* ===========

    _code 'WHILE'.
    _code '    lv_bar = abap_true.'.
    _code '  lv_moo = lv_foo.'.
    _code 'ENDWHILE.'.

    ms_result = zcl_aoc_unit_test=>check( it_code  = mt_code
                                          io_check = mo_check ).

    cl_abap_unit_assert=>assert_initial( ms_result-code ).

  ENDMETHOD.

ENDCLASS.       "lcl_Te