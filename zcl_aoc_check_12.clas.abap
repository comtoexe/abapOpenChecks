class ZCL_AOC_CHECK_12 definition
  public
  inheriting from ZCL_AOC_SUPER
  create public .

public section.
*"* public components of class ZCL_AOC_CHECK_12
*"* do not include other source files here!!!

  methods CONSTRUCTOR .

  methods CHECK
    redefinition .
  methods GET_MESSAGE_TEXT
    redefinition .
protected section.
*"* protected components of class ZCL_AOC_CHECK_12
*"* do not include other source files here!!!
private section.
*"* private components of class ZCL_AOC_CHECK_12
*"* do not include other source files here!!!

  constants C_MY_NAME type SEOCLSNAME value 'ZCL_AOC_CHECK_12'. "#EC NOTEXT
ENDCLASS.



CLASS ZCL_AOC_CHECK_12 IMPLEMENTATION.


METHOD check.

* abapOpenChecks
* https://github.com/larshp/abapOpenChecks
* MIT License

  DATA: lv_include   TYPE program,
        lv_trash     TYPE string,                           "#EC NEEDED
        lv_error     TYPE abap_bool,
        lt_results   TYPE TABLE OF string,
        lv_statement LIKE LINE OF lt_results.

  FIELD-SYMBOLS: <ls_statement> LIKE LINE OF it_statements,
                 <ls_token>     LIKE LINE OF it_tokens.


  LOOP AT it_statements ASSIGNING <ls_statement> WHERE type = scan_stmnt_type-standard.

    READ TABLE it_tokens ASSIGNING <ls_token> INDEX <ls_statement>-from.
    CHECK sy-subrc = 0 AND <ls_token>-str = 'SORT'.

    CLEAR lv_statement.
    LOOP AT it_tokens ASSIGNING <ls_token>
        FROM <ls_statement>-from TO <ls_statement>-to.
      CONCATENATE lv_statement <ls_token>-str INTO lv_statement SEPARATED BY space.
    ENDLOOP.

* parsing, derpy derp
    SPLIT lv_statement AT ' BY ' INTO lv_trash lv_statement.
    IF lv_statement IS INITIAL OR lv_statement CA '()'.
      CONTINUE. " current loop
    ENDIF.
    REPLACE ALL OCCURRENCES OF ' AS TEXT' IN lv_statement WITH ''.
    SPLIT lv_statement AT space INTO TABLE lt_results.

    lv_error = abap_false.
    IF lines( lt_results ) MOD 2 <> 0.
      lv_error = abap_true.
    ENDIF.

    LOOP AT lt_results INTO lv_statement.
      IF sy-tabix MOD 2 = 0
          AND lv_statement <> 'ASCENDING'
          AND lv_statement <> 'DESCENDING'.
        lv_error = abap_true.
      ENDIF.
    ENDLOOP.

    IF lv_error = abap_true.
      lv_include = get_include( p_level = <ls_statement>-level ).

      inform( p_sub_obj_type = c_type_include
              p_sub_obj_name = lv_include
              p_line         = <ls_token>-row
              p_kind         = mv_errty
              p_test         = c_my_name
              p_code         = '001' ).
    ENDIF.

  ENDLOOP.

ENDMETHOD.


METHOD constructor.

  super->constructor( ).

  description    = 'Specify SORT order'.                    "#EC NOTEXT
  category       = 'ZCL_AOC_CATEGORY'.
  version        = '000'.

  has_attributes = abap_true.
  attributes_ok  = abap_true.

  mv_errty = c_error.

ENDMETHOD.                    "CONSTRUCTOR


METHOD get_message_text.

  CASE p_code.
    WHEN '001'.
      p_text = 'Specify SORT order'.                        "#EC NOTEXT
    WHEN OTHERS.
      ASSERT 1 = 1 + 1.
  ENDCASE.

ENDMETHOD.                    "GET_MESSAGE_TEXT
ENDCLASS.