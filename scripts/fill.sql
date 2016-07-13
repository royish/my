alter table `batches` drop foreign key  `fk_action_descs_batches`;

TRUNCATE cpes;
SELECT @cpe_id:=1000000, @index:=0, @base_ip:=INET_ATON("10.10.0.1") - 1;

INSERT INTO cpes (cpe_id, cpe_wan_ip, external_wan_ip, first_connected, last_connected, protocol_jnet, jacs_name, domain_id, platform, firmware_version, supported_features)
SELECT	(@cpe_id:=@cpe_id+1) as cpe_id,
	@var_cpe_wan_ip:=(INET_NTOA(@base_ip + ((@index:=@index+1) % 254) + (floor(@index/254)*256) + (floor(@index/(254*254))*256*256))) as cpe_wan_ip,
	@var_cpe_wan_ip as external_wan_ip,
	(UTC_TIMESTAMP() - INTERVAL 15 DAY - INTERVAL FLOOR(RAND() * 165 * 86400) SECOND) as first_connected,
	(UTC_TIMESTAMP() - INTERVAL FLOOR(RAND() * 15 * 86400) SECOND) as last_connected,
	1 as protocol_jnet,
	IF((@var_jacs_id:=FLOOR(RAND() * 6))=0,NULL,@var_jacs_id) as jacs_name,
	2 as domain_id,
	'UML' as platform,
	'4.11.3.7' as firmware_version,
	2 as supported_features
FROM 	information_schema.columns as a,
	information_schema.columns as b
LIMIT	 5000;




TRUNCATE batches;
SELECT @var_day:= 180;
INSERT INTO batches (cpe_group_id, action_desc_id, priority, scheduled_time, status)
SELECT	 1 as cpe_group_id,
	20 as action_desc_id,
	50 as priority,
	(UTC_TIMESTAMP() - INTERVAL (@var_day:=@var_day - 1) DAY) as scheduled_time,
	'Closed' as status
FROM 	information_schema.columns
LIMIT	 180;
INSERT INTO batches (cpe_group_id, action_desc_id, priority, scheduled_time, status)
SELECT	 1 as cpe_group_id,
	19 as action_desc_id,
	50 as priority,
	(UTC_TIMESTAMP() - INTERVAL 120 DAY) as scheduled_time,
	'Closed' as status;
INSERT INTO batches (cpe_group_id, action_desc_id, priority, scheduled_time, status)
SELECT	 1 as cpe_group_id,
	19 as action_desc_id,
	50 as priority,
	(UTC_TIMESTAMP() - INTERVAL 60 DAY) as scheduled_time,
	'Closed' as status;
INSERT INTO batches (cpe_group_id, action_desc_id, priority, scheduled_time, status)
SELECT	 1 as cpe_group_id,
	10000 as action_desc_id,
	50 as priority,
	(UTC_TIMESTAMP() - INTERVAL (@var_day:=@var_day - 1) DAY) as scheduled_time,
	'Closed' as status
FROM 	information_schema.columns
LIMIT	 18;


-- (SELECT id FROM actions WHERE action_desc_id = batches.action_desc_id AND protocol in ('JNET', 'ALL') ORDER BY protocol DESC LIMIT 1) as action_id,

TRUNCATE tasks;
INSERT INTO tasks (batch_id, id_cpes, action_id, priority, scheduled_time, start_time, end_time, result, status, on_queue)
SELECT  batches.id as batch_id,
        cpes.id as id_cpes,
	10000 as action_id,
	batches.priority as priority,
	batches.scheduled_time as scheduled_time,
	(@var_start_time := (batches.scheduled_time + INTERVAL ((cpes.id - 1000000)/10) SECOND)) as start_time,
	(@var_start_time + INTERVAL 11 SECOND) as end_time,
	IF(CAST(RAND() AS UNSIGNED), "Short result", "Long Long Long Long Long Long Long Long Long Long Long Long Long Long Long Long Long Long Long Long Long
		Long Long Long Long Long Long Long Long Long Long Long Long Long Long Long Long Long Long Long Long Long Long Long Long Long Long Long Long 
		Long Long Long Long Long Long Long Long Long Long Long Long Long Long Long Long Long Long Long Long Long Long Long Long Long Long Long Long 
		Long Long Long Long Long Long Long Long Long Long Long Long Long Long Long Long Long Long Long Long Long Long Long Long Long Long Long Long 
		Long Long Long Long Long Long Long Long Long Long Long Long Long Long Long Long Long Long Long Long Long Long Long Long Long Long Long Long result") as result,
	IF(CAST(RAND() AS UNSIGNED), 'Failed Permanently', 'Succeeded') as status, 0 as on_queue
FROM    cpes,
        batches
WHERE   batches.cpe_group_id IS NOT NULL;




TRUNCATE cpe_cable;
INSERT INTO cpe_cable (id_cpes)
SELECT  cpes.id as id_cpes,
FROM    cpes
WHERE   cpes.id <= 100;
	




TRUNCATE cpe_log;
INSERT INTO cpe_log (id_cpes, time, event, created_by)
SELECT  cpes.id as id_cpes,
        (UTC_TIMESTAMP() - INTERVAL (FLOOR(RAND() * 180)) DAY) as time,
	CEIL(RAND() * 6) as event,
	IF(CAST(RAND() AS UNSIGNED),1,3) as created_by
FROM    cpes,
	batches
WHERE   batches.id <= 100;
	





-- cpes: 50000
-- batches: 200
-- tasks: batches * cpes
-- cpes_log: batches * cpes + 4 * cpes

