STORE SET '5-coim-sequence-set.tmp' replace
SET echo off
SET feedback off
SET head off
SET linesize 200
SET pagesize 0
SET space 0
SET tab off
SET trimspool on
SET termout off
SET verify off

SPOOL 5-coim-sequence.tmp

-- create sequence coimacqs_s start with  32946;

def where_condition="" 
def sequence_name=""
@ 5-coim-sequence-modulo coimaces cod_aces
@ 5-coim-sequence-modulo coimacts cod_acts
def where_condition="where cod_impianto < 'A'"
@ 5-coim-sequence-modulo coimaimp cod_impianto
def where_condition="" 
def where_condition="where cod_impianto_est < 'A'"
def sequence_name="coimaimp_est"
@ 5-coim-sequence-modulo coimaimp cod_impianto_est
def where_condition="" 
def sequence_name=""
@ 5-coim-sequence-modulo coimaimp_st st_progressivo
@ 5-coim-sequence-modulo coimadre cod_adre
@ 5-coim-sequence-modulo coimarea cod_area
@ 5-coim-sequence-modulo coimboll cod_bollini
@ 5-coim-sequence-modulo coimbatc cod_batc
@ 5-coim-sequence-modulo coimcimp cod_cimp
@ 5-coim-sequence-modulo coimcinc cod_cinc
def where_condition="where cod_cittadino < 'A'"
@ 5-coim-sequence-modulo coimcitt cod_cittadino
def where_condition=""
@ 5-coim-sequence-modulo coimcomu cod_comune
def where_condition="where cod_cost < 'A'"
@ 5-coim-sequence-modulo coimcont cod_contratto
def where_condition=""
@ 5-coim-sequence-modulo coimcost cod_cost
def where_condition=""
@ 5-coim-sequence-modulo coimdimp cod_dimp
def where_condition="where cod_distr < 'A'"
@ 5-coim-sequence-modulo coimdist cod_distr
def where_condition=""
@ 5-coim-sequence-modulo coimdocu cod_documento
def where_condition="where cod_enve like 'VE%'"
@ 5-coim-sequence-modulo coimenve substr(cod_enve,3)
def where_condition=""
@ 5-coim-sequence-modulo coimfatt cod_fatt
def where_condition=""
@ 5-coim-sequence-modulo coiminco cod_inco
def where_condition="where cod_manutentore like 'MA%'"
@ 5-coim-sequence-modulo coimmanu substr(cod_manutentore,3)
def where_condition=""
@ 5-coim-sequence-modulo coimmovi cod_movi
def where_condition=""
@ 5-coim-sequence-modulo coimprog cod_progettista
@ 5-coim-sequence-modulo coimprov cod_provincia
@ 5-coim-sequence-modulo coimprvv cod_prvv
@ 5-coim-sequence-modulo coimregi cod_regione
@ 5-coim-sequence-modulo coimrelg cod_relg
@ 5-coim-sequence-modulo coimtodo cod_todo
@ 5-coim-sequence-modulo coimtpdo cod_tpdo
@ 5-coim-sequence-modulo coimstpm id_stampa
@ 5-coim-sequence-modulo coimviae cod_via
@ 5-coim-sequence-modulo coimboap cod_boap
@ 5-coim-sequence-modulo coimtpco cod_tpco
@ 5-coim-sequence-modulo coimrfis cod_rfis
@ 5-coim-sequence-modulo coimdope_aimp cod_dope_aimp

SPOOL OFF

-- ripristino i settaggi di sql salvati in precedenza
@ 5-coim-sequence-set.tmp

-- lancio le create delle sequence
@ 5-coim-sequence.tmp
