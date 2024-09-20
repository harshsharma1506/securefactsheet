insert_job: GRAC-FILE-EXTRACT    job_type: cmd
description: run transfer
machine: xxxx 
owner: xxxx
box_name: GRAC-FILE-EXTRACT-BOX
alarm_if_fail: y
alarm_if_terminated: y
job_terminator: y
send_notification: n
std_out_file: > /tmp/$AUTO_JOB_NAME.out
std_err_file: > /tmp/$AUTO_JOB_NAME.err
command: /home/spndm/scripts/PUSHTOWIN_BINARY.pl <application_layer>.csv "\"\\\\ <shared_path>-`date +%y%W`.csv"\" UST.NT.NDM02T RPL NOARCHIVE $AUTO_JOB_NAME $AUTOSERV
