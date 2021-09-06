begin
DBMS_MVIEW.refresh(list => 'ft_table20', method => 'COMPLETE', refresh_after_errors => True);
end;