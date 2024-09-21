*&---------------------------------------------------------------------*
*& Include          Z_SSB_SEL
*&---------------------------------------------------------------------*
PARAMETERS: p_path TYPE localfile,
            p_file TYPE localfile,
            p_ssb  RADIOBUTTON GROUP rad1,
            p_chg  RADIOBUTTON GROUP rad1.
SELECT-OPTIONS: s_date for cdhdr-udate NO-DISPLAY.
