-- tabelle
spool 1-coim-drop.log

drop table coim_as_resp;
drop table coimaces;
drop table coimacts;
drop table coimaimp;
drop table coimalim;
drop table coimanec;
drop table coimanom;
drop table coimanrg;
drop table coimarea;
drop table coimbatc;
drop table coimboap;
drop table coimboll;
drop table coimbpos;
drop table coimcaus;
drop table coimcimp;
drop table coimcinc;
drop table coimcitt;
drop table coimcitt_st;
drop table coimcmar;
drop table coimcoma;
drop table coimcomb;
drop table coimcomu;
drop table coimcont;
drop table coimcost;
drop table coimcout;
--drop table coimcqua;
drop table coimcted;
--drop table coimcuar;
--drop table coimcurb;
drop table coimdesc;
drop table coimdest;
drop table coimdimp;
drop table coimdimp_gend;
drop table coimdist;
drop table coimdmsg;
drop table coimdocu;
drop table coimdope_aimp;
drop table coimdope_gend;
drop table coimenre;
drop table coimenti;
drop table coimenrg;
drop table coimenve;
drop table coimesit;
drop table coimfatt;
drop table coimfdc;
drop table coimflre;
drop table coimfuge;
drop table coimfunp;
drop table coimfunz;
drop table coimgage;
drop table coimgend;
drop table coimgend_as_resp;
drop table coimgend_st;
drop table coimimst;
drop table coiminco;
drop table coiminco_st;
drop table coiminst;
drop table coimmanu;
drop table coimmenp;
drop table coimmenu;
drop table coimmode;
drop table coimmovi;
drop table coimmtar;
drop table coimnoveb;
drop table coimogge;
drop table coimopdi;
drop table coimopve;
drop table coimpote;
drop table coimprof;
drop table coimprog;
drop table coimprov;
drop table coimprvv;
drop table coimqrar;
drop table coimregi;
drop table coimrelg;
drop table coimrelt;
drop table coimtfis;
drop table coimrgen;
drop table coimrgh;
drop table coimrife;
drop table coimruol;
drop table coimscamb;
drop table coimsett;
drop table coimsrcg;
drop table coimsrcm;
drop table coimsrdg;
drop table coimstat;
drop table coimstpm;
drop table coimstrl;
drop table coimstru;
drop table coimstub;
drop table coimtano;
drop table coimtari;
drop table coimtcar;
drop table coimtdoc;
drop table coimtgen;
drop table coimtmsg;
drop table coimtipo_grup_termico;
drop table coimtodo;
drop table coimtopo;
drop table coimtpbo;
drop table coimtpco;
drop table coimtpdo;
drop table coimtpdu;
drop table coimtpem;
drop table coimtpes;
drop table coimtpim;
drop table coimtpnu;
drop table coimtppr;
drop table coimtppt;
drop table coimtprg;
drop table coimtpsg;
drop table coimtrans_manu;
drop table coimutar;
drop table coimuten;
drop table coimutgi;
drop table coimviae;
drop table coimviar;
drop table coimlist;

-- sequence
drop sequence coimaces_s; 
drop sequence coimacts_s; 
drop sequence coimaimp_s;
drop sequence coimaimp_est_s;
drop sequence coimarea_s;
drop sequence coimbatc_s; 
drop sequence coimboll_s;
drop sequence coimcimp_s; 
drop sequence coimcinc_s; 
drop sequence coimcitt_s; 
drop sequence coimcomu_s; 
drop sequence coimcont_s; 
drop sequence coimcost_s; 
drop sequence coimdimp_s; 
drop sequence coimdist_s; 
drop sequence coimdocu_s; 
drop sequence coimenve_s;
drop sequence coimfatt_s;
drop sequence coiminco_s; 
drop sequence coimmanu_s;
drop sequence coimmovi_s;
drop sequence coimprog_s; 
drop sequence coimprov_s;
drop sequence coimprvv_s; 
drop sequence coimregi_s; 
drop sequence coimrelg_s; 
drop sequence coimstpm_s; 
drop sequence coimtodo_s; 
drop sequence coimtpdo_s; 
drop sequence coimviae_s; 
drop sequence coim_as_resp_s;
drop sequence coimbpos_s;
drop sequence coimstru_s;
drop sequence coimcitt_st_seq;
drop sequence coiminco_st_seq;

--funzioni
drop package iter_edit;
drop package iter_get;

spool off
