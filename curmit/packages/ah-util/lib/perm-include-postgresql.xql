<?xml version="1.0"?>

<queryset>
   <rdbms><type>postgresql</type><version>7.1</version></rdbms>

<fullquery name="object_info">      
      <querytext>
    select acs_object__name(object_id) as object_name,
           acs_object__name(context_id) as parent_object_name,
           context_id
    from   acs_objects
    where  object_id = :object_id

      </querytext>
</fullquery>


<fullquery name="permissions">      
      <querytext>
    select ptab.grantee_id,
           acs_object__name(ptab.grantee_id) as grantee_name,
           o.object_type,
           [join $select_clauses ", "],
           sum([join $privs "_p + "]_p) as any_perm_p_
    from   (select grantee_id,
                   [join $from_all_clauses ", "]
            from   acs_permissions_all
            where  object_id = :object_id
            union all
            select grantee_id,
                   [join $from_direct_clauses ", "]
            from   acs_permissions
            where  object_id = :object_id
            union all
            select g.group_id, 0 as read_p, 0 as exec_p, 0 as admin_p
            from acs_rels r, groups g
            where r.rel_type      ='composition_rel' 
              and r.object_id_one = :application_group_id 
              and r.object_id_two = g.group_id
           ) ptab,
           acs_objects o
    where  o.object_id = ptab.grantee_id
    and    not exists (select 1 from acs_object_party_privilege_map p where p.object_id =  acs__magic_object_id('security_context_root') and p.party_id = ptab.grantee_id and p.privilege =  'admin')
    group  by ptab.grantee_id, grantee_name, object_type
    order  by object_type desc, grantee_name
      </querytext>
</fullquery>


 
</queryset>
