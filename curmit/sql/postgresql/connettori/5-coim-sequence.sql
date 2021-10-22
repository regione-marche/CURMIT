\o 5-coim-sequence.tmp
\t

\qecho '\\echo Questo script serve per far iniziare le sequence'
\qecho '\\echo dal primo valore libero delle relative tabelle'
\qecho ''
        
select 'create sequence coimaimp_cnt_s start '||
   (select to_char(coalesce(max(to_number(cod_impianto, 99999990) ),0) + 1, 9999999999) from   coimaimp_cnt where cod_impianto < 'A')||';';

select 'create sequence coimaimp_cnt_est_s start '||
   (select to_char(coalesce(max(to_number(cod_impianto_est, 9999999990) ),0) + 1, 99999999999) from   coimaimp_cnt where cod_impianto_est < 'A')||';';

select 'create sequence coimcimp_cnt_s start '||
   (select to_char(coalesce(max(to_number(cod_cimp, 99999990) ),0) + 1, 9999999999)from   coimcimp_cnt)||';';

select 'create sequence coimcitt_cnt_s start '||
   (select to_char(coalesce(max(to_number(cod_cittadino, 99999990) ),0) + 1, 9999999999)from   coimcitt_cnt where cod_cittadino < 'A')||';';

select 'create sequence coimcost_cnt_s start '||
   (select to_char(coalesce(max(to_number(cod_cost, 99999990) ),0) + 1, 9999999999)from   coimcost_cnt where cod_cost < 'A')||';';

select 'create sequence coimdimp_cnt_s start '||
   (select to_char(coalesce(max(to_number(cod_dimp, 99999990) ),0) + 1, 9999999999)from   coimdimp_cnt)||';';

select 'create sequence coimmanu_cnt_s start '||
   (select to_char(coalesce(max(to_number(substr(cod_manutentore,3), 99999990) ),0) + 1, 9999999999)from coimmanu_cnt where cod_manutentore like 'MA%')||';';

select 'create sequence coimprog_cnt_s start '||
   (select to_char(coalesce(max(to_number(cod_progettista, 99999990) ),0) + 1, 9999999999)from   coimprog_cnt)||';';

select 'create sequence coimviae_cnt_s start '||
   (select to_char(coalesce(max(to_number(cod_via, 99999990) ),0) + 1, 9999999999)from   coimviae_cnt)||';';


\t
\o

\i 5-coim-sequence.tmp
