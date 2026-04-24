begin;

/* BUT 12/06/2023  Aggiunto campo per annullamento logico di uno strumento da portale */

ALTER TABLE iter_tools ADD COLUMN is_active_p boolean DEFAULT TRUE;

end;
